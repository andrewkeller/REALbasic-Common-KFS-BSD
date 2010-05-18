	#tag Class
	Protected Class TestDeepDictionaryFunctions
	Inherits UnitTestingKFS.TestClass
		#tag Method, Flags = &h0
			Sub TestGetValue()
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestHasKey()
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestLookup()
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestRemove()
			  // Created 5/12/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // BSDGlobalsKFS_Data.DeepRemoveKFS( path() As Variant )
			  
			  // Generate a sample hierarchy.
			  
			  Dim sample As Dictionary
			  
			  sample = New Dictionary( "dog" : 9 )
			  sample = New Dictionary( "fish" : 7 , "cat" : sample )
			  sample = New Dictionary( "foo" : 12 , "bar" : sample )
			  
			  // Confirm that DeepValueKFS can remove the values correctly.
			  
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestSetValue()
			  
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
	End Class
	#tag EndClass
