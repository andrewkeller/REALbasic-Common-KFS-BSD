#tag Class
Protected Class DataChainKFS
	#tag Method, Flags = &h0
		Sub Append(value As Variant)
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Appends the given value to the end of this chain.
		  
		  myLock.Enter
		  
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
		  
		  myLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 8/2/2010 by Andrew Keller
		  
		  // Blows away the chain.
		  
		  myLock.Enter
		  
		  myCount = 0
		  myHead = Nil
		  myTail = Nil
		  
		  myLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Basic constructor.
		  
		  myCount = 0
		  myHead = Nil
		  myLock = New CriticalSection
		  myTail = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns the count of this chain.
		  
		  myLock.Enter
		  
		  Dim rslt As Integer = myCount
		  
		  myLock.Leave
		  
		  Return rslt
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasValue(value As Variant) As Boolean
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns whether or not this chain contains the given value.
		  
		  // This function does not acquire a lock on the chain because
		  // of how long it can take, and also because of how cleanly
		  // this function can exit once it reaches what might be the end.
		  
		  Dim p As NodeKFS = myHead
		  
		  While Not ( p Is Nil )
		    
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
		  
		  myLock.Enter
		  
		  Dim rslt As Boolean = myCount = 0
		  
		  myLock.Leave
		  
		  Return rslt
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Peek() As Variant
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns the head value without removing it from the chain.
		  
		  myLock.Enter
		  
		  If myHead Is Nil Then
		    
		    myLock.Leave
		    Raise New NilObjectException
		    
		  Else
		    
		    myLock.Leave
		    Return myHead.Value
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Pop() As Variant
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Returns and removes the head of the chain.
		  
		  myLock.Enter
		  
		  If myCount > 0 Then
		    
		    Dim result As Variant = myHead.Value
		    myHead = myHead.Right
		    If myHead Is Nil Then myTail = Nil
		    
		    myCount = myCount -1
		    
		    myLock.Leave
		    
		    Return result
		    
		  Else
		    
		    myLock.Leave
		    Raise New NilObjectException
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Push(value As Variant)
		  // Created 6/7/2010 by Andrew Keller
		  
		  // Prepends the given value to the beginning of this chain.
		  
		  myLock.Enter
		  
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
		  
		  myLock.Leave
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a full list of all contributors.
		
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
		Protected myCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myHead As NodeKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myLock As CriticalSection
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
