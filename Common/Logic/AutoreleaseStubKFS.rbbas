#tag Class
Protected Class AutoreleaseStubKFS
	#tag Method, Flags = &h0
		Sub Add(fn As PlainMethodKFS)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Adds the given PlainMethod.
		  
		  p_d.Append fn
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Cancel()
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Cancels all delegates to be invoked.
		  
		  ReDim p_d( -1 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  ReDim p_d( -1 )
		  p_enabled = True
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(fn As PlainMethod)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Sets up this class.
		  
		  Constructor
		  
		  Add fn
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden )  Sub Destructor()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Invoke all the delegates we've collected.
		  
		  If p_enabled Then
		    
		    InvokeAll
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Enabled() As Boolean
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Returns whether or not this object will
		  // automatically invoke all the acquired
		  // delegates when REALbasic deallocates
		  // this object from memory.
		  
		  Return p_enabled
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Enabled(Assigns newValue As Boolean)
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Sets whether or not this object will
		  // automatically invoke all the acquired
		  // delegates when REALbasic deallocates
		  // this object from memory.
		  
		  p_enabled = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InvokeAll()
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Invoke all the delegates we've collected.
		  
		  For Each d As PlainMethod In p_d
		    
		    Try
		      d.Invoke
		    Catch
		    End Try
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub PlainMethod()
	#tag EndDelegateDeclaration


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


	#tag Property, Flags = &h1
		Protected p_d() As PlainMethod
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_enabled As Boolean
	#tag EndProperty


	#tag ViewBehavior
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
