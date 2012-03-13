#tag Class
Protected Class SimpleResourceManagerKFS
Implements ResourceManagerKFS
	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Basic constructor - initializes this class with no contents.
		  
		  p_cache = New Dictionary
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As Dictionary)
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Convert constructor - initializes this class with the contents of the given Dictionary.
		  
		  p_cache = New Dictionary
		  
		  If Not ( other Is Nil ) Then
		    For Each k As Variant In other.Keys
		      p_cache.Value( k ) = other.Value( k )
		    Next
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Fetch(key As String, ByRef value As Variant, ByRef persistenceCriteria As PersistenceCriteriaKFS) As Boolean
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Part of the ResourceManagerKFS interface.
		  
		  // Returns the value and the persistence criteria for the
		  // given key through the ByRef parameters.  Returns whether
		  // or not the data was successfully fetched.
		  
		  value = Nil
		  persistenceCriteria = Nil
		  
		  If p_cache.HasKey( key ) Then
		    
		    value = p_cache.Value( key )
		    persistenceCriteria = New PersistenceCriteriaKFS_AlwaysPersist
		    Return True
		    
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(key As String) As Variant
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Part of the ResourceManagerKFS interface.
		  
		  // Returns the value for the given key.  Raises a
		  // KeyNotFoundException if the key does not exist.
		  
		  If p_cache.HasKey( key ) Then
		    
		    Return p_cache.Value( key )
		    
		  Else
		    
		    Dim err As New ResourceNotFoundInManagerException
		    err.OffendingKey = key
		    Raise err
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(key As String, defaultValue As Variant) As Variant
		  // Created 3/12/2012 by Andrew Keller
		  
		  // Part of the ResourceManagerKFS interface.
		  
		  // Returns the value for the given key.
		  // Returns defaultValue if the key does not exist.
		  
		  Return p_cache.Lookup( key, defaultValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2012 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a list of all contributors for this library.
		
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
		Protected p_cache As Dictionary
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
