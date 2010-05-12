#tag Module
Protected Module BSDGlobalsKFS_Data
	#tag Method, Flags = &h0
		Function DeepHasKeyKFS(Extends d As Dictionary, ParamArray path As Variant) As Boolean
		  // Created 5/7/2010 by Andrew Keller
		  
		  // A version of Dictionary.HasKey that deals with multiple levels of Dictionaries.
		  
		  Return d.DeepHasKeyKFS_a( path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeepHasKeyKFS_a(Extends d As Dictionary, path() As Variant) As Boolean
		  // Created 5/7/2010 by Andrew Keller
		  
		  // A version of Dictionary.HasKey that deals with multiple levels of Dictionaries.
		  
		  Dim last As Integer = path.Ubound
		  If last < 0 Then Return False
		  
		  // General idea: try to prove false.  Else, it's true.
		  
		  If d IsA PropertyListKFS Then
		    
		    // The PropertyListKFS class and all known subclasses
		    // use a 'Child' function to navigate the hierarchy,
		    // and a 'Value' function to access data.
		    
		    Dim cursor As PropertyListKFS = PropertyListKFS( d )
		    
		    For Each key As Variant In path
		      
		      If cursor.HasKey( key ) Then
		        
		        cursor = cursor.Child( key )
		        
		      Else
		        
		        Return False
		        
		      End If
		      
		    Next
		    
		    Return True
		    
		  Else
		    
		    // The Dictionary class and all known subclasses
		    // (except PropertyListKFS) use a 'Value' function
		    // to access data, and there is no hierarchy,
		    // which is why this function exists.
		    
		    Dim cursor As Dictionary = d
		    
		    For index As Integer = 0 To last-1
		      
		      If cursor.HasKey( path(index) ) And cursor.Value( path(index) ) IsA Dictionary Then
		        
		        cursor = cursor.Value( path(index) )
		        
		      Else
		        
		        Return False
		        
		      End If
		      
		    Next
		    
		    Return cursor.HasKey( path(last) )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeepLookupKFS(Extends d As Dictionary, defaultValue As Variant, ParamArray path As Variant) As Variant
		  // Created 5/7/2010 by Andrew Keller
		  
		  // A version of Dictionary.Lookup that deals with multiple levels of Dictionaries.
		  
		  Return d.DeepLookupKFS_a( defaultValue, path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeepLookupKFS_a(Extends d As Dictionary, defaultValue As Variant, path() As Variant) As Variant
		  // Created 5/7/2010 by Andrew Keller
		  
		  // A version of Dictionary.Lookup that deals with multiple levels of Dictionaries.
		  
		  Dim last As Integer = path.Ubound
		  If last < 0 Then Return defaultValue
		  
		  If d IsA PropertyListKFS Then
		    
		    // The PropertyListKFS class and all known subclasses
		    // use a 'Child' function to navigate the hierarchy,
		    // and a 'Value' function to access data.
		    
		    Dim cursor As PropertyListKFS = PropertyListKFS( d )
		    
		    For Each key As Variant In path
		      
		      If cursor.HasKey( key ) Then
		        
		        cursor = cursor.Child( key )
		        
		      Else
		        
		        Return defaultValue
		        
		      End If
		      
		    Next
		    
		    Return cursor.Value
		    
		  Else
		    
		    // The Dictionary class and all known subclasses
		    // (except PropertyListKFS) use a 'Value' function
		    // to access data, and there is no hierarchy,
		    // which is why this function exists.
		    
		    Dim cursor As Dictionary = d
		    
		    For index As Integer = 0 To last -1
		      
		      If cursor.HasKey( path(index) ) Then
		        
		        cursor = cursor.Value( path(index) )
		        
		      Else
		        
		        Return defaultValue
		        
		      End If
		      
		    Next
		    
		    Return cursor.Lookup( path(last), defaultValue )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeepRemoveKFS(Extends d As Dictionary, cleanUp As Boolean, ParamArray path As Variant)
		  // Created 5/8/2010 by Andrew Keller
		  
		  // A version of Dictionary.Remove that deals with multiple levels of Dictionaries.
		  
		  d.DeepRemoveKFS_a( cleanUp, path )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeepRemoveKFS_a(Extends d As Dictionary, cleanUp As Boolean, path() As Variant)
		  // Created 5/8/2010 by Andrew Keller
		  
		  // A version of Dictionary.Remove that deals with multiple levels of Dictionaries.
		  
		  Dim last As Integer = path.Ubound
		  If last < 0 Then Return
		  
		  Dim stack(-1) As Variant
		  stack.Append d
		  
		  For index As Integer = 0 To last
		    
		    If stack(0) IsA Dictionary Then
		      
		      If Dictionary( stack(0) ).HasKey( path(index) ) Then
		        
		        // This level of the hierarchy has the current key in the path.
		        
		        If index < last Then
		          
		          // This is not the level at which we have a key to remove,
		          // so continue navigating the path.
		          
		          If stack(0) IsA PropertyListKFS Then
		            
		            // This level is a PropertyListKFS - use 'Child' to proceed.
		            
		            stack.Insert 0, PropertyListKFS( stack(0) ).Child( path(index) )
		            
		          ElseIf stack(0) IsA Dictionary Then
		            
		            // This level is a Dictionary - use 'Value' to proceed.
		            
		            stack.Insert 0, Dictionary( stack(0) ).Value( path(index) )
		            
		          Else
		            
		            // This level is not a supported hierarchy.
		            
		            Exit
		            
		          End If
		        Else
		          
		          // This is the level at which we have a key to remove.
		          
		          Dictionary( stack(0) ).Remove path(last)
		          
		        End If
		      Else
		        
		        // This level does not have the key required to proceed.
		        
		        Exit
		        
		      End If
		    End If
		  Next
		  
		  // We now have a stack describing where we've been.
		  
		  // Time to clean up.
		  
		  If cleanUp Then
		    
		    While stack.Ubound > 0
		      
		      If stack(0) IsA Dictionary Then
		        
		        If Dictionary( stack(0) ).Count = 0 Then
		          
		          Dictionary( stack(1) ).Remove path( stack.Ubound -1 )
		          
		        Else
		          
		          Exit
		          
		        End If
		      End If
		    Wend
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeepValueKFS(Extends d As Dictionary, ParamArray path As Variant) As Variant
		  // Created 5/7/2010 by Andrew Keller
		  
		  // A version of Dictionary.Value that deals with multiple levels of Dictionaries.
		  
		  Return d.DeepValueKFS_a( path )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeepValueKFS(Extends d As Dictionary, ParamArray path As Variant, Assigns newValue As Variant)
		  // Created 5/7/2010 by Andrew Keller
		  
		  // A version of Dictionary.Value that deals with multiple levels of Dictionaries.
		  
		  d.DeepValueKFS_a( path ) = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeepValueKFS_a(Extends d As Dictionary, path() As Variant) As Variant
		  // Created 5/7/2010 by Andrew Keller
		  
		  // A version of Dictionary.Value that deals with multiple levels of Dictionaries.
		  
		  Dim last As Integer = path.Ubound
		  If last < 0 Then Raise New UnsupportedFormatException
		  
		  If d IsA PropertyListKFS Then
		    
		    // The PropertyListKFS class and all known subclasses
		    // use a 'Child' function to navigate the hierarchy,
		    // and a 'Value' function to access data.
		    
		    Dim cursor As PropertyListKFS = PropertyListKFS( d )
		    
		    For Each key As Variant In path
		      
		      If cursor.HasKey( key ) Then
		        
		        cursor = cursor.Child( key )
		        
		      Else
		        
		        Raise New KeyNotFoundException
		        
		      End If
		      
		    Next
		    
		    Return cursor.Value
		    
		  Else
		    
		    // The Dictionary class and all known subclasses
		    // (except PropertyListKFS) use a 'Value' function
		    // to access data, and there is no hierarchy,
		    // which is why this function exists.
		    
		    Dim cursor As Dictionary = d
		    
		    For index As Integer = 0 To last -1
		      
		      If cursor.HasKey( path(index) ) Then
		        
		        cursor = cursor.Value( path(index) )
		        
		      Else
		        
		        Raise New KeyNotFoundException
		        
		      End If
		      
		    Next
		    
		    Return cursor.Value( path(last) )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeepValueKFS_a(Extends d As Dictionary, path() As Variant, Assigns newValue As Variant)
		  // Created 5/7/2010 by Andrew Keller
		  
		  // A version of Dictionary.Value that deals with multiple levels of Dictionaries.
		  
		  Dim last As Integer = path.Ubound
		  If last < 0 Then Raise New UnsupportedFormatException
		  
		  If d IsA PropertyListKFS Then
		    
		    // The PropertyListKFS class and all known subclasses
		    // use a 'Child' function to navigate the hierarchy,
		    // and a 'Value' function to access data.
		    
		    Dim cursor As PropertyListKFS = PropertyListKFS( d )
		    
		    For Each key As Variant In path
		      
		      If VarType( key ) = Variant.TypeInteger Or _
		        VarType( key ) = Variant.TypeLong Or _
		        VarType( key ) = Variant.TypeSingle Then
		        
		        cursor = cursor.Child( key, PropertyListKFS.kNodeTypeArray )
		        
		      Else
		        
		        cursor = cursor.Child( key, PropertyListKFS.kNodeTypeDictionary )
		        
		      End If
		      
		    Next
		    
		    cursor.Value = newValue
		    
		  Else
		    
		    // The Dictionary class and all known subclasses
		    // (except PropertyListKFS) use a 'Value' function
		    // to access data, and there is no hierarchy,
		    // which is why this function exists.
		    
		    Dim cursor As Dictionary = d
		    
		    For index As Integer = 0 To last -1
		      
		      If Not cursor.HasKey( path(index) ) Then cursor.Value( path(index) ) = New Dictionary
		      
		      cursor = cursor.Value( path(index) )
		      
		    Next
		    
		    cursor.Value( path(last) ) = newValue
		    
		  End If
		  
		  // done.
		  
		End Sub
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
