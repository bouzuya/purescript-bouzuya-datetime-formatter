module Test.Bouzuya.DateTime.Formatter.WeekDate
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.WeekDate as WeekDateFormatter
import Bouzuya.DateTime.WeekDate as WeekDate
import Data.Date as Date
import Data.Enum as Enum
import Data.Maybe as Maybe
import Partial.Unsafe as Unsafe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.WeekDate" do
  let
    weekDate =
      Unsafe.unsafePartial
        (Maybe.fromJust do
          year <- Enum.toEnum 2000
          month <- Enum.toEnum 1
          day <- Enum.toEnum 2
          date <- Date.exactDate year month day
          pure (WeekDate.fromDate date))
    weekDateString = "1999-W52-7"

  TestUnit.test "fromString" do
    Assert.equal
      (Maybe.Just weekDate)
      (WeekDateFormatter.fromString weekDateString)

  TestUnit.test "toString" do
    Assert.equal weekDateString (WeekDateFormatter.toString weekDate)
