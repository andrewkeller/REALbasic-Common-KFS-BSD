#tag Class
Protected Class TestHierarchalDictionaryFunctionsKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Sub AssertArrayContains(ary() As Variant, ParamArray test As Variant)
		  // Created 5/28/2010 by Andrew Keller
		  
		  // Asserts that each value in test exists in ary.
		  
		  Dim bFound As Boolean
		  
		  For Each v As Variant In test
		    
		    bFound = False
		    
		    For Each t As Variant In ary
		      If v = t Then
		        
		        bFound = True
		        Exit
		        
		      End If
		    Next
		    
		    If Not bFound Then AssertFailure "The given array does not contain the value " + v.DescriptionKFS + "."
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

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
		Sub TestGetBinCount()
		  // Created 5/24/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.BinCount foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Confirm that Dictionary.BinCount works correctly.
		  
		  AssertEquals Dictionary( sample.Value( "bar" ) ).BinCount, sample.BinCount( "bar" ), "BinCount was unable to retrieve an L1 Dictionary BinCount."
		  AssertEquals Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).BinCount, sample.BinCount( "bar", "cat" ), "BinCount was unable to retrieve an L2 Dictionary BinCount."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetChildren()
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Children foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : New Dictionary )
		  
		  // Confirm that Dictionary.Children works correctly.
		  
		  PushMessageStack "Something about the Children method doesn't work."
		  
		  AssertEquals 1, UBound( sample.Children )
		  AssertEquals 0, UBound( sample.Children( "bar" ) )
		  AssertEquals -1, UBound( sample.Children( "bar", "cat" ) )
		  
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
		Sub TestGetKey()
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Key foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Confirm that Dictionary.Key works correctly.
		  
		  // NOTE: these tests depend on the order the keys are stored in the hash table.
		  // If any of these tests fail, it might just be the order of the keys.
		  
		  PushMessageStack "Key could not retrieve "
		  PushMessageStack "a root key."
		  
		  AssertEquals "foo", sample.Key( 0 )
		  AssertEquals "bar", sample.Key( 1 )
		  AssertEquals "dog", sample.Key( 2 )
		  
		  PopMessageStack
		  PushMessageStack "an L2 key."
		  
		  AssertEquals "fish", sample.Key( 0, "bar" )
		  AssertEquals "cat", sample.Key( 1, "bar" )
		  
		  PopMessageStack
		  PushMessageStack "an L3 key."
		  
		  AssertEquals "dog", sample.Key( 0, "bar", "cat" )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetKeys()
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Keys foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Confirm that Dictionary.Keys works correctly.
		  
		  PushMessageStack "Something about the Keys method doesn't work."
		  
		  AssertEquals 2, UBound( sample.Keys )
		  AssertArrayContains sample.Keys, "foo", "bar", "dog"
		  
		  AssertEquals 1, UBound( sample.Keys( "bar" ) )
		  AssertArrayContains sample.Keys( "bar" ), "fish", "cat"
		  
		  AssertEquals 0, UBound( sample.Keys( "bar", "cat" ) )
		  AssertArrayContains sample.Keys( "bar", "cat" ), "dog"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetKeys_Filtered()
		  // Created 5/28/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Keys_Filtered foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Confirm that Dictionary.Keys_Filtered works correctly.
		  
		  PushMessageStack "Something about the Keys_Filtered method doesn't work."
		  
		  AssertZero sample.Keys_Filtered( False, False ).UBound +1
		  AssertZero sample.Keys_Filtered( False, False, "bar" ).UBound +1
		  AssertZero sample.Keys_Filtered( False, False, "bar", "cat" ).UBound +1
		  
		  
		  AssertEquals 1, sample.Keys_Filtered( True, False ).UBound
		  AssertEquals 0, sample.Keys_Filtered( True, False, "bar" ).UBound
		  AssertEquals 0, sample.Keys_Filtered( True, False, "bar", "cat" ).UBound
		  
		  AssertArrayContains sample.Keys_Filtered( True, False ), "foo", "dog"
		  AssertArrayContains sample.Keys_Filtered( True, False, "bar" ), "fish"
		  AssertArrayContains sample.Keys_Filtered( True, False, "bar", "cat" ), "dog"
		  
		  
		  AssertEquals 0, sample.Keys_Filtered( False, True ).UBound
		  AssertEquals 0, sample.Keys_Filtered( False, True, "bar" ).UBound
		  AssertEquals -1, sample.Keys_Filtered( False, True, "bar", "cat" ).UBound
		  
		  AssertArrayContains sample.Keys_Filtered( False, True ), "bar"
		  AssertArrayContains sample.Keys_Filtered( False, True, "bar" ), "cat"
		  
		  
		  AssertEquals 2, sample.Keys_Filtered( True, True ).UBound
		  AssertEquals 1, sample.Keys_Filtered( True, True, "bar" ).UBound
		  AssertEquals 0, sample.Keys_Filtered( True, True, "bar", "cat" ).UBound
		  
		  AssertArrayContains sample.Keys_Filtered( True, True ), "foo", "bar", "dog"
		  AssertArrayContains sample.Keys_Filtered( True, True, "bar" ), "fish", "cat"
		  AssertArrayContains sample.Keys_Filtered( True, True, "bar", "cat" ), "dog"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetNonChildren()
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.NonChildren foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Confirm that Dictionary.NonChildren works correctly.
		  
		  PushMessageStack "Something about the NonChildren method doesn't work."
		  
		  AssertEquals 1, UBound( sample.NonChildren )
		  AssertEquals 0, UBound( Dictionary( sample.Value( "bar" ) ).NonChildren )
		  AssertEquals 0, UBound( Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).NonChildren )
		  
		  AssertArrayContains sample.NonChildren, 12, "cat"
		  
		  AssertEquals 0, UBound( sample.NonChildren( "bar" ) )
		  AssertArrayContains sample.NonChildren( "bar" ), 7
		  
		  AssertEquals 0, UBound( sample.NonChildren( "bar", "cat" ) )
		  AssertArrayContains sample.NonChildren( "bar", "cat" ), 9
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetValue()
		  // Created 5/28/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Value foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Confirm that Dictionary.Value works correctly.
		  
		  PushMessageStack "Value could not retrieve "
		  
		  AssertEquals 12, sample.Value( "foo" ), "an L1 value."
		  AssertEquals "cat", sample.Value( "dog" ), "an L1 value."
		  AssertEquals 7, sample.Value( "bar", "fish" ), "an L2 value."
		  AssertEquals 9, sample.Value( "bar", "cat", "dog" ), "an L3 value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetValues()
		  // Created 5/27/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Values foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : New Dictionary )
		  
		  // Confirm that Dictionary.Values works correctly.
		  
		  PushMessageStack "Something about the Values method doesn't work."
		  
		  AssertEquals 2, UBound( sample.Values )
		  AssertEquals 1, UBound( Dictionary( sample.Value( "bar" ) ).Values )
		  AssertEquals 0, UBound( Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).Values )
		  
		  AssertArrayContains sample.Values, 12
		  
		  AssertEquals 1, UBound( sample.Values( "bar" ) )
		  AssertArrayContains sample.Values( "bar" ), 7
		  
		  AssertEquals 0, UBound( sample.Values( "bar", "cat" ) )
		  AssertArrayContains sample.Values( "bar", "cat" ), 9
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHasChild()
		  // Created 5/22/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.HasChild foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Confirm that Dictionary.HasChild works correctly.
		  
		  AssertFalse sample.HasChild( "foo" )
		  AssertTrue sample.HasChild( "bar" )
		  AssertFalse sample.HasChild( "dog" )
		  AssertFalse sample.HasChild( "bar", "fish" )
		  AssertTrue sample.HasChild( "bar", "cat" )
		  AssertFalse sample.HasChild( "bar", "cat", "dog" )
		  
		  AssertFalse sample.HasChild( "fish" )
		  AssertFalse sample.HasChild( "fish", "foo" )
		  AssertFalse sample.HasChild( "fish", "cat" )
		  AssertFalse sample.HasChild( "bar", "foo" )
		  AssertFalse sample.HasChild( "bar", "cat", "fish" )
		  AssertFalse sample.HasChild( "bar", "cat", "dog", "fish" )
		  
		  // done.
		  
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
		  // Created 5/28/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Lookup foo, bar, fish, cat ...
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Confirm that Dictionary.Lookup works correctly.
		  
		  PushMessageStack "Lookup could not retrieve "
		  
		  AssertEquals 12, sample.Lookup_R( 0, "foo" ), "an L1 value."
		  AssertEquals "cat", sample.Lookup_R( 1, "dog" ), "an L1 value."
		  AssertEquals 7, sample.Lookup_R( 2, "bar", "fish" ), "an L2 value."
		  AssertEquals 9, sample.Lookup_R( 3, "bar", "cat", "dog" ), "an L3 value."
		  
		  PopMessageStack
		  PushMessageStack "Lookup could not return the default value upon error."
		  
		  AssertEquals 0, sample.Lookup_R( 0, "foo " )
		  AssertEquals 1, sample.Lookup_R( 1, "dog " )
		  AssertEquals 2, sample.Lookup_R( 2, "bar", "fish " )
		  AssertEquals 3, sample.Lookup_R( 3, "bar", "cat ", "dog" )
		  
		  // done.
		  
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
		Sub TestSetBinCount()
		  // Created 5/24/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.BinCount foo, bar, fish, cat ... = dog
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample, "dog" : "cat" )
		  
		  // Change the BinCounts.
		  
		  sample.BinCount( "bar" ) = 12
		  sample.BinCount( "bar", "cat" ) = 25
		  
		  // Confirm that Dictionary.BinCount works correctly.
		  
		  AssertEquals 12, Dictionary( sample.Value( "bar" ) ).BinCount, "BinCount was unable to set an L1 Dictionary BinCount."
		  AssertEquals 25, Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).BinCount, "BinCount was unable to set an L2 Dictionary BinCount."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetChild()
		  // Created 5/30/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Child foo, bar, fish, cat ... = dog
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample, tmp As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample )
		  
		  // Confirm that Dictionary.Child works correctly.
		  
		  sample.Child( "foo", "bar" ) = New Dictionary
		  AssertTrue sample.HasKey( "foo" )
		  AssertTrue sample.Value( "foo" ) IsA Dictionary
		  AssertTrue Dictionary( sample.Value( "foo" ) ).HasKey( "bar" )
		  AssertTrue Dictionary( sample.Value( "foo" ) ).Value( "bar" ) IsA Dictionary
		  
		  tmp = New Dictionary
		  sample.Child( "one" ) = tmp
		  AssertEquals sample.Value( "one" ), tmp, "Child was not able to set an L1 child."
		  
		  tmp = New Dictionary
		  sample.Child( "one", "two" ) = tmp
		  AssertEquals Dictionary( sample.Value( "one" ) ).Value( "two" ), tmp, "Child was not able to set an L2 child."
		  
		  tmp = New Dictionary
		  sample.Child( "one", "two", "three" ) = tmp
		  AssertEquals Dictionary( Dictionary( sample.Value( "one" ) ).Value( "two" ) ).Value( "three" ), tmp, "Child was not able to set an L3 child."
		  
		  sample.Child( "bar", "cat" ) = New Dictionary
		  AssertZero Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).Count, "Child did not overwrite an existing child."
		  
		  sample.Child( "bar" ) = New Dictionary
		  AssertZero Dictionary( sample.Value( "bar" ) ).Count, "Child did not overwrite an existing child."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetValue()
		  // Created 5/30/2010 by Andrew Keller
		  
		  // Test cases for the function
		  // Dictionary.Value foo, bar, fish, cat ... = dog
		  
		  // Generate a sample hierarchy.
		  
		  Dim sample As Dictionary
		  
		  sample = New Dictionary( "dog" : 9 )
		  sample = New Dictionary( "fish" : 7 , "cat" : sample )
		  sample = New Dictionary( "foo" : 12 , "bar" : sample )
		  
		  // Confirm that Dictionary.Value works correctly.
		  
		  sample.Value( "foo", "bar", "fish" ) = "foobarfish"
		  AssertTrue sample.HasKey( "foo" )
		  AssertTrue sample.Value( "foo" ) IsA Dictionary
		  AssertTrue Dictionary( sample.Value( "foo" ) ).HasKey( "bar" )
		  AssertTrue Dictionary( sample.Value( "foo" ) ).Value( "bar" ) IsA Dictionary
		  AssertEquals "foobarfish", Dictionary( Dictionary( sample.Value( "foo" ) ).Value( "bar" ) ).Value( "fish" )
		  
		  sample.Value( "one" ) = "hello"
		  AssertEquals "hello", sample.Value( "one" ), "Value was not able to set an L1 value."
		  
		  sample.Value( "one", "two" ) = "world"
		  AssertEquals "world", Dictionary( sample.Value( "one" ) ).Value( "two" ), "Value was not able to set an L2 value."
		  
		  sample.Value( "bar", "cat", "dog" ) = 10
		  AssertEquals 10, Dictionary( Dictionary( sample.Value( "bar" ) ).Value( "cat" ) ).Value( "dog" ), "Value was not able to set an L3 value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller, et al.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a full list of all contributors.
		
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="UnitTestingKFS.TestClass"
		#tag EndViewProperty
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
