	#tag Class
	Protected Class TestDeepDictionaryFunctions
	Inherits UnitTestingKFS.TestClass
		#tag Method, Flags = &h0
			Sub TestGetValue()
			  // Created 5/10/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // BSDGlobalsKFS_Data.DeepValueKFS( path() As Variant ) As Variant
			  
			  // Generate a sample hierarchy.
			  
			  Dim sample As New Dictionary
			  
			  sample.Value( "foo" ) = 12
			  sample.Value( "bar" ) = New Dictionary
			  Dictionary( sample.Value( "bar" ) ).Value( "fish" ) = 7
			  Dictionary( sample.Value( "bar" ) ).Value( "cat" ) = New Dictionary
			  Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).Value( "dog" ) = 9
			  
			  // Confirm that DeepValueKFS can get the values correctly.
			  
			  AssertEquals 12, sample.DeepValueKFS( "foo" ), "DeepValueKFS could not retrieve an L1 Integer."
			  AssertTrue sample.DeepValueKFS( "bar" ) IsA Dictionary, "DeepValueKFS could not retrieve an L1 Dictionary."
			  AssertEquals 7, sample.DeepValueKFS( "bar", "fish" ), "DeepValueKFS could not retrieve an L2 Integer."
			  AssertTrue sample.DeepValueKFS( "bar", "cat" ) IsA Dictionary, "DeepValueKFS could not retrieve an L2 Dictionary."
			  AssertEquals 9, sample.DeepValueKFS( "bar", "cat", "dog" ), "DeepValueKFS could not retrieve an L3 Integer."
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestGetValueWithPListKFS()
			  // Created 5/10/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // BSDGlobalsKFS_Data.DeepValueKFS( path() As Variant ) As Variant
			  
			  // Different code is used to navigate a PropertyListKFS tree.
			  // Generate a sample hierarchy.
			  
			  Dim sample As New Dictionary
			  Dim p1 As New PropertyListKFS
			  
			  p1.Value = 15
			  p1.Value( "fish" ) = "hello"
			  p1.Value( "cat" ) = "world"
			  
			  sample.Value( "foo" ) = p1
			  sample.Value( "bar" ) = 29
			  
			  // Confirm that DeepValueKFS works correctly with PropertyListKFS instances.
			  
			  AssertEquals 29, sample.DeepValueKFS( "bar" ), "DeepValueKFS could not retrieve an L1 Integer."
			  AssertFalse sample.DeepValueKFS( "foo" ) IsA PropertyListKFS, "DeepValueKFS returned a PropertyListKFS instead of its value."
			  AssertEquals 15, sample.DeepValueKFS( "foo" ), "DeepValueKFS could not retrieve an L1 PropertyListKFS value."
			  AssertEquals "hello", sample.DeepValueKFS( "foo", "fish" ), "DeepValueKFS could not retrieve an L2 String."
			  AssertEquals "world", sample.DeepValueKFS( "foo", "cat" ), "DeepValueKFS could not retrieve an L2 String."
			  
			  // done.
			  
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
			  // Created 5/11/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // BSDGlobalsKFS_Data.DeepRemoveKFS( path() As Variant )
			  
			  // Generate a sample hierarchy.
			  
			  Dim sample As New Dictionary
			  
			  sample.Value( "foo" ) = 12
			  sample.Value( "bar" ) = New Dictionary
			  Dictionary( sample.Value( "bar" ) ).Value( "fish" ) = 7
			  Dictionary( sample.Value( "bar" ) ).Value( "cat" ) = New Dictionary
			  Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).Value( "dog" ) = 9
			  
			  // Confirm that DeepValueKFS can get the values correctly.
			  
			  AssertEquals 2, sample.Count, "The sample Dictionary did not start out with 2 items."
			  sample.DeepRemoveKFS False, "foo"
			  AssertEquals 1, sample.Count, "DeepRemoveKFS was not able to remove an L1 Integer."
			  
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
