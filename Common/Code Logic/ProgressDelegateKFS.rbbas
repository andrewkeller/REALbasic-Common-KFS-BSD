#tag Class
Protected Class ProgressDelegateKFS
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 12/28/2009 --;
		  
		  // Basic constructor - just initialize things
		  
		  AutoFlush = True
		  UserPressedCancel = False
		  
		  myStackHeight = 1
		  
		  ReDim myMaxes( 0 )
		  ReDim myMsgs( 0 )
		  ReDim myValues( 0 )
		  
		  myMaxes(0) = 1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DecimalValue() As Double
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/20/2009 --;
		  
		  // calculates the overall progress as a decimal in the interval [0,1]
		  
		  If myStackHeight = 0 Then Return 0
		  
		  Dim result As Double = 0
		  Dim magnitude As Double = 1
		  Dim row As Integer
		  
		  For row = myStackHeight -1 DownTo 0
		    
		    If myMaxes( row ) > 0 Then
		      
		      result = result + myValues( row ) / myMaxes( row ) * magnitude
		      magnitude = magnitude / myMaxes( row )
		      
		    End If
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Flush(valueChanged As Boolean = True, maxChanged As Boolean = True, messageChanged As Boolean = True, stackChanged As Boolean = True)
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; Calling function now has control over ProgressChanged arguments
		  
		  // fires the ProgressChanged event manually
		  
		  ProgressChanged valueChanged, maxChanged, messageChanged, stackChanged
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Maximum() As Int64
		  // Created 4/13/2009 by Andrew Keller
		  
		  // returns the maximum at the current level in the stack
		  
		  If myStackHeight > 0 Then
		    
		    Return myMaxes( 0 )
		    
		  Else
		    
		    Return 0
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Maximum(Assigns newValue As Int64)
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; now more efficient
		  
		  // sets a new maximum at the current stack level
		  
		  Dim maxc As Boolean
		  
		  If myStackHeight > 0 Then
		    
		    maxc = myMaxes( 0 ) <> newValue
		    
		    If maxc Then
		      
		      myMaxes( 0 ) = newValue
		      
		      ProgressChanged False, True, False, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  // Created 4/13/2009 by Andrew Keller
		  
		  // returns the current message at the current stack level
		  
		  // also note that if a message at a stack level is an empty string,
		  // then the message in the previous stack level replaces it.
		  
		  Dim row As Integer
		  
		  For row = 0 to myStackHeight -1
		    
		    If myMsgs( row ) <> "" Then
		      
		      Return myMsgs( row )
		      
		    End If
		    
		  Next
		  
		  Return ""
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns newMessage As String)
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; now more efficient
		  
		  // sets the message at the current stack level
		  
		  Dim msgc As Boolean
		  
		  If myStackHeight > 0 Then
		    
		    msgc = myMsgs( 0 ) <> newMessage
		    
		    If msgc Then
		      
		      myMsgs( 0 ) = newMessage
		      
		      ProgressChanged False, False, True, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message(stackPosition As Integer) As String
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/20/2009 --;
		  
		  // returns the current message at the current stack level
		  
		  // also note that if a message at a stack level is an empty string,
		  // then the message in the previous stack level replaces it.
		  
		  // BIG FAT NOTE: Although this class uses an inverted stack,
		  // this function in particular implements behavior like a
		  // normal stack.  This is because an inverted stack is not
		  // exactly standard, and it is good that no code outside of
		  // here ever gets the slightest hint of inconsistency.
		  
		  // Convert the input to the inverted stack equivalent
		  
		  Dim pos As Integer = myStackHeight - stackPosition -1
		  
		  // check for out of bounds
		  
		  If pos >= myStackHeight Then Return ""
		  
		  // if too high, then pull down
		  
		  If pos < 0 Then pos = 0
		  
		  // find the first level at which a message is set
		  
		  For row As Integer = pos To myStackHeight -1
		    
		    If myMsgs( row ) <> "" Then
		      
		      Return myMsgs( row )
		      
		    End If
		    
		  Next
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PopStack(autoIncrementValue As Boolean = False)
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; now fires ProgressChanged more descriptively
		  
		  // pops the stack
		  
		  Dim valc, maxc, msgc As Boolean
		  
		  If myStackHeight > 0 Then
		    
		    If myStackHeight > 1 Then
		      
		      valc = myValues( 0 ) <> myValues( 1 )
		      maxc = myMaxes( 0 ) <> myMaxes( 1 )
		      msgc = myMsgs( 0 ) <> "" And myMsgs( 0 ) <> myMsgs( 1 )
		      
		    End If
		    
		    myValues.Remove 0
		    myMaxes.Remove 0
		    myMsgs.Remove 0
		    
		    myStackHeight = myStackHeight -1
		    
		    
		    If myStackHeight > 0 Then
		      
		      If autoIncrementValue Then
		        
		        myValues( 0 ) = myValues( 0 ) +1
		        
		      End If
		      
		      ProgressChanged valc, maxc, msgc, True
		      
		    Else
		      
		      StackEmpied
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PushStack()
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; now fires ProgressChanged more descriptively
		  
		  // pushes the stack
		  
		  myValues.Insert 0, 0
		  myMaxes.Insert 0, 0
		  myMsgs.Insert 0, ""
		  
		  myStackHeight = myStackHeight +1
		  
		  If myStackHeight = 1 Then
		    
		    ProgressChanged True, True, True, True
		    
		  Else
		    
		    ProgressChanged myValues( 0 ) <> myValues( 1 ), myMaxes( 0 ) <> myMaxes( 1 ), False, True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PushStack(newValue As Int64, newMax As Int64, newMsg As String = "")
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; now fires ProgressChanged more descriptively
		  
		  // pushes the stack, and also sets some default values
		  
		  // this approach reduces the number of times ProgressChanged is called
		  
		  myMaxes.Insert 0, newMax
		  myMsgs.Insert 0, newMsg
		  myValues.Insert 0, newValue
		  
		  myStackHeight = myStackHeight +1
		  
		  If myStackHeight = 1 Then
		    
		    ProgressChanged True, True, True, True
		    
		  Else
		    
		    ProgressChanged myValues( 0 ) <> myValues( 1 ), myMaxes( 0 ) <> myMaxes( 1 ), myMsgs( 0 ) <> "" And myMsgs( 0 ) <> myMsgs( 1 ), True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetValues(value As Int64, max As Int64)
		  // Created 4/20/2009 by Andrew Keller
		  
		  
		  // sets multiple properties at once
		  
		  // this approach reduces the number of times ProgressChanged is called
		  
		  Dim valc, maxc, msgc As Boolean
		  
		  If myStackHeight > 0 Then
		    
		    valc = myValues( 0 ) <> value
		    maxc = myMaxes( 0 ) <> max
		    
		    If valc Or maxc Or msgc Then
		      
		      myValues( 0 ) = value
		      myMaxes( 0 ) = max
		      
		      ProgressChanged valc, maxc, False, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetValues(value As Int64, max As Int64, msg As String)
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; now fires ProgressChanged more descriptively
		  
		  // sets multiple properties at once
		  
		  // this approach reduces the number of times ProgressChanged is called
		  
		  Dim valc, maxc, msgc As Boolean
		  
		  If myStackHeight > 0 Then
		    
		    valc = myValues( 0 ) <> value
		    maxc = myMaxes( 0 ) <> max
		    msgc = msg <> Message
		    
		    If valc Or maxc Or msgc Then
		      
		      myValues( 0 ) = value
		      myMaxes( 0 ) = max
		      myMsgs( 0 ) = msg
		      
		      ProgressChanged valc, maxc, msgc, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SetValues(value As Int64, msg As String)
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; now fires ProgressChanged more descriptively
		  
		  // sets multiple properties at once
		  
		  // this approach reduces the number of times ProgressChanged is called
		  
		  Dim valc, msgc As Boolean
		  
		  If myStackHeight > 0 Then
		    
		    valc = myValues( 0 ) <> value
		    msgc = msg <> Message
		    
		    If valc Or msgc Then
		      
		      myValues( 0 ) = value
		      myMsgs( 0 ) = msg
		      
		      ProgressChanged valc, False, msgc, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StackHeight() As Integer
		  // Created 4/13/2009 by Andrew Keller
		  
		  // returns the current height of the stack
		  
		  Return myStackHeight
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Int64
		  // Created 4/13/2009 by Andrew Keller
		  
		  // returns the value at the current level of the stack
		  
		  If myStackHeight > 0 Then
		    
		    Return myValues( 0 )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Assigns newValue As Int64)
		  // Created 4/13/2009 by Andrew Keller
		  // Modified 4/18/2009 --; now more efficient
		  
		  // sets a new value in the current level of the stack
		  
		  Dim valc As Boolean
		  
		  If myStackHeight > 0 Then
		    
		    valc = myValues( 0 ) <> newValue
		    
		    If valc Then
		      
		      myValues( 0 ) = newValue
		      
		      ProgressChanged True, False, False, False
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event ProgressChanged(valueChanged As Boolean, maxChanged As Boolean, messageChanged As Boolean, stackChanged As Boolean)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event StackEmpied()
	#tag EndHook


	#tag Property, Flags = &h0
		AutoFlush As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMaxes() As Int64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMsgs() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myStackHeight As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myValues() As Int64
	#tag EndProperty

	#tag Property, Flags = &h0
		UserPressedCancel As Boolean
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
