module Bouzuya.DateTime.Formatter.DateTime
  ( fromString
  , toString
  ) where

import Prelude

import Data.DateTime (DateTime)
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
    , Formatter.Placeholder "T"
    , Formatter.Hours24
    , Formatter.Placeholder ":"
    , Formatter.MinutesTwoDigits
    , Formatter.Placeholder ":"
    , Formatter.SecondsTwoDigits
    ]

fromString :: String -> Maybe DateTime
fromString = Either.hush <<< (Formatter.unformat formatter)

toString :: DateTime -> String
toString = Formatter.format formatter
