module Test.Bouzuya.DateTime.Formatter.TimeZoneOffset
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.TimeZoneOffset as TimeZoneOffsetFormatter
import Bouzuya.DateTime.TimeZoneOffset as TimeZoneOffset
import Data.Maybe as Maybe
import Data.Time.Duration as TimeDuration
import Partial.Unsafe as Unsafe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.TimeZoneOffset" do
  let
    timeZoneOffsetUTC = TimeZoneOffset.utc
    timeZoneOffsetUTCString = "Z"
    timeZoneOffsetJST =
      Unsafe.unsafePartial
        (Maybe.fromJust
          (TimeZoneOffset.fromDuration (TimeDuration.Hours (-9.0))))
    timeZoneOffsetJSTString = "+09:00"

  TestUnit.test "fromString" do
    Assert.equal
      (Maybe.Just timeZoneOffsetUTC)
      (TimeZoneOffsetFormatter.fromString timeZoneOffsetUTCString)
    Assert.equal
      (Maybe.Just timeZoneOffsetJST)
      (TimeZoneOffsetFormatter.fromString timeZoneOffsetJSTString)

  TestUnit.test "toString" do
    Assert.equal
      timeZoneOffsetUTCString
      (TimeZoneOffsetFormatter.toString timeZoneOffsetUTC)
    Assert.equal
      timeZoneOffsetJSTString
      (TimeZoneOffsetFormatter.toString timeZoneOffsetJST)
