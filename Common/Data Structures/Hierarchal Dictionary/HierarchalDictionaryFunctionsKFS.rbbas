#tag Module
Protected Module HierarchalDictionaryFunctionsKFS
	#tag Method, Flags = &h0
		Function BinCount(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant) As Integer
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the BinCount property of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the BinCount of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   value = myd.BinCount( "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function sets the BinCount of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   myd.BinCount( "foo", "bar", "fish" ) = newBinCount
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   myc = myd.Child( "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function sets the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   myd.Child( "foo", "bar", "fish" ) = newChild
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of the Dictionaries that are
		  // children of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   myca = myd.Children( "foo", "bar", "fish" )
		  
		  // Forward this to the core function.
		  
		  Return dict_Children( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant)
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Clear method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function clears the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   myd.Clear( "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the count of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   value = myd.Count( "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the BinCount of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   value = HierarchalDictionaryFunctionsKFS.dict_BinCount( myd, "foo", "bar", "fish" )
		  
		  Return dict_Child( d, path ).BinCount
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_BinCount(d As Dictionary, path() As Variant, Assigns newBinCount As Integer)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the BinCount method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function sets the BinCount of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   HierarchalDictionaryFunctionsKFS.dict_BinCount( myd, "foo", "bar", "fish" ) = newBinCount
		  
		  dict_Child( d, path ).BinCount = newBinCount
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Child(d As Dictionary, path() As Variant) As Dictionary
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   myc = HierarchalDictionaryFunctionsKFS.dict_Child( myd, "foo", "bar", "fish" )
		  
		  Return dict_Value( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Child(d As Dictionary, path() As Variant, Assigns newChild As Dictionary)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function sets the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   HierarchalDictionaryFunctionsKFS.dict_Child( myd, "foo", "bar", "fish" ) = newChild
		  
		  dict_Value( d, path ) = newChild
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Children(d As Dictionary, path() As Variant) As Dictionary()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Values method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of the Dictionaries that are
		  // children of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   myca = HierarchalDictionaryFunctionsKFS.dict_Children( myd, "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function clears the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   HierarchalDictionaryFunctionsKFS.dict_Clear( myd, "foo", "bar", "fish" )
		  
		  dict_Child( d, path ).Clear
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Count(d As Dictionary, path() As Variant) As Integer
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Count method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the count of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   value = HierarchalDictionaryFunctionsKFS.dict_Count( myd, "foo", "bar", "fish" )
		  
		  Return dict_Child( d, path ).Count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_HasChild(d As Dictionary, path() As Variant) As Boolean
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the HasKey method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns true if a Dictionary exists at the given path.
		  
		  // Allows for the syntax:
		  //   value = HierarchalDictionaryFunctionsKFS.dict_HasChild( myd, "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns true if any value or child exists at the given path.
		  
		  // Allows for the syntax:
		  //   value = HierarchalDictionaryFunctionsKFS.dict_HasKey( myd, "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the key at the given index inside the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   value = HierarchalDictionaryFunctionsKFS.dict_Key( myd, index, "foo", "bar", "fish" )
		  
		  Return dict_Child( d, path ).Key( index )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Keys(d As Dictionary, path() As Variant) As Variant()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Keys method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of the keys of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   values = HierarchalDictionaryFunctionsKFS.dict_Keys( myd, "foo", "bar", "fish" )
		  
		  Return dict_Keys_Filtered( d, True, True, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Keys_Filtered(d As Dictionary, includeNonChildren As Boolean, includeChildren As Boolean, path() As Variant) As Variant()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Keys method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of the keys of the Dictionary at the given path in the tree
		  // that match the given parameters (include non children versus include children).
		  
		  // Allows for the syntax:
		  //   values = HierarchalDictionaryFunctionsKFS.dict_Keys_Filtered( myd, bool, bool, "foo", "bar", "fish" )
		  
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
		Protected Function dict_Lookup_R(d As Dictionary, defaultValue As Variant, path() As Variant) As Variant
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Lookup method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the value at the given path in the tree, or the given default value if an error occurs.
		  
		  // Allows for the syntax:
		  //   value = HierarchalDictionaryFunctionsKFS.dict_Lookup_R( myd, "defaultValue", "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of the non-Dictionaries that are
		  // children of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   values = HierarchalDictionaryFunctionsKFS.dict_NonChildren( myd, "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function removes the key at the specified path in the tree,
		  // and optionally removes all empty parent nodes.
		  
		  // Allows for the syntax:
		  //   HierarchalDictionaryFunctionsKFS.dict_Remove( myd, bool, "foo", "bar", "fish" )
		  
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
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Value(d As Dictionary, path() As Variant) As Variant
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the value at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   value = HierarchalDictionaryFunctionsKFS.dict_Value( myd, "foo", "bar", "fish" )
		  
		  Return dict_Navigate( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub dict_Value(d As Dictionary, path() As Variant, Assigns newValue As Variant)
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Value method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function sets the value at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   HierarchalDictionaryFunctionsKFS.dict_Value( myd, "foo", "bar", "fish" ) = newValue
		  
		  Dim cursor As Dictionary = d
		  Dim tmp As Dictionary
		  
		  Dim last As Integer = UBound( path )
		  
		  For row As Integer = 0 To last -1
		    
		    If Not cursor.HasKey( path(row) ) Then
		      
		      tmp = New Dictionary
		      cursor.Value( path(row) ) = tmp
		      cursor = tmp
		      
		    ElseIf Not cursor.Value( path(row) ) IsA Dictionary Then
		      
		      tmp = New Dictionary
		      cursor.Value( path(row) ) = tmp
		      cursor = tmp
		      
		    Else
		      
		      cursor = Dictionary( cursor.Value( path(row) ) )
		      
		    End If
		    
		  Next
		  
		  cursor.Value( path(last) ) = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function dict_Values(d As Dictionary, path() As Variant) As Variant()
		  // Created 5/18/2010 by Andrew Keller
		  
		  // An extension of the Values method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of all the values that are
		  // children of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   values = HierarchalDictionaryFunctionsKFS.dict_Values( myd, "foo", "bar", "fish" )
		  
		  Return dict_Child( d, path ).Values
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasChild(Extends d As Dictionary, pathRoot As Variant, ParamArray path As Variant) As Boolean
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the HasKey method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns true if a Dictionary exists at the given path.
		  
		  // Allows for the syntax:
		  //   value = myd.HasChild( "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns true if any value or child exists at the given path.
		  
		  // Allows for the syntax:
		  //   value = myd.HasKey( "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the key at the given index inside the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   value = myd.Key( index, "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of the keys of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   values = myd.Keys( "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of the keys of the Dictionary at the given path in the tree
		  // that match the given parameters (include non children versus include children).
		  
		  // Allows for the syntax:
		  //   values = myd.Keys_Filtered( bool, bool, "foo", "bar", "fish" )
		  
		  // Forward this to the core function.
		  
		  Return dict_Keys_Filtered( d, includeNonChildren, includeChildren, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup_R(Extends d As Dictionary, defaultValue As Variant, pathRoot As Variant, ParamArray path As Variant) As Variant
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Lookup method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the value at the given path in the tree, or the given default value if an error occurs.
		  
		  // Allows for the syntax:
		  //   value = myd.Lookup_R( "defaultValue", "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of the non-Dictionaries that are
		  // children of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   values = myd.NonChildren( "foo", "bar", "fish" )
		  
		  // Forward this to the core function.
		  
		  Return dict_NonChildren( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Extends d As Dictionary, cleanUp As Boolean, pathRoot As Variant, ParamArray path As Variant)
		  // Created 5/17/2010 by Andrew Keller
		  
		  // An extension of the Remove method of the Dictionary class.
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function removes the key at the specified path in the tree,
		  // and optionally removes all empty parent nodes.
		  
		  // Allows for the syntax:
		  //   myd.Remove( bool, "foo", "bar", "fish" )
		  
		  // Assemble the path.
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns the value at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   value = myd.Value( "foo", "bar", "fish" )
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function sets the value at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   myd.Value( "foo", "bar", "fish" ) = newValue
		  
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
		  
		  // Assuming that the given Dictionary is the root of a tree of Dictionaries,
		  // and that the given path is a series of keys that leads to a single node of the tree,
		  // this function returns an array of all the values that are
		  // children of the Dictionary at the given path in the tree.
		  
		  // Allows for the syntax:
		  //   values = myd.Values( "foo", "bar", "fish" )
		  
		  // Assemble the path.
		  
		  path.Insert 0, pathRoot
		  
		  // Forward this to the core function.
		  
		  Return dict_Values( d, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This module is licensed as BSD.
		
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
