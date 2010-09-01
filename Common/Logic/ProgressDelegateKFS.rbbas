#tag Class
Protected Class ProgressDelegateKFS
	#tag Method, Flags = &h0
		Sub AddAutoUpdatedObject(f As ProgressBar)
		  // Created 8/31/2010 by Andrew Keller
		  
		  // Adds the given object to the list of objects that are automatically updated.
		  
		  Lock.Enter
		  
		  myAUObjects_ProgressBars.Append f
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddAutoUpdatedObject(f As StaticText)
		  // Created 8/31/2010 by Andrew Keller
		  
		  // Adds the given object to the list of objects that are automatically updated.
		  
		  Lock.Enter
		  
		  myAUObjects_Labels.Append f
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddMessageChangedCallback(f As ProgressDelegateKFS.BasicEventHandler)
		  // Created 8/31/2010 by Andrew Keller
		  
		  // Adds the given BasicEventHandler to myPCHandlers_Message.
		  
		  Lock.Enter
		  
		  myPCHandlers_Message.Append f
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddValueChangedCallback(f As ProgressDelegateKFS.BasicEventHandler)
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Adds the given BasicEventHandler to myPCHandlers_Value.
		  
		  Lock.Enter
		  
		  myPCHandlers_Value.Append f
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub BasicEventHandler(pgd As ProgressDelegateKFS)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Children() As ProgressDelegateKFS()
		  // Created 8/24/2010 by Andrew Keller
		  
		  // Returns an array of all the children of this object.
		  
		  Lock.Enter
		  
		  Dim result() As ProgressDelegateKFS
		  
		  For Each w As WeakRef In myChildren
		    
		    If w <> Nil Then
		      If w.Value <> Nil Then
		        result.Append ProgressDelegateKFS( w.Value )
		      End If
		    End If
		    
		  Next
		  
		  lock.Leave
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 8/24/2010 by Andrew Keller
		  
		  // Initializes everything.
		  
		  ReDim myAUObjects_Labels(-1)
		  ReDim myAUObjects_ProgressBars(-1)
		  ReDim myChildren(-1)
		  myDecimalDone = 0
		  myExpectedTotalChildrenWeight = 1
		  myIndeterminate = True
		  myMessage = ""
		  myParent = Nil
		  ReDim myPCHandlers_Message(-1)
		  ReDim myPCHandlers_Value(-1)
		  myWeight = 1
		  
		  p_oldIndeterminate = True
		  p_oldMessage = ""
		  p_oldValue = 0
		  
		  _lock = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 8/24/2010 by Andrew Keller
		  
		  // Add the weight of this object into the parent object.
		  
		  Dim p As ProgressDelegateKFS = Parent
		  
		  If p <> Nil Then
		    
		    p.Lock.Enter
		    
		    // Do not signal that progress changed, because unlinking with the parent will do that.
		    
		    p.myDecimalDone = Min( 1, p.myDecimalDone + myWeight * ( 1 - p.myDecimalDone ) / p.TotalWeightOfChildren )
		    p.myIndeterminate = False
		    
		    Me.Parent = Nil
		    
		    p.Lock.Leave
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventRouter()
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Raises the *Changed events in this object and all the parents.
		  
		  Lock.Enter
		  
		  Dim valueChanged As Boolean = False
		  Dim messageChanged As Boolean = False
		  
		  If Me.Value <> p_oldValue Or Me.IndeterminateValue <> p_oldIndeterminate Then
		    
		    valueChanged = True
		    p_oldValue = Me.Value
		    p_oldIndeterminate = Me.IndeterminateValue
		    
		    RaiseEvent ValueChanged
		    
		    For Each h As BasicEventHandler In myPCHandlers_Value
		      If h <> Nil Then h.Invoke Me
		    Next
		    
		    For Each p As ProgressBar In myAUObjects_ProgressBars
		      If p <> Nil Then
		        p.Maximum = p.Width
		        p.Value = p.Maximum * Me.OverallValue
		      End If
		    Next
		    
		  End If
		  
		  If Me.Message <> p_oldMessage Then
		    
		    messageChanged = True
		    p_oldMessage = Me.Message
		    
		    RaiseEvent MessageChanged
		    
		    For Each h As BasicEventHandler In myPCHandlers_Message
		      If h <> Nil Then h.Invoke Me
		    Next
		    
		    For Each s As StaticText In myAUObjects_Labels
		      If s <> Nil Then s.Caption = Me.Message
		    Next
		    
		  End If
		  
		  // Notify the parent that something changed.
		  
		  If valueChanged Or messageChanged Then
		    Dim p As ProgressDelegateKFS = Me.Parent
		    If p <> Nil Then p.EventRouter
		  End If
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExpectedWeightOfChildren() As Double
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Returns the current segment count value.
		  
		  Return myExpectedTotalChildrenWeight
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExpectedWeightOfChildren(Assigns newValue As Double)
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Sets the current segment count value.
		  
		  Lock.Enter
		  
		  myExpectedTotalChildrenWeight = Max( 0, newValue )
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndeterminateValue() As Boolean
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Returns the current indeterminate value state.
		  
		  Lock.Enter
		  
		  If myIndeterminate = False Then
		    Lock.Leave
		    Return False
		  End If
		  
		  For Each p As ProgressDelegateKFS In Children
		    
		    If p <> Nil Then
		      
		      If p.IndeterminateValue = False Then
		        Lock.Leave
		        Return False
		      End If
		      
		    End If
		    
		  Next
		  
		  Lock.Leave
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndeterminateValue(Assigns newValue As Boolean)
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Sets the current indeterminate value state.
		  
		  Lock.Enter
		  
		  myIndeterminate = newValue
		  
		  EventRouter
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Lock() As CriticalSection
		  // Created 9/1/2010 by Andrew Keller
		  
		  // Returns a reference to the CriticalSection object at the root of this tree.
		  
		  Dim p As ProgressDelegateKFS = Me
		  
		  While p.Parent <> Nil
		    
		    p = p.Parent
		    
		  Wend
		  
		  If p._lock = Nil Then p._lock = New CriticalSection
		  
		  Return p._lock
		  
		  // done.
		  
		End Function
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
		  
		  Lock.Enter
		  
		  myMessage = newValue
		  
		  EventRouter
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverallValue() As Double
		  // Created 8/26/2010 by Andrew Keller
		  
		  // Generates a decimal progress value that reflects this object and all children.
		  
		  Lock.Enter
		  
		  Dim result As Double = 0
		  Dim twoc As Double = TotalWeightOfChildren
		  
		  For Each p As ProgressDelegateKFS In Children
		    
		    result = result + p.OverallValue * p.Weight / twoc
		    
		  Next
		  
		  result = Me.Value + result * ( 1 - Me.Value )
		  
		  Lock.Leave
		  
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
		  
		  Lock.Enter
		  
		  If myParent <> Nil Then
		    
		    For row As Integer = myParent.myChildren.Ubound DownTo 0
		      
		      If myParent.myChildren( row ) <> Nil Then
		        If myParent.myChildren( row ).Value Is Me Then
		          
		          myParent.myChildren.Remove row
		          myParent.EventRouter
		          Exit
		          
		        End If
		      End If
		    Next
		  End If
		  
		  Lock.Leave
		  
		  // Next, set the new parent.
		  
		  If newParent = Nil Then
		    myParent = Nil
		  Else
		    
		    newParent.Lock.Enter
		    
		    myParent = newParent
		    
		    myParent.myChildren.Append New WeakRef( Me )
		    
		    newParent.Lock.Leave
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnChild(weight As Double = 1, value As Double = 0, msg As String = "") As ProgressDelegateKFS
		  // Created 8/24/2010 by Andrew Keller
		  
		  // Returns a ProgressDelegateKFS that is set to be a child of this object.
		  
		  Dim result As New ProgressDelegateKFS
		  
		  result.myDecimalDone = Min( 1, Max( 0, value ) )
		  result.myMessage = msg
		  result.myWeight = weight
		  result.Parent = Me
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TotalWeightOfChildren() As Double
		  // Created 8/25/2010 by Andrew Keller
		  
		  // Returns the sum of the weights of all the children of this object.
		  
		  Lock.Enter
		  
		  Dim result As Double = 0
		  
		  For Each p As ProgressDelegateKFS In Me.Children
		    
		    result = result + p.Weight
		    
		  Next
		  
		  Lock.Leave
		  
		  Return Max( ExpectedWeightOfChildren, result )
		  
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
		  
		  Lock.Enter
		  
		  myDecimalDone = Min( 1, Max( 0, newValue ) )
		  myIndeterminate = False
		  
		  EventRouter
		  
		  Lock.Leave
		  
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
		  
		  Lock.Enter
		  
		  myWeight = Max( 0, newValue )
		  
		  Dim p As ProgressDelegateKFS = Me.Parent
		  If p <> Nil Then p.EventRouter
		  
		  Lock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged()
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
		Protected myAUObjects_Labels() As StaticText
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myAUObjects_ProgressBars() As ProgressBar
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myChildren() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myDecimalDone As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExpectedTotalChildrenWeight As Double
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
		Protected myPCHandlers_Message() As ProgressDelegateKFS.BasicEventHandler
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myPCHandlers_Value() As ProgressDelegateKFS.BasicEventHandler
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myWeight As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private p_oldIndeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private p_oldMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private p_oldValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private _lock As CriticalSection
	#tag EndProperty


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
