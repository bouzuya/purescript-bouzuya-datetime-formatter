module Test.Bouzuya.DateTime.Formatter.OrdinalDate
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.OrdinalDate as OrdinalDateFormatter
import Bouzuya.DateTime.OrdinalDate as OrdinalDate
import Data.Date as Date
import Data.Enum as Enum
import Data.Maybe as Maybe
import Partial.Unsafe as Unsafe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.OrdinalDate" do
  let
    ordinalDate =
      Unsafe.unsafePartial
        (Maybe.fromJust do
          year <- Enum.toEnum 2000
          month <- Enum.toEnum 1
          day <- Enum.toEnum 2
          date <- Date.exactDate year month day
          pure (OrdinalDate.fromDate date))
    ordinalDateString = "2000-002"

  TestUnit.test "fromString" do
    Assert.equal
      (Maybe.Just ordinalDate)
      (OrdinalDateFormatter.fromString ordinalDateString)

  TestUnit.test "toString" do
    Assert.equal ordinalDateString (OrdinalDateFormatter.toString ordinalDate)
