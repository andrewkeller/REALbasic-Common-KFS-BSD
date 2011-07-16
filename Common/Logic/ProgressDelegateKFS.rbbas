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
		  p_frequency = New DurationKFS( 0.5 )
		  p_indeterminate = True
		  p_last_update_time = 0
		  p_message = ""
		  p_mode = Modes.ThrottledSynchronous
		  p_parent = Nil
		  p_signal = Signals.Normal
		  p_throttle = p_frequency.MicrosecondsValue
		  p_value = 0
		  p_weight = 1
		  
		  RaiseEvent Open
		  
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
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the current frequency.
		  
		  Return p_frequency
		  
		  // done.
		  
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
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not this node has an indeterminate value,
		  // possibly taking into account the children nodes.
		  
		  If p_indeterminate And include_children Then
		    
		    // The indeterminate value property can be described as a
		    // "fragile True", meaning that all it takes is one child
		    // being False and the entire result is False.
		    
		    For Each c As ProgressDelegateKFS In Children
		      If Not ( c Is Nil ) Then
		        If Not c.IndeterminateValue( include_children ) Then
		          
		          Return False
		          
		        End If
		      End If
		    Next
		    
		  End If
		  
		  Return p_indeterminate
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns new_value As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message(search_harder_for_result As Boolean = True) As String
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns the message of this node.
		  
		  // If the local message is an empty string and
		  // search_harder_for_result is True, then the
		  // children are searched for a non-empty string
		  // using a breadth first search.
		  
		  If p_message = "" And search_harder_for_result Then
		    
		    Dim queue As New DataChainKFS
		    
		    For Each ch As ProgressDelegateKFS In Children
		      queue.Append ch
		    Next
		    
		    While Not queue.IsEmpty
		      
		      Dim c As ProgressDelegateKFS = ProgressDelegateKFS( queue.Pop.ObjectValue )
		      
		      If Not ( c Is Nil ) Then
		        
		        Dim rslt As String = c.p_message
		        
		        If rslt = "" Then
		          
		          For Each ch As ProgressDelegateKFS In c.Children
		            queue.Append ch
		          Next
		          
		        Else
		          
		          Return rslt
		          
		        End If
		      End If
		    Wend
		    
		  End If
		  
		  Return p_message
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mode() As Modes
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the current mode.
		  
		  Return p_mode
		  
		  // done.
		  
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
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given object is currently set to be automatically updated.
		  
		  Return p_autoupdate_objects.HasKey( obj )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldAutoUpdateObject(obj As Object, Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given object is currently set to be automatically updated.
		  
		  If new_value Then
		    
		    p_autoupdate_objects.Value( obj ) = True
		    
		  ElseIf p_autoupdate_objects.HasKey( obj ) Then
		    
		    p_autoupdate_objects.Remove obj
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeMessageChangedCallback(d As BasicEventHandler) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given method is currently
		  // set to be invoked when the message changes.
		  
		  Return p_callback_msgch.HasKey( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeMessageChangedCallback(d As BasicEventHandler, Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given method is currently
		  // set to be invoked when the message changes.
		  
		  If new_value Then
		    
		    p_callback_msgch.Value( d ) = True
		    
		  ElseIf p_callback_msgch.HasKey( d ) Then
		    
		    p_callback_msgch.Remove d
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeSignalChangedCallback(d As BasicEventHandler) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given method is currently
		  // set to be invoked when the signal changes.
		  
		  Return p_callback_sigch.HasKey( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeSignalChangedCallback(d As BasicEventHandler, Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not the given method is currently
		  // set to be invoked when the signal changes.
		  
		  If new_value Then
		    
		    p_callback_sigch.Value( d ) = True
		    
		  ElseIf p_callback_sigch.HasKey( d ) Then
		    
		    p_callback_sigch.Remove d
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShouldInvokeValueChangedCallback(d As BasicEventHandler) As Boolean
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns whether or not the given method is currently
		  // set to be invoked when the value changes.
		  
		  Return p_callback_valch.HasKey( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ShouldInvokeValueChangedCallback(d As BasicEventHandler, Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigCancel() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigCancel is set.
		  
		  Return p_signal = Signals.Cancel
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigCancel(Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not SigCancel should be set.
		  
		  If new_value Then
		    
		    Signal = Signals.Cancel
		    
		  Else
		    
		    Signal = Signals.Normal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigKill() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigKill is set.
		  
		  Return p_signal = Signals.Kill
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigKill(Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not SigKill should be set.
		  
		  If new_value Then
		    
		    Signal = Signals.Kill
		    
		  Else
		    
		    Signal = Signals.Normal
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Signal() As Signals
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the value of the current signal.
		  
		  Return p_signal
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Signal(Assigns new_value As Signals)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets the current signal, and propagates the new value up the tree.
		  // This method is designed to be recursive.
		  
		  // First, figure out whether or not this new value is different.
		  Dim is_different As Boolean = Not ( p_signal = new_value )
		  
		  // Next, set the value locally.
		  p_signal = new_value
		  
		  // Next, call this function for all the children.
		  
		  For Each c As ProgressDelegateKFS In Children
		    If Not ( c Is Nil ) Then
		      c.Signal = new_value
		    End If
		  Next
		  
		  // And finally, if the signal was different, then fire the signal changed events.
		  
		  If is_different Then
		    
		    RaiseEvent SignalChanged
		    
		    For Each v As Variant In p_callback_sigch.Keys
		      Dim d As BasicEventHandler = v
		      If Not ( d Is Nil ) Then
		        
		        d.Invoke Me
		        
		      End If
		    Next
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigNormal() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigNormal is set.
		  
		  Return p_signal = Signals.Normal
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigNormal(Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not SigNormal should be set.
		  
		  If new_value Then
		    
		    Signal = Signals.Normal
		    
		  Else
		    
		    // Do nothing.
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SigPause() As Boolean
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns whether or not SigPause is set.
		  
		  Return p_signal = Signals.Pause
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SigPause(Assigns new_value As Boolean)
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Sets whether or not SigPause should be set.
		  
		  If new_value Then
		    
		    Signal = Signals.Pause
		    
		  Else
		    
		    Signal = Signals.Normal
		    
		  End If
		  
		  // done.
		  
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
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the total weight of all the children.
		  
		  Return p_childrenweight
		  
		  // done.
		  
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
		  // Created 7/16/2011 by Andrew Keller
		  
		  // Returns the value of this node, possibly taking
		  // into account the values of the children.
		  
		  // General formula:
		  //    = local value
		  //    + child 0 value * ( child 0 weight / total children weight )
		  //    + child 1 value * ( child 1 weight / total children weight )
		  //    + ...
		  //    + child N value * ( child N weight / total children weight )
		  
		  // Note that this property completely ignores the indeterminate value property.
		  // The value and the indeterminate value are completely separate by design,
		  // allowing a user interface to ignore one and not get jerks and jumps in the other.
		  
		  Dim rslt As Double = p_value
		  
		  If include_children Then
		    For Each c As ProgressDelegateKFS In Children
		      If Not ( c Is Nil ) Then
		        
		        rslt = rslt + ( c.Value( include_children ) * ( c.p_weight / p_childrenweight ) )
		        
		      End If
		    Next
		  End If
		  
		  // Return the resut, making sure it is in the range [0,1].
		  
		  If rslt > 1 Then
		    Return 1
		    
		  ElseIf rslt < 0 Then
		    Return 0
		    
		  Else
		    Return rslt
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  // Created 7/15/2011 by Andrew Keller
		  
		  // Returns the current weight of this node.
		  
		  Return p_weight
		  
		  // done.
		  
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
