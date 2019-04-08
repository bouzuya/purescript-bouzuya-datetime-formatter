module Test.Bouzuya.DateTime.Formatter.Date
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.Date as DateFormatter
import Data.Date as Date
import Data.Enum as Enum
import Data.Maybe as Maybe
import Partial.Unsafe as Unsafe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.Date" do
  let
    date =
      Unsafe.unsafePartial
        (Maybe.fromJust do
          year <- Enum.toEnum 2000
          month <- Enum.toEnum 1
          day <- Enum.toEnum 2
          Date.exactDate year month day)
    dateString = "2000-01-02"

  TestUnit.test "fromString" do
    Assert.equal (Maybe.Just date) (DateFormatter.fromString dateString)

  TestUnit.test "toString" do
    Assert.equal dateString (DateFormatter.toString date)
