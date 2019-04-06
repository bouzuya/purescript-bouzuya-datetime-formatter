module Test.Bouzuya.DateTime.Formatter.TimeZoneOffset
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.TimeZoneOffset as TimeZoneOffsetFormatter
import Bouzuya.DateTime.TimeZoneOffset as TimeZoneOffset
import Data.Maybe as Maybe
import Data.Time.Duration as TimeDuration
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.TimeZoneOffset" do
  TestUnit.test "fromString / toString" do
    Assert.equal
      (Maybe.Just "Z")
      (map
        TimeZoneOffsetFormatter.toString
        (TimeZoneOffsetFormatter.fromString "Z"))
    Assert.equal
      (Maybe.Just "+09:00")
      (map
        TimeZoneOffsetFormatter.toString
        (TimeZoneOffsetFormatter.fromString "+09:00"))
    Assert.equal
      (Maybe.Just "-09:30")
      (map
        TimeZoneOffsetFormatter.toString
        (TimeZoneOffsetFormatter.fromString "-09:30"))
    Assert.equal
      (Maybe.Just "+09:00")
      (map
        TimeZoneOffsetFormatter.toString
        (TimeZoneOffset.fromDuration (TimeDuration.Hours (-9.0))))
    Assert.equal
      (Maybe.Just "+09:00")
      (map
        TimeZoneOffsetFormatter.toString
        (TimeZoneOffset.fromDuration (TimeDuration.Minutes (-540.0))))
    Assert.equal
      (Maybe.Just true)
      ((==)
        <$> (TimeZoneOffsetFormatter.fromString "+09:00")
        <*> (TimeZoneOffsetFormatter.fromString "+09:00"))
    Assert.equal
      (Maybe.Just true)
      ((<)
        <$> (TimeZoneOffsetFormatter.fromString "+09:00")
        <*> (TimeZoneOffsetFormatter.fromString "-09:00"))
