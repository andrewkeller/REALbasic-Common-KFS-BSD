#tag Module
Protected Module BSDGlobalsKFS_Data
	#tag Method, Flags = &h0
		Function BinCount(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant) As Integer
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the BinCount property of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_BinCount( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BinCount(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant, Assigns newBinCount As Integer)
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the BinCount property of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  dict_BinCount( d, path ) = newBinCount
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Child(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant) As Dictionary
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_Child( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Child(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant, Assigns newChild As Dictionary)
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  dict_Child( d, path ) = newChild
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children(Extends d As Dictionary, ParamArray path As Variant) As Dictionary()
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Values method of the Dictionary class.
		  
		  // Forward this to the core function.
		  
		  Return dict_Children( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant)
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Clear method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  dict_Clear( d, path )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant) As Integer
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Count method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_Count( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_BinCount(d As Dictionary, path() As Variant) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_BinCount(d As Dictionary, path() As Variant, Assigns newBinCount As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Child(d As Dictionary, path() As Variant) As Dictionary
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Child(d As Dictionary, path() As Variant, Assigns newChild As Dictionary)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Children(d As Dictionary, path() As Variant) As Dictionary()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Clear(d As Dictionary, path() As Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Count(d As Dictionary, path() As Variant) As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_HasChild(d As Dictionary, path() As Variant) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_HasKey(d As Dictionary, path() As Variant) As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Key(d As Dictionary, index As Integer, path() As Variant) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Keys(d As Dictionary, path() As Variant) As Variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Keys_Filtered(d As Dictionary, includeNonChildren As Boolean, includeChildren As Boolean, path() As Variant) As Variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Lookup_R(d As Dictionary, defaultValue As Variant, path() As Variant) As Variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_NonChildren(d As Dictionary, path() As Variant) As Variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub dict_Remove(d As Dictionary, cleanUp As Boolean, path() As Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Value(d As Dictionary, path() As Variant) As Variant
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Value(d As Dictionary, path() As Variant, Assigns newValue As Variant)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Values(d As Dictionary, path() As Variant) As Variant()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasChild(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant) As Boolean
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the HasKey method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_HasChild( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(Extends d As Dictionary, pathRoot As Variant, pathNext As Variant, ParamArray path As Variant) As Boolean
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the HasKey method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathNext
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_HasKey( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key(Extends d As Dictionary, index As Integer, pathRoot As Variant, ParamArray path As Variant) As Variant
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Key method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_Key( d, index, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant) As Variant()
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Keys method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_Keys( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys_Filtered(Extends d As Dictionary, includeNonChildren As Boolean, includeChildren As Boolean, ParamArray path As Variant) As Variant()
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Keys method of the Dictionary class.
		  
		  // Forward this to the core function.
		  
		  Return dict_Keys_Filtered( d, includeNonChildren, includeChildren, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup_R(Extends d As Dictionary, defaultValue As Variant, pathRoot As Variant, ParamArray path As Variant) As Variant()
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Lookup method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_Lookup_R( d, defaultValue, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NonChildren(Extends d As Dictionary, ParamArray path As Variant) As Variant()
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Values method of the Dictionary class.
		  
		  // Forward this to the core function.
		  
		  Return dict_NonChildren( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Extends d As Dictionary, cleanUp As Boolean, pathRoot As Variant, pathNext As Variant, ParamArray path As Variant)
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Remove method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathNext
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  dict_Remove( d, cleanUp, path )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Extends d As Dictionary, pathRoot As Variant, pathNext As Variant, ParamArray path As Variant) As Variant
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathNext
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_Value( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Extends d As Dictionary, pathRoot As Variant, pathNext As Variant, ParamArray path As Variant, Assigns newValue As Variant)
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathNext
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  dict_Value( d, path ) = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant) As Variant()
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Values method of the Dictionary class.
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_Values( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
