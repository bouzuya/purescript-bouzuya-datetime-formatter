module Test.Bouzuya.DateTime.Formatter.OrdinalDate
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.OrdinalDate as OrdinalDateFormatter
import Data.Maybe as Maybe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.OrdinalDate" do
  TestUnit.test "fromString / toString" do
    Assert.equal
      (Maybe.Just "2000-002")
      (map
        OrdinalDateFormatter.toString
        (OrdinalDateFormatter.fromString "2000-002"))
