module Bouzuya.DateTime.Formatter.TimeZoneOffset
  ( fromString
  , toString
  ) where

import Prelude

import Bouzuya.DateTime.TimeZoneOffset (TimeZoneOffset)
import Bouzuya.DateTime.TimeZoneOffset as TimeZoneOffset
import Control.MonadZero as MonadZero
import Data.Array as Array
import Data.Array.NonEmpty as NonEmptyArray
import Data.Either as Either
import Data.Int as Int
import Data.Maybe (Maybe)
import Data.Maybe as Maybe
import Data.Ord as Ord
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.Time.Duration (Minutes(..))
import Data.Time.Duration as TimeDuration
import Partial.Unsafe as Unsafe

fromString :: String -> Maybe TimeZoneOffset
fromString "Z" = Maybe.Just TimeZoneOffset.utc
fromString s = do
  regex <-
    Either.hush
      (Regex.regex "^([-+])([0-2][0-9]):([0-5][0-9])$" RegexFlags.noFlags)
  matches <- map NonEmptyArray.toArray (Regex.match regex s)
  signString <- join (Array.index matches 1)
  hoursString <- join (Array.index matches 2)
  minutesString <- join (Array.index matches 3)
  let
    sign :: forall a. Ring a => a -> a
    sign = if signString == "+" then negate else identity
  hours <- Int.fromString hoursString
  MonadZero.guard (between 0 23 hours)
  minutes <- Int.fromString minutesString
  MonadZero.guard (between 0 59 minutes)
  TimeZoneOffset.fromDuration
    (TimeDuration.Minutes (Int.toNumber (sign (hours * 60 + minutes))))

toString :: TimeZoneOffset -> String
toString timeZoneOffset
  | timeZoneOffset == TimeZoneOffset.utc = "Z"
  | otherwise =
      let
        (Minutes offset') = TimeZoneOffset.toDuration timeZoneOffset
        offset = Unsafe.unsafePartial (Maybe.fromJust (Int.fromNumber offset'))
        hours = ((Ord.abs offset) `div` 60)
        minutes = ((Ord.abs offset) `mod` 60)
      in
        Array.fold
          [ if offset < 0 then "+" else "-"
          , (if hours < 10 then "0" else "") <> show hours
          , ":"
          , (if minutes < 10 then "0" else "") <> show minutes
          ]

