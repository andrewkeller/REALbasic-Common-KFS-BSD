#tag Class
Protected Class DataChainKFS
	#tag Method, Flags = &h0
		Sub Append(value As Variant)
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Appends the given value to the end of this chain.
		  
		  If myCount > 0 Then
		    
		    myTail.Right = New NodeKFS
		    myTail = myTail.Right
		    myTail.Value = value
		    
		    myCount = myCount + 1
		    
		  Else
		    
		    myHead = New NodeKFS
		    myHead.Value = value
		    myTail = myHead
		    
		    myCount = 1
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Basic constructor.
		  
		  myCount = 0
		  myHead = Nil
		  myTail = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns the count of this chain.
		  
		  Return myCount
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasValue(value As Variant) As Boolean
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns whether or not this chain contains the given value.
		  
		  Dim p As NodeKFS = myHead
		  
		  While p <> Nil
		    
		    If p.Value = value Then Return True
		    
		    p = p.Right
		    
		  Wend
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsEmpty() As Boolean
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns whether or not this chain is empty.
		  
		  Return myCount = 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Peek() As Variant
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns the head value without removing it from the chain.
		  
		  If myHead = Nil Then
		    
		    Raise New NilObjectException
		    
		  Else
		    
		    Return myHead.Value
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pop() As Variant
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns and removes the head of the chain.
		  
		  If myCount > 0 Then
		    
		    Dim result As Variant = myHead.Value
		    myHead = myHead.Right
		    If myHead = Nil Then myTail = Nil
		    
		    myCount = myCount -1
		    
		    Return result
		    
		  Else
		    
		    Raise New NilObjectException
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Push(value As Variant)
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Prepends the given value to the beginning of this chain.
		  
		  Dim newHead As New NodeKFS
		  
		  newHead.Right = myHead
		  newHead.Value = value
		  
		  myHead = newHead
		  
		  If myCount > 0 Then
		    
		    myCount = myCount + 1
		    
		  Else
		    
		    myTail = myHead
		    myCount = 1
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected myCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myHead As NodeKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTail As NodeKFS
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
