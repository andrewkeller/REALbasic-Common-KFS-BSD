#tag Class
Protected Class ProgressDelegateKFS
	#tag Method, Flags = &h0
		Sub AddProgressChangedCallback(f As ProgressChangedHandler)
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Adds the given ProgressChangedHandler to myPCHandlers.
		  
		  myPCHandlers.Append f
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children() As ProgressDelegateKFS()
		  // Created 8/24/2010 by Andrew Keller
		  
		  // Returns an array of all the children of this object.
		  
		  Dim result() As ProgressDelegateKFS
		  
		  For Each w As WeakRef In myChildren
		    
		    If w <> Nil Then
		      If w.Value <> Nil Then
		        result.Append ProgressDelegateKFS( w.Value )
		      End If
		    End If
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 8/24/2010 by Andrew Keller
		  
		  // Initializes everything.
		  
		  ReDim myChildren(-1)
		  myDecimalDone = 0
		  myIndeterminate = True
		  myMessage = ""
		  myParent = Nil
		  mySegmentCount = 1
		  myWeight = 1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 8/24/2010 by Andrew Keller
		  
		  // Add the weight of this object into the parent object.
		  
		  Dim p As ProgressDelegateKFS = Parent
		  
		  If p <> Nil Then
		    
		    p.Value = p.Value + Me.Weight * ( 1- p.Value ) / p.TotalWeightOfChildren
		    
		    Me.Parent = Nil
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventRouter(valueChanged As Boolean, messageChanged As Boolean, stackChanged As Boolean)
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Raises the ProgressChanged event in this object and all the parents.
		  
		  RaiseEvent ProgressChanged valueChanged, messageChanged, stackChanged
		  
		  For Each h As ProgressChangedHandler In myPCHandlers
		    
		    If h <> Nil Then h.Invoke Me
		    
		  Next
		  
		  Dim p As ProgressDelegateKFS = Me.Parent
		  If p <> Nil Then p.EventRouter valueChanged, messageChanged, stackChanged
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndeterminateValue() As Boolean
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Returns the current indeterminate value state.
		  
		  Return myIndeterminate
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndeterminateValue(Assigns newValue As Boolean)
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Sets the current indeterminate value state.
		  
		  myIndeterminate = newValue
		  
		  EventRouter True, False, False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Returns the current message.
		  
		  Return myMessage
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns newValue As String)
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Sets the current message.
		  
		  myMessage = newValue
		  
		  EventRouter False, True, False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverallValue() As Double
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Generates a decimal progress value that reflects this object and all children.
		  
		  Dim result As Double = Me.Value
		  Dim twoc As Double = TotalWeightOfChildren
		  
		  For Each p As ProgressDelegateKFS In Children
		    
		    result = result + p.OverallValue * p.Weight / twoc
		    
		  Next
		  
		  Return Min( 1, result )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Parent() As ProgressDelegateKFS
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Returns a reference to the parent object.
		  
		  Return myParent
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Parent(Assigns newParent As ProgressDelegateKFS)
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Sets the parent of this object.
		  
		  // First, clear the current parent.
		  
		  If myParent <> Nil Then
		    
		    For row As Integer = myParent.myChildren.Ubound DownTo 0
		      
		      If myParent.myChildren( row ) <> Nil Then
		        If myParent.myChildren( row ).Value Is Me Then
		          
		          myParent.myChildren.Remove row
		          myParent.EventRouter True, True, True
		          Exit
		          
		        End If
		      End If
		    Next
		  End If
		  
		  // Next, set the new parent.
		  
		  myParent = newParent
		  If myParent <> Nil Then
		    
		    myParent.myChildren.Append New WeakRef( Me )
		    EventRouter True, True, True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub ProgressChangedHandler(progressObject As ProgressDelegateKFS)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function SegmentCount() As UInt16
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Returns the current segment count value.
		  
		  Return mySegmentCount
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SegmentCount(Assigns newValue As UInt16)
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Sets the current segment count value.
		  
		  mySegmentCount = newValue
		  
		  EventRouter True, False, False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnSubDelegate(weight As Double = 1, value As Double = 0, msg As String = "") As ProgressDelegateKFS
		  // Created 8/24/2010 by Andrew Keller
		  
		  // Returns a ProgressDelegateKFS that is set to be a child of this object.
		  
		  Dim result As New ProgressDelegateKFS
		  
		  result.Parent = Me
		  result.myDecimalDone = Min( 1, Max( 0, value ) )
		  result.myMessage = msg
		  result.myWeight = weight
		  
		  EventRouter True, True, True
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TotalWeightOfChildren() As Double
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Returns the sum of the weights of all the children of this object.
		  
		  Dim result As Double = 0
		  
		  For Each p As ProgressDelegateKFS In Me.Children
		    
		    result = result + p.Weight
		    
		  Next
		  
		  Return Max( SegmentCount, result )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Double
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Returns the current decimal done value.
		  
		  If myIndeterminate Then
		    
		    Return 0
		    
		  Else
		    
		    Return myDecimalDone
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Assigns newValue As Double)
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Sets the current decimal done value.
		  
		  myDecimalDone = Min( 1, Max( 0, newValue ) )
		  myIndeterminate = False
		  
		  EventRouter True, False, False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Returns the current weight value.
		  
		  Return myWeight
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Weight(Assigns newValue As Double)
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Sets the current weight value.
		  
		  myWeight = newValue
		  
		  EventRouter True, False, False
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ProgressChanged(valueChanged As Boolean, messageChanged As Boolean, stackChanged As Boolean)
	#tag EndHook


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
		Protected myChildren() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myDecimalDone As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myIndeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMessage As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myParent As ProgressDelegateKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myPCHandlers() As ProgressChangedHandler
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mySegmentCount As UInt16
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myWeight As Double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoFlush"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
		#tag EndViewProperty
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
		#tag ViewProperty
			Name="userPressedCancel"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
