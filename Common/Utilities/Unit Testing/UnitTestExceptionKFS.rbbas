#tag Class
Class UnitTestExceptionKFS
Inherits RuntimeException
	#tag Method, Flags = &h1000
		Sub Constructor(cause As RuntimeException, failureMsg As String, assertionNumber As Integer = 0)
		  // Created 5/12/2010 by Andrew Keller
		  
		  // A simple constructor that takes some situational data.
		  
		  myAssertionNumber = assertionNumber
		  myCause = ""
		  myException = cause
		  myMsg = failureMsg
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(failureMsg As String, assertionNumber As Integer = 0)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // A simple constructor that takes some situational data.
		  
		  myAssertionNumber = assertionNumber
		  myCause = ""
		  myException = Nil
		  myMsg = failureMsg
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(cause As String, failureMsg As String, assertionNumber As Integer = 0)
		  // Created 5/9/2010 by Andrew Keller
		  
		  // A simple constructor that takes some situational data.
		  
		  myAssertionNumber = assertionNumber
		  myCause = cause
		  myException = Nil
		  myMsg = failureMsg
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Stack() As String()
		  // Created 5/13/2010 by Andrew Keller
		  
		  // Returns the correct stack trace.
		  
		  // This class can be created to wrap another
		  // exception, or it can *be* an exception.
		  // In either case, a single stack trace exists.
		  // This function returns the correct one.
		  
		  If myException = Nil Then
		    
		    Return Super.Stack
		    
		  Else
		    
		    Return myException.Stack
		    
		  End If
		  
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


	#tag Property, Flags = &h1
		Protected myAssertionNumber As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myCause As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myException As RuntimeException
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMsg As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  // Created 5/12/2010 by Andrew Keller
			  
			  // Returns a summary of this error.
			  
			  Dim result(2) As String
			  
			  result(0) = myMsg
			  If myAssertionNumber > 0 Then
			    result(1) = Join( Array( myCause, "(Assertion Number " + str(myAssertionNumber) + ")" ), "  " )
			  Else
			    result(1) = myCause
			  End If
			  If myException <> Nil Then result(2) = myException.Message
			  
			  For row As Integer = 2 DownTo 0
			    
			    If result(row) = "" Then result.Remove row
			    
			  Next
			  
			  Return Join( result, EndOfLineKFS )
			  
			  // done.
			  
			End Get
		#tag EndGetter
		Summary As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ErrorNumber"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="RuntimeException"
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
			Name="Message"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="RuntimeException"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Summary"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
