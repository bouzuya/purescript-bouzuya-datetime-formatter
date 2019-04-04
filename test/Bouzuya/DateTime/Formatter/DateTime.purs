module Test.Bouzuya.DateTime.Formatter.DateTime
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.DateTime as DateTimeFormatter
import Data.Maybe as Maybe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.DateTime" do
  TestUnit.test "fromString / toString" do
    Assert.equal
      (Maybe.Just "2000-01-02T03:04:05")
      (map
        DateTimeFormatter.toString
        (DateTimeFormatter.fromString "2000-01-02T03:04:05"))
