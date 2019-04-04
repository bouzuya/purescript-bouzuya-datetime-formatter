module Bouzuya.DateTime.Formatter.OffsetDateTime
  ( fromString
  , toString
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.TimeZoneOffset as TimeZoneOffsetFormatter
import Bouzuya.DateTime.OffsetDateTime (OffsetDateTime)
import Bouzuya.DateTime.OffsetDateTime as OffsetDateTime
import Data.Array.NonEmpty as NonEmptyArray
import Data.DateTime (DateTime)
import Data.Either as Either
import Data.Formatter.DateTime as Formatter
import Data.List as List
import Data.Maybe (Maybe)
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.String.Regex.Unsafe as RegexUnsafe

formatDateTime :: DateTime -> String
formatDateTime =
  Formatter.format
    (List.fromFoldable
      [ Formatter.YearFull
      , Formatter.Placeholder "-"
      , Formatter.MonthTwoDigits
      , Formatter.Placeholder "-"
      , Formatter.DayOfMonthTwoDigits
      , Formatter.Placeholder "T"
      , Formatter.Hours24
      , Formatter.Placeholder ":"
      , Formatter.MinutesTwoDigits
      , Formatter.Placeholder ":"
      , Formatter.SecondsTwoDigits
      ])

-- YYYY-MM-DDTHH:MM:SSZ or YYYY-MM-DDTHH:MM:SS+HH:MM
fromString :: String -> Maybe OffsetDateTime
fromString s = do
  let
    regex =
      RegexUnsafe.unsafeRegex
        "^(\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2})(Z|[-+]\\d{2}:\\d{2})$"
        RegexFlags.noFlags
  matches <- Regex.match regex s
  dateTimeString <- join (NonEmptyArray.index matches 1)
  timeZoneOffsetString <- join (NonEmptyArray.index matches 2)
  dateTime <- parseDateTime dateTimeString
  timeZoneOffset <- TimeZoneOffsetFormatter.fromString timeZoneOffsetString
  OffsetDateTime.fromLocalDateTime timeZoneOffset dateTime

parseDateTime :: String -> Maybe DateTime
parseDateTime s =
  Either.hush
    (Formatter.unformat
      (List.fromFoldable
        [ Formatter.YearFull
        , Formatter.Placeholder "-"
        , Formatter.MonthTwoDigits
        , Formatter.Placeholder "-"
        , Formatter.DayOfMonthTwoDigits
        , Formatter.Placeholder "T"
        , Formatter.Hours24
        , Formatter.Placeholder ":"
        , Formatter.MinutesTwoDigits
        , Formatter.Placeholder ":"
        , Formatter.SecondsTwoDigits
        ])
      s)

-- YYYY-MM-DDTHH:MM:SSZ or YYYY-MM-DDTHH:MM:SS+HH:MM
toString :: OffsetDateTime -> String
toString odt =
  let
    offset = OffsetDateTime.timeZoneOffset odt
    local = OffsetDateTime.toLocalDateTime odt
  in
    (formatDateTime local) <> (TimeZoneOffsetFormatter.toString offset)
