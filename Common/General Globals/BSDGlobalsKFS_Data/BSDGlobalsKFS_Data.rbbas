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
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the BinCount method of the Dictionary class.
		  
		  Return dict_Child( d, path ).BinCount
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_BinCount(d As Dictionary, path() As Variant, Assigns newBinCount As Integer)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the BinCount method of the Dictionary class.
		  
		  dict_Child( d, path ).BinCount = newBinCount
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Child(d As Dictionary, path() As Variant) As Dictionary
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  Return dict_Value( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Child(d As Dictionary, path() As Variant, Assigns newChild As Dictionary)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  dict_Value( d, path ) = newChild
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Children(d As Dictionary, path() As Variant) As Dictionary()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Values method of the Dictionary class.
		  
		  Dim result(-1) As Dictionary
		  
		  For Each v As Variant In dict_Values( d, path )
		    
		    If v IsA Dictionary Then
		      
		      result.Append v
		      
		    End If
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Clear(d As Dictionary, path() As Variant)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Clear method of the Dictionary class.
		  
		  dict_Child( d, path ).Clear
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Count(d As Dictionary, path() As Variant) As Integer
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Count method of the Dictionary class.
		  
		  Return dict_Child( d, path ).Count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_HasChild(d As Dictionary, path() As Variant) As Boolean
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the HasKey method of the Dictionary class.
		  
		  Dim c As Variant = dict_Navigate( d, path, New Dictionary( kNav_Opt_RaiseKeyNotFoundExc : False, kNav_Opt_RaiseTypecastExc : False ) )
		  
		  If c = Nil Then Return False
		  
		  If c.IsNull Then Return False
		  
		  Return c IsA Dictionary
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_HasKey(d As Dictionary, path() As Variant) As Boolean
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the HasKey method of the Dictionary class.
		  
		  Dim c As Variant = dict_Navigate( d, path, New Dictionary( kNav_Opt_RaiseKeyNotFoundExc : False, kNav_Opt_RaiseTypecastExc : False ) )
		  
		  If c = Nil Then Return False
		  
		  If c.IsNull Then Return False
		  
		  Return True
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Key(d As Dictionary, index As Integer, path() As Variant) As Variant
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Key method of the Dictionary class.
		  
		  Return dict_Child( d, path ).Key( index )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Keys(d As Dictionary, path() As Variant) As Variant()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Keys method of the Dictionary class.
		  
		  Return dict_Keys_Filtered( d, True, True, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Keys_Filtered(d As Dictionary, includeNonChildren As Boolean, includeChildren As Boolean, path() As Variant) As Variant()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Keys method of the Dictionary class.
		  
		  Dim result(-1) As Variant
		  
		  Dim c As Dictionary = dict_Navigate( d, path )
		  
		  For Each k As Variant In c.Keys
		    
		    Dim v As Variant = c.Value( k )
		    
		    If v IsA Dictionary Then
		      
		      If includeChildren Then result.Append k
		      
		    Else
		      
		      If includeNonChildren Then result.Append k
		      
		    End If
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Lookup_R(d As Dictionary, defaultValue As Variant, path() As Variant) As Variant()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Lookup method of the Dictionary class.
		  
		  If dict_HasKey( d, path ) Then
		    
		    Return dict_Value( d, path )
		    
		  Else
		    
		    Return defaultValue
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function dict_Navigate(root As Dictionary, path() As Variant, options As Dictionary = Nil) As Variant
		  // Created 5/18/2010 by Andrew Keller
		  
		  // A slave function that navigates the given path,
		  // and behaves as specified in the parameters.
		  
		  // Verify the root.
		  
		  If root = Nil Then Raise New NilObjectException
		  
		  // Extract the options from the parameters.
		  
		  If options = Nil Then options = New Dictionary
		  Dim bOmitLastKey As Boolean = options.Lookup( kNav_Opt_OmitLastKey, False )
		  Dim bRaiseKNFExc As Boolean = options.Lookup( kNav_Opt_RaiseKeyNotFoundExc, True )
		  Dim bRaiseTCExc As Boolean = options.Lookup( kNav_Opt_RaiseTypecastExc, True )
		  
		  // Set up the navigation environment.
		  
		  Dim cursor As Variant = root
		  
		  Dim index, last As Integer
		  last = UBound( path )
		  If bOmitLastKey Then last = last -1
		  
		  // Navigate to the given address.
		  
		  For index = 0 To last
		    
		    // First, make sure the key is actually there.
		    
		    If Not Dictionary( cursor ).HasKey( path(index) ) Then
		      If bRaiseKNFExc Then
		        Raise New KeyNotFoundException
		      Else
		        Return Nil
		      End If
		    End If
		    
		    // Get the child.
		    
		    cursor = Dictionary( cursor ).Value( path(index) )
		    
		    // If we're not done with our path, then that
		    // cursor had better contain a Dictionary.
		    
		    If index < last Then
		      If Not cursor IsA Dictionary Then
		        If bRaiseTCExc Then
		          Raise New IllegalCastException
		        Else
		          Return Nil
		        End If
		      End If
		    End If
		    
		    // All seems to be good.  Keep looping.
		    
		  Next
		  
		  Return cursor
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_NonChildren(d As Dictionary, path() As Variant) As Variant()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Values method of the Dictionary class.
		  
		  Dim result(-1) As Variant
		  
		  For Each v As Variant In dict_Values( d, path )
		    
		    If Not v IsA Dictionary Then
		      
		      result.Append v
		      
		    End If
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Remove(d As Dictionary, cleanUp As Boolean, path() As Variant)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Remove method of the Dictionary class.
		  
		  // Set up the navigation environment.
		  
		  Dim cursor(0) As Dictionary
		  cursor(0) = d
		  
		  Dim index, last As Integer
		  last = UBound( path )
		  
		  // Navigate to the given address.
		  
		  For index = 0 To last
		    
		    If index < last Then
		      If cursor(0).HasChild( path(index) ) Then
		        
		        cursor.Insert 0, cursor(0).Child( path(index) )
		        
		      Else
		        Exit
		      End If
		    ElseIf cursor(0).HasKey( path(index) ) Then
		      
		      cursor(0).Remove path(last)
		      
		    End If
		    
		  Next
		  
		  // Now, trace back through the stack, removing empty Dictionaries.
		  
		  If cleanUp Then
		    While UBound( cursor ) > 0
		      If cursor(0).Count = 0 Then
		        
		        cursor(1).Remove path( UBound( cursor ) -1 )
		        
		        cursor.Remove 0
		        
		      Else
		        
		        Exit
		        
		      End If
		    Wend
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Value(d As Dictionary, path() As Variant) As Variant
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  Return dict_Navigate( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Value(d As Dictionary, path() As Variant, Assigns newValue As Variant)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  Dim cursor As Dictionary = d
		  
		  Dim last As Integer = UBound( path )
		  
		  For row As Integer = 0 To last -1
		    
		    If Not cursor.HasKey( path(row) ) Then cursor.Value( path(row) ) = New Dictionary
		    
		    cursor = cursor.Value( path(row) )
		    
		  Next
		  
		  cursor.Value( path(last) ) = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Values(d As Dictionary, path() As Variant) As Variant()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Values method of the Dictionary class.
		  
		  Return dict_Child( d, path ).Values
		  
		  // done.
		  
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


	#tag Constant, Name = kNav_Opt_OmitLastKey, Type = String, Dynamic = False, Default = \"omitLastKey", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kNav_Opt_RaiseKeyNotFoundExc, Type = String, Dynamic = False, Default = \"raiseKeyNotFoundException", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kNav_Opt_RaiseTypecastExc, Type = String, Dynamic = False, Default = \"raiseIllegalCastException", Scope = Private
	#tag EndConstant


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
