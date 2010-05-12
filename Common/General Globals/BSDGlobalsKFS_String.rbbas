#tag Module
Protected Module BSDGlobalsKFS_String
	#tag Method, Flags = &h0
		Function EndOfLineKFS() As String
		  // Created 5/12/2010 by Andrew Keller
		  
		  // A version of EndOfLine that returns Unix line endings on an OS X GUI app.
		  
		  #if TargetMacOS and not TargetMacOSClassic then
		    
		    Return EndOfLine.UNIX
		    
		  #else
		    
		    Return EndOfLine
		    
		  #endif
		  
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
