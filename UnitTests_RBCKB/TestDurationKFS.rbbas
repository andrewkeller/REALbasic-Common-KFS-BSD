#tag Class
Protected Class TestDurationKFS
Inherits UnitTestBaseClassKFS
	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_Date_Date(dLater As Date, dEarlier As Date) As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_Double_Double(newValue As Double, powerOfTen As Double = DurationKFS . kSeconds) As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_DurationKFS(other As DurationKFS) As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_Timer(other As Timer) As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_void() As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0, CompatibilityFlags = TargetWeb
		Delegate Function ConstructorFactoryMethod_WebTimer(other As WebTimer) As DurationKFS
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Factory_Construct() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( dLater, dEarlier )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDurationKFS(other As DurationKFS) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromTimer(other As Timer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( newValue, powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_ConstructFromWebTimer(other As WebTimer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_DurationKFS(d As DurationKFS) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromClone( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_Timer(t As Timer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromClone( t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_NewFromClone_WebTimer(t As WebTimer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromClone( t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromDateDifference( dLater, dEarlier )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromSystemUptime() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromSystemUptime
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMaximum() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithMaximum
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMicroseconds(newValue As Int64) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithMicroseconds( newValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMinimum() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithMinimum
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithNegativeInfinity() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithNegativeInfinity
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithPositiveInfinity() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithPositiveInfinity
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithUndefined() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithUndefined
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithValue( newValue, powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithZero() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithZero
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListDataScenariosToTest(tuneForClass As String) As String()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Returns a list of all the data scenarios that need to be tested.
		  
		  If tuneForClass = "DurationKFS" Then
		    
		    Return Array( _
		    "Nil", _
		    "undefined", _
		    "neginf", _
		    "posinf", _
		    "negovr", _
		    "posovr", _
		    "negreal", _
		    "posreal", _
		    "zero" )
		    
		  ElseIf tuneForClass = "Date" Then
		    
		    Return Array( _
		    "Nil", _
		    "negreal", _
		    "posreal", _
		    "zero" )
		    
		  ElseIf tuneForClass = "Timer" Or tuneForClass = "WebTimer" Then
		    
		    Return Array( _
		    "Nil", _
		    "posreal", _
		    "zero" )
		    
		  ElseIf tuneForClass = "Double" Then
		    
		    Return Array( _
		    "negreal", _
		    "posreal", _
		    "zero" )
		    
		  Else
		    
		    AssertFailure "Unknown class for which to generate data scenarios: '" + tuneForClass + "'."
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListDurationClassesToTest() As String()
		  // Created 1/29/2012 by Andrew Keller
		  
		  // Returns a list of classes that need to be tested in this class.
		  
		  Return Array( "DurationKFS" )
		  
		  // done.
		  
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
		    d = Factory_NewWithValue( 5 )
		    AssertFailure "(via getting Value property)  Result was " + ObjectDescriptionKFS( d.Value( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  Try
		    #pragma BreakOnExceptions Off
		    d = Factory_NewWithValue( 5 )
		    AssertFailure "(via getting IntegerValue property)  Result was " + ObjectDescriptionKFS( d.IntegerValue( iu ) ) + "."
		  Catch e As UnsupportedFormatException
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConcept_UnitConversions()
		  // Created 8/6/2010 by Andrew Keller
		  
		  // Makes sure the DurationKFS class can convert units correctly.
		  
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
		  
		  // Makes sure the DurationKFS class can handle <unitLabel> correctly.
		  
		  Dim d(-1) As DurationKFS
		  Dim s(-1) As String
		  
		  d.Append Factory_ConstructFromValue( inputValue, unitExponent )
		  s.Append "(via constructor)"
		  
		  d.Append Factory_NewWithValue( inputValue, unitExponent )
		  s.Append "(via shared constructor)"
		  
		  PushMessageStack "DurationKFS was not able to take a value in " + unitLabel + "."
		  
		  For i As Integer = 0 To 1
		    
		    PushMessageStack s(i)
		    
		    If PresumeNotIsNil( d(i), "Uh, the factory method returned Nil.  Gotta fix that first." ) Then
		      AssertEquals expectedMicroseconds, d(i).MicrosecondsValue, "(problem detected with the MicrosecondsValue property)", False
		      AssertEquals expectedMicroseconds, d(i).Value( DurationKFS.kMicroseconds ), "(problem detected with the Value property)", False
		      AssertEquals expectedMicroseconds, d(i).IntegerValue( DurationKFS.kMicroseconds ), "(problem detected with the IntegerValue property)", False
		    End If
		    
		    PopMessageStack
		    
		  Next
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Date_Date()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Double_Double()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_DurationKFS()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the clone constructor works.
		  
		  Dim orig, clone As DurationKFS
		  
		  // Make sure we can clone Nil:
		  
		  clone = Factory_ConstructFromDurationKFS( orig )
		  
		  AssertNotIsNil clone, "The clone constructor is never supposed to return Nil."
		  AssertZero clone.MicrosecondsValue, "When cloning Nil, the value should be zero."
		  
		  // Make sure we can clone a DurationKFS object:
		  
		  orig = Factory_NewWithMicroseconds(13)
		  clone = Factory_ConstructFromDurationKFS( orig )
		  
		  AssertNotIsNil clone, "The clone constructor is never supposed to return Nil."
		  AssertEquals 13, clone.MicrosecondsValue, "When cloning a real DurationKFS object, the value should be inherited."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestConstructor_WebTimer()
		  
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
		  
		  Worker_TestNewOrConstructFromDateDifference AddressOf Factory_NewFromDateDifference
		  
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
		  
		  Dim d As DurationKFS = Factory_NewWithMaximum
		  
		  // The maximum value should be 9,223,372,036,854,775,805
		  
		  Dim m As Int64 = 9223372036854775805
		  AssertEquals m, d.MicrosecondsValue, "NewWithMaximum did not return a DurationKFS with the expected maximum value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithMicroseconds()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewWithMicroseconds constructor works.
		  
		  Dim d As DurationKFS = Factory_NewWithMicroseconds( 1194832 )
		  
		  // The MicrosecondsValue of the object should be 1194832.
		  
		  AssertEquals 1194832, d.MicrosecondsValue, "NewWithMicroseconds did not return a DurationKFS object with the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithMinimum()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewWithMinimum constructor works.
		  
		  Dim d As DurationKFS = Factory_NewWithMinimum
		  
		  // The minimum value should be -9,223,372,036,854,775,805
		  
		  Dim m As Int64 = -9223372036854775805
		  AssertEquals m, d.MicrosecondsValue, "NewWithMinimum did not return a DurationKFS with the expected minimum value."
		  
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
		  
		  // Make sure that ( Date + DurationKFS => Date ) works.
		  
		  For Each ltype As String In Array("Date")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_AddRight_Timer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Timer + DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_AddRight_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Make sure that ( WebTimer + DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_Date()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( DurationKFS + Date => Date ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Date")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_DurationKFS()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure that ( DurationKFS + DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_Timer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( DurationKFS + Timer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Add_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Make sure that ( DurationKFS + WebTimer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Compare_DurationKFS()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure a DurationKFS object can be compared to another DurationKFS object.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "compare", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Compare_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Make sure a DurationKFS object can be compared to a Timer object.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "compare", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Compare_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Make sure a DurationKFS object can be compared to a WebTimer object.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "compare", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_DivideRight_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( Timer / DurationKFS => Double ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_DivideRight_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( WebTimer / DurationKFS => Double ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_Double()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS / Double => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Double")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS / DurationKFS => Double ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS / Timer => Double ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Divide_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS / WebTimer => Double ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_IntegerDivideRight_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( Timer \ DurationKFS => Int64 ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_IntegerDivideRight_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( WebTimer \ DurationKFS => Int64 ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_IntegerDivide_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS \ DurationKFS => Int64 ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_IntegerDivide_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS \ Timer => Int64 ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_IntegerDivide_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS \ WebTimer => Int64 ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_ModuloRight_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( Timer Mod DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_ModuloRight_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( WebTimer Mod DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Modulo_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS Mod DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Modulo_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS Mod Timer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Modulo_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS Mod WebTimer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_MultiplyRight_Double()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( Double * DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("Double")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "multiply", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Multiply_Double()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS * Double => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Double")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "multiply", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Negate()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Makes sure ( -DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      
		      Worker_TestSimpleOperation "negate", lsen, ltype
		      
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_SubtractRight_Date()
		  // Created 8/19/2010 by Andrew Keller
		  
		  // Makes sure ( Date - DurationKFS => Date ) works.
		  
		  For Each ltype As String In Array("Date")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_SubtractRight_Timer()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Makes sure ( Timer - DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_SubtractRight_WebTimer()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Makes sure ( WebTimer - DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Subtract_DurationKFS()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS - DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Subtract_Timer()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS - Timer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Subtract_WebTimer()
		  // Created 1/29/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS - WebTimer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosToTest(ltype)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosToTest(rtype)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
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
		Sub TestValue_Double()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstruct(factory_method As ConstructorFactoryMethod_void)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstructFromClone_DurationKFS(factory_method As ConstructorFactoryMethod_DurationKFS)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstructFromClone_Timer(factory_method As ConstructorFactoryMethod_Timer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub Worker_TestNewOrConstructFromClone_WebTimer(factory_method As ConstructorFactoryMethod_WebTimer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstructFromDateDifference(factory_method As ConstructorFactoryMethod_Date_Date)
		  // Created 1/22/2012 by Andrew Keller
		  
		  // Make sure the given date difference constructor works properly.
		  
		  Dim r As New Random
		  Dim dEarlier As New Date
		  Dim dLater As New Date
		  Dim result As DurationKFS
		  
		  // Generate the dates:
		  
		  Do
		    dEarlier.TotalSeconds = r.InRange( dEarlier.TotalSeconds - 1000, dEarlier.TotalSeconds + 1000 )
		    dLater.TotalSeconds = r.InRange( dLater.TotalSeconds - 1000, dLater.TotalSeconds + 1000 )
		  Loop Until dEarlier.TotalSeconds < dLater.TotalSeconds
		  
		  // Test the 'positive' scenerio:
		  
		  result = factory_method.Invoke( dLater, dEarlier )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals dLater.TotalSeconds - dEarlier.TotalSeconds, result.Value, "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // Test the 'zero' scenerio:
		  
		  result = factory_method.Invoke( dLater, New Date( dLater ) )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertZero result.MicrosecondsValue, "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // Test the 'negative' scenerio:
		  
		  result = factory_method.Invoke( dEarlier, dLater )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals dEarlier.TotalSeconds - dLater.TotalSeconds, result.Value, "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // Test the 'positive infinity' scenerios:
		  
		  result = factory_method.Invoke( Nil, dLater )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals DurationKFS.NewWithPositiveInfinity.MicrosecondsValue, result.MicrosecondsValue, _
		  "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  result = factory_method.Invoke( dEarlier, Nil )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals DurationKFS.NewWithPositiveInfinity.MicrosecondsValue, result.MicrosecondsValue, _
		  "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // (there is no 'negative infinity' scenerio)
		  
		  // Test the 'undefined' scenerio:
		  
		  result = factory_method.Invoke( Nil, Nil )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals DurationKFS.NewWithUndefined.MicrosecondsValue, result.MicrosecondsValue, _
		  "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstructWithValue(factory_method As ConstructorFactoryMethod_Double_Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestSimpleOperation(operationCode As String, arg1Code As String, arg1Type As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestSimpleOperation(operationCode As String, arg1Code As String, arg1Type As String, arg2Code As String, arg2Type As String)
		  
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
