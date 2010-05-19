	#tag Class
	Protected Class TestDeepDictionaryFunctions
	Inherits UnitTestingKFS.TestClass
		#tag Method, Flags = &h0
			Sub TestCoreNavigate_GetPreValue()
			  // Created 5/18/2010 by Andrew Keller
			  
			  // Test cases for the core navigation method of the DeepValue methods.
			  
			  Dim sample As Dictionary
			  Dim path(-1) As Variant
			  Dim args As New Dictionary( kNav_Opt_OmitLastKey : True )
			  
			  // Generate a sample hierarchy.
			  
			  sample = New Dictionary( "dog" : 9 )
			  sample = New Dictionary( "fish" : 7 , "cat" : sample )
			  sample = New Dictionary( "foo" : 12 , "bar" : sample )
			  
			  // Confirm that dict_Navigate can retrieve the pre-values correctly.
			  
			  AssertEquals sample, dict_Navigate( sample, path, args ), "Core navigation could not return the given Dictionary given an empty path."
			  
			  path.Append "foo"
			  AssertEquals sample, dict_Navigate( sample, path, args ), "Core navigation could not retrieve an L1 Integer."
			  
			  path(0) = "bar"
			  AssertEquals sample, dict_Navigate( sample, path, args ), "Core navigation could not retrieve an L1 Dictionary."
			  
			  path.Append "fish"
			  AssertEquals sample.Value( "bar" ), dict_Navigate( sample, path, args ), "Core navigation could not retrieve an L2 Integer."
			  
			  path(1) = "cat"
			  AssertEquals sample.Value( "bar" ), dict_Navigate( sample, path, args ), "Core navigation could not retrieve an L2 Dictionary."
			  
			  path.Append "dog"
			  AssertEquals Dictionary( sample.Value( "bar" ) ).Value( "cat" ), dict_Navigate( sample, path, args ), "Core navigation could not retrieve an L3 Integer."
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestCoreNavigate_GetValue()
			  // Created 5/18/2010 by Andrew Keller
			  
			  // Test cases for the core navigation method of the DeepValue methods.
			  
			  Dim sample As Dictionary
			  Dim path(-1) As Variant
			  
			  // Generate a sample hierarchy.
			  
			  sample = New Dictionary( "dog" : 9 )
			  sample = New Dictionary( "fish" : 7 , "cat" : sample )
			  sample = New Dictionary( "foo" : 12 , "bar" : sample )
			  
			  // Confirm that dict_Navigate can retrieve the values correctly.
			  
			  AssertEquals sample, dict_Navigate( sample, path ), "Core navigation could not return the given Dictionary given an empty path."
			  
			  path.Append "foo"
			  AssertEquals 12, dict_Navigate( sample, path ), "Core navigation could not retrieve an L1 Integer."
			  
			  path(0) = "bar"
			  AssertTrue dict_Navigate( sample, path ) IsA Dictionary, "Core navigation could not retrieve an L1 Dictionary."
			  
			  path.Append "fish"
			  AssertEquals 7, dict_Navigate( sample, path ), "Core navigation could not retrieve an L2 Integer."
			  
			  path(1) = "cat"
			  AssertTrue dict_Navigate( sample, path ) IsA Dictionary, "Core navigation could not retrieve an L2 Dictionary."
			  
			  path.Append "dog"
			  AssertEquals 9, dict_Navigate( sample, path ), "Core navigation could not retrieve an L3 Integer."
			  
			  // done.
			  
			End Sub
		#tag EndMethod

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
