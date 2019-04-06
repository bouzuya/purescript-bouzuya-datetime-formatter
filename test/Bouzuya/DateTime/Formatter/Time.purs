module Test.Bouzuya.DateTime.Formatter.Time
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.Time as TimeFormatter
import Data.Maybe as Maybe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.Time" do
  TestUnit.test "fromString / toString" do
    Assert.equal
      (Maybe.Just "03:04:05")
      (map
        TimeFormatter.toString
        (TimeFormatter.fromString "03:04:05"))
