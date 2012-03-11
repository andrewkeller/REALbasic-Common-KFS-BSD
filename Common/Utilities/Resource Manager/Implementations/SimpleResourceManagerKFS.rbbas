#tag Class
Protected Class SimpleResourceManagerKFS
Implements ResourceManagerKFS
	#tag Method, Flags = &h0
		Function Fetch(key As String, ByRef value As Variant, ByRef persistenceCriteria As PersistenceCriteriaKFS) As Boolean
		  // Part of the ResourceManagerKFS interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Get(key As String) As Variant
		  // Part of the ResourceManagerKFS interface.
		  #error  // (don't forget to implement this method!)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(key As String, defaultValue As Variant) As Variant
		  // Part of the ResourceManagerKFS interface.
		  #error  // (don't forget to implement this method!)
		  
		  
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
End Class
#tag EndClass
