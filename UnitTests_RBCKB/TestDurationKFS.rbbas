#tag Class
Protected Class TestDurationKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Function Factory_Construct() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDurationKFS(other As DurationKFS) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromTimer(other As Timer) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_ConstructFromWebTimer(other As WebTimer) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_DurationKFS(d As DurationKFS) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_Timer(t As Timer) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_NewFromClone_WebTimer(t As WebTimer) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromSystemUptime() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMaximum() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMicroseconds(newValue As Int64) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMinimum() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithNegativeInfinity() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithPositiveInfinity() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithUndefined() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithZero() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConcept_InvalidUnit()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure the DurationKFS class fails when dealing with invalid units.
		  
		  Dim d As DurationKFS
		  Dim iu As Double = 4.8
		  
		  PushMessageStack "DurationKFS did not throw an exception when dealing with an invalid unit."
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "(via constructor)  Result was " + ObjectDescriptionKFS( Factory_ConstructFromValue( 5, iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = DurationKFS.NewWithValue( 5 )
		    AssertFailure "(via getting Value property)  Result was " + ObjectDescriptionKFS( d.Value( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = DurationKFS.NewWithValue( 5 )
		    AssertFailure "(via getting IntegerValue property)  Result was " + ObjectDescriptionKFS( d.IntegerValue( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConcept_UnitConversions()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure DurationKFS can convert units correctly.
		  
		  TestConcept_Units "microseconds", DurationKFS.kMicroseconds, 5, 5
		  TestConcept_Units "milliseconds", DurationKFS.kMilliseconds, 5, 5000
		  TestConcept_Units "seconds", DurationKFS.kSeconds, 5, 5000000
		  TestConcept_Units "minutes", DurationKFS.kMinutes, 5, 300000000
		  TestConcept_Units "hours", DurationKFS.kHours, 5, 18000000000
		  TestConcept_Units "days", DurationKFS.kDays, 5, 432000000000
		  TestConcept_Units "weeks", DurationKFS.kWeeks, 5, 3024000000000
		  TestConcept_Units "months", DurationKFS.kMonths, 5, 13149000000000
		  TestConcept_Units "years", DurationKFS.kYears, 5, 157788000000000
		  TestConcept_Units "decades", DurationKFS.kDecades, 5, 1577880000000000
		  TestConcept_Units "centuries", DurationKFS.kCenturies, 5, 15778800000000000
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConcept_Units(unitLabel As String, unitExponent As Double, inputValue As Double, expectedMicroseconds As UInt64)
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure DurationKFS can handle <unitLabel> correctly.
		  
		  Dim d As DurationKFS
		  
		  PushMessageStack "DurationKFS was not able to take a value in " + unitLabel + "."
		  
		  d = New DurationKFS( inputValue, unitExponent )
		  AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via constructor)"
		  
		  d = New DurationKFS( inputValue )
		  If unitExponent = DurationKFS.kSeconds Then
		    AssertEquals expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "(via convert constructor)"
		  Else
		    AssertNotEqual expectedMicroseconds, d.Value( DurationKFS.kMicroseconds ), "The convert constructor apparently had the idea that the default units are " + unitLabel + "."
		  End If
		  
		  PopMessageStack
		  PushMessageStack "DurationKFS was not able to return a value in " + unitLabel + "."
		  
		  AssertEquals inputValue, d.Value( unitExponent ), "(via the Value property)"
		  
		  AssertEquals inputValue, d.IntegerValue( unitExponent ), "(via the IntegerValue property)"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Date_Date(dLater As Date, dEarlier As Date)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Double_Double(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_DurationKFS(other As DurationKFS)
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the clone operation works.
		  
		  // Clone of normal object
		  
		  Dim d As New DurationKFS( 2 )
		  d = New DurationKFS( d )
		  
		  AssertFalse d Is Nil, "The clone constructor returned Nil from a normal duration."
		  AssertEquals 2, d.Value, "The clone constructor did not clone the value correctly (not running)."
		  
		  // Clone of Nil object
		  
		  d = Nil
		  Try
		    d = New DurationKFS( d )
		  Catch err As NilObjectException
		    AssertFailure "The clone constructor is not supposed to fail when given Nil."
		  End Try
		  
		  AssertNotIsNil d, "The clone constructor is not supposed to return Nil when given Nil."
		  AssertZero d.Value, "When cloning Nil, the value should be zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Timer(other As Timer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestConstructor_WebTimer(other As WebTimer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIntegerValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIntegerValue_Double()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsInfinity()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsNegative()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsOverflow()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsPositive()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsUndefined()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestIsZero()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_DoubleToMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_Int64ToMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsDividedByMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsDividedByScalar()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsMinusMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsModMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsPlusMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsTimesScalar()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsToDouble()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsToInt64()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMicrosecondsValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromClone_DurationKFS()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromClone_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestNewFromClone_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromDateDifference()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the date difference constructor works.
		  
		  Dim r As New Random
		  Dim d1 As New Date
		  Dim d2 As New Date
		  Dim result As DurationKFS
		  
		  d1.TotalSeconds = r.InRange( d1.TotalSeconds - 1000, d1.TotalSeconds + 1000 )
		  d2.TotalSeconds = r.InRange( d2.TotalSeconds - 1000, d2.TotalSeconds + 1000 )
		  
		  result = DurationKFS.NewFromDateDifference( d1, d2 )
		  
		  AssertEquals d1.TotalSeconds - d2.TotalSeconds, result.Value, "The Date Difference constructor did not correctly calculate the difference."
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    Call DurationKFS.NewFromDateDifference( d1, Nil )
		    
		    AssertFailure "The Date Difference constructor did not raise an error when getting the difference between d1 and Nil."
		    
		  Catch err As NilObjectException
		  End Try
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    Call DurationKFS.NewFromDateDifference( Nil, d2 )
		    
		    AssertFailure "The Date Difference constructor did not raise an error when getting the difference between Nil and d2."
		    
		  Catch err As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromSystemUptime()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithMaximum()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewWithMaximum constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.NewWithMaximum
		  
		  // The maximum value should be 18,446,744,073,709,551,615.
		  
		  Dim m As UInt64 = -1
		  AssertEquals m, d.MicrosecondsValue, "NewWithMaximum did not return a DurationKFS with the expected maximum value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithMicroseconds()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewWithMicroseconds constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.NewWithMicroseconds( 1194832 )
		  
		  // The MicrosecondsValue of the object should be 1194832.
		  
		  AssertEquals 1194832, d.MicrosecondsValue, "NewWithMicroseconds did not return a DurationKFS object with the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithMinimum()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewWithMinimum constructor works.
		  
		  Dim d As DurationKFS = DurationKFS.NewWithMinimum
		  
		  // The maximum value should be 0.
		  
		  AssertEquals 0, d.MicrosecondsValue, "NewWithMinimum did not return a DurationKFS with the expected minimum value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithNegativeInfinity()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithPositiveInfinity()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithUndefined()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithZero()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNextUniqueID()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_AddRight_Date()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Date + DurationKFS => Date ) and ( DurationKFS + Date => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New DurationKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = DurationKFS.NewWithValue( 75 )
		  
		  result = da + du
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The Date + DurationKFS operator did not correctly calculate a new Date."
		  
		  result = du + da
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The DurationKFS + Date operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "Nil + DurationKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da + du ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "DurationKFS + Nil should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( du + da ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_AddRight_Timer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Timer + DurationKFS => DurationKFS ) and ( DurationKFS + Timer => DurationKFS ) works.
		  
		  Dim r As New Random
		  Dim ti As New Timer
		  Dim du As New DurationKFS
		  Dim result As DurationKFS
		  
		  du = DurationKFS.NewWithValue( 75 )
		  ti.Period = 15000
		  
		  result = ti + du
		  AssertEquals 75 + 15, result.Value, "The Timer + DurationKFS operator did not correctly calculate a new DurationKFS."
		  
		  result = du + ti
		  AssertEquals 75 + 15, result.Value, "The DurationKFS + Timer operator did not correctly calculate a new DurationKFS."
		  
		  ti = Nil
		  
		  result = ti + du
		  AssertEquals 75 + 0, result.Value, "The Nil + DurationKFS operator did not correctly calculate a new DurationKFS."
		  
		  result = du + ti
		  AssertEquals 75 + 0, result.Value, "The DurationKFS + Nil operator did not correctly calculate a new DurationKFS."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_AddRight_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_Date()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Date + DurationKFS => Date ) and ( DurationKFS + Date => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New DurationKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = DurationKFS.NewWithValue( 75 )
		  
		  result = da + du
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The Date + DurationKFS operator did not correctly calculate a new Date."
		  
		  result = du + da
		  AssertEquals da.TotalSeconds + du.Value, result.TotalSeconds, "The DurationKFS + Date operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "Nil + DurationKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da + du ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "DurationKFS + Nil should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( du + da ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_DurationKFS()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure the (+) operator works.
		  
		  Dim d1, d2, result As DurationKFS
		  
		  d1 = DurationKFS.NewWithValue( 4 )
		  d2 = DurationKFS.NewWithValue( 8 )
		  result = d1 + d2
		  
		  AssertEquals 12, result.Value, "Basic addition doesn't work."
		  
		  d1 = DurationKFS.NewWithMicroseconds( -16 )
		  d2 = DurationKFS.NewWithMicroseconds( 50 )
		  
		  d1 = d1 + d2
		  Dim i As UInt64 = d1.MicrosecondsValue
		  
		  AssertEquals DurationKFS.NewWithMaximum.MicrosecondsValue, i, "The addition operator did not check for the overflow condition."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_Timer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Timer + DurationKFS => DurationKFS ) and ( DurationKFS + Timer => DurationKFS ) works.
		  
		  Dim r As New Random
		  Dim ti As New Timer
		  Dim du As New DurationKFS
		  Dim result As DurationKFS
		  
		  du = DurationKFS.NewWithValue( 75 )
		  ti.Period = 15000
		  
		  result = ti + du
		  AssertEquals 75 + 15, result.Value, "The Timer + DurationKFS operator did not correctly calculate a new DurationKFS."
		  
		  result = du + ti
		  AssertEquals 75 + 15, result.Value, "The DurationKFS + Timer operator did not correctly calculate a new DurationKFS."
		  
		  ti = Nil
		  
		  result = ti + du
		  AssertEquals 75 + 0, result.Value, "The Nil + DurationKFS operator did not correctly calculate a new DurationKFS."
		  
		  result = du + ti
		  AssertEquals 75 + 0, result.Value, "The DurationKFS + Nil operator did not correctly calculate a new DurationKFS."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Add_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Compare_DurationKFS()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the compare operators work.
		  
		  Dim d, d2 As DurationKFS
		  
		  d = DurationKFS.NewWithValue( 4 )
		  AssertFalse d = d2, "The Operator_Compare method thinks that a non-Nil DurationKFS is Nil."
		  
		  d2 = DurationKFS.NewWithValue( 4 )
		  AssertTrue d = d2, "Either Operator_Convert did not take an integer correctly, or Operator_Compare did not compare correctly."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Compare_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Compare_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_Double()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure division works.
		  
		  Dim d1 As New DurationKFS( 12 )
		  Dim d2 As New DurationKFS( 4 )
		  
		  AssertEquals 3, d1 / d2, "DurationKFS does not correctly calculate ratios of durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Divide_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_IntegerDivide_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure integer division works.
		  
		  Dim d1 As New DurationKFS( 12 )
		  Dim d2 As New DurationKFS( 5 )
		  
		  AssertEquals 2, d1 \ d2, "DurationKFS does not correctly calculate integer ratios of durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_IntegerDivide_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_IntegerDivide_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Modulo_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure finding a remainder works.
		  
		  Dim d1 As New DurationKFS( 12 )
		  Dim d2 As New DurationKFS( 5 )
		  Dim expected As New DurationKFS( 2 )
		  
		  AssertTrue expected = d1 Mod d2, "DurationKFS does not correctly calculate a modulo of two durations."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Modulo_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Modulo_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_MultiplyRight_Double()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure multiplying by a scalar works.
		  
		  Dim d As New DurationKFS( 3 )
		  
		  AssertEquals 3000000, d.MicrosecondsValue, "A DurationKFS did not acquire the requested value."
		  
		  d = d * 3
		  
		  AssertEquals 9000000, d.MicrosecondsValue, "DurationKFS * Double did not work."
		  
		  d = 3 * d
		  
		  AssertEquals 27000000, d.MicrosecondsValue, "Double * DurationKFS did not work."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Multiply_Double()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Make sure multiplying by a scalar works.
		  
		  Dim d As New DurationKFS( 3 )
		  
		  AssertEquals 3000000, d.MicrosecondsValue, "A DurationKFS did not acquire the requested value."
		  
		  d = d * 3
		  
		  AssertEquals 9000000, d.MicrosecondsValue, "DurationKFS * Double did not work."
		  
		  d = 3 * d
		  
		  AssertEquals 27000000, d.MicrosecondsValue, "Double * DurationKFS did not work."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Negate()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_SubtractRight_Date()
		  // Created 8/19/2010 by Andrew Keller
		  
		  // Make sure that ( Date - DurationKFS => Date ) works.
		  
		  Dim r As New Random
		  Dim da As New Date
		  Dim du As New DurationKFS
		  Dim result As Date
		  
		  da.TotalSeconds = r.InRange( da.TotalSeconds - 1000, da.TotalSeconds + 1000 )
		  du = DurationKFS.NewWithValue( 75 )
		  
		  result = da - du
		  AssertEquals da.TotalSeconds - du.Value, result.TotalSeconds, "The Date minus DurationKFS operator did not correctly calculate a new Date."
		  
		  da = Nil
		  
		  Try
		    #pragma BreakOnExceptions Off
		    AssertFailure "Nil minus DurationKFS should raise a NilObjectException, but instead returned " + ObjectDescriptionKFS( da - du ) + "."
		  Catch e As NilObjectException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_SubtractRight_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_SubtractRight_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Subtract_DurationKFS()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure the (-) operator works.
		  
		  Dim d1, d2, result As DurationKFS
		  
		  d1 = DurationKFS.NewWithValue( 8 )
		  d2 = DurationKFS.NewWithValue( 3 )
		  result = d1 - d2
		  
		  AssertEquals 5, result.Value, "Basic subtraction doesn't work."
		  
		  d1 = d2 - d1
		  Dim i As UInt64 = d1.MicrosecondsValue
		  
		  AssertEquals 0, i, "The subtraction operator did not check for the overflow condition."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Subtract_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Subtract_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestShortHumanReadableStringValue()
		  // Created 8/30/2010 by Andrew Keller
		  
		  // Make sure the ShortHumanReadableStringValue function works.
		  
		  Dim d As New DurationKFS
		  
		  PushMessageStack "ShortHumanReadableStringValue did not return an expected value."
		  
		  AssertEquals "0 us", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "0 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "0.00 ms", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "0.00 s", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "0.00 m", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "0.00 h", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "0.00 d", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "0.00 w", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "0.00 mon", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "0.00 y", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "0.00 dec", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "0.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  d = New DurationKFS( 5 )
		  
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "0.08 m", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "0.00 h", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "0.00 d", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "0.00 w", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "0.00 mon", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "0.00 y", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "0.00 dec", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "0.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "5000000 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5000 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  
		  d = New DurationKFS( 5, DurationKFS.kCenturies )
		  
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "15778800000000000 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "15778800000000 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "15778800000 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  AssertEquals "262980000 m", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMinutes ), "", False
		  AssertEquals "4383000 h", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kHours ), "", False
		  AssertEquals "182625 d", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDays ), "", False
		  AssertEquals "26089 w", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kWeeks ), "", False
		  AssertEquals "6000 mon", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMonths ), "", False
		  AssertEquals "500 y", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kYears ), "", False
		  AssertEquals "50.0 dec", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDecades ), "", False
		  AssertEquals "5.00 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kCenturies ), "", False
		  
		  d = DurationKFS.NewWithMaximum
		  
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue, "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMilliseconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kSeconds ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMinutes ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kHours ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kDays ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kWeeks ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMonths ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kYears ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kDecades ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kCenturies ), "", False
		  
		  AssertEquals "18446744073709551615 us", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMicroseconds ), "", False
		  AssertEquals "18446744073709552 ms", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMilliseconds ), "", False
		  AssertEquals "18446744073710 s", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kSeconds ), "", False
		  AssertEquals "307445734562 m", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMinutes ), "", False
		  AssertEquals "5124095576 h", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kHours ), "", False
		  AssertEquals "213503982 d", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDays ), "", False
		  AssertEquals "30500569 w", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kWeeks ), "", False
		  AssertEquals "7014505 mon", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kMonths ), "", False
		  AssertEquals "584542 y", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kYears ), "", False
		  AssertEquals "58454 dec", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kDecades ), "", False
		  AssertEquals "5845 cen", d.ShortHumanReadableStringValue( DurationKFS.kMicroseconds, DurationKFS.kCenturies ), "", False
		  
		  PopMessageStack
		  
		  // Now, make sure that the ShortHumanReadableStringValue fails when it is supposed to.
		  
		  d = New DurationKFS( 5 )
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( DurationKFS.kYears, DurationKFS.kSeconds )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when minUnit > maxUnit."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( 10, 15 )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when the requested units are above the range of the available units."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    Call d.ShortHumanReadableStringValue( -10, -7 )
		    AssertFailure "ShortHumanReadableStringValue did not throw an UnsupportedFormatException when the requested units are below the range of the available units."
		  Catch err As UnsupportedFormatException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestValue_Double(powerOfTen As Double)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010 - 2012 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a list of all contributors for this library.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
		  contributors may be used to endorse or promote products derived
		  from this software without specific prior written permission.
		
		THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
		"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
		LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
		FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
		COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
		INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
		BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
		LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
		CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
		LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
		ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
		POSSIBILITY OF SUCH DAMAGE.
	#tag EndNote

	#tag Note, Name = WTF
		Okay, so I found a problem that I found rather interesting, but
		since it's not absolutely critical and I'm rather short on time
		at the moment, I'm going to place this one on the back burner.
		
		According to my tests on my 2.16 GHz MBP, the smallest I
		can get the difference between two successive reads of the
		Microseconds function is 3 microseconds.
		
		BUT...  somehow...  two successive reads of the MicrosecondsValue
		property of a DurationKFS object can return identical values.
		
		The following assertion has the ability to fail with a running stopwatch:
		
		AssertNotEqual d.MicrosecondsValue, d.MicrosecondsValue, "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		
		This is why assertions like that were replaced by:
		
		AssertTrue MicrosecondsValueIncreases( d ), "Successive calls of MicrosecondsValue should not return the same result when the stopwatch is running."
		
		The MicrosecondsValueIncreases function checks for a change
		over a longer period of time, so that changes are easier to find.
		
		This behavior is approximately 10% reproducible on my
		computer at the moment.  Just set the timeout in the
		MicrosecondsValueIncreases function to zero, and keep
		running the tests over and over again until something fails.
	#tag EndNote


	#tag Constant, Name = kStopwatchObservationTimeout, Type = Double, Dynamic = False, Default = \"30", Scope = Public
	#tag EndConstant


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
