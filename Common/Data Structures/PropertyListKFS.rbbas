#tag Class
Protected Class PropertyListKFS
	#tag Method, Flags = &h0
		Function Child(key1 As Variant, ParamArray keyN As Variant) As PropertyListKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Child(key1 As Variant, ParamArray keyN As Variant, Assigns newChild As PropertyListKFS)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChildCount(ParamArray keyN As Variant) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children(ParamArray keyN As Variant) As PropertyListKFS()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As PropertyListKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 11/22/2010 by Andrew Keller
		  
		  // A basic constructor.
		  
		  p_Core = New Dictionary
		  p_treatAsArray = False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(entries() As Pair)
		  // Created 11/22/2010 by Andrew Keller
		  
		  // A clone constructor that imports the given data.
		  
		  p_Core = New Dictionary
		  p_treatAsArray = False
		  
		  For Each item As Pair In entries
		    
		    p_Core.Value( item.Left ) = item.Right
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(entry1 As Pair, ParamArray entries As Pair)
		  // Created 11/22/2010 by Andrew Keller
		  
		  // A clone constructor that imports the given data.
		  
		  entries.Insert 0, entry1
		  
		  Constructor entries
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As PropertyListKFS)
		  // Created 11/22/2010 by Andrew Keller
		  
		  // A clone constructor that imports the given data.
		  
		  p_Core = New Dictionary
		  p_treatAsArray = False
		  
		  Import other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count(ParamArray keyN As Variant) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasChild(key1 As Variant, ParamArray keyN As Variant) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(key1 As Variant, ParamArray keyN As Variant) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasTerminal(key1 As Variant, ParamArray keyN As Variant) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(other As PropertyListKFS)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key(key1 As Variant, ParamArray keyN As Variant) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys(ParamArray keyN As Variant) As Variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(defaultValue As Variant, key1 As Variant, ParamArray keyN As Variant) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewPListFromClone(other As PropertyListKFS) As PropertyListKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewPListWithDataCore(d As Dictionary) As PropertyListKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(other As PropertyListKFS) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Dictionary
		  // Created 11/22/2010 by Andrew Keller
		  
		  // Converts this object to a Dictionary object.
		  
		  // Return the data core.
		  
		  Return p_Core
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As Dictionary)
		  // Created 11/22/2010 by Andrew Keller
		  
		  // A convert constructor that takes the given Dictionary object.
		  
		  // Treat the Dictionary object as a data core.
		  
		  If other Is Nil Then
		    
		    p_Core = New Dictionary
		    
		  Else
		    
		    p_Core = other
		    
		  End If
		  
		  p_treatAsArray = False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(prune As Boolean, key1 As Variant, ParamArray keyN As Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TerminalCount(ParamArray keyN As Variant) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TreatAsArray(ParamArray keyN As Variant) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TreatAsArray(ParamArray keyN As Variant, Assigns newValue As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(key1 As Variant, ParamArray keyN As Variant) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(key1 As Variant, ParamArray keyN As Variant, Assigns newValue As Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values(ParamArray keyN As Variant) As Variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Wedge(newValue As Variant, key1 As Variant, ParamArray keyN As Variant)
		  
		End Sub
	#tag EndMethod


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


	#tag Property, Flags = &h1
		Protected p_Core As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_treatAsArray As Boolean
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
