#tag Class
Protected Class UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Function Arbiter() As UnitTestArbiterKFS
		  // Created 7/23/2011 by Andrew Keller
		  
		  // Returns a reference to the current owning arbiter.
		  
		  If Not ( myArbiter Is Nil ) Then
		    
		    Dim v As Variant = myArbiter.Value
		    
		    If v IsA UnitTestArbiterKFS Then
		      
		      Return UnitTestArbiterKFS( v )
		      
		    End If
		  End If
		  
		  Return Nil
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertEmptyString(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is not an empty string.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_EmptyString( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertEquals(expected As Variant, found As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are not equal.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Equal( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertFailure(err As RuntimeException, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS manually.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromException( Me, err, failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertFailure(failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS manually.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Unit test declared a failure.", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertFalse(value As Boolean, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is true.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_False( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertIsNil(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/21/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is not literally Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_IsNil( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertLikeNil(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/21/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is not like Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_LikeNil( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNegative(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-negative.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Negative( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNoIssuesYet(failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if some exceptions have been logged.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NoIssuesYet( failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNonNegative(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is negative.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NonNegative( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNonPositive(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is positive.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NonPositive( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNonZero(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is zero.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NonZero( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNotEqual(expected As Variant, found As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 7/7/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are equal.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NotEqual( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNotIsNil(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/21/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is literally Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NotIsNil( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNotLikeNil(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/21/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is like Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NotLikeNil( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertNotSame(expected As Variant, found As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are the same object.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NotSame( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertPositive(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-positive.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Positive( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertSame(expected As Variant, found As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are not the same object.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Same( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertTrue(value As Boolean, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is false.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_True( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertZero(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-zero.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Zero( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    If isTerminal Then
		      
		      #pragma BreakOnExceptions Off
		      Raise e
		      
		    Else
		      StashException e
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub BeginSession(owning_arbiter As UnitTestArbiterKFS)
		  // Created 7/23/2011 by Andrew Keller
		  
		  // Locks this class and sets the owning arbiter.
		  
		  If myLock Is Nil Then myLock = New CriticalSection
		  
		  myLock.Enter
		  
		  myArbiter = New WeakRef( owning_arbiter )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ClassName() As String
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Returns the name of this class.
		  
		  Return Introspection.GetType(Me).Name
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_EmptyString(value As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is a String, and is empty.
		  
		  If value.Type = Variant.TypeCFStringRef _
		    Or value.Type = Variant.TypeCString _
		    Or value.Type = Variant.TypePString _
		    Or value.Type = Variant.TypeString _
		    Or value.Type = Variant.TypeWString Then
		    
		    If value = "" Then Return Nil
		    
		  End If
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "", value, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_Equal(expected As Variant, found As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given two values are equal.
		  
		  If expected = found Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, expected, found, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_False(value As Boolean, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is False.
		  
		  If value = False Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, False, True, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_IsNil(value As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is literally Nil.
		  
		  If value Is Nil Then Return Nil
		  If value.IsNull Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, Nil, value, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_LikeNil(value As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is like Nil.
		  
		  If value = Nil Then Return Nil
		  If value.IsNull Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, Nil, value, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_Negative(value As Double, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is negative.
		  
		  If value < 0 Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected negative but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_NoIssuesYet(failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/27/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that there are currently no execptions logged for this test.
		  
		  Dim problemCount As Integer = UBound( AssertionFailureStash ) +1
		  
		  If problemCount = 0 Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected no issues with this test but found " + Str( problemCount ) + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_NonNegative(value As Double, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is not negative.
		  
		  If value >= 0 Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected non-negative but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_NonPositive(value As Double, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is not positive.
		  
		  If value <= 0 Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected non-positive but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_NonZero(value As Double, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is not zero.
		  
		  If value <> 0 Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected non-zero but found zero.", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_NotEqual(expected As Variant, found As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given two values are not equal.
		  
		  If expected <> found Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected anything else but found " + expected.DescriptionKFS + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_NotIsNil(value As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is not literally Nil.
		  
		  If Not ( value Is Nil ) Then Return Nil
		  If Not value.IsNull Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected non-Nil found " + value.DescriptionKFS + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_NotLikeNil(value As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is not like Nil.
		  
		  If value <> Nil Then Return Nil
		  If Not value.IsNull Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected not like Nil but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_NotSame(expected As Variant, found As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given objects are not the same object.
		  
		  If Not ( expected Is found ) Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected any other object but found " + found.DescriptionKFS + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_Positive(value As Double, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is positive.
		  
		  If value > 0 Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected positive but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_Same(expected As Variant, found As Variant, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given objects are the same object.
		  
		  If expected Is found Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, expected, found, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_True(value As Boolean, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is True.
		  
		  If value = True Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, True, False, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CoreAssert_check_Zero(value As Double, failureMessage As String = "") As UnitTestExceptionKFS
		  // Created 1/13/2011 by Andrew Keller
		  
		  // If the given assertion fails, then this function returns an
		  // unraised UnitTestExceptionKFS object that describes the
		  // assertion failure.  If the assertion passes, then Nil is returned.
		  
		  // The AssertionCount property is NOT incremented.
		  // This function is considered to be a helper, not a do-er.
		  
		  // This function asserts that the given value is zero.
		  
		  If value = 0 Then Return Nil
		  
		  Return UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, 0, value, failureMessage )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DefineVirtualTestCase(case_name As String, case_delegate As UnitTestArbiterKFS.TestCaseMethod) As Int64
		  // Created 7/23/2011 by Andrew Keller
		  
		  // A simplified alias for Arbiter.AddTestCase.
		  
		  // Get the Arbiter:
		  
		  Dim a As UnitTestArbiterKFS = Arbiter
		  
		  // Make sure the Arbiter is valid:
		  
		  AssertNotIsNil a, "A valid context is required in order to add a virtual test case.  No UnitTestArbiterKFS object can be found."
		  
		  // If the assertion passed, then we don't need
		  // other code to know that the assertion was made:
		  
		  AssertionCount = AssertionCount -1
		  
		  // Define the test case, spawn a new result for it,
		  // and return the ID of the test case specification:
		  
		  Return a.DefineVirtualTestCase( Me, case_name, case_delegate, True )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Raises the Destructor event.
		  
		  Try
		    RaiseEvent Destructor
		  Catch e As UnitTestExceptionKFS
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub EndSession()
		  // Created 7/23/2011 by Andrew Keller
		  
		  // Unlocks the lock on this class, and clears lock-like things.
		  
		  If Not ( myLock Is Nil ) Then myLock.Leave
		  
		  myArbiter = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Function GetTestMethods() As Introspection.MethodInfo()
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Returns a list of the test functions in this class.
		  // Index zero is the constructor.  Because the constructor
		  // always exists, the array that this function returns always
		  // has at least one item in it (the constructor).
		  
		  Dim myConstructor As Introspection.MethodInfo
		  Dim myMethods() As Introspection.MethodInfo
		  
		  Dim illegalTestCaseNames() As String = Array( _
		  "", _
		  "Event_AfterTestCase", _
		  "Event_BeforeTestCase", _
		  "Event_ConstructorWithAssertionHandling", _
		  "Event_Destructor", _
		  "Event_MethodIsATestMethod", _
		  "Event_VerifyTestCase", _
		  "ClassName", _
		  "Destructor", _
		  "GetTestMethods", _
		  "InvokeTestCaseSetup", _
		  "InvokeTestCaseTearDown", _
		  "PopMessageStack", _
		  "PushMessageStack", _
		  "SetupEventWasImplemented", _
		  "StashException", _
		  "TearDownEventWasImplemented", _
		  "VerifyEventWasImplemented" )
		  
		  For Each method As Introspection.MethodInfo In Introspection.GetType( Me ).GetMethods
		    
		    If method.Name = "Event_ConstructorWithAssertionHandling" Then
		      
		      myConstructor = method
		      
		    Else
		      If method.ReturnType Is Nil Then
		        If method.GetParameters.UBound < 0 Then
		          If illegalTestCaseNames.IndexOf( method.Name ) < 0 Then
		            
		            Dim b As Boolean = method.Name.Left( 4 ) = "Test"
		            
		            If MethodIsATestMethod( method.Name, b ) Then
		              
		              If b Then myMethods.Append method
		              
		            ElseIf method.Name.Left( 4 ) = "Test" Then
		              
		              myMethods.Append method
		              
		            End If
		            
		          End If
		        End If
		      End If
		    End If
		    
		  Next
		  
		  myMethods.Insert 0, myConstructor
		  Return myMethods
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub InvokeTestCaseSetup(methodName As String)
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Raises the BeforeTestCase event.
		  
		  RaiseEvent BeforeTestCase methodName
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub InvokeTestCaseTearDown(methodName As String)
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Raises the AfterTestCase event.
		  
		  RaiseEvent AfterTestCase methodName
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub InvokeTestCaseVerification(methodName As String)
		  // Created 2/17/2010 by Andrew Keller
		  
		  // Raises the VerifyTestCase event.
		  
		  RaiseEvent VerifyTestCase methodName
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopMessageStack()
		  // Created 7/25/2010 by Andrew Keller
		  
		  // Pops the messageStack.
		  
		  Call AssertionMessageStack.Pop
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeEmptyString(value As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is not an empty string.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_EmptyString( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeEquals(expected As Variant, found As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given values are not equal.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Equal( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeFalse(value As Boolean, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is true.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_False( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeIsNil(value As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is not literally Nil.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_IsNil( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeLikeNil(value As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is not like Nil.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_LikeNil( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNegative(value As Double, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is non-negative.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Negative( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNoIssuesYet(failureMessage As String = "") As Boolean
		  // Created 1/27/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if some exceptions have been logged.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NoIssuesYet( failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNonNegative(value As Double, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is negative.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NonNegative( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNonPositive(value As Double, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is positive.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NonPositive( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNonZero(value As Double, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is zero.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NonZero( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNotEqual(expected As Variant, found As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given values are equal.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NotEqual( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNotIsNil(value As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is literally Nil.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NotIsNil( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNotLikeNil(value As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is like Nil.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NotLikeNil( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeNotSame(expected As Variant, found As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given values are the same object.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_NotSame( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumePositive(value As Double, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is non-positive.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Positive( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeSame(expected As Variant, found As Variant, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given values are not the same object.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Same( expected, found, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeTrue(value As Boolean, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is false.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_True( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function PresumeZero(value As Double, failureMessage As String = "") As Boolean
		  // Created 1/14/2011 by Andrew Keller
		  
		  // Stashes a UnitTestExceptionKFS if the given value is non-zero.
		  // Returns whether or not the assertion passed.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Dim e As UnitTestExceptionKFS = CoreAssert_check_Zero( value, failureMessage )
		  
		  If Not ( e Is Nil ) Then
		    
		    StashException e
		    
		    Return False
		    
		  End If
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PushMessageStack(newMessage As String)
		  // Created 7/25/2010 by Andrew Keller
		  
		  // Pushes a new message onto the message stack.
		  
		  AssertionMessageStack.Append newMessage
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Function SetupEventWasImplemented() As Boolean
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns whether or not the BeforeTestCase event was implemented.
		  
		  For Each method As Introspection.MethodInfo In Introspection.GetType( Me ).GetMethods
		    
		    If method.Name = "Event_BeforeTestCase" Then
		      
		      Return True
		      
		    End If
		    
		  Next
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StashException(e As RuntimeException, msg As String = "")
		  // Created 7/25/2010 by Andrew Keller
		  
		  // Stashes the given exception, rather than raising it.
		  
		  If e IsA UnitTestExceptionKFS Then
		    
		    AssertionFailureStash.Append UnitTestExceptionKFS( e )
		    
		  Else
		    
		    AssertionFailureStash.Append UnitTestExceptionKFS.NewExceptionFromException( Me, e, msg )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Function TearDownEventWasImplemented() As Boolean
		  // Created 2/12/2011 by Andrew Keller
		  
		  // Returns whether or not the AfterTestCase event was implemented.
		  
		  For Each method As Introspection.MethodInfo In Introspection.GetType( Me ).GetMethods
		    
		    If method.Name = "Event_AfterTestCase" Then
		      
		      Return True
		      
		    End If
		    
		  Next
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Function TryBeginSession(owning_arbiter As UnitTestArbiterKFS) As Boolean
		  // Created 7/23/2011 by Andrew Keller
		  
		  // Tries to lock this class, and upon success, sets the owning arbiter.
		  
		  If myLock Is Nil Then myLock = New CriticalSection
		  
		  If myLock.TryEnter Then
		    
		    myArbiter = New WeakRef( owning_arbiter )
		    
		    Return True
		    
		  Else
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Function VerificationEventWasImplemented() As Boolean
		  // Created 2/17/2011 by Andrew Keller
		  
		  // Returns whether or not the VerifyTestCase event was implemented.
		  
		  For Each method As Introspection.MethodInfo In Introspection.GetType( Me ).GetMethods
		    
		    If method.Name = "Event_VerifyTestCase" Then
		      
		      Return True
		      
		    End If
		    
		  Next
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AfterTestCase(testMethodName As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BeforeTestCase(testMethodName As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ConstructorWithAssertionHandling()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Destructor()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event MethodIsATestMethod(methodName As String, ByRef isATestMethod As Boolean) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event VerifyTestCase(testMethodName As String)
	#tag EndHook


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, 2011 Andrew Keller.
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


	#tag Property, Flags = &h0
		AssertionCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Attributes( Hidden = True ) AssertionFailureStash() As UnitTestExceptionKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		Attributes( Hidden = True ) AssertionMessageStack() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Attributes( Hidden = True ) Private myArbiter As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h21
		Private myLock As CriticalSection
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
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
