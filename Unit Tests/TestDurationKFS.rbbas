#tag Class
Protected Class TestDurationKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestAddition()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure the (+) operator works.
		  
		  Dim d1, d2 As DurationKFS
		  Dim d As Double
		  
		  d1 = 4
		  d2 = 8
		  d = d1 + d2
		  
		  AssertEquals 12, d, "Basic addition doesn't work."
		  
		  d1.MicrosecondsValue = -16
		  d2.MicrosecondsValue = 50
		  d1 = d1 + d2
		  Dim i As UInt64 = d1.MicrosecondsValue
		  
		  AssertEquals DurationKFS.MaximumValue.MicrosecondsValue, i, "The addition operator did not check for the overflow condition."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddToDate()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddToTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClear()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCompare()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDateDifference()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDivision()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIntegerDivision()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInvalidUnit()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure DurationKFS fails when dealing with invalid units.
		  
		  Dim d As DurationKFS
		  Dim iu As Double = 4.8
		  
		  PushMessageStack "DurationKFS did not throw an exception when dealing with an invalid unit."
		  
		  Try
		    d = New DurationKFS( 5, iu )
		    AssertFailure "(via constructor)"
		  Catch e As RuntimeException
		    If e IsA UnitTestExceptionKFS Then StashException e
		  End Try
		  
		  Try
		    d = New DurationKFS
		    d.Value( iu ) = 5
		    AssertFailure "(via setting Value property)"
		  Catch e As RuntimeException
		    If e IsA UnitTestExceptionKFS Then StashException e
		  End Try
		  
		  Try
		    d = New DurationKFS
		    d.IntegerValue( iu ) = 5
		    AssertFailure "(via setting IntegerValue property)"
		  Catch e As RuntimeException
		    If e IsA UnitTestExceptionKFS Then StashException e
		  End Try
		  
		  Try
		    d = 5
		    Call d.Value( iu )
		    AssertFailure "(via getting Value property)"
		  Catch e As RuntimeException
		    If e IsA UnitTestExceptionKFS Then StashException e
		  End Try
		  
		  Try
		    d = 5
		    Call d.Value( iu )
		    AssertFailure "(via getting IntegerValue property)"
		  Catch e As RuntimeException
		    If e IsA UnitTestExceptionKFS Then StashException e
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMaximumValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMinimumValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestModulo()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMultiplyByScalar()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromMicrosecondsValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewStopwatchStartingNow()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchCancel()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchSplit()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchStart()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchStop()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSubtractFromDate()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSubtraction()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure the (-) operator works.
		  
		  Dim d1, d2 As DurationKFS
		  Dim d As Double
		  
		  d1 = 8
		  d2 = 3
		  d = d1 - d2
		  
		  AssertEquals 5, d, "Basic subtraction doesn't work."
		  
		  d1 = d2 - d1
		  Dim i As UInt64 = d1.MicrosecondsValue
		  
		  AssertEquals 0, i, "The subtraction operator did not check for the overflow condition."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestUnitConversions()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure DurationKFS can convert units correctly.
		  
		  UnitsCommonTest "microseconds", DurationKFS.kMicroseconds, 5, 5
		  UnitsCommonTest "milliseconds", DurationKFS.kMilliseconds, 5, 5000
		  UnitsCommonTest "seconds", DurationKFS.kSeconds, 5, 5000000
		  UnitsCommonTest "minutes", DurationKFS.kMinutes, 5, 300000000
		  UnitsCommonTest "hours", DurationKFS.kHours, 5, 18000000000
		  UnitsCommonTest "days", DurationKFS.kDays, 5, 432000000000
		  UnitsCommonTest "weeks", DurationKFS.kWeeks, 5, 3024000000000
		  UnitsCommonTest "months", DurationKFS.kMonths, 5, 13149000000000
		  UnitsCommonTest "years", DurationKFS.kYears, 5, 157788000000000
		  UnitsCommonTest "decades", DurationKFS.kDecades, 5, 1577880000000000
		  UnitsCommonTest "centuries", DurationKFS.kCenturies, 5, 15778800000000000
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UnitsCommonTest(unitLabel As String, unitExponent As Double, inputValue As Double, expectedMicroseconds As UInt64)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure DurationKFS can handle <unitLabel> correctly.
		  
		  Dim d As DurationKFS
		  
		  PushMessageStack "DurationKFS was not able to take a value in " + unitLabel + "."
		  
		  d = New DurationKFS( inputValue, unitExponent )
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via constructor)"
		  
		  d = inputValue
		  If unitExponent = DurationKFS.kSeconds Then
		    AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via convert constructor)"
		  Else
		    AssertNotEqual expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "The convert constructor apparently had the idea that the default units are " + unitLabel + "."
		  End If
		  
		  d.Value( unitExponent ) = inputValue
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via Value property)"
		  
		  d.IntegerValue( unitExponent ) = inputValue
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via IntegerValue property)"
		  
		  PopMessageStack
		  PushMessageStack "DurationKFS was not able to return a value in " + unitLabel + "."
		  
		  AssertEquals inputValue, d.Value( unitExponent ), "(via the Value property)"
		  
		  AssertEquals inputValue, d.IntegerValue( unitExponent ), "(via the IntegerValue property)"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="UnitTestBaseClassKFS"
		#tag EndViewProperty
		#tag ViewProperty
			Name="bCWAHHasRan"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			InheritedFrom="UnitTestBaseClassKFS"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ClassName"
			Group="Behavior"
			Type="String"
			InheritedFrom="UnitTestBaseClassKFS"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
