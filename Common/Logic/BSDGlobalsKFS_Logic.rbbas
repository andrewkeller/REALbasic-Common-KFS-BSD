#tag Module
Protected Module BSDGlobalsKFS_Logic
	#tag Method, Flags = &h0
		Function cvt(v As Variant) As Variant
		  // simple variant loop-back
		  // used for easy converting
		  
		  // Created 10/1/2005 by Andrew Keller
		  
		  Return v
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetUniqueIndexKFS(sCategory As String = "") As Integer
		  // returns an integer that is unique
		  // as long as this program is running
		  
		  // Created 3/15/2007 by Andrew Keller
		  
		  If dictUniqueIndex = Nil Then dictUniqueIndex = New Dictionary
		  
		  dictUniqueIndex.Value(sCategory) = dictUniqueIndex.Lookup(sCategory, -1) +1
		  
		  Return dictUniqueIndex.Value(sCategory)
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Lookup(Extends xnode As XmlNode, ParamArray names As String) As XmlNode
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Searches the given XmlElement for a node with the given name.
		  // Returns Nil if not found.
		  
		  Dim cursor As XmlNode = xnode
		  Dim probe As XmlNode
		  
		  For Each name As String In names
		    
		    // Find a child inside <cursor> with name <test>.
		    
		    probe = cursor.FirstChild
		    
		    // Linear search.  Upon success, probe <> Nil.
		    
		    While probe <> Nil
		      
		      If probe.Name = name Then Exit
		      
		      probe = probe.NextSibling
		      
		    Wend
		    
		    // Was the current name found?
		    
		    If probe = Nil Then Return Nil
		    
		    // It was!
		    
		    // Update the cursor for the next itteration.
		    
		    cursor = probe
		    
		  Next
		  
		  // Loop complete.
		  
		  Return cursor
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		#tag Note
			Used by GetUniqueIndexKFS
		#tag EndNote
		Private dictUniqueIndex As Dictionary
	#tag EndProperty


	#tag Constant, Name = kASCIIDownArrow, Type = Double, Dynamic = False, Default = \"31", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kASCIILeftArrow, Type = Double, Dynamic = False, Default = \"28", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kASCIIRightArrow, Type = Double, Dynamic = False, Default = \"29", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kASCIIUpArrow, Type = Double, Dynamic = False, Default = \"30", Scope = Public
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
