module Bouzuya.DateTime.Formatter.Time
  ( fromString
  , toString
  ) where

import Prelude

import Data.DateTime (Time)
import Data.DateTime as DateTime
import Data.Either as Either
import Data.Formatter.DateTime (Formatter)
import Data.Formatter.DateTime as Formatter
import Data.List as List
import Data.Maybe (Maybe)

formatter :: Formatter
formatter =
  List.fromFoldable
    [ Formatter.Hours24
    , Formatter.Placeholder ":"
    , Formatter.MinutesTwoDigits
    , Formatter.Placeholder ":"
    , Formatter.SecondsTwoDigits
    ]

fromString :: String -> Maybe Time
fromString =
  (map DateTime.time) <<< Either.hush <<< (Formatter.unformat formatter)

toString :: Time -> String
toString = (Formatter.format formatter) <<< (DateTime.DateTime bottom)
