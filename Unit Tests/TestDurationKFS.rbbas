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
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Date + DurationKFS => Date ) and ( DurationKFS + Date => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New DurationKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = 75
		  
		  result = da + du
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The Date + DurationKFS operator did not correctly calculate a new Date."
		  
		  result = du + da
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The DurationKFS + Date operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    AssertFailure "Nil + DurationKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da + du ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  Try
		    AssertFailure "DurationKFS + Nil should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( du + da ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAddToTimer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Timer + DurationKFS => DurationKFS ) and ( DurationKFS + Timer => DurationKFS ) works.
		  
		  Dim r As New Random
		  Dim ti As New Timer
		  Dim du As New DurationKFS
		  Dim result As DurationKFS
		  
		  du = 75
		  ti.Period = 15000
		  
		  result = ti + du
		  AssertEquals 75 + 15, result.Value, "The Timer + DurationKFS operator did not correctly calculate a new DurationKFS."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  result = du + ti
		  AssertEquals 75 + 15, result.Value, "The DurationKFS + Timer operator did not correctly calculate a new DurationKFS."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  ti = Nil
		  
		  result = ti + du
		  AssertEquals 75 + 0, result.Value, "The Nil + DurationKFS operator did not correctly calculate a new DurationKFS."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  result = du + ti
		  AssertEquals 75 + 0, result.Value, "The DurationKFS + Nil operator did not correctly calculate a new DurationKFS."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClear()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the clear method works.
		  
		  Dim d As DurationKFS = 4
		  
		  AssertNonZero d.MicrosecondsValue, "Operator_Convert didn't take an integer."
		  AssertFalse d.IsRunning, "The stopwatch should not be running (1)."
		  
		  d.Clear
		  
		  AssertZero d.MicrosecondsValue, "The Clear method did not set the microseconds to zero."
		  AssertFalse d.IsRunning, "The stopwatch should not be running (2)."
		  
		  d = 4
		  d.Start
		  
		  AssertNonZero d.MicrosecondsValue, "Operator_Convert didn't take an integer."
		  AssertTrue d.IsRunning, "The stopwatch should be running (3)."
		  
		  d.Clear
		  
		  AssertZero d.MicrosecondsValue, "The Clear method did not stop the stopwatch."
		  AssertFalse d.IsRunning, "The stopwatch should not be running (4)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestCompare()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the compare operators work.
		  
		  Dim d As DurationKFS
		  
		  AssertTrue d Is Nil, "The Operator_Compare method does not think that a Nil DurationKFS is Nil."
		  
		  d = 4
		  
		  AssertFalse d Is Nil, "The Operator_Compare method thinks that a non-Nil DurationKFS is Nil."
		  
		  AssertTrue d = 4, "Either Operator_Convert did not take an integer correctly, or Operator_Compare did not compare correctly."
		  
		  // Make sure the compare operators respect the stopwatch.
		  
		  d = 3.99
		  d.Start
		  Dim t As UInt64 = Microseconds
		  
		  While Microseconds - t < 10000
		    
		  Wend
		  
		  AssertTrue d > 4, "Either the stopwatch isn't working correctly, or Operator_Compare does not respect the stopwatch."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDateDifference()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the date difference constructor works.
		  
		  Dim r As New Random
		  Dim d1 As New Date
		  Dim d2 As New Date
		  Dim result As DurationKFS
		  
		  d1.TotalSeconds = r.InRange( d1.TotalSeconds - 1000, d1.TotalSeconds + 1000 )
		  d2.TotalSeconds = r.InRange( d2.TotalSeconds - 1000, d2.TotalSeconds + 1000 )
		  
		  result = DurationKFS.DateDifference( d1, d2 )
		  
		  AssertEquals d1.TotalSeconds - d2.TotalSeconds, result.Value, "The Date Difference constructor did not correctly calculate the difference."
		  AssertFalse result.IsRunning, "The stopwatch should not be running."
		  
		  Try
		    
		    Call DurationKFS.DateDifference( d1, Nil )
		    
		    AssertFailure "The Date Difference constructor did not raise an error when getting the difference between d1 and Nil."
		    
		  Catch err As NilObjectException
		  End Try
		  
		  Try
		    
		    Call DurationKFS.DateDifference( Nil, d2 )
		    
		    AssertFailure "The Date Difference constructor did not raise an error when getting the difference between Nil and d2."
		    
		  Catch err As NilObjectException
		  End Try
		  
		  // done.
		  
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
		    AssertFailure "(via constructor)  Result was " + ObjectDescriptionKFS( New DurationKFS( 5, iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    d = New DurationKFS
		    d.Value( iu ) = 5
		    AssertFailure "(via setting Value property)  Result was " + ObjectDescriptionKFS( d ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    d = New DurationKFS
		    d.IntegerValue( iu ) = 5
		    AssertFailure "(via setting IntegerValue property)  Result was " + ObjectDescriptionKFS( d ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    d = 5
		    AssertFailure "(via getting Value property)  Result was " + ObjectDescriptionKFS( d.Value( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    d = 5
		    AssertFailure "(via getting IntegerValue property)  Result was " + ObjectDescriptionKFS( d.IntegerValue( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMaximumValue()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the MaximumValue constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.MaximumValue
		  
		  // The maximum value should be 18,446,744,073,709,551,615.
		  
		  AssertEquals 18446744073709551615, d.MicrosecondsValue, "MaximumValue did not return a DurationKFS with the expected maximum value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMinimumValue()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the MinimumValue constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.MinimumValue
		  
		  // The maximum value should be 0.
		  
		  AssertEquals 0, d.MicrosecondsValue, "MinimumValue did not return a DurationKFS with the expected minimum value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestModulo()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMultiplyByScalar()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure multiplying by a scalar works.
		  
		  Dim d As DurationKFS = 3
		  
		  AssertEquals 3000000, d.MicrosecondsValue, "A DurationKFS did not acquire the requested value."
		  
		  d = d * 3
		  
		  AssertFalse d.IsRunning, "Multiplication by a scalar should not return a DurationKFS with the stopwatch running."
		  AssertEquals 9000000, d.MicrosecondsValue, "DurationKFS * Double did not work."
		  
		  d = 3 * d
		  
		  AssertFalse d.IsRunning, "Multiplication by a scalar should not return a DurationKFS with the stopwatch running."
		  AssertEquals 27000000, d.MicrosecondsValue, "Double * DurationKFS did not work."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromMicrosecondsValue()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewFromMicrosecondsValue constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.NewFromMicrosecondsValue( 1194832 )
		  
		  // The MicrosecondsValue of the object should be 1194832.
		  
		  AssertEquals 1194832, d.MicrosecondsValue, "NewFromMicrosecondsValue did not return a DurationKFS with the expected value."
		  
		  // The stopwatch should not be running.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewStopwatchStartingNow()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewStopwatchStartingNow constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.NewStopwatchStartingNow
		  
		  // The MicrosecondsValue should be very low, but it is hard to definitively test for that.
		  
		  // In any case, the stopwatch should be running.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchCancel()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure canceling the stopwatch works.
		  
		  Dim d As DurationKFS = 1
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertEquals 1000000, d.MicrosecondsValue, "A DurationKFS did not acquire a value of one second."
		  AssertEquals d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertPositive d.MicrosecondsValue - 1000000, "The stopwatch should be adding to the pre-existing value when it is running."
		  'AssertNotEqual d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		  
		  d.CancelStopwatch
		  
		  // The stopwatch should not be running anymore, and the value should be back to zero.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running anymore."
		  AssertEquals 1000000, d.MicrosecondsValue, "The stopwatch value should be reverted when it is canceled."
		  AssertEquals d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchSplit()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure splitting the stopwatch works.
		  
		  Dim d As DurationKFS = 0
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertZero d.MicrosecondsValue, "A DurationKFS did not acquire a value of zero."
		  AssertEquals d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch should be adding to the pre-existing value when it is running."
		  'AssertNotEqual d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		  
		  Dim d2 As DurationKFS = d.Split
		  
		  // The first stopwatch should not be running anymore, and the value should be slightly greater than zero.
		  
		  AssertFalse d.IsRunning, "The first stopwatch should not be running anymore (after calling Split)."
		  AssertPositive d.MicrosecondsValue, "The first stopwatch's value should not have been reverted when Split was called."
		  AssertEquals d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  
		  // The Second stopwatch should be running, and the value should be slightly greater than zero.
		  
		  AssertTrue d2.IsRunning, "The second stopwatch should be running."
		  AssertPositive d2.MicrosecondsValue, "The second stopwatch should be adding to the pre-existing value when it is running."
		  'AssertNotEqual d2.MicrosecondsValue, d2.MicrosecondsValue, "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		  
		  // Let's cancel the second stopwatch to see what the original value was (it has better be zero).
		  
		  d2.CancelStopwatch
		  
		  AssertFalse d2.IsRunning, "The second stopwatch should have no reason to not be able to cancel."
		  AssertZero d2.MicrosecondsValue, "The second stopwatch value should be reverted to zero if it is canceled."
		  AssertEquals d2.MicrosecondsValue, d2.MicrosecondsValue, "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStopwatchStartStop()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure starting and stopping the stopwatch works.
		  
		  Dim d As DurationKFS = 0
		  
		  AssertFalse d.IsRunning, "A DurationKFS apparently was initialized with the stopwatch running."
		  AssertZero d.MicrosecondsValue, "A DurationKFS did not acquire a value of zero."
		  AssertEquals d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  
		  d.Start
		  
		  // The MicrosecondsValue should be very low and climbing, but it is hard to definitively test for that.
		  
		  AssertTrue d.IsRunning, "The stopwatch should be running."
		  AssertPositive d.MicrosecondsValue, "The stopwatch should be adding to the pre-existing value when it is running."
		  'AssertNotEqual d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		  
		  d.Stop
		  
		  // The stopwatch should not be running anymore.
		  
		  AssertFalse d.IsRunning, "The stopwatch should not be running anymore."
		  AssertPositive d.MicrosecondsValue, "The stopwatch value should not be reverted when it is stopped."
		  AssertEquals d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should return the same result when the stopwatch is not running."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSubtractFromDate()
		  // Created 8/19/2010 by Andrew Keller
		  
		  // Make sure that ( Date - DurationKFS => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New DurationKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = 75
		  
		  result = da - du
		  AssertEquals da.TotalSeconds - du.Value, result.TotalSeconds, "The Date - DurationKFS operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    AssertFailure "Nil - DurationKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da - du ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  // done.
		  
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
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  d = inputValue
		  If unitExponent = DurationKFS.kSeconds Then
		    AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via convert constructor)"
		  Else
		    AssertNotEqual expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "The convert constructor apparently had the idea that the default units are " + unitLabel + "."
		  End If
		  
		  d.Value( unitExponent ) = inputValue
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via Value property)"
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  d.IntegerValue( unitExponent ) = inputValue
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via IntegerValue property)"
		  AssertFalse d.IsRunning, "The stopwatch should not be running."
		  
		  PopMessageStack
		  PushMessageStack "DurationKFS was not able to return a value in " + unitLabel + "."
		  
		  AssertEquals inputValue, d.Value( unitExponent ), "(via the Value property)"
		  
		  AssertEquals inputValue, d.IntegerValue( unitExponent ), "(via the IntegerValue property)"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = WTF
		Okay, so I found a problem that I found rather interesting, but
		since it's not absolutely critical and I'm rather short on time
		at the moment, I'm going to place this one on the back burner.
		
		According to my tests on my 2.16 GHz MBP, the smallest I
		can get the difference between two successive reads of the
		Microseconds function is 3 microseconds.
		
		BUT...  somehow...  two successive reads of the MicrosecondsValue
		property of a DurationKFS object can return identical values.
		
		You might notice that in some tests, an assertion such as:
		
		AssertNotEqual d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		
		Is commented out.  This is because I haven't decided whether
		or not this is a big enough problem to catch and squash.
		
		This behavior is approximately 10% reproducible on my
		computer at the moment.  Just uncomment all of the
		assertions like the one above, and keep running the tests
		over and over again until something fails.
		
	#tag EndNote


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
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
