module Test.Main where

import Prelude

import Effect (Effect)
import Test.Bouzuya.DateTime.Formatter.DateTime as DateTimeFormatter
import Test.Bouzuya.DateTime.Formatter.OffsetDateTime as OffsetDateTimeFormatter
import Test.Bouzuya.DateTime.Formatter.TimeZoneOffset as TimeZoneOffsetFormatter
import Test.Unit.Main as TestUnitMain

main :: Effect Unit
main = TestUnitMain.runTest do
  DateTimeFormatter.tests
  OffsetDateTimeFormatter.tests
  TimeZoneOffsetFormatter.tests
