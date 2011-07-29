#tag Class
Protected Class MainThreadInvokerKFS
	#tag Method, Flags = &h0
		Sub Cancel()
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Cancels the method to invoke, and destroys the circular reference.
		  
		  p_target = Nil
		  p_timer = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub common_init()
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Common initialization code.
		  
		  p_target = Nil
		  p_timer = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(d As PlainMethod, delay As Integer = 0)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // (Almost) Basic constructor.
		  
		  common_init
		  
		  Set d, delay
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsSet() As Boolean
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Returns whether or not this object is currently set to invoke a delegate.
		  
		  If p_timer Is Nil Then
		    
		    Return False
		    
		  ElseIf p_timer.Mode = Timer.ModeOff Then
		    
		    Return False
		    
		  ElseIf p_target Is Nil Then
		    
		    Return False
		    
		  Else
		    
		    Return True
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub PlainMethod()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Sub Set(d As PlainMethod, delay As Integer)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Sets this object to run the given method after the given delay.
		  
		  If d Is Nil Then
		    
		    p_timer = Nil
		    p_target = Nil
		    
		  Else
		    
		    p_timer = New Timer
		    p_target = d
		    
		    p_timer.Period = Max( 0, delay )
		    AddHandler p_timer.Action, AddressOf timer_action_hook
		    p_timer.Mode = Timer.ModeSingle
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub timer_action_hook(t As Timer)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Destroys the circular reference, and invokes the target.
		  
		  If p_timer Is t Then
		    
		    // Good, no race issue.
		    
		    // Destroy the circular reference:
		    
		    p_timer = Nil
		    
		    // Clean up other properties now, in case
		    // the target method raises an exception:
		    
		    Dim d As PlainMethod = p_target
		    p_target = Nil
		    
		    // And finally, invoke the target:
		    
		    If Not ( d Is Nil ) Then d.Invoke
		    
		    // And we're done.
		    
		  Else
		    
		    // Uh oh, it looks like we have a race issue.
		    
		    // The currently active timer does not equal the timer that ran this hook.
		    
		    // We probably shouldn't do anything.
		    
		  End If
		  
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
		Protected p_target As PlainMethod
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_timer As Timer
	#tag EndProperty


End Class
#tag EndClass
