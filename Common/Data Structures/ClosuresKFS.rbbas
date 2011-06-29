#tag Class
Protected Class ClosuresKFS
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
		Delegate Sub del_Shell_void(arg1 As Shell)
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
		Protected Shared Sub err_fmt(code As Integer, msg As String)
		  // Created 6/29/2011 by Andrew Keller
		  
		  // Raises an UnsupportedFormatException with the given code and message.
		  
		  Dim err As New UnsupportedFormatException
		  
		  err.ErrorNumber = code
		  err.Message = msg
		  
		  Raise err
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub err_type(code As Integer, msg As String)
		  // Created 6/29/2011 by Andrew Keller
		  
		  // Raises a TypeMismatchException with the given code and message.
		  
		  Dim err As New TypeMismatchException
		  
		  err.ErrorNumber = code
		  err.Message = msg
		  
		  Raise err
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub map_Shell_void(arg1 As Shell)
		  // Created 6/28/2011 by Andrew Keller
		  
		  // A method that takes a Shell object and returns nothing,
		  // and invokes the target delegate, trying to pass the Shell as an argument.
		  
		  If p_target.IsNull Then
		    
		    // Do nothing.
		    
		  ElseIf p_target IsA del_Dictionary_void Then
		    err_type 1, "Cannot map a Shell object to a Dictionary parameter."
		    
		  ElseIf p_target IsA del_Double_void Then
		    err_type 1, "Cannot map a Shell object to a Double parameter."
		    
		  ElseIf p_target IsA del_Int64_void Then
		    err_type 1, "Cannot map a Shell object to an Int64 parameter."
		    
		  ElseIf p_target IsA del_Shell_void Then
		    Dim d As del_Shell_void = p_target
		    d.Invoke arg1
		    
		  ElseIf p_target IsA del_String_void Then
		    err_type 1, "Cannot map a Shell object to a String parameter."
		    
		  ElseIf p_target IsA del_Thread_void Then
		    err_type 1, "Cannot map a Shell object to a Thread parameter."
		    
		  ElseIf p_target IsA del_Timer_void Then
		    err_type 1, "Cannot map a Shell object to a Timer parameter."
		    
		  ElseIf p_target IsA del_void_void Then
		    Dim d As del_void_void = p_target
		    d.Invoke
		    
		  Else
		    err_fmt 1, "The target delegate is not supported by the "+CurrentMethodName+" callback."
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub map_Thread_void(arg1 As Thread)
		  // Created 6/28/2011 by Andrew Keller
		  
		  // A method that takes a Thread object and returns nothing,
		  // and invokes the target delegate, trying to pass the Thread as an argument.
		  
		  If p_target.IsNull Then
		    
		    // Do nothing.
		    
		  ElseIf p_target IsA del_Dictionary_void Then
		    err_type 1, "Cannot map a Thread object to a Dictionary parameter."
		    
		  ElseIf p_target IsA del_Double_void Then
		    err_type 1, "Cannot map a Thread object to a Double parameter."
		    
		  ElseIf p_target IsA del_Int64_void Then
		    err_type 1, "Cannot map a Thread object to an Int64 parameter."
		    
		  ElseIf p_target IsA del_Shell_void Then
		    err_type 1, "Cannot map a Thread object to an Shell parameter."
		    
		  ElseIf p_target IsA del_String_void Then
		    err_type 1, "Cannot map a Thread object to a String parameter."
		    
		  ElseIf p_target IsA del_Thread_void Then
		    Dim d As del_Thread_void = p_target
		    d.Invoke arg1
		    
		  ElseIf p_target IsA del_Timer_void Then
		    err_type 1, "Cannot map a Thread object to a Timer parameter."
		    
		  ElseIf p_target IsA del_void_void Then
		    Dim d As del_void_void = p_target
		    d.Invoke
		    
		  Else
		    err_fmt 1, "The target delegate is not supported by the "+CurrentMethodName+" callback."
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub map_Timer_void(arg1 As Timer)
		  // Created 6/28/2011 by Andrew Keller
		  
		  // A method that takes a Timer object and returns nothing,
		  // and invokes the target delegate, trying to pass the Timer as an argument.
		  
		  If p_target.IsNull Then
		    
		    // Do nothing.
		    
		  ElseIf p_target IsA del_Dictionary_void Then
		    err_type 1, "Cannot map a Timer object to a Dictionary parameter."
		    
		  ElseIf p_target IsA del_Double_void Then
		    err_type 1, "Cannot map a Timer object to a Double parameter."
		    
		  ElseIf p_target IsA del_Int64_void Then
		    err_type 1, "Cannot map a Timer object to an Int64 parameter."
		    
		  ElseIf p_target IsA del_Shell_void Then
		    err_type 1, "Cannot map a Timer object to an Shell parameter."
		    
		  ElseIf p_target IsA del_String_void Then
		    err_type 1, "Cannot map a Timer object to a String parameter."
		    
		  ElseIf p_target IsA del_Thread_void Then
		    err_type 1, "Cannot map a Timer object to a Thread parameter."
		    
		  ElseIf p_target IsA del_Timer_void Then
		    Dim d As del_Timer_void = p_target
		    d.Invoke arg1
		    
		  ElseIf p_target IsA del_void_void Then
		    Dim d As del_void_void = p_target
		    d.Invoke
		    
		  Else
		    err_fmt 1, "The target delegate is not supported by the "+CurrentMethodName+" callback."
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub map_void_void()
		  // Created 6/28/2011 by Andrew Keller
		  
		  // A method that takes nothing and returns nothing,
		  // and invokes the target delegate.
		  
		  If p_target.IsNull Then
		    
		    // Do nothing.
		    
		  ElseIf p_target IsA del_Dictionary_void Then
		    Dim d As del_Dictionary_void = p_target
		    d.Invoke p_args(0)
		    
		  ElseIf p_target IsA del_Double_void Then
		    Dim d As del_Double_void = p_target
		    d.Invoke p_args(0)
		    
		  ElseIf p_target IsA del_Int64_void Then
		    Dim d As del_Int64_void = p_target
		    d.Invoke p_args(0)
		    
		  ElseIf p_target IsA del_Shell_void Then
		    Dim d As del_Shell_void = p_target
		    d.Invoke p_args(0)
		    
		  ElseIf p_target IsA del_String_void Then
		    Dim d As del_String_void = p_target
		    d.Invoke p_args(0)
		    
		  ElseIf p_target IsA del_Thread_void Then
		    Dim d As del_Thread_void = p_target
		    d.Invoke p_args(0)
		    
		  ElseIf p_target IsA del_Timer_void Then
		    Dim d As del_Timer_void = p_target
		    d.Invoke p_args(0)
		    
		  ElseIf p_target IsA del_void_void Then
		    Dim d As del_void_void = p_target
		    d.Invoke
		    
		  Else
		    err_fmt 1, "The target delegate is not supported by the "+CurrentMethodName+" callback."
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub map_xShell_void(arg1 As Shell)
		  // Created 6/28/2011 by Andrew Keller
		  
		  // A method that takes a Shell object and returns nothing,
		  // and invokes the target delegate, discarding the given argument.
		  
		  // This is conveniently the same code as map_void_void.
		  
		  map_void_void
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub map_xThread_void(arg1 As Thread)
		  // Created 6/28/2011 by Andrew Keller
		  
		  // A method that takes a Thread object and returns nothing,
		  // and invokes the target delegate, discarding the given argument.
		  
		  // This is conveniently the same code as map_void_void.
		  
		  map_void_void
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub map_xTimer_void(arg1 As Timer)
		  // Created 6/28/2011 by Andrew Keller
		  
		  // A method that takes a Timer object and returns nothing,
		  // and invokes the target delegate, discarding the given argument.
		  
		  // This is conveniently the same code as map_void_void.
		  
		  map_void_void
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_From_Dictionary(d As del_Dictionary_void, arg1 As Dictionary) As del_void_void
		  // Created 3/16/2011 by Andrew Keller
		  
		  // Creates a new ClosuresKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New ClosuresKFS
		  
		  c.p_target = d
		  c.p_args.Append arg1
		  
		  Return AddressOf c.map_void_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_From_Double(d As del_Double_void, arg1 As Double) As del_void_void
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Creates a new ClosuresKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New ClosuresKFS
		  
		  c.p_target = d
		  c.p_args.Append arg1
		  
		  Return AddressOf c.map_void_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_From_Int64(d As del_Int64_void, arg1 As Int64) As del_void_void
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Creates a new ClosuresKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New ClosuresKFS
		  
		  c.p_target = d
		  c.p_args.Append arg1
		  
		  Return AddressOf c.map_void_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_From_String(d As del_String_void, arg1 As String) As del_void_void
		  // Created 3/11/2011 by Andrew Keller
		  
		  // Creates a new ClosuresKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New ClosuresKFS
		  
		  c.p_target = d
		  c.p_args.Append arg1
		  
		  Return AddressOf c.map_void_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_Shell_From_void(d As del_void_void) As del_Shell_void
		  // Created 6/28/2011 by Andrew Keller
		  
		  // Creates a new ClosuresKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New ClosuresKFS
		  
		  c.p_target = d
		  
		  Return AddressOf c.map_xShell_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_Thread_From_void(d As del_void_void) As del_Thread_void
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Creates a new ClosuresKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New ClosuresKFS
		  
		  c.p_target = d
		  
		  Return AddressOf c.map_xThread_void
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewClosure_Timer_From_void(d As del_void_void) As del_Timer_void
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Creates a new ClosuresKFS object, sets it up
		  // to invoke the given delegate with the given arguments,
		  // and returns a delegate for the invocation method.
		  
		  // Returning the function pointer and discarding the
		  // parent object creates the closure.
		  
		  Dim c As New ClosuresKFS
		  
		  c.p_target = d
		  
		  Return AddressOf c.map_xTimer_void
		  
		  // done.
		  
		End Function
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
		Protected p_target As Variant
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
