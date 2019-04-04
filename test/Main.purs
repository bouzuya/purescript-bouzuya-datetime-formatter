module Test.Main where

import Prelude

import Effect (Effect)
import Test.Bouzuya.DateTime.Formatter.OffsetDateTime as OffsetDateTimeFormatter
import Test.Bouzuya.DateTime.Formatter.TimeZoneOffset as TimeZoneOffsetFormatter
import Test.Unit.Main as TestUnitMain

main :: Effect Unit
main = TestUnitMain.runTest do
  OffsetDateTimeFormatter.tests
  TimeZoneOffsetFormatter.tests
