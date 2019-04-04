module Test.Bouzuya.DateTime.Formatter.OffsetDateTime
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.OffsetDateTime as OffsetDateTimeFormatter
import Bouzuya.DateTime.OffsetDateTime as OffsetDateTime
import Data.Maybe as Maybe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.OffsetDateTime" do
  TestUnit.test "fromString / toString" do
    Assert.equal
      (Maybe.Just "2000-01-02T12:04:05+09:00")
      (map
        OffsetDateTimeFormatter.toString
        (OffsetDateTimeFormatter.fromString "2000-01-02T12:04:05+09:00"))
    Assert.equal
      (Maybe.Just "2000-01-02T03:04:05Z")
      (map
        OffsetDateTimeFormatter.toString
        (OffsetDateTimeFormatter.fromString "2000-01-02T03:04:05Z"))
    Assert.equal
      (Maybe.Just "2000-01-02T03:04:05Z")
      (map
        (OffsetDateTimeFormatter.toString <<< OffsetDateTime.inUTC)
        (OffsetDateTimeFormatter.fromString "2000-01-02T12:04:05+09:00"))
