module Bouzuya.DateTime.Formatter.Date
  ( fromString
  , toString
  ) where

import Prelude

import Data.DateTime (Date)
import Data.DateTime as DateTime
import Data.Either as Either
import Data.Formatter.DateTime (Formatter)
import Data.Formatter.DateTime as Formatter
import Data.List as List
import Data.Maybe (Maybe)

formatter :: Formatter
formatter =
  List.fromFoldable
    [ Formatter.YearFull
    , Formatter.Placeholder "-"
    , Formatter.MonthTwoDigits
    , Formatter.Placeholder "-"
    , Formatter.DayOfMonthTwoDigits
    ]

fromString :: String -> Maybe Date
fromString =
  (map DateTime.date) <<< Either.hush <<< (Formatter.unformat formatter)

toString :: Date -> String
toString d = Formatter.format formatter (DateTime.DateTime d bottom)
