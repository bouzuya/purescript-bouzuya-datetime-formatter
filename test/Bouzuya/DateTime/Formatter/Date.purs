module Test.Bouzuya.DateTime.Formatter.Date
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.Date as DateFormatter
import Data.Maybe as Maybe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.Date" do
  TestUnit.test "fromString / toString" do
    Assert.equal
      (Maybe.Just "2000-01-02")
      (map
        DateFormatter.toString
        (DateFormatter.fromString "2000-01-02"))
