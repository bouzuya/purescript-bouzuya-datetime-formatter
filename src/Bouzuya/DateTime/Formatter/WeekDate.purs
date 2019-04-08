module Bouzuya.DateTime.Formatter.WeekDate
  ( fromString
  , toString
  ) where

import Prelude

import Bouzuya.DateTime.WeekDate (WeekDate)
import Bouzuya.DateTime.WeekDate as WeekDate
import Data.Array as Array
import Data.Array.NonEmpty as NonEmptyArray
import Data.Enum as Enum
import Data.Enum as Week
import Data.Enum as WeekYear
import Data.Enum as Weekday
import Data.Int as Int
import Data.Maybe (Maybe)
import Data.String as String
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.String.Regex.Unsafe as RegexUnsafe

fromString :: String -> Maybe WeekDate
fromString s = do
  let
    regex =
      RegexUnsafe.unsafeRegex "^(\\d{4})-W(\\d{2})-(\\d)$" RegexFlags.noFlags
  matches <- Regex.match regex s
  weekYearString <- join (NonEmptyArray.index matches 1)
  weekString <- join (NonEmptyArray.index matches 2)
  weekdayString <- join (NonEmptyArray.index matches 3)
  weekYear <- (Int.fromString weekYearString) >>= WeekYear.toEnum
  week <- (Int.fromString weekString) >>= Week.toEnum
  weekday <- (Int.fromString weekdayString) >>= Weekday.toEnum
  WeekDate.weekDate weekYear week weekday

toString :: WeekDate -> String
toString wd =
  String.joinWith
    "-"
    [ padStart 4 "0" (show (Enum.fromEnum (WeekDate.weekYear wd)))
    , "W" <> (padStart 2 "0" (show (Enum.fromEnum (WeekDate.week wd))))
    , show (Enum.fromEnum (WeekDate.weekday wd))
    ]
  where
    padStart :: Int -> String -> String -> String
    padStart l p s
      | String.length s >= l = s
      | otherwise =
        (String.joinWith "" (Array.replicate (l - (String.length s)) p)) <> s
