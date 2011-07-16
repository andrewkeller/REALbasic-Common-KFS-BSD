#tag Class
Protected Class ProgressDelegateKFS
	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub BasicEventHandler(pgd As ProgressDelegateKFS)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function ChildCount() As Integer
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the number of nodes that are children of this node.
		  
		  Return p_children.Count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children() As ProgressDelegateKFS()
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns an array of all the nodes that are children of this node.
		  
		  Dim v() As Variant = p_children.Keys
		  Dim c() As ProgressDelegateKFS
		  
		  Dim i, l As Integer
		  l = UBound( v )
		  
		  ReDim c( l )
		  
		  For i = 0 to l
		    
		    c( i ) = ProgressDelegateKFS( v(i).ObjectValue )
		    
		  Next
		  
		  Return c
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor()
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Initializes this object.
		  
		  p_autoupdate_objects = New Dictionary
		  p_callback_msgch = New Dictionary
		  p_callback_sigch = New Dictionary
		  p_callback_valch = New Dictionary
		  p_children = New Dictionary
		  p_childrenweight = 0
		  p_frequency = 0.5
		  p_indeterminate = True
		  p_last_update_time = 0
		  p_message = ""
		  p_mode = Modes.ThrottledSynchronous
		  p_parent = Nil
		  p_signal = Signals.Normal
		  p_throttle = p_frequency.MicrosecondsValue
		  p_value = 0
		  p_weight = 1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Constructor(new_parent As ProgressDelegateKFS, new_weight As Double, new_value As Double, new_msg As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush(ignore_throttle As Boolean = False, ignore_diff As Boolean = False)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Frequency() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Frequency(Assigns new_value As DurationKFS)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndeterminateValue(Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndeterminateValue(include_children As Boolean = True) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns new_value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message(search_harder_for_result As Boolean = True) As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mode() As Modes
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Mode(Assigns new_value As Modes)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Parent() As ProgressDelegateKFS
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns a reference to the parent object.
		  
		  If p_parent Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Return ProgressDelegateKFS( p_parent.Value )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub SetMessage(pgd As ProgressDelegateKFS, msg As String)
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Provides a way of setting the message of a ProgressDelegateKFS
		  // object without first verifying that the ProgressDelegateKFS
		  // object is in fact not Nil.  This sounds trivial, but it
		  // comes in handy in algorithms, where one more If statement
		  // really does make things more cluttered.
		  
		  If pgd Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    pgd.Message = msg
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub SetValue(pgd As ProgressDelegateKFS, v As Double)
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Provides a way of setting the value of a ProgressDelegateKFS
		  // object without first verifying that the ProgressDelegateKFS
		  // object is in fact not Nil.  This sounds trivial, but it
		  // comes in handy in algorithms, where one more If statement
		  // really does make things more cluttered.
		  
		  If pgd Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    pgd.Value = v
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldAutoUpdateObject(obj As Object) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldAutoUpdateObject(obj As Object, Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeMessageChangedCallback(d As BasicEventHandler) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeMessageChangedCallback(d As BasicEventHandler, Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeSignalChangedCallback(d As BasicEventHandler) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeSignalChangedCallback(d As BasicEventHandler, Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeValueChangedCallback(d As BasicEventHandler) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeValueChangedCallback(d As BasicEventHandler, Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigCancel() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigCancel(Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigKill() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigKill(Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Signal() As Signals
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Signal(Assigns new_value As Signals)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigNormal() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigNormal(Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigPause() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigPause(Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnChild(new_weight As Double = 1, new_value As Double = 0, new_msg As String = "") As ProgressDelegateKFS
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Spawns a new child off this node, and returns a reference to the object.
		  
		  Return New ProgressDelegateKFS( Me, new_weight, new_value, new_msg )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TotalWeightOfChildren() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TotalWeightOfChildren(Assigns new_value As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Assigns new_value As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(include_children As Boolean = True) As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Weight(Assigns new_value As Double)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event Open()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event SignalChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged()
	#tag EndHook


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2009-2011 Andrew Keller.
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
		Protected p_autoupdate_objects As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_callback_msgch As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_callback_sigch As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_callback_valch As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_children As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_childrenweight As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_frequency As DurationKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_indeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_last_update_time As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_message As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_mode As Modes
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_parent As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_signal As Signals
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_throttle As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_value As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_weight As Double
	#tag EndProperty


	#tag Enum, Name = Modes, Flags = &h0
		FullSynchronous
		  ThrottledSynchronous
		  InternalAsynchronous
		ExternalAsynchronous
	#tag EndEnum

	#tag Enum, Name = Signals, Flags = &h0
		Normal
		  Pause
		  Cancel
		Kill
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
