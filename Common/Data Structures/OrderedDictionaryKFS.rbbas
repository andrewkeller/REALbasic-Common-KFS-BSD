#tag Class
Protected Class OrderedDictionaryKFS
Inherits Dictionary
	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Clears this dictionary of all its data.
		  
		  Super.Clear
		  
		  indicesByKey.Clear
		  keysByIndex.Clear
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(entries() As Pair)
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Simple constructor that adds the given key-value pairs
		  
		  Super.Constructor
		  
		  indicesByKey = New Dictionary
		  keysByIndex = New Dictionary
		  
		  For Each item As Pair In entries
		    
		    Me.Value( item.Left ) = item.Right
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(ParamArray entries As Pair)
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Simple constructor that adds the given key-value pairs
		  
		  Constructor entries
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(key As Variant) As Integer
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Returns the index of the given key
		  
		  If Not Me.HasKey( key ) Then Raise New KeyNotFoundException
		  
		  Return indicesByKey.Value( key )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexOf(key As Variant, Assigns newPosition As Integer)
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Tries to move the given key to the given index
		  
		  If Not Me.HasKey( key ) Then Raise New KeyNotFoundException
		  
		  If newPosition < 0 Or newPosition >= Me.Count Then Raise New OutOfBoundsException
		  
		  MoveIndex( IndexOf( Key ), newPosition )
		  
		  // done.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key(index As Integer) As Variant
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Returns the key at the given index.
		  
		  If index < 0 Or index >= Me.Count Then Raise New OutOfBoundsException
		  
		  Return keysByIndex.Value( index )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys() As Variant()
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Returns an array of the keys in this class, in order of their indicies.
		  
		  Dim result() As Variant
		  ReDim result( Me.Count -1 )
		  
		  Dim index, last As Integer
		  
		  last = Me.Count -1
		  
		  For index = 0 To last
		    
		    result( index ) = Me.Key( index )
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub MoveIndex(position As Integer, newPosition As Integer, shiftIndices As Boolean = True)
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Moves the given index to the given new index.
		  
		  If position = newPosition Then Return
		  
		  If position < 0 Or newPosition < 0 Or position >= Me.Count Or newPosition >= Me.Count Then
		    
		    Raise New OutOfBoundsException
		    
		  End If
		  
		  // The primary dictionary does not change, only the index
		  
		  If shiftIndices Then
		    
		    Dim key As Variant = keysByIndex.Value( position )
		    
		    // Perform the shift
		    
		    Dim pole As Integer
		    
		    If position < newPosition Then
		      pole = 1
		    Else
		      pole = -1
		    End If
		    
		    Dim k As Variant
		    For index As Integer = position + pole To newPosition Step pole
		      
		      k = keysByIndex.Value( index )
		      
		      indicesByKey.Value( k ) = index - pole
		      keysByIndex.Value( index - pole ) = k
		      
		    Next
		    
		    indicesByKey.Value( key ) = newPosition
		    keysByIndex.Value( newPosition ) = key
		    
		  Else
		    
		    Dim a As Variant = keysByIndex.Value( position )
		    Dim b As Variant = keysByIndex.Value( newPosition )
		    
		    keysByIndex.Value( newPosition ) = a
		    keysByIndex.Value( position ) = b
		    
		    indicesByKey.Value( a ) = newPosition
		    indicesByKey.Value( b ) = position
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(key As Variant)
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Removes the given key from this Dictionary and updates the index
		  
		  If Not Me.HasKey( key ) Then Raise New OutOfBoundsException
		  
		  // Shift the indicies in the index to soak up the missing slot
		  
		  Dim rm As Integer = indicesByKey.Value( key )
		  Dim index As Integer
		  Dim last As Integer = Me.Count -1
		  
		  Dim k As Variant
		  For index = rm +1 To last
		    
		    k = keysByIndex.Value( index )
		    
		    indicesByKey.Value( k ) = index -1
		    keysByIndex.Value( index -1 ) = k
		    
		  Next
		  
		  indicesByKey.Remove key
		  keysByIndex.Remove last
		  Super.Remove key
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(key As Variant, Assigns _value As Variant)
		  // Created 8/23/2009 by Andrew Keller
		  
		  // Sets the given key-value pair and assigns it the default index.
		  
		  If Me.HasKey( key ) Then
		    
		    Super.Value( key ) = _value
		    
		  Else
		    
		    Super.Value( key ) = _value
		    
		    Dim index As Integer = Me.Count -1
		    
		    indicesByKey.Value( key ) = index
		    keysByIndex.Value( index ) = key
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values() As Variant()
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Returns an array of the values in this class, in order of their key indicies.
		  
		  Dim result() As Variant
		  ReDim result( Me.Count -1 )
		  
		  Dim index, last As Integer
		  
		  last = Me.Count -1
		  
		  For index = 0 To last
		    
		    result( index ) = Super.Value( Me.Key( index ) )
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = Implementation
		There is a rather important implementation detail to
		keep in mind here: this class does not represent an
		array; it represents a Dictionary with user definable
		key indices.
		
		This means that this class does not have public Append,
		Insert, or Move methods.  It is, quite simply, a
		Dictionary class where the keys have indices.
	#tag EndNote

	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller, et al.
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


	#tag Property, Flags = &h21
		Private indicesByKey As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private keysByIndex As Dictionary
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="BinCount"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Dictionary"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Count"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Dictionary"
		#tag EndViewProperty
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
