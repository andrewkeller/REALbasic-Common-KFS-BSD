#tag Module
Protected Module PropertyListGlobalsKFS
	#tag Method, Flags = &h0
		Function OpenAsPropertyListKFS(Extends file As FolderItem) As PropertyListKFS
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Returns a PropertyListKFS instance that
		  // contains the data in the given file.
		  
		  // If the file doesn't exist, then hand back
		  // a PropertyListKFS set to read and write
		  // the default format.
		  
		  If Not file.Exists Then Return New PropertyListKFS_XML1( file )
		  
		  // Return an instance of the first subclass that actually works.
		  
		  Try
		    Return New PropertyListKFS_XML1( file )
		  Catch
		  End Try
		  
		  // Well, we tried.
		  
		  Raise New UnsupportedFormatException
		  
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
