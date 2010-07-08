#tag Class
Protected Class UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub AssertEmptyString(value As Variant, failureMessage As String = "")
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-positive.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value <> Nil Then
		    
		    If value.Type = Variant.TypeCFStringRef _
		      Or value.Type = Variant.TypeCString _
		      Or value.Type = Variant.TypePString _
		      Or value.Type = Variant.TypeString _
		      Or value.Type = Variant.TypeWString Then
		      
		      If value = "" Then Return
		      
		    End If
		  End If
		  
		  Raise New UnitTestExceptionKFS( "Expected " + StrVariant("") + " but found " + StrVariant( value ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertEquals(expected As Variant, found As Variant, failureMessage As String = "")
		  // Created 5/10/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are not equal.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If expected = found Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected " + StrVariant( expected ) + " but found " + StrVariant( found ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertFailure(failureMessage As String = "")
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS manually.
		  
		  AssertionCount = AssertionCount + 1
		  
		  Raise New UnitTestExceptionKFS( "Unit test declared a failure.", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertFalse(value As Boolean, failureMessage As String = "")
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is true.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value = False Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected False but found True.", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNegative(value As Integer, failureMessage As String = "")
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-negative.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value < 0 Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected negative but found " + str( value ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNil(value As Variant, failureMessage As String = "")
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is not Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value = Nil Then Return
		  If value.IsNull Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected Nil but found " + StrVariant( value ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNonNegative(value As Integer, failureMessage As String = "")
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is negative.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value >= 0 Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected non-negative but found " + str( value ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNonPositive(value As Integer, failureMessage As String = "")
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is positive.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value <= 0 Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected non-positive but found " + str( value ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNonZero(value As Integer, failureMessage As String = "")
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is zero.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value <> 0 Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected non-zero but found zero.", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNotEqual(expected As Variant, found As Variant, failureMessage As String = "")
		  // Created 7/7/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given values are equal.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If expected <> found Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected and found " + StrVariant( expected ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertNotNil(value As Variant, failureMessage As String = "")
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is Nil.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value <> Nil Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected Not Nil but found " + StrVariant( value ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertPositive(value As Integer, failureMessage As String = "")
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-positive.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value > 0 Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected positive but found " + StrVariant( value ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertTrue(value As Boolean, failureMessage As String = "")
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is false.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value = True Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected True but found False.", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssertZero(value As Integer, failureMessage As String = "")
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Raises a UnitTestExceptionKFS if the given value is non-zero.
		  
		  AssertionCount = AssertionCount + 1
		  
		  If value = 0 Then Return
		  
		  Raise New UnitTestExceptionKFS( "Expected zero but found " + StrVariant( value ) + ".", failureMessage, AssertionCount )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetClassName() As String
		  // Created 5/9/2010 by Andrew Keller
		  
		  // Returns the name of this class.
		  
		  Return Introspection.GetType(Me).Name
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTestMethods() As Introspection.MethodInfo()
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

	#tag Method, Flags = &h1
		Protected Function StrVariant(v As Variant) As String
		  // Created 5/12/2010 by Andrew Keller
		  
		  // Returns a textual representation of the given Variant.
		  
		  If v = Nil Then Return "Nil"
		  
		  If v.IsNull Then Return "Null"
		  
		  If v.Type = Variant.TypeBoolean Then
		    
		    If v = True Then Return "True"
		    If v = False Then Return "False"
		    
		  ElseIf v.IsNumeric Then
		    
		    If v = 0 Then Return "zero"
		    
		    Return v.StringValue
		    
		  ElseIf v.Type = Variant.TypeCFStringRef _
		    Or v.Type = Variant.TypeCString _
		    Or v.Type = Variant.TypePString _
		    Or v.Type = Variant.TypeString _
		    Or v.Type = Variant.TypeWString Then
		    
		    If v = "" Then Return "an empty string"
		    
		  End If
		  
		  Return "'" + v + "'"
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of its
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
