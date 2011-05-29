#tag Class
Protected Class DelegateClosureKFS
	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // Created 5/10/2011 by Andrew Keller
		  
		  // Protected constructor.  Only accessible from within this class.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub del_Dictionary_void(arg1 As Dictionary)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub del_Double_void(arg1 As Double)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub del_Int64_void(arg1 As Int64)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub del_String_void(arg1 As String)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub del_Thread_void(arg1 As Thread)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub del_Timer_void(arg1 As Timer)
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub del_void_void()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Sub inv_Dictionary_void()
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Invokes the Dictionary_void delegate.
		  
		  // NOTE: This function assumes that the delegate is set
		  // up correctly.  This method will crash if it is not!
		  
		  p_fptr_Dictionary_void.Invoke Dictionary( p_args(0).ObjectValue )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub inv_Double_void()
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Invokes the Double_void delegate.
		  
		  // NOTE: This function assumes that the delegate is set
		  // up correctly.  This method will crash if it is not!
		  
		  p_fptr_Double_void.Invoke p_args(0).DoubleValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub inv_Int64_void()
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Invokes the Int64_void delegate.
		  
		  // NOTE: This function assumes that the delegate is set
		  // up correctly.  This method will crash if it is not!
		  
		  p_fptr_Int64_void.Invoke p_args(0).Int64Value
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub inv_String_void()
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Invokes the String_void delegate.
		  
		  // NOTE: This function assumes that the delegate is set
		  // up correctly.  This method will crash if it is not!
		  
		  p_fptr_String_void.Invoke p_args(0).StringValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub inv_void_void()
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Invokes the void_void delegate.
		  
		  // NOTE: This function assumes that the delegate is set
		  // up correctly.  This method will crash if it is not!
		  
		  p_fptr_void_void.Invoke
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_From_Dictionary(d As del_Dictionary_void, arg1 As Dictionary) As del_void_void
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Creates a new DelegateClosureKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New DelegateClosureKFS
		  
		  c.p_fptr_Dictionary_void = d
		  c.p_args.Append arg1
		  
		  Return AddressOf c.inv_Dictionary_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_From_Double(d As del_Double_void, arg1 As Double) As del_void_void
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Creates a new DelegateClosureKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New DelegateClosureKFS
		  
		  c.p_fptr_Double_void = d
		  c.p_args.Append arg1
		  
		  Return AddressOf c.inv_Double_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_From_Int64(d As del_Int64_void, arg1 As Int64) As del_void_void
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Creates a new DelegateClosureKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New DelegateClosureKFS
		  
		  c.p_fptr_Int64_void = d
		  c.p_args.Append arg1
		  
		  Return AddressOf c.inv_Int64_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_From_String(d As del_String_void, arg1 As String) As del_void_void
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Creates a new DelegateClosureKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New DelegateClosureKFS
		  
		  c.p_fptr_String_void = d
		  c.p_args.Append arg1
		  
		  Return AddressOf c.inv_String_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_Thread_From_void(d As del_void_void) As del_Thread_void
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Creates a new DelegateClosureKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New DelegateClosureKFS
		  
		  c.p_fptr_void_void = d
		  
		  Return AddressOf c.trans_Thread_void_To_void_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_Timer_From_void(d As del_void_void) As del_Timer_void
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Creates a new DelegateClosureKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New DelegateClosureKFS
		  
		  c.p_fptr_void_void = d
		  
		  Return AddressOf c.trans_Timer_void_To_void_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub trans_Thread_void_To_void_void(arg1 As Thread)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Invokes the void_void delegate.
		  
		  // NOTE: This function assumes that the delegate is set
		  // up correctly.  This method will crash if it is not!
		  
		  inv_void_void
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub trans_Timer_void_To_void_void(arg1 As Timer)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Invokes the void_void delegate.
		  
		  // NOTE: This function assumes that the delegate is set
		  // up correctly.  This method will crash if it is not!
		  
		  inv_void_void
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011 Andrew Keller.
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
		Protected p_args() As Variant
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_fptr_Dictionary_void As del_Dictionary_void
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_fptr_Double_void As del_Double_void
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_fptr_Int64_void As del_Int64_void
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_fptr_String_void As del_String_void
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_fptr_void_void As del_void_void
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
