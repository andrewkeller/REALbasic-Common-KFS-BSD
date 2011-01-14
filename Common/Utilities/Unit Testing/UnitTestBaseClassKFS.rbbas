#tag Class
Protected Class UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub AssertEmptyString(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is not an empty string.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value.Type = Variant.TypeCFStringRef _
		    Or value.Type = Variant.TypeCString _
		    Or value.Type = Variant.TypePString _
		    Or value.Type = Variant.TypeString _
		    Or value.Type = Variant.TypeWString Then
		    
		    If value = "" Then Return
		    
		  End If
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "", value, failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertEquals(expected As Variant, found As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are not equal.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If expected = found Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, expected, found, failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertFailure(err As RuntimeException, failureMessage As String = "", isTerminal As Boolean = True)
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

	#tag Method, Flags = &h0
		Sub AssertFailure(failureMessage As String = "", isTerminal As Boolean = True)
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

	#tag Method, Flags = &h0
		Sub AssertFalse(value As Boolean, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is true.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value = False Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, False, True, failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertIsNil(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/21/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is not literally Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value.IsNull Then Return
		  If value Is Nil Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, Nil, value, failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertLikeNil(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/21/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is not like Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value.IsNull Then Return
		  If value = Nil Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, Nil, value, failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNegative(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-negative.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value < 0 Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected negative but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNonNegative(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is negative.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value >= 0 Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected non-negative but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNonPositive(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is positive.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value <= 0 Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected non-positive but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNonZero(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is zero.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value <> 0 Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected non-zero but found zero.", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNotEqual(expected As Variant, found As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 7/7/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are equal.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If expected <> found Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected anything else but found " + expected.DescriptionKFS + ".", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNotIsNil(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/21/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is literally Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If Not value.IsNull Then Return
		  If Not value Is Nil Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected non-Nil found " + value.DescriptionKFS + ".", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNotLikeNil(value As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/21/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is like Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If Not value.IsNull Then Return
		  If value <> Nil Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected not like Nil but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNotSame(expected As Variant, found As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 11/25/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are the same object.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If Not ( expected Is found ) Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected any other object but found " + found.DescriptionKFS + ".", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertPositive(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-positive.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value > 0 Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, "Expected positive but found " + value.DescriptionKFS + ".", failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertSame(expected As Variant, found As Variant, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are not the same object.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If expected Is found Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, expected, found, failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertTrue(value As Boolean, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is false.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value = True Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, True, False, failureMessage )
		  
		  If isTerminal Then
		    
		    #pragma BreakOnExceptions Off
		    Raise e
		    
		  Else
		    StashException e
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertZero(value As Double, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-zero.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value = 0 Then Return
		  
		  Dim e As UnitTestExceptionKFS = UnitTestExceptionKFS.NewExceptionFromAssertionFailure( Me, 0, value, failureMessage )
		  
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
		Sub Destructor()
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
		Sub PopMessageStack()
		  // Created 7/25/2010 by Andrew Keller
		  
		  // Pops the messageStack.
		  
		  Call _AssertionMessageStack.Pop
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PushMessageStack(newMessage As String)
		  // Created 7/25/2010 by Andrew Keller
		  
		  // Pushes a new message onto the message stack.
		  
		  _AssertionMessageStack.Append newMessage
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StashException(e As RuntimeException, msg As String = "")
		  // Created 7/25/2010 by Andrew Keller
		  
		  // Stashes the given exception, rather than raising it.
		  
		  _AssertionFailureStash.Append UnitTestExceptionKFS.NewExceptionFromException( Me, e, msg )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function _ClassName() As String
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Returns the name of this class.
		  
		  Return Introspection.GetType(Me).Name
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function _GetTestMethods() As Introspection.MethodInfo()
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Returns a list of the test functions in this class.
		  
		  Dim myMethods() As Introspection.MethodInfo = Introspection.GetType(Me).GetMethods
		  
		  For row As Integer = UBound( myMethods ) DownTo 0
		    
		    If left( myMethods(row).Name, 4 ) <> "Test" Then
		      
		      myMethods.Remove row
		      
		    End If
		    
		  Next
		  
		  Return myMethods
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function _InvokeClassSetup() As Boolean
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Provides the ability to raise the ConstructorWithAssertionHandling event.
		  // Also returns whether or not the event was actually raised.
		  
		  If bCWAHHasRan Then
		    
		    Return False
		    
		  Else
		    
		    bCWAHHasRan = True
		    
		    RaiseEvent ConstructorWithAssertionHandling
		    
		    Return True
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub _InvokeTestCaseSetup(methodName As String)
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Raises the BeforeTestCase event.
		  
		  RaiseEvent BeforeTestCase methodName
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub _InvokeTestCaseTearDown(methodName As String)
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Raises the AfterTestCase event.
		  
		  RaiseEvent AfterTestCase methodName
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event AfterTestCase(methodName As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event BeforeTestCase(methodName As String)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ConstructorWithAssertionHandling()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Destructor()
	#tag EndHook


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller, et al.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a full list of all contributors.
		
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

	#tag Property, Flags = &h21
		Private bCWAHHasRan As Boolean = False
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 8/2/2010 by Andrew Keller
			  
			  // Returns the lock for this class.
			  
			  If myLock Is Nil Then myLock = New CriticalSection
			  
			  Return myLock
			  
			  // done.
			  
			End Get
		#tag EndGetter
		Lock As CriticalSection
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private myLock As CriticalSection
	#tag EndProperty

	#tag Property, Flags = &h0
		_AssertionFailureStash() As UnitTestExceptionKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		_AssertionMessageStack() As String
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
