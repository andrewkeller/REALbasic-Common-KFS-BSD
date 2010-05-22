	#tag Class
	Protected Class TestDeepDictionaryFunctions
	Inherits UnitTestingKFS.TestClass
		#tag Method, Flags = &h0
			Sub TestClear()
			  // Created 5/21/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // Dictionary.Clear foo, bar, fish, cat ...
			  
			  // Generate a sample hierarchy.
			  
			  Dim sample As Dictionary
			  
			  sample = New Dictionary( "dog" : 9 )
			  sample = New Dictionary( "fish" : 7 , "cat" : sample )
			  sample = New Dictionary( "foo" : 12 , "bar" : sample )
			  
			  // Confirm that Dictionary.Clear works correctly.
			  
			  sample.Clear "bar", "cat"
			  
			  AssertEquals 2, sample.Count, "This operation should not have changed the number of items at the root level."
			  AssertEquals 2, Dictionary( sample.Value( "bar" ) ).Count, "This operation should not have changed the number of items at the second level."
			  AssertEquals 0, Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).Count, "This operation should have left nothing at the second level."
			  
			  sample.Clear "bar"
			  
			  AssertEquals 2, sample.Count, "This operation should not have changed the number of items at the root level."
			  AssertEquals 0, Dictionary( sample.Value( "bar" ) ).Count, "This operation should have left nothing at the second level."
			  
			  sample.Clear
			  
			  AssertEquals 0, sample.Count, "This operation should have left nothing at the root level."
			  
			  // done.
			  
			End Sub
		#tag EndMethod

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
			Sub TestGetCount()
			  // Created 5/21/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // Dictionary.Count foo, bar, fish, cat ...
			  
			  // Generate a sample hierarchy.
			  
			  Dim sample As Dictionary
			  
			  sample = New Dictionary( "dog" : 9 )
			  sample = New Dictionary( "fish" : 7 , "cat" : sample )
			  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
			  
			  // Confirm that Dictionary.Count works correctly.
			  
			  AssertEquals 3, sample.Count, "Could not retrieve the count of the root Dictionary."
			  AssertEquals 2, sample.Count( "bar" ), "Could not retrieve the count of the L2 Dictionary."
			  AssertEquals 1, sample.Count( "bar", "cat" ), "Could not retrieve the count of the L3 Dictionary."
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestGetValue()
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestHasKey()
			  // Created 5/21/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // Dictionary.HasKey foo, bar, fish, cat ...
			  
			  // Generate a sample hierarchy.
			  
			  Dim sample As Dictionary
			  
			  sample = New Dictionary( "dog" : 9 )
			  sample = New Dictionary( "fish" : 7 , "cat" : sample )
			  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
			  
			  // Confirm that Dictionary.HasKey works correctly.
			  
			  AssertTrue sample.HasKey( "foo" )
			  AssertTrue sample.HasKey( "bar" )
			  AssertTrue sample.HasKey( "dog" )
			  AssertTrue sample.HasKey( "bar", "fish" )
			  AssertTrue sample.HasKey( "bar", "cat" )
			  AssertTrue sample.HasKey( "bar", "cat", "dog" )
			  
			  AssertFalse sample.HasKey( "fish" )
			  AssertFalse sample.HasKey( "fish", "foo" )
			  AssertFalse sample.HasKey( "fish", "cat" )
			  AssertFalse sample.HasKey( "bar", "foo" )
			  AssertFalse sample.HasKey( "bar", "cat", "fish" )
			  AssertFalse sample.HasKey( "bar", "cat", "dog", "fish" )
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestLookup()
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestRemove()
			  // Created 5/19/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // Dictionary.Remove False, foo, bar, fish, cat ...
			  
			  // Generate a sample hierarchy.
			  
			  Dim sample As Dictionary
			  
			  sample = New Dictionary( "dog" : 9 )
			  sample = New Dictionary( "fish" : 7 , "cat" : sample )
			  sample = New Dictionary( "foo" : 12 , "bar" : sample )
			  
			  // Confirm that Dictionary.Remove works correctly.
			  
			  sample.Remove False, "bar", "cat", "dog"
			  
			  AssertEquals 2, sample.Count, "This operation should not have changed the number of items at the root level."
			  AssertEquals 2, Dictionary( sample.Value( "bar" ) ).Count, "This operation should not have changed the number of items at the second level."
			  AssertEquals 0, Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).Count, "This operation did not leave the L3 Dictionary empty."
			  AssertEquals 7, Dictionary( sample.Value( "bar" ) ).Value( "fish" ), "This operation modified a second level key that should have been left alone."
			  
			  sample.Remove False, "bar", "cat"
			  
			  AssertEquals 2, sample.Count, "This operation should not have changed the number of items at the root level."
			  AssertEquals 12, sample.Value( "foo" ), "This operation modified a root level key that should have been left alone."
			  AssertEquals 1, Dictionary( sample.Value( "bar" ) ).Count, "This operation should have left one item in the L2 Dictionary."
			  AssertEquals 7, Dictionary( sample.Value( "bar" ) ).Value( "fish" ), "This operation should have left the L2 Integer alone."
			  
			  // done.
			  
			End Sub
		#tag EndMethod

		#tag Method, Flags = &h0
			Sub TestRemove_Clean()
			  // Created 5/19/2010 by Andrew Keller
			  
			  // Test cases for the function
			  // Dictionary.Remove True, foo, bar, fish, cat ...
			  
			  // Generate a sample hierarchy.
			  
			  Dim sample As Dictionary
			  
			  sample = New Dictionary( "dog" : 9 )
			  sample = New Dictionary( "fish" : 7 , "cat" : sample )
			  sample = New Dictionary( "foo" : 12 , "bar" : sample )
			  
			  // Confirm that Dictionary.Remove works correctly.
			  
			  sample.Remove True, "bar", "cat", "dog"
			  
			  AssertEquals 2, sample.Count, "This operation should not have changed the number of items at the root level."
			  AssertEquals 1, Dictionary( sample.Value( "bar" ) ).Count, "This operation should have left exactly one item left at the secnod level."
			  AssertFalse Dictionary( sample.Value( "bar" ) ).HasKey( "cat" ), "This operation did not remove the correct key."
			  AssertEquals 7, Dictionary( sample.Value( "bar" ) ).Value( "fish" ), "This operation modified a second level key that should have been left alone."
			  
			  sample.Remove True, "bar", "fish"
			  
			  AssertEquals 1, sample.Count, "This operation should have left one item left at the root."
			  AssertEquals 12, sample.Value( "foo" ), "This operation modified a root level key that should have been left alone."
			  
			  // done.
			  
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
