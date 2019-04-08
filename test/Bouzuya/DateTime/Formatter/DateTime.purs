module Test.Bouzuya.DateTime.Formatter.DateTime
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.DateTime as DateTimeFormatter
import Data.DateTime as DateTime
import Data.Enum as Enum
import Data.Maybe as Maybe
import Partial.Unsafe as Unsafe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.DateTime" do
  let
    dateTime =
      Unsafe.unsafePartial
        (Maybe.fromJust do
          year <- Enum.toEnum 2000
          month <- Enum.toEnum 1
          day <- Enum.toEnum 2
          date <- DateTime.exactDate year month day
          hour <- Enum.toEnum 3
          minute <- Enum.toEnum 4
          second <- Enum.toEnum 5
          millisecond <- pure bottom
          time <- pure (DateTime.Time hour minute second millisecond)
          pure (DateTime.DateTime date time))
    dateTimeString = "2000-01-02T03:04:05"

  TestUnit.test "fromString" do
    Assert.equal
      (Maybe.Just dateTime)
      (DateTimeFormatter.fromString dateTimeString)

  TestUnit.test "toString" do
    Assert.equal dateTimeString (DateTimeFormatter.toString dateTime)
