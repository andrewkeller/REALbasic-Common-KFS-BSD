#tag Class
Protected Class MainThreadInvokerKFS
	#tag Method, Flags = &h0
		Sub Cancel()
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Cancels the method to invoke, and disables orphaning for this object.
		  
		  p_target = Nil
		  p_timer = Nil
		  Orphaned = False
		  
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
		Function Delay() As Integer
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Returns the delay that the timer was set for.
		  
		  If p_timer Is Nil Then
		    
		    Return 1
		    
		  Else
		    
		    Return p_timer.Period
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  // Created 10/16/2011 by Andrew Keller
		  
		  // Clean up some things.
		  
		  Cancel
		  
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

	#tag Method, Flags = &h1
		Protected Sub Orphaned(Assigns new_value As Boolean)
		  // Created 10/16/2011 by Andrew Keller
		  
		  // Sets whether or not orphaning is enabled for this object.
		  
		  If new_value Then
		    
		    If p_orphan_pool Is Nil Then p_orphan_pool = New Dictionary
		    
		    p_orphan_pool.Value( Me ) = True
		    
		  Else
		    
		    If Not ( p_orphan_pool Is Nil ) Then
		      
		      If p_orphan_pool.HasKey( Me ) Then
		        
		        p_orphan_pool.Remove Me
		        
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub PlainMethod()
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h1
		Protected Sub Set(d As PlainMethod, delay As Integer)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Sets this object to run the given method after the given delay.
		  
		  If d Is Nil Then
		    
		    Cancel
		    
		  Else
		    
		    p_timer = New Timer
		    p_target = d
		    Orphaned = True
		    
		    p_timer.Period = Max( 0, delay )
		    AddHandler p_timer.Action, WeakAddressOf timer_action_hook
		    p_timer.Mode = Timer.ModeSingle
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Target() As PlainMethod
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Returns the current target.
		  
		  Return p_target
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub timer_action_hook(t As Timer)
		  // Created 7/29/2011 by Andrew Keller
		  
		  // Disables orphaning for this object, and invokes the target.
		  
		  If p_timer Is t Then
		    
		    // Good, no race issue.
		    
		    // Disable orphaning for this object:
		    
		    Orphaned = False
		    
		    // Clean up other properties now, in case
		    // the target method raises an exception
		    // and we don't get a chance to do it later:
		    
		    Dim d As PlainMethod = p_target
		    p_target = Nil
		    p_timer = Nil
		    
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
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This class is licensed as BSD.  This generally means you may do
		whatever you want with this class so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this class does NOT require
		your work to inherit the license of this class.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this class.
		
		The full official license is as follows:
		
		Copyright (c) 2011 Andrew Keller.
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or without
		modification, are permitted provided that the following conditions
		are met:
		
		  Redistributions of source code must retain the above
		  copyright notice, this list of conditions and the
		  following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the
		  following disclaimer in the documentation and/or other
		  materials provided with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
		  contributors may be used to endorse or promote products
		  derived from this software without specific prior written
		  permission.
		
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
		Protected Shared p_orphan_pool As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_target As PlainMethod
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_timer As Timer
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
