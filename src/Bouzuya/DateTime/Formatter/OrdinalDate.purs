module Bouzuya.DateTime.Formatter.OrdinalDate
  ( fromString
  , toString
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.Date as DateFormatter
import Bouzuya.DateTime.OrdinalDate (DayOfYear, OrdinalDate)
import Bouzuya.DateTime.OrdinalDate as OrdinalDate
import Bouzuya.DateTime.OrdinalDate as OridinalDate
import Data.Array as Array
import Data.Array.NonEmpty as NonEmptyArray
import Data.DateTime (Date, Year)
import Data.DateTime as DateTime
import Data.Either as Either
import Data.Enum as DayOfYear
import Data.Enum as Enum
import Data.Formatter.DateTime (Formatter)
import Data.Formatter.DateTime as Formatter
import Data.Int as Int
import Data.List as List
import Data.Maybe (Maybe)
import Data.String as String
import Data.String.Regex as Regex
import Data.String.Regex.Flags as RegexFlags
import Data.String.Regex.Unsafe as RegexUnsafe

formatter :: Formatter
formatter =
  List.fromFoldable
    [ Formatter.YearFull
    ]

fromString :: String -> Maybe OrdinalDate
fromString s = do
  let regex = RegexUnsafe.unsafeRegex "^(\\d{4})-(\\d{3})$" RegexFlags.noFlags
  matches <- Regex.match regex s
  yearString <- join (NonEmptyArray.index matches 1)
  doyString <- join (NonEmptyArray.index matches 2)
  year <- map DateTime.year (DateFormatter.fromString (yearString <> "-01-01"))
  doy <- (Int.fromString doyString) >>= DayOfYear.toEnum
  OrdinalDate.ordinalDate year doy

toString :: OrdinalDate -> String
toString od =
  String.joinWith
    "-"
    [ padStart 4 "0" (show (Enum.fromEnum (OrdinalDate.year od)))
    , padStart 3 "0" (show (Enum.fromEnum (OridinalDate.dayOfYear od)))
    ]
  where
    padStart :: Int -> String -> String -> String
    padStart l p s
      | String.length s >= l = s
      | otherwise =
        (String.joinWith "" (Array.replicate (l - (String.length s)) p)) <> s
