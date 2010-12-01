#tag Class
Protected Class PropertyListKFS
	#tag Method, Flags = &h0
		Function Child(key1 As Variant, ParamArray keyN As Variant) As PropertyListKFS
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Returns the child at the given path.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If Not dcursor.HasKey( k ) Then Return Nil
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return Nil
		      
		    End If
		  Next
		  
		  If dcursor.HasKey( keyN( last ) ) Then
		    
		    v = dcursor.Value( keyN( last ) )
		    
		    If v IsA Dictionary Then
		      
		      Return Dictionary( v )
		      
		    ElseIf v IsA PropertyListKFS Then
		      
		      Return PropertyListKFS( v )
		      
		    End If
		  End If
		  
		  Return Nil
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Child(key1 As Variant, ParamArray keyN As Variant, Assigns newChild As PropertyListKFS)
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Sets the child at the given path.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim p As PropertyListKFS
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If dcursor.HasKey( k ) Then
		      
		      v = dcursor.Value( k )
		      
		      If v IsA PropertyListKFS Then
		        
		        dcursor = PropertyListKFS( v )
		        
		      ElseIf v IsA Dictionary Then
		        
		        dcursor = v
		        
		      Else
		        
		        p = New PropertyListKFS
		        dcursor.Value( k ) = p
		        dcursor = p
		        
		      End If
		    Else
		      
		      p = New PropertyListKFS
		      dcursor.Value( k ) = p
		      dcursor = p
		      
		    End If
		  Next
		  
		  dcursor.Value( keyN( last ) ) = newChild
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ChildCount(ParamArray keyN As Variant) As Integer
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns the number of directories in the directory at the given path.
		  
		  Dim dcursor As Dictionary
		  Dim v As Variant
		  
		  dcursor = p_core
		  
		  For Each k As Variant In keyN
		    
		    If Not dcursor.HasKey( k ) Then Return 0
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return 0
		      
		    End If
		  Next
		  
		  Dim result As Integer = 0
		  
		  For Each v In dcursor.Values
		    If v IsA Dictionary Or v IsA PropertyListKFS Then
		      result = result +1
		    End If
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Children(ParamArray keyN As Variant) As PropertyListKFS()
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Returns an array of the children in the directory at the given path.
		  
		  Dim dcursor As Dictionary
		  Dim v As Variant
		  Dim result(-1) As PropertyListKFS
		  
		  dcursor = p_core
		  
		  For Each k As Variant In keyN
		    
		    If Not dcursor.HasKey( k ) Then Return result
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return result
		      
		    End If
		  Next
		  
		  For Each v In dcursor.Values
		    
		    If v IsA Dictionary Then
		      
		      result.Append Dictionary( v )
		      
		    ElseIf v IsA PropertyListKFS Then
		      
		      result.Append PropertyListKFS( v )
		      
		    End If
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Clone() As PropertyListKFS
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns a clone of Me.
		  
		  Return New PropertyListKFS( Me )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 11/22/2010 by Andrew Keller
		  
		  // A basic constructor.
		  
		  p_core = New Dictionary
		  p_treatAsArray = False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(entries() As Pair)
		  // Created 11/22/2010 by Andrew Keller
		  
		  // A clone constructor that imports the given data.
		  
		  p_core = New Dictionary
		  p_treatAsArray = False
		  
		  For Each item As Pair In entries
		    
		    p_core.Value( item.Left ) = item.Right
		    
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
		  
		  p_core = New Dictionary
		  p_treatAsArray = False
		  
		  Import other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count(ParamArray keyN As Variant) As Integer
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns the number of keys in the directory at the given path.
		  
		  Dim dcursor As Dictionary
		  Dim v As Variant
		  
		  dcursor = p_core
		  
		  For Each k As Variant In keyN
		    
		    If Not dcursor.HasKey( k ) Then Return 0
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return 0
		      
		    End If
		  Next
		  
		  Return dcursor.Count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasChild(key1 As Variant, ParamArray keyN As Variant) As Boolean
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns whether or not the given key exists and points to a directory.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If Not dcursor.HasKey( k ) Then Return False
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return False
		      
		    End If
		  Next
		  
		  If dcursor.HasKey( keyN( last ) ) Then
		    
		    v = dcursor.Value( keyN( last ) )
		    Return v IsA PropertyListKFS Or v IsA Dictionary
		    
		  Else
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasKey(key1 As Variant, ParamArray keyN As Variant) As Boolean
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns whether or not the given key exists.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If Not dcursor.HasKey( k ) Then Return False
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return False
		      
		    End If
		  Next
		  
		  Return dcursor.HasKey( keyN( last ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasTerminal(key1 As Variant, ParamArray keyN As Variant) As Boolean
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns whether or not the given key exists and points to a terminal.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If Not dcursor.HasKey( k ) Then Return False
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return False
		      
		    End If
		  Next
		  
		  If dcursor.HasKey( keyN( last ) ) Then
		    
		    v = dcursor.Value( keyN( last ) )
		    Return Not ( v IsA PropertyListKFS Or v IsA Dictionary )
		    
		  Else
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Import(other As PropertyListKFS)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key(key1 As Variant, ParamArray keyN As Variant) As Variant
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Returns the key at the given location.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim p As PropertyListKFS
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    // Note: The following line will raise a KeyNotFoundException if the key does not exist.  This is intensional.
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Raise New KeyNotFoundException
		      
		    End If
		  Next
		  
		  // Note: The following line will raise an OutOfBoundsException if the index does not exist.  This is intensional.
		  
		  Return dcursor.Key( keyN( last ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Keys(ParamArray keyN As Variant) As Variant()
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Returns an array of the keys in the directory at the given path.
		  
		  Dim dcursor As Dictionary
		  Dim v, result(-1) As Variant
		  
		  dcursor = p_core
		  
		  For Each k As Variant In keyN
		    
		    If Not dcursor.HasKey( k ) Then Return result
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return result
		      
		    End If
		  Next
		  
		  Return dcursor.Keys
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(defaultValue As Variant, key1 As Variant, ParamArray keyN As Variant) As Variant
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Returns the value at the given path.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If Not dcursor.HasKey( k ) Then Return defaultValue
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return defaultValue
		      
		    End If
		  Next
		  
		  If dcursor.HasKey( keyN( last ) ) Then
		    
		    v = dcursor.Value( keyN( last ) )
		    
		    If v IsA Dictionary Or v IsA PropertyListKFS Then Return defaultValue
		    
		    Return v
		    
		  Else
		    
		    Return defaultValue
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewPListFromClone(other As PropertyListKFS) As PropertyListKFS
		  // Created 11/28/2010 by Andrew Keller
		  
		  // Returns a clone of the given PropertyListKFS object.
		  
		  Return New PropertyListKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewPListWithDataCore(d As Dictionary) As PropertyListKFS
		  // Created 11/24/2010 by Andrew Keller
		  
		  // Returns a new PropertyListKFS object using the given Dictionary object as the data core.
		  
		  Return d
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(other As PropertyListKFS) As Integer
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns zero for equality, and nonzero for inequality.
		  
		  // NOTE: this function does NOT generate a reproducable sort order.
		  // this function is ONLY used for determining equivalence.
		  
		  // Check for other being Nil:
		  
		  If other Is Nil Then Return 1
		  
		  // Check for the number of keys not being equal:
		  
		  If p_core.Count <> other.p_core.Count Then Return other.p_core.Count - p_core.Count
		  
		  // Check for different key-value pairs:
		  
		  For Each k As Variant In p_core.Keys
		    
		    If Not other.p_core.HasKey( k ) Then Return 1
		    
		    Dim mv As Variant = p_core.Value( k )
		    Dim ov As Variant = other.p_core.Value( k )
		    
		    If mv IsA PropertyListKFS Then
		      If ov IsA PropertyListKFS Then
		        
		        If PropertyListKFS( mv ) <> PropertyListKFS( ov ) Then Return 1
		        
		      Else
		        
		        Return 1
		        
		      End If
		    ElseIf mv IsA Dictionary Then
		      If ov IsA Dictionary Then
		        
		        Dim p As PropertyListKFS = Dictionary( mv )
		        Dim q As PropertyListKFS = Dictionary( ov )
		        
		        If p <> q Then Return 1
		        
		      Else
		        
		        Return 1
		        
		      End If
		    ElseIf mv <> ov Then
		      
		      Return 1
		      
		    End If
		    
		  Next
		  
		  Return 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As Dictionary
		  // Created 11/22/2010 by Andrew Keller
		  
		  // Converts this object to a Dictionary object.
		  
		  // Return the data core.
		  
		  Return p_core
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As Dictionary)
		  // Created 11/22/2010 by Andrew Keller
		  
		  // A convert constructor that takes the given Dictionary object.
		  
		  // Treat the Dictionary object as a data core.
		  
		  If other Is Nil Then
		    
		    p_core = New Dictionary
		    
		  Else
		    
		    p_core = other
		    
		  End If
		  
		  p_treatAsArray = False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(prune As Boolean, key1 As Variant, ParamArray keyN As Variant)
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Removes the given key from the hierarchy.
		  
		  keyN.Insert 0, key1
		  keyN.Insert 0, Nil
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim coretrail() As Dictionary
		  ReDim coretrail( last )
		  coretrail( 0 ) = Me
		  
		  Dim k, v As Variant
		  
		  For row = 1 To last -1
		    
		    k = keyN( row )
		    
		    If Not coretrail( row -1 ).HasKey( k ) Then Exit
		    
		    v = coretrail( row -1 ).Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      coretrail( row ) = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      coretrail( row ) = v
		      
		    Else
		      
		      Exit
		      
		    End If
		  Next
		  
		  If Not ( coretrail( last -1 ) Is Nil ) Then
		    
		    If coretrail( last -1 ).HasKey( keyN( last ) ) Then
		      
		      coretrail( last -1 ).Remove keyN( last )
		      
		    End If
		    
		  End If
		  
		  If prune Then
		    For row = row -1 DownTo 1
		      
		      If Not ( coretrail( row ) Is Nil ) Then
		        
		        If coretrail( row ).Count = 0 Then
		          
		          coretrail( row -1 ).Remove keyN( row )
		          
		        End If
		      End If
		    Next
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TerminalCount(ParamArray keyN As Variant) As Integer
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns the number of terminals in the directory at the given path.
		  
		  Dim dcursor As Dictionary
		  Dim v As Variant
		  
		  dcursor = p_core
		  
		  For Each k As Variant In keyN
		    
		    If Not dcursor.HasKey( k ) Then Return 0
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return 0
		      
		    End If
		  Next
		  
		  Dim result As Integer = 0
		  
		  For Each v In dcursor.Values
		    If Not ( v IsA Dictionary Or v IsA PropertyListKFS ) Then
		      result = result +1
		    End If
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TreatAsArray(ParamArray keyN As Variant) As Boolean
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Returns the value of the TreatAsArray property at the given path.
		  
		  Dim pcursor As PropertyListKFS
		  Dim dcursor As Dictionary
		  Dim v As Variant
		  
		  pcursor = Me
		  dcursor = p_core
		  
		  For Each k As Variant In keyN
		    
		    If Not dcursor.HasKey( k ) Then Return False
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      pcursor = v
		      dcursor = pcursor
		      
		    ElseIf v IsA Dictionary Then
		      
		      pcursor = Nil
		      dcursor = v
		      
		    Else
		      
		      Return False
		      
		    End If
		  Next
		  
		  If pcursor Is Nil Then Return False
		  
		  Return pcursor.p_treatAsArray
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TreatAsArray(ParamArray keyN As Variant, Assigns newValue As Boolean)
		  // Created 11/29/2010 by Andrew Keller
		  
		  // Sets the value of the TreatAsArray property at the given path.
		  
		  Dim pcursor As PropertyListKFS
		  Dim dcursor, dparent As Dictionary
		  Dim v As Variant
		  
		  pcursor = Me
		  dcursor = p_core
		  dparent = Nil
		  
		  For Each k As Variant In keyN
		    
		    dparent = dcursor
		    
		    v = dcursor.Lookup( k, Nil )
		    
		    If v IsA PropertyListKFS Then
		      
		      pcursor = v
		      dcursor = pcursor
		      
		    ElseIf v IsA Dictionary Then
		      
		      pcursor = Nil
		      dcursor = v
		      
		    Else
		      
		      pcursor = New PropertyListKFS
		      dcursor = pcursor
		      dparent.Value( k ) = pcursor
		      
		    End If
		  Next
		  
		  If pcursor Is Nil Then
		    
		    pcursor = dcursor
		    dparent.Value( keyN( UBound( keyN ) ) ) = pcursor
		    
		  End If
		  
		  pcursor.p_treatAsArray = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(key1 As Variant, ParamArray keyN As Variant) As Variant
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Returns the value at the given path.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If Not dcursor.HasKey( k ) Then Return Nil
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return Nil
		      
		    End If
		  Next
		  
		  If dcursor.HasKey( keyN( last ) ) Then
		    
		    v = dcursor.Value( keyN( last ) )
		    
		    If v IsA Dictionary Or v IsA PropertyListKFS Then Return Nil
		    
		    Return v
		    
		  Else
		    
		    Return Nil
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(key1 As Variant, ParamArray keyN As Variant, Assigns newValue As Variant)
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Sets the value at the given path.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim p As PropertyListKFS
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If dcursor.HasKey( k ) Then
		      
		      v = dcursor.Value( k )
		      
		      If v IsA PropertyListKFS Then
		        
		        dcursor = PropertyListKFS( v )
		        
		      ElseIf v IsA Dictionary Then
		        
		        dcursor = v
		        
		      Else
		        
		        p = New PropertyListKFS
		        dcursor.Value( k ) = p
		        dcursor = p
		        
		      End If
		    Else
		      
		      p = New PropertyListKFS
		      dcursor.Value( k ) = p
		      dcursor = p
		      
		    End If
		  Next
		  
		  dcursor.Value( keyN( last ) ) = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Values(ParamArray keyN As Variant) As Variant()
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Returns an array of the values in the directory at the given path.
		  
		  Dim dcursor As Dictionary
		  Dim v, result(-1) As Variant
		  
		  dcursor = p_core
		  
		  For Each k As Variant In keyN
		    
		    If Not dcursor.HasKey( k ) Then Return result
		    
		    v = dcursor.Value( k )
		    
		    If v IsA PropertyListKFS Then
		      
		      dcursor = PropertyListKFS( v )
		      
		    ElseIf v IsA Dictionary Then
		      
		      dcursor = v
		      
		    Else
		      
		      Return result
		      
		    End If
		  Next
		  
		  For Each v In dcursor.Values
		    
		    If Not ( v IsA Dictionary Or v IsA PropertyListKFS ) Then
		      
		      result.Append v
		      
		    End If
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Wedge(newValue As Variant, key1 As Variant, ParamArray keyN As Variant)
		  // Created 11/30/2010 by Andrew Keller
		  
		  // Wedges the given value into the given location.
		  
		  keyN.Insert 0, key1
		  
		  Dim row, last As Integer
		  last = UBound( keyN )
		  
		  Dim p As PropertyListKFS
		  Dim dcursor As Dictionary
		  Dim k, v As Variant
		  
		  dcursor = p_core
		  
		  For row = 0 to last -1
		    
		    k = keyN( row )
		    
		    If dcursor.HasKey( k ) Then
		      
		      v = dcursor.Value( k )
		      
		      If v IsA PropertyListKFS Then
		        
		        dcursor = PropertyListKFS( v )
		        
		      ElseIf v IsA Dictionary Then
		        
		        dcursor = v
		        
		      Else
		        
		        p = New PropertyListKFS
		        dcursor.Value( k ) = p
		        dcursor = p
		        
		      End If
		    Else
		      
		      p = New PropertyListKFS
		      dcursor.Value( k ) = p
		      dcursor = p
		      
		    End If
		  Next
		  
		  If keyN( last ).IsNumeric _
		    And keyN( last ).DoubleValue = keyN( last ).Int64Value _
		    And dcursor.HasKey( keyN( last ).Int64Value ) Then
		    
		    Dim iKey As Int64 = keyN( last )
		    Dim iCursor As Int64 = iKey
		    
		    While dcursor.HasKey( iCursor )
		      iCursor = iCursor +1
		      If iCursor < iKey Then Raise New OutOfBoundsException
		    Wend
		    
		    While iCursor > iKey
		      dcursor.Value( iCursor ) = dcursor.Value( iCursor -1 )
		      iCursor = iCursor -1
		    Wend
		    
		    dcursor.Value( iKey ) = newValue
		    
		  Else
		    
		    dcursor.Value( keyN( last ) ) = newValue
		    
		  End If
		  
		  // done.
		  
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
		Protected p_core As Dictionary
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
