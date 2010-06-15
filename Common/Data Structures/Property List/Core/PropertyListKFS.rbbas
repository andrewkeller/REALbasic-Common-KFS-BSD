#tag Class
Protected Class PropertyListKFS
Inherits OrderedDictionaryKFS
	#tag Method, Flags = &h0
		Function Child(key As Variant, setAsType As Integer = - 1) As PropertyListKFS
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard child function, except that we must first
		  // figure out whether the key is an index or not.
		  
		  // Super.Key and Super.Value in the last block may throw exceptions.
		  
		  Dim result As PropertyListKFS
		  
		  If setAsType > -1 And Me.HasKey( key ) Then
		    
		    If IsIndex( key ) Then
		      
		      result = Super.Value( Super.Key( key ) )
		    Else
		      result = Super.Value( key )
		    End If
		    
		    result.Type = setAsType
		    
		  ElseIf setAsType > -1 Then
		    
		    result = New PropertyListKFS( setAsType )
		    
		    result.Type = setAsType
		    
		    Me.Child( key ) = result
		    
		  Else
		    
		    If IsIndex( key ) Then
		      
		      result = Super.Value( Super.Key( key ) )
		      
		    Else
		      
		      result = Super.Value( key )
		      
		    End If
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Child(key As Variant, Assigns newChild As PropertyListKFS)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard child function, except that we must first
		  // figure out whether the key is an index or not.
		  
		  If IsIndex( key ) Then
		    
		    If key < 0 Or key > Me.Count Then Raise New OutOfBoundsException
		    
		    If key = Me.Count Then
		      
		      Super.Value( NewUnusedKey ) = newChild
		      
		    Else
		      
		      Super.Value( Super.Key( key ) ) = newChild
		      
		    End If
		    
		  Else
		    
		    Super.Value( key.StringValue ) = newChild
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children() As PropertyListKFS()
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Returns an array of all the children in this instance.
		  
		  Dim tmp() As Variant = Super.Values
		  
		  Dim row, last As Integer = UBound( tmp )
		  
		  Dim result() As PropertyListKFS
		  ReDim result( last )
		  
		  For row = 0 To last
		    
		    result( row ) = PropertyListKFS( tmp( row ) )
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Clears this instance of all data.
		  
		  Super.Clear
		  
		  IsModified = False
		  myValue = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(setAsType As Integer)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Constructor that takes a type.
		  
		  Super.Constructor
		  
		  AutoSaveInDestructor = False
		  myDataIsModified = False
		  myType = setAsType
		  myValue = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(entries() As Pair)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Simple constructor that adds the given key-value pairs
		  
		  Super.Constructor entries
		  
		  AutoSaveInDestructor = False
		  myDataIsModified = False
		  myType = kNodeTypeDictionary
		  myValue = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(ParamArray entries As Pair)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Simple constructor that adds the given key-value pairs
		  
		  Constructor entries
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 1/7/2009 by Andrew Keller
		  
		  // Standard Destructor.
		  
		  // Save this instance to origin?
		  
		  If AutoSaveInDestructor Then
		    
		    Save
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Function GetDataType(data As Variant) As Integer
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Returns the type of the given variant.
		  
		  If data = Nil Then Return kNodeTypeBoolean
		  
		  If data.IsArray Then Return kNodeTypeArray
		  
		  Dim type As Integer = VarType( data )
		  
		  Select Case type
		    
		  Case Variant.TypeBoolean
		    Return kNodeTypeBoolean
		    
		  Case Variant.TypeCFStringRef
		    Return kNodeTypeString
		    
		  Case Variant.TypeColor
		    Return kNodeTypeNumber
		    
		  Case Variant.TypeCString
		    Return kNodeTypeString
		    
		  Case Variant.TypeCurrency
		    Return kNodeTypeNumber
		    
		  Case Variant.TypeDate
		    Return kNodeTypeDate
		    
		  Case Variant.TypeDouble
		    Return kNodeTypeNumber
		    
		  Case Variant.TypeInteger
		    Return kNodeTypeNumber
		    
		  Case Variant.TypeLong
		    Return kNodeTypeNumber
		    
		  Case Variant.TypeNil
		    Return kNodeTypeBoolean
		    
		  Case Variant.TypeObject
		    Return kNodeTypeData
		    
		  Case Variant.TypeOSType
		    Return kNodeTypeNumber
		    
		  Case Variant.TypePString
		    Return kNodeTypeString
		    
		  Case Variant.TypePtr
		    Return kNodeTypeNumber
		    
		  Case Variant.TypeSingle
		    Return kNodeTypeNumber
		    
		  Case Variant.TypeString
		    Return kNodeTypeString
		    
		  Case Variant.TypeStructure
		    Return kNodeTypeData
		    
		  Case Variant.TypeWindowPtr
		    Return kNodeTypeNumber
		    
		  Case Variant.TypeWString
		    Return kNodeTypeString
		    
		  End Select
		  
		  Return kNodeTypeData
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(key As Variant) As Boolean
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard HasKey function, but first we have to figure
		  // out whether the given key is an index or not.
		  
		  If IsIndex( key ) Then
		    
		    Return key.IntegerValue >=0 And key.IntegerValue < Me.Count
		    
		  Else
		    
		    Return Super.HasKey( key.StringValue )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndexOf(key As Variant) As Integer
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard IndexOf function, except that we must first
		  // figure out whether the key is an index or not.
		  
		  If IsIndex( key ) Then
		    
		    Return key
		    
		  Else
		    
		    Return Super.IndexOf( key )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndexOf(key As Variant, Assigns newPosition As Integer)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard IndexOf function, except that we must first
		  // figure out whether the key is an index or not.
		  
		  If IsIndex( key ) Then
		    
		    Super.MoveIndex( key, newPosition )
		    
		  Else
		    
		    Super.IndexOf( key ) = newPosition
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function IsIndex(key As Variant) As Boolean
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Returns whether or not the given key should be treated as an index.
		  
		  Dim type As Integer = VarType( key )
		  
		  Select Case type
		    
		  Case Variant.TypeInteger
		    Return True
		    
		  Case Variant.TypeLong
		    Return True
		    
		  Case Variant.TypeSingle
		    Return True
		    
		  End Select
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsModified() As Boolean
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Returns whether or not this instance
		  // or any of its children are modified.
		  
		  If myDataIsModified Then Return True
		  
		  For Each child As PropertyListKFS In Me.Children
		    
		    If child.IsModified Then Return True
		    
		  Next
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub IsModified(Assigns b As Boolean)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Either marks this instance as modified, or marks
		  // this instance and all of its children as not modified.
		  
		  If b Then
		    
		    myDataIsModified = True
		    
		  Else
		    
		    myDataIsModified = False
		    
		    For Each child As PropertyListKFS In Me.Children
		      
		      child.IsModified = False
		      
		    Next
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(key As Variant, defaultValue As Variant) As Variant
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard Value function, except that it is abstracted at
		  // this layer (meaning key could be either an index or a key).
		  
		  If Me.HasKey( key ) Then
		    
		    Return Value( key )
		    
		  Else
		    
		    Return defaultValue
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function NewUnusedKey() As String
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Returns a key that is not used in this instance.
		  
		  Dim result As String
		  
		  Do
		    
		    result = "default_key_" + str( GetUniqueIndexKFS( "PropertyListKFS.NewUnusedKey" ) )
		    
		  Loop Until Not Me.HasKey( result )
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Open(file As FolderItem) As PropertyListKFS
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Provides an alternate syntax for initializing
		  // a PropertyListKFS instance from a file.
		  
		  If file = Nil Then Raise New NilObjectException
		  
		  Return file.OpenAsPropertyListKFS
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(key As Variant)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard Remove function, but first we have to figure
		  // out whether the given key is an index or not.
		  
		  // Super.Remove and Super.Key may throw exceptions.
		  
		  If IsIndex( key ) Then
		    
		    Super.Remove( Super.Key( key ) )
		    
		  Else
		    
		    Super.Remove( key )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Revert()
		  // Created 1/7/2009 by Andrew Keller
		  
		  // Doesn't actually do anything.
		  
		  // This function exists here for easy access to the
		  // Revert function in any subclasses, when they are
		  // applicable.  This way, you can call Revert on any
		  // instance of PropertyListKFS without actually knowing
		  // what type it is, or even if it will revert to something.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Revert(src As PropertyListKFS)
		  // Created 1/7/2009 by Andrew Keller
		  
		  // Reinitializes this instance with the data contained in the given PropertyListKFS.
		  
		  Clear
		  
		  If src <> Nil Then
		    
		    // Import the value in src
		    
		    myValue = src.myValue
		    myType = src.myType
		    
		    // Import the children in src
		    
		    Dim index, last As Integer
		    
		    last = src.Count -1
		    
		    For index = 0 To last
		      
		      Dim k As String = src.Key( index )
		      Dim c As PropertyListKFS = src.Child( index )
		      
		      Me.Child( k, c.Type ).Revert c
		      
		    Next
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  // Created 1/7/2009 by Andrew Keller
		  
		  // Doesn't actually do anything.
		  
		  // This function exists here for easy access to the
		  // Save function in any subclasses, when they are
		  // applicable.  This way, you can call Save on any
		  // instance of PropertyListKFS without actually knowing
		  // what type it is, or even if it will save to something.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type() As Integer
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Returns the current type of this instance.
		  
		  Return myType
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Type(Assigns newType As Integer)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Sets the type of this instance.
		  
		  myType = newType
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Type_Localized() As String
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Returns a human-readable representation
		  // of the type of this class.
		  
		  Select Case Type
		    
		  Case kNodeTypeDictionary
		    Return "Dictionary"
		    
		  Case kNodeTypeArray
		    Return "Array"
		    
		  Case kNodeTypeBoolean
		    Return "Boolean"
		    
		  Case kNodeTypeNumber
		    Return "Number"
		    
		  Case kNodeTypeString
		    Return "String"
		    
		  Case kNodeTypeDate
		    Return "Date"
		    
		  Case kNodeTypeData
		    Return "Data"
		    
		  Else
		    Return "[Invalid Type]"
		    
		  End Select
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Variant
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Returns the current value in this instance.
		  
		  Return myValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Assigns newValue As Variant)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Sets the value in this instance.
		  
		  myValue = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(key As Variant) As Variant
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard Value function, except that it is abstracted at
		  // this layer (meaning key could be either an index or a key).
		  
		  // Me.Child may throw an exception.
		  
		  Return Me.Child( key ).Value
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(key As Variant, setAsType As Integer, Assigns _value As Variant)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard Value function, except that it is abstracted at
		  // this layer (meaning key could be either an index or a key).
		  
		  Me.Child( key, setAsType ).Value = _value
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(key As Variant, Assigns _value As Variant)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // A standard Value function, except that it is abstracted at
		  // this layer (meaning key could be either an index or a key).
		  
		  Me.Value( key, GetDataType( _value ) ) = _value
		  
		  // done.
		  
		End Sub
	#tag EndMethod


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


	#tag Property, Flags = &h0
		#tag Note
			Almost doesn't do anything.
			
			This property is shared amongst most of the subclasses
			of this class, making it eligible for being in this
			layer.  This way, you can tell whether or not an
			arbitrary PropertyListKFS will save in the destructor
			or not, without knowing which subclass it is, or if
			Save will even do anything.
		#tag EndNote
		AutoSaveInDestructor As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private myDataIsModified As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private myType As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private myValue As Variant
	#tag EndProperty


	#tag Constant, Name = kNodeTypeArray, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kNodeTypeBoolean, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kNodeTypeData, Type = Double, Dynamic = False, Default = \"6", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kNodeTypeDate, Type = Double, Dynamic = False, Default = \"5", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kNodeTypeDictionary, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kNodeTypeNumber, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kNodeTypeString, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoSaveInDestructor"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
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
