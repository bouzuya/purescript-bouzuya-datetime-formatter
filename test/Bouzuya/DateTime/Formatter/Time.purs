module Test.Bouzuya.DateTime.Formatter.Time
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.Time as TimeFormatter
import Data.Enum as Enum
import Data.Maybe as Maybe
import Data.Time as Time
import Partial.Unsafe as Unsafe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.Time" do
  let
    time =
      Unsafe.unsafePartial
        (Maybe.fromJust do
          hour <- Enum.toEnum 3
          minute <- Enum.toEnum 4
          second <- Enum.toEnum 5
          millisecond <- pure bottom
          pure (Time.Time hour minute second millisecond))
    timeString = "03:04:05"

  TestUnit.test "fromString" do
    Assert.equal (Maybe.Just time) (TimeFormatter.fromString timeString)

  TestUnit.test "toString" do
    Assert.equal timeString (TimeFormatter.toString time)
