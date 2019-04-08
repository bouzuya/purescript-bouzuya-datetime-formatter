module Test.Bouzuya.DateTime.Formatter.OffsetDateTime
  ( tests
  ) where

import Prelude

import Bouzuya.DateTime.Formatter.OffsetDateTime as OffsetDateTimeFormatter
import Bouzuya.DateTime.OffsetDateTime as OffsetDateTime
import Bouzuya.DateTime.TimeZoneOffset as TimeZoneOffset
import Data.DateTime as DateTime
import Data.Enum as Enum
import Data.Maybe as Maybe
import Data.Time.Duration as TimeDuration
import Partial.Unsafe as Unsafe
import Test.Unit (TestSuite)
import Test.Unit as TestUnit
import Test.Unit.Assert as Assert

tests :: TestSuite
tests = TestUnit.suite "Bouzuya.DateTime.Formatter.OffsetDateTime" do
  let
    offsetDateTime =
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
          dateTime <- pure (DateTime.DateTime date time)
          timeZoneOffset <-
            TimeZoneOffset.fromDuration (TimeDuration.Hours (-9.0))
          OffsetDateTime.fromLocalDateTime timeZoneOffset dateTime)
    offsetDateTimeString = "2000-01-02T03:04:05+09:00"
    offsetDateTimeStringInUTC = "2000-01-01T18:04:05Z"

  TestUnit.test "fromString" do
    Assert.equal
      (Maybe.Just offsetDateTime)
      (OffsetDateTimeFormatter.fromString offsetDateTimeString)

  TestUnit.test "toString" do
    Assert.equal
      offsetDateTimeString
      (OffsetDateTimeFormatter.toString offsetDateTime)
    Assert.equal
      offsetDateTimeStringInUTC
      (OffsetDateTimeFormatter.toString
        (OffsetDateTime.inUTC offsetDateTime))
