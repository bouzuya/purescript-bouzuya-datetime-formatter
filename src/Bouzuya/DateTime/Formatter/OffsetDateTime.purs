module Bouzuya.DateTime.Formatter.OffsetDateTime
  ( fromString
  , toString
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.DateTime as DateTimeFormatter
import Bouzuya.DateTime.Formatter.TimeZoneOffset as TimeZoneOffsetFormatter
import Bouzuya.DateTime.OffsetDateTime (OffsetDateTime)
import Bouzuya.DateTime.OffsetDateTime as OffsetDateTime
import Data.Array.NonEmpty as NonEmptyArray
import Data.Maybe (Maybe)
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.String.Regex.Unsafe as RegexUnsafe

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
  dateTime <- DateTimeFormatter.fromString dateTimeString
  timeZoneOffset <- TimeZoneOffsetFormatter.fromString timeZoneOffsetString
  OffsetDateTime.fromLocalDateTime timeZoneOffset dateTime

-- YYYY-MM-DDTHH:MM:SSZ or YYYY-MM-DDTHH:MM:SS+HH:MM
toString :: OffsetDateTime -> String
toString odt =
  let
    offset = OffsetDateTime.timeZoneOffset odt
    local = OffsetDateTime.toLocalDateTime odt
  in
    (DateTimeFormatter.toString local)
    <> (TimeZoneOffsetFormatter.toString offset)
