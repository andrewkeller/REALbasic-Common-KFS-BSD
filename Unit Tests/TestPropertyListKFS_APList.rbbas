#tag Class
Protected Class TestPropertyListKFS_APList
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 1/9/2011 by Andrew Keller
		  
		  // Loads the sample property list constants into a Dictionary for easy access.
		  
		  SamplePLists = New Dictionary
		  
		  SamplePLists.Value( "k_APList_array_array_m" ) = k_APList_array_array_m
		  SamplePLists.Value( "k_APList_array_array_s" ) = k_APList_array_array_s
		  SamplePLists.Value( "k_APList_array_bool_m" ) = k_APList_array_bool_m
		  SamplePLists.Value( "k_APList_array_bool_s" ) = k_APList_array_bool_s
		  SamplePLists.Value( "k_APList_array_data_m" ) = k_APList_array_data_m
		  SamplePLists.Value( "k_APList_array_data_s" ) = k_APList_array_data_s
		  SamplePLists.Value( "k_APList_array_date_m" ) = k_APList_array_date_m
		  SamplePLists.Value( "k_APList_array_date_s" ) = k_APList_array_date_s
		  SamplePLists.Value( "k_APList_array_dict_m" ) = k_APList_array_dict_m
		  SamplePLists.Value( "k_APList_array_dict_s" ) = k_APList_array_dict_s
		  SamplePLists.Value( "k_APList_array_empty" ) = k_APList_array_empty
		  SamplePLists.Value( "k_APList_array_int_m" ) = k_APList_array_int_m
		  SamplePLists.Value( "k_APList_array_int_s" ) = k_APList_array_int_s
		  SamplePLists.Value( "k_APList_array_multiple" ) = k_APList_array_multiple
		  SamplePLists.Value( "k_APList_array_real_m" ) = k_APList_array_real_m
		  SamplePLists.Value( "k_APList_array_real_s" ) = k_APList_array_real_s
		  SamplePLists.Value( "k_APList_array_string_m" ) = k_APList_array_string_m
		  SamplePLists.Value( "k_APList_array_string_s" ) = k_APList_array_string_s
		  SamplePLists.Value( "k_APList_bool_false" ) = k_APList_bool_false
		  SamplePLists.Value( "k_APList_bool_true" ) = k_APList_bool_true
		  SamplePLists.Value( "k_APList_data_big" ) = k_APList_data_big
		  SamplePLists.Value( "k_APList_data_empty" ) = k_APList_data_empty
		  SamplePLists.Value( "k_APList_data_small" ) = k_APList_data_small
		  SamplePLists.Value( "k_APList_date" ) = k_APList_date
		  SamplePLists.Value( "k_APList_dict_array_m" ) = k_APList_dict_array_m
		  SamplePLists.Value( "k_APList_dict_array_s" ) = k_APList_dict_array_s
		  SamplePLists.Value( "k_APList_dict_bool_m" ) = k_APList_dict_bool_m
		  SamplePLists.Value( "k_APList_dict_bool_s" ) = k_APList_dict_bool_s
		  SamplePLists.Value( "k_APList_dict_data_m" ) = k_APList_dict_data_m
		  SamplePLists.Value( "k_APList_dict_data_s" ) = k_APList_dict_data_s
		  SamplePLists.Value( "k_APList_dict_date_m" ) = k_APList_dict_date_m
		  SamplePLists.Value( "k_APList_dict_date_s" ) = k_APList_dict_date_s
		  SamplePLists.Value( "k_APList_dict_dict_m" ) = k_APList_dict_dict_m
		  SamplePLists.Value( "k_APList_dict_dict_s" ) = k_APList_dict_dict_s
		  SamplePLists.Value( "k_APList_dict_empty" ) = k_APList_dict_empty
		  SamplePLists.Value( "k_APList_dict_int_m" ) = k_APList_dict_int_m
		  SamplePLists.Value( "k_APList_dict_int_s" ) = k_APList_dict_int_s
		  SamplePLists.Value( "k_APList_dict_multiple" ) = k_APList_dict_multiple
		  SamplePLists.Value( "k_APList_dict_real_m" ) = k_APList_dict_real_m
		  SamplePLists.Value( "k_APList_dict_real_s" ) = k_APList_dict_real_s
		  SamplePLists.Value( "k_APList_dict_string_m" ) = k_APList_dict_string_m
		  SamplePLists.Value( "k_APList_dict_string_s" ) = k_APList_dict_string_s
		  SamplePLists.Value( "k_APList_int" ) = k_APList_int
		  SamplePLists.Value( "k_APList_real" ) = k_APList_real
		  SamplePLists.Value( "k_APList_string_big" ) = k_APList_string_big
		  SamplePLists.Value( "k_APList_string_escape" ) = k_APList_string_escape
		  SamplePLists.Value( "k_APList_string_small" ) = k_APList_string_small
		  
		  For Each k As Variant In SamplePLists.Keys
		    
		    AssertEquals 1, SamplePLists.Value( k ).StringValue.CountFields( kApplePListHeader ) -1, "PList Sample '" + k + "' does not have exactly one plist."
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub AssertEquals_str(expected As String, found As String, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 1/16/2010 by Andrew Keller
		  
		  // A polarizing wrapper for AssertEquals that forces the input to Strings.
		  
		  AssertEquals expected, found, failureMessage, isTerminal
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDeserialize_Undefined_ApplePList()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure unsupported structures raise errors correctly.
		  
		  #pragma BreakOnExceptions Off
		  
		  Dim p As PropertyListKFS
		  
		  Try
		    
		    p = New PropertyListKFS( Nil, PropertyListKFS.SerialFormats.ApplePList )
		    AssertFailure "Deserializing a Nil string should raise a NilObjectException."
		    
		  Catch err As NilObjectException
		  Catch err As UnitTestExceptionKFS
		  Catch err
		    AssertFailure "Deserializing a Nil string raised the wrong type of exception (" + ObjectDescriptionKFS(err) + ")."
		  End Try
		  
		  Try
		    
		    p = New PropertyListKFS( "", PropertyListKFS.SerialFormats.ApplePList )
		    AssertFailure "Deserializing an empty string should raise an UnsupportedFormatException."
		    
		  Catch err As UnsupportedFormatException
		  Catch err As UnitTestExceptionKFS
		  Catch err
		    AssertFailure "Deserializing an empty string raised the wrong type of exception (" + ObjectDescriptionKFS(err) + ")."
		  End Try
		  
		  Try
		    
		    p = New PropertyListKFS( " ", PropertyListKFS.SerialFormats.ApplePList )
		    AssertFailure "Deserializing a space should raise an UnsupportedFormatException."
		    
		  Catch err As UnsupportedFormatException
		  Catch err As UnitTestExceptionKFS
		  Catch err
		    AssertFailure "Deserializing a space raised the wrong type of exception (" + ObjectDescriptionKFS(err) + ")."
		  End Try
		  
		  Try
		    
		    p = New PropertyListKFS( "          ", PropertyListKFS.SerialFormats.ApplePList )
		    AssertFailure "Deserializing 10 spaces should raise an UnsupportedFormatException."
		    
		  Catch err As UnsupportedFormatException
		  Catch err As UnitTestExceptionKFS
		  Catch err
		    AssertFailure "Deserializing 10 spaces raised the wrong type of exception (" + ObjectDescriptionKFS(err) + ")."
		  End Try
		  
		  Try
		    
		    p = New PropertyListKFS( "  blah  foobar  ", PropertyListKFS.SerialFormats.ApplePList )
		    AssertFailure "Deserializing arbitrary text should raise an UnsupportedFormatException."
		    
		  Catch err As UnsupportedFormatException
		  Catch err As UnitTestExceptionKFS
		  Catch err
		    AssertFailure "Deserializing arbitrary text raised the wrong type of exception (" + ObjectDescriptionKFS(err) + ")."
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGuessSerializedFormat_ApplePList()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure the GuessSerializedPListFormat function can identify Apple Property Lists.
		  
		  PushMessageStack "Did not recognize some data formatted as an Apple Property List."
		  
		  For Each k As Variant In SamplePLists.Keys
		    
		    AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( SamplePLists.Value( k ).StringValue ), "(" + k + ")"
		    
		  Next
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGuessSerializedFormat_Undefined()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure the GuessSerializedPListFormat function can identify undefined plist formats.
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( Nil ), "Did not return Undefined for a Nil string."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "" ), "Did not return Undefined for an empty string."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( " " ), "Did not return Undefined for a single space."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "          " ), "Did not return Undefined for 10 spaces."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "  blah  foobar  " ), "Did not return Undefined for arbitrary text."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSerialize_Undefined_ApplePList()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_array_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_array_m, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items.", False
		  
		  For Each k As Variant In d.Keys
		    
		    Dim v As Variant = d.Value( k )
		    
		    AssertNotIsNil v, "None of the children are supposed to be Nil."
		    AssertTrue v IsA PropertyListKFS, "All of the children are supposed to be PropertyListKFS objects."
		    
		    Dim p2 As PropertyListKFS = v
		    
		    AssertTrue p2.TreatAsArray, "All of the children are supposed to be arrays.", False
		    
		    Dim d2 As Dictionary = p2
		    
		    AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		    
		    AssertZero d2.Count, "None of the children are supposed to have any items of their own.", False
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_array_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_array_s, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA PropertyListKFS, "The child is supposed to be a PropertyListKFS object."
		  
		  Dim p2 As PropertyListKFS = v
		  
		  AssertTrue p2.TreatAsArray, "The child is supposed to be an array.", False
		  
		  Dim d2 As Dictionary = p2
		  
		  AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertZero d2.Count, "The child is not supposed to have any items of its own.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_bool_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_bool_m, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The children are supposed to be boolean.", False
		  AssertEquals True, v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The children are supposed to be boolean.", False
		  AssertEquals False, v, "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The children are supposed to be boolean.", False
		  AssertEquals True, v, "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_bool_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_bool_s, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The children are supposed to be boolean.", False
		  AssertEquals True, v, "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_data_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_data_m, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The children are supposed to be MemoryBlocks.", False
		  AssertEquals "foo", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The children are supposed to be MemoryBlocks.", False
		  AssertEquals "bar", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The children are supposed to be MemoryBlocks.", False
		  AssertEquals "fish", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_data_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_data_s, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The children are supposed to be MemoryBlocks.", False
		  AssertEquals "foo", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_date_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_date_m, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The children are supposed to be Dates.", False
		  AssertEquals New Date( 2010, 1, 1, 4, 0, 0 ), v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The children are supposed to be Dates.", False
		  AssertEquals New Date( 2010, 1, 1, 5, 0, 0 ), v, "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The children are supposed to be Dates.", False
		  AssertEquals New Date( 2010, 1, 1, 6, 0, 0 ), v, "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_date_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_date_s, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The children are supposed to be Dates.", False
		  AssertEquals New Date( 2010, 1, 1, 4, 0, 0 ), v, "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_dict_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_dict_m, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items.", False
		  
		  For Each k As Variant In d.Keys
		    
		    Dim v As Variant = d.Value( k )
		    
		    AssertNotIsNil v, "None of the children are supposed to be Nil."
		    AssertTrue v IsA PropertyListKFS, "All of the children are supposed to be PropertyListKFS objects."
		    
		    Dim p2 As PropertyListKFS = v
		    
		    AssertFalse p2.TreatAsArray, "All of the children are supposed to be Dictionaries.", False
		    
		    Dim d2 As Dictionary = p2
		    
		    AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		    
		    AssertZero d2.Count, "None of the children are supposed to have any items of their own.", False
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_dict_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_dict_s, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA PropertyListKFS, "The child is supposed to be a PropertyListKFS object."
		  
		  Dim p2 As PropertyListKFS = v
		  
		  AssertFalse p2.TreatAsArray, "The child is supposed to be a Dictionary.", False
		  
		  Dim d2 As Dictionary = p2
		  
		  AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertZero d2.Count, "The child is not supposed to have any items of its own.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_empty()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_empty, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 0, d.Count, "The plist does not have the expected number of items.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_int_m()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_int_m, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The children are supposed to be Integers.", False
		  AssertEquals 15, v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The children are supposed to be Integers.", False
		  AssertEquals 16, v, "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The children are supposed to be Integers.", False
		  AssertEquals 17, v, "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_int_s()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_int_s, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The children are supposed to be Integers.", False
		  AssertEquals 15, v, "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_multiple()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_multiple, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 8, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The first child is supposed to be a Date.", False
		  AssertEquals New Date( 2011, 1, 10, 1, 3, 27 ), v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The second child is supposed to be a MemoryBlock.", False
		  AssertEquals "Hello, World!", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The third child is supposed to be a Boolean value.", False
		  AssertEquals True, v, "The third child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 3 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The fourth child is supposed to be an Integer.", False
		  AssertEquals 15, v, "The fourth child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 4 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The fifth child is supposed to be a Double.", False
		  AssertEquals 15.4, v, "The fifth child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 5 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The sixth child is supposed to be a String.", False
		  AssertEquals "Hello, World!", v, "The sixth child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 6 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA PropertyListKFS, "The seventh child is supposed to be a PropertyListKFS object."
		  AssertFalse PropertyListKFS( v ).TreatAsArray, "The TreatAsArray property of the Dictionary child should be False.", False
		  Dim d2 As Dictionary = PropertyListKFS( v )
		  AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 1, d2.Count, "The seventh child is supposed to have 1 child."
		  AssertEquals "foo", d2.Key( 0 ), "The seventh child should have a key called 'foo'."
		  v = d2.Value( "foo" )
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The child of the seventh child is supposed to be a String.", False
		  AssertEquals "bar", v, "The child of the seventh child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 7 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA PropertyListKFS, "The eighth child is supposed to be a PropertyListKFS object."
		  AssertTrue PropertyListKFS( v ).TreatAsArray, "The TreatAsArray property of the Array child should be True.", False
		  d2 = PropertyListKFS( v )
		  AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 1, d2.Count, "The eighth child is supposed to have 1 child."
		  v = d2.Value( d2.Key( 0 ) )
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The child of the eighth child is supposed to be a String.", False
		  AssertEquals "fishcat", v, "The child of the eighth child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_real_m()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_real_m, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The children are supposed to be Doubles.", False
		  AssertEquals 15.4, v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The children are supposed to be Doubles.", False
		  AssertEquals 15.5, v, "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The children are supposed to be Doubles.", False
		  AssertEquals 15.6, v, "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_real_s()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_real_s, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The children are supposed to be Doubles.", False
		  AssertEquals 15.4, v, "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_string_m()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_string_m, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  If v IsA BigStringKFS Then
		    AssertEquals "foo", BigStringKFS( v ).StringValue, "The first child has an unexpected value.", False
		  Else
		    AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The children are supposed to be Strings.", False
		    AssertEquals "foo", v, "The first child has an unexpected value.", False
		  End If
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  If v IsA BigStringKFS Then
		    AssertEquals "bar", BigStringKFS( v ).StringValue, "The second child has an unexpected value.", False
		  Else
		    AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The children are supposed to be Strings.", False
		    AssertEquals "bar", v, "The second child has an unexpected value.", False
		  End If
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  If v IsA BigStringKFS Then
		    AssertEquals "fish", BigStringKFS( v ).StringValue, "The third child has an unexpected value.", False
		  Else
		    AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The children are supposed to be Strings.", False
		    AssertEquals "fish", v, "The third child has an unexpected value.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_string_s()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_string_s, PropertyListKFS.SerialFormats.ApplePList )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  If v IsA BigStringKFS Then
		    AssertEquals "foo", BigStringKFS( v ).StringValue, "The first child has an unexpected value.", False
		  Else
		    AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The children are supposed to be Strings.", False
		    AssertEquals "foo", v, "The first child has an unexpected value.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_bool_false()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_bool_true()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_data_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_data_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_data_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_date()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_array_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_array_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_bool_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_bool_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_data_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_data_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_date_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_date_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_dict_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_dict_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_int_m()
		  // Created 1/13/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_int_m, PropertyListKFS.SerialFormats.ApplePList ), False, New Dictionary( _
		  "foo" : 15, _
		  "bar" : 16, _
		  "fish" : 17 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_int_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_multiple()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_real_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_real_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_string_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_string_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_int()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_real()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_string_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_string_escape()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_string_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_array_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_array_m )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items.", False
		  
		  For Each k As Variant In d.Keys
		    
		    Dim v As Variant = d.Value( k )
		    
		    AssertNotIsNil v, "None of the children are supposed to be Nil."
		    AssertTrue v IsA PropertyListKFS, "All of the children are supposed to be PropertyListKFS objects."
		    
		    Dim p2 As PropertyListKFS = v
		    
		    AssertTrue p2.TreatAsArray, "All of the children are supposed to be arrays.", False
		    
		    Dim d2 As Dictionary = p2
		    
		    AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		    
		    AssertZero d2.Count, "None of the children are supposed to have any items of their own.", False
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_array_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_array_s )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA PropertyListKFS, "The child is supposed to be a PropertyListKFS object."
		  
		  Dim p2 As PropertyListKFS = v
		  
		  AssertTrue p2.TreatAsArray, "The child is supposed to be an array.", False
		  
		  Dim d2 As Dictionary = p2
		  
		  AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertZero d2.Count, "The child is not supposed to have any items of its own.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_bool_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_bool_m )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The children are supposed to be boolean.", False
		  AssertEquals True, v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The children are supposed to be boolean.", False
		  AssertEquals False, v, "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The children are supposed to be boolean.", False
		  AssertEquals True, v, "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_bool_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_bool_s )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The children are supposed to be boolean.", False
		  AssertEquals True, v, "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_data_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_data_m )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The children are supposed to be MemoryBlocks.", False
		  AssertEquals "foo", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The children are supposed to be MemoryBlocks.", False
		  AssertEquals "bar", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The children are supposed to be MemoryBlocks.", False
		  AssertEquals "fish", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_data_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_data_s )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The children are supposed to be MemoryBlocks.", False
		  AssertEquals "foo", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_date_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_date_m )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The children are supposed to be Dates.", False
		  AssertEquals New Date( 2010, 1, 1, 4, 0, 0 ), v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The children are supposed to be Dates.", False
		  AssertEquals New Date( 2010, 1, 1, 5, 0, 0 ), v, "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The children are supposed to be Dates.", False
		  AssertEquals New Date( 2010, 1, 1, 6, 0, 0 ), v, "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_date_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_date_s )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The children are supposed to be Dates.", False
		  AssertEquals New Date( 2010, 1, 1, 4, 0, 0 ), v, "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_dict_m()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_dict_m )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items.", False
		  
		  For Each k As Variant In d.Keys
		    
		    Dim v As Variant = d.Value( k )
		    
		    AssertNotIsNil v, "None of the children are supposed to be Nil."
		    AssertTrue v IsA PropertyListKFS, "All of the children are supposed to be PropertyListKFS objects."
		    
		    Dim p2 As PropertyListKFS = v
		    
		    AssertFalse p2.TreatAsArray, "All of the children are supposed to be Dictionaries.", False
		    
		    Dim d2 As Dictionary = p2
		    
		    AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		    
		    AssertZero d2.Count, "None of the children are supposed to have any items of their own.", False
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_dict_s()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_dict_s )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA PropertyListKFS, "The child is supposed to be a PropertyListKFS object."
		  
		  Dim p2 As PropertyListKFS = v
		  
		  AssertFalse p2.TreatAsArray, "The child is supposed to be a Dictionary.", False
		  
		  Dim d2 As Dictionary = p2
		  
		  AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertZero d2.Count, "The child is not supposed to have any items of its own.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_empty()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_empty )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 0, d.Count, "The plist does not have the expected number of items.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_int_m()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_int_m )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The children are supposed to be Integers.", False
		  AssertEquals 15, v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The children are supposed to be Integers.", False
		  AssertEquals 16, v, "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The children are supposed to be Integers.", False
		  AssertEquals 17, v, "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_int_s()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_int_s )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The children are supposed to be Integers.", False
		  AssertEquals 15, v, "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_multiple()
		  // Created 1/10/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_multiple )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 8, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDate, v.Type, "The first child is supposed to be a Date.", False
		  AssertEquals New Date( 2011, 1, 10, 1, 3, 27 ), v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA MemoryBlock, "The second child is supposed to be a MemoryBlock.", False
		  AssertEquals "Hello, World!", MemoryBlock( v ).StringValue( 0, MemoryBlock(v).Size ), "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeBoolean, v.Type, "The third child is supposed to be a Boolean value.", False
		  AssertEquals True, v, "The third child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 3 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeInteger Or v.Type = Variant.TypeLong Or v.Type = Variant.TypeSingle, "The fourth child is supposed to be an Integer.", False
		  AssertEquals 15, v, "The fourth child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 4 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The fifth child is supposed to be a Double.", False
		  AssertEquals 15.4, v, "The fifth child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 5 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The sixth child is supposed to be a String.", False
		  AssertEquals "Hello, World!", v, "The sixth child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 6 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA PropertyListKFS, "The seventh child is supposed to be a PropertyListKFS object."
		  AssertFalse PropertyListKFS( v ).TreatAsArray, "The TreatAsArray property of the Dictionary child should be False.", False
		  Dim d2 As Dictionary = PropertyListKFS( v )
		  AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 1, d2.Count, "The seventh child is supposed to have 1 child."
		  AssertEquals "foo", d2.Key( 0 ), "The seventh child should have a key called 'foo'."
		  v = d2.Value( "foo" )
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The child of the seventh child is supposed to be a String.", False
		  AssertEquals "bar", v, "The child of the seventh child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 7 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v IsA PropertyListKFS, "The eighth child is supposed to be a PropertyListKFS object."
		  AssertTrue PropertyListKFS( v ).TreatAsArray, "The TreatAsArray property of the Array child should be True.", False
		  d2 = PropertyListKFS( v )
		  AssertNotIsNil d2, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  AssertEquals 1, d2.Count, "The eighth child is supposed to have 1 child."
		  v = d2.Value( d2.Key( 0 ) )
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The child of the eighth child is supposed to be a String.", False
		  AssertEquals "fishcat", v, "The child of the eighth child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_real_m()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_real_m )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The children are supposed to be Doubles.", False
		  AssertEquals 15.4, v, "The first child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The children are supposed to be Doubles.", False
		  AssertEquals 15.5, v, "The second child has an unexpected value.", False
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The children are supposed to be Doubles.", False
		  AssertEquals 15.6, v, "The third child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_real_s()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_real_s )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  AssertEquals Variant.TypeDouble, v.Type, "The children are supposed to be Doubles.", False
		  AssertEquals 15.4, v, "The first child has an unexpected value.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_string_m()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_string_m )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 3, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  If v IsA BigStringKFS Then
		    AssertEquals "foo", BigStringKFS( v ).StringValue, "The first child has an unexpected value.", False
		  Else
		    AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The children are supposed to be Strings.", False
		    AssertEquals "foo", v, "The first child has an unexpected value.", False
		  End If
		  
		  v = d.Value( d.Key( 1 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  If v IsA BigStringKFS Then
		    AssertEquals "bar", BigStringKFS( v ).StringValue, "The second child has an unexpected value.", False
		  Else
		    AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The children are supposed to be Strings.", False
		    AssertEquals "bar", v, "The second child has an unexpected value.", False
		  End If
		  
		  v = d.Value( d.Key( 2 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  If v IsA BigStringKFS Then
		    AssertEquals "fish", BigStringKFS( v ).StringValue, "The third child has an unexpected value.", False
		  Else
		    AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The children are supposed to be Strings.", False
		    AssertEquals "fish", v, "The third child has an unexpected value.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_string_s()
		  // Created 1/12/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim p As New PropertyListKFS( k_APList_array_string_s )
		  Dim d As Dictionary = p
		  
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  AssertTrue p.TreatAsArray, "The plist is supposed to be an array.", False
		  
		  AssertEquals 1, d.Count, "The plist does not have the expected number of items."
		  
		  Dim v As Variant = d.Value( d.Key( 0 ) )
		  
		  AssertNotIsNil v, "None of the children are supposed to be Nil."
		  If v IsA BigStringKFS Then
		    AssertEquals "foo", BigStringKFS( v ).StringValue, "The first child has an unexpected value.", False
		  Else
		    AssertTrue v.Type = Variant.TypeCFStringRef Or v.Type = Variant.TypeCString Or v.Type = Variant.TypePString Or v.Type = Variant.TypeString Or v.Type = Variant.TypeWString, "The children are supposed to be Strings.", False
		    AssertEquals "foo", v, "The first child has an unexpected value.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_bool_false()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_bool_true()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_data_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_data_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_data_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_date()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_array_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_array_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_bool_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_bool_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_data_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_data_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_date_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_date_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_dict_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_dict_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_int_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_int_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_multiple()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_real_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_real_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_string_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_string_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_int()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_real()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_string_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_string_escape()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_string_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_array_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_array_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_bool_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_bool_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_data_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_data_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_date_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_date_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_dict_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_dict_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_int_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_int_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_multiple()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_real_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_real_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_string_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_array_string_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_bool_false()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_bool_true()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_data_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_data_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_data_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_date()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_array_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_array_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_bool_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_bool_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_data_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_data_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_date_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_date_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_dict_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_dict_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_int_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_int_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_multiple()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_real_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_real_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_string_m()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_dict_string_s()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_int()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_real()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_string_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_string_escape()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_APList_string_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifyPListContents(p As PropertyListKFS, treatAsArray As Boolean, expectedData As Dictionary, ignoreValueValue As Variant = Nil, plistDesc As String = "plist")
		  // Created 1/13/2011 by Andrew Keller
		  
		  // Verifies that the given PropertyListKFS object has the given data.
		  
		  AssertNotIsNil p, "Cannot verify a Nil PropertyListKFS object."
		  
		  If treatAsArray Then
		    
		    AssertTrue p.TreatAsArray, "The "+plistDesc+" is supposed to be an array."
		  Else
		    AssertFalse p.TreatAsArray, "The "+plistDesc+" is supposed to be a Dictionary."
		  End If
		  
		  
		  Dim d As Dictionary = p
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  Dim extraKeys As New Dictionary
		  Dim ev, fv As Variant
		  
		  For Each k As Variant In d.Keys
		    extraKeys.Value( k ) = True
		  Next
		  
		  For Each k As Variant In expectedData.Keys
		    
		    If PresumeTrue( d.HasKey( k ), "The "+plistDesc+" is missing the key '"+k+"'." ) Then
		      
		      extraKeys.Remove k
		      ev = expectedData.Value( k )
		      fv = d.Value( k )
		      
		      PushMessageStack "The value referenced by the key '"+k+"' in the "+plistDesc+" is supposed to be"
		      
		      If ev = ignoreValueValue Then
		        
		        // ignore this value
		        
		      ElseIf ev.Type = Variant.TypeBoolean Then
		        
		        AssertTrue fv.Type = Variant.TypeBoolean, "a Boolean value.", False
		        
		      ElseIf ev.Type = Variant.TypeCFStringRef _
		        Or ev.Type = Variant.TypeCString _
		        Or ev.Type = Variant.TypePString _
		        Or ev.Type = Variant.TypeString _
		        Or ev.Type = Variant.TypeWString Then
		        
		        AssertTrue fv.Type = Variant.TypeCFStringRef _
		        Or fv.Type = Variant.TypeCString _
		        Or fv.Type = Variant.TypePString _
		        Or fv.Type = Variant.TypeString _
		        Or fv.Type = Variant.TypeWString, "a String value.", False
		        
		      ElseIf ev.Type = Variant.TypeDate Then
		        
		        AssertTrue fv.Type = Variant.TypeDate, "a Date value.", False
		        
		      ElseIf ev.Type = Variant.TypeDouble Then
		        
		        AssertTrue fv.Type = Variant.TypeDouble, "a Double value.", False
		        
		      ElseIf ev.Type = Variant.TypeInteger _
		        Or ev.Type = Variant.TypeLong _
		        Or ev.Type = Variant.TypeSingle Then
		        
		        AssertTrue fv.Type = Variant.TypeInteger _
		        Or fv.Type = Variant.TypeLong _
		        Or fv.Type = Variant.TypeSingle, "an Integer value.", False
		        
		      ElseIf ev IsA MemoryBlock Then
		        
		        AssertTrue fv IsA MemoryBlock, "a MemoryBlock value.", False
		        
		      Else
		        
		        PopMessageStack
		        AssertFailure "An unknown data type is supposed to be assigned with the key '"+k+"'."
		        
		      End If
		      
		      PopMessageStack
		      
		    End If
		  Next
		  
		  For Each k As Variant in extraKeys.Keys
		    AssertFailure "The "+plistDesc+" is not supposed to have the key '"+k+"'."
		  Next
		  
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


	#tag Property, Flags = &h1
		Protected SamplePLists As Dictionary
	#tag EndProperty


	#tag Constant, Name = kApplePListFooter, Type = String, Dynamic = False, Default = \"</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kApplePListHeader, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kTheIliad, Type = String, Dynamic = False, Default = \"Sing\x2C O goddess\x2C the anger of Achilles son of Peleus\x2C that brought countless ills upon the Achaeans. Many a brave soul did it send hurrying down to Hades\x2C and many a hero did it yield a prey to dogs and vultures\x2C for so were the counsels of Jove fulfilled from the day on which the son of Atreus\x2C king of men\x2C and great Achilles\x2C first fell out with one another.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_array_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<array/>\r\t<array/>\r\t<array/>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_array_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<array/>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_bool_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<true/>\r\t<false/>\r\t<true/>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_bool_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<true/>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_data_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<data>Zm9v</data>\r\t<data>YmFy</data>\r\t<data>ZmlzaA\x3D\x3D</data>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_data_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<data>Zm9v</data>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_date_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<date>2010-01-01T09:00:00Z</date>\r\t<date>2010-01-01T10:00:00Z</date>\r\t<date>2010-01-01T11:00:00Z</date>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_date_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<date>2010-01-01T09:00:00Z</date>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_dict_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<dict/>\r\t<dict/>\r\t<dict/>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_dict_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<dict/>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_empty, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array/>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_int_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<integer>15</integer>\r\t<integer>16</integer>\r\t<integer>17</integer>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_int_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<integer>15</integer>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_multiple, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<date>2011-01-10T06:03:27Z</date>\r\t<data>SGVsbG8sIFdvcmxkIQ\x3D\x3D</data>\r\t<true/>\r\t<integer>15</integer>\r\t<real>15.4</real>\r\t<string>Hello\x2C World!</string>\r\t<dict>\r\t\t<key>foo</key>\r\t\t<string>bar</string>\r\t</dict>\r\t<array>\r\t\t<string>fishcat</string>\r\t</array>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_real_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<real>15.4</real>\r\t<real>15.5</real>\r\t<real>15.6</real>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_real_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<real>15.4</real>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_string_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<string>foo</string>\r\t<string>bar</string>\r\t<string>fish</string>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_string_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<array>\r\t<string>foo</string>\r</array>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_bool_false, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<false/>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_bool_true, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<true/>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_data_big, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<data>U2luZywgTyBnb2RkZXNzLCB0aGUgYW5nZXIgb2YgQWNoaWxsZXMgc29uIG9mIFBlbGV1cywgdGhhdCBicm91Z2h0IGNvdW50bGVzcyBpbGxzIHVwb24gdGhlIEFjaGFlYW5zLiBNYW55IGEgYnJhdmUgc291bCBkaWQgaXQgc2VuZCBodXJyeWluZyBkb3duIHRvIEhhZGVzLCBhbmQgbWFueSBhIGhlcm8gZGlkIGl0IHlpZWxkIGEgcHJleSB0byBkb2dzIGFuZCB2dWx0dXJlcywgZm9yIHNvIHdlcmUgdGhlIGNvdW5zZWxzIG9mIEpvdmUgZnVsZmlsbGVkIGZyb20gdGhlIGRheSBvbiB3aGljaCB0aGUgc29uIG9mIEF0cmV1cywga2luZyBvZiBtZW4sIGFuZCBncmVhdCBBY2hpbGxlcywgZmlyc3QgZmVsbCBvdXQgd2l0aCBvbmUgYW5vdGhlci4\x3D</data>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_data_empty, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<data></data>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_data_small, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<data>SGVsbG8sIFdvcmxkIQ\x3D\x3D</data>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_date, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<date>2011-01-09T19:04:17Z</date>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_array_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<array/>\r\t<key>bar</key>\r\t<array/>\r\t<key>fish</key>\r\t<array/>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_array_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<array/>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_bool_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<true/>\r\t<key>bar</key>\r\t<false/>\r\t<key>fish</key>\r\t<true/>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_bool_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<true/>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_data_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<data>YmFy</data>\r\t<key>fish</key>\r\t<data>Y2F0</data>\r\t<key>bird</key>\r\t<data>ZG9n</data>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_data_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<data>YmFy</data>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_date_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<date>2010-01-01T09:00:00Z</date>\r\t<key>bar</key>\r\t<date>2010-01-01T10:00:00Z</date>\r\t<key>fish</key>\r\t<date>2010-01-01T11:00:00Z</date>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_date_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<date>2010-01-01T09:00:00Z</date>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_dict_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<dict/>\r\t<key>bar</key>\r\t<dict/>\r\t<key>fish</key>\r\t<dict/>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_dict_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<dict/>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_empty, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict/>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_int_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<integer>15</integer>\r\t<key>bar</key>\r\t<integer>16</integer>\r\t<key>fish</key>\r\t<integer>17</integer>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_int_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<integer>15</integer>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_multiple, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>tval</key>\r\t<date>2011-01-10T06:03:27Z</date>\r\t<key>mval</key>\r\t<data>SGVsbG8sIFdvcmxkIQ\x3D\x3D</data>\r\t<key>bval</key>\r\t<true/>\r\t<key>ival</key>\r\t<integer>15</integer>\r\t<key>dval</key>\r\t<real>15.4</real>\r\t<key>sval</key>\r\t<string>Hello\x2C World!</string>\r\t<key>c1</key>\r\t<dict>\r\t\t<key>foo</key>\r\t\t<string>bar</string>\r\t</dict>\r\t<key>c2</key>\r\t<array>\r\t\t<string>fishcat</string>\r\t</array>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_real_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<real>15.4</real>\r\t<key>bar</key>\r\t<string>15.5</string>\r\t<key>fish</key>\r\t<string>15.6</string>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_real_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<real>15.4</real>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_string_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<string>bar</string>\r\t<key>fish</key>\r\t<string>cat</string>\r\t<key>bird</key>\r\t<string>dog</string>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_string_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>foo</key>\r\t<string>bar</string>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_int, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<integer>15</integer>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_real, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<real>15.4</real>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_string_big, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<string>Sing\x2C O goddess\x2C the anger of Achilles son of Peleus\x2C that brought countless ills upon the Achaeans. Many a brave soul did it send hurrying down to Hades\x2C and many a hero did it yield a prey to dogs and vultures\x2C for so were the counsels of Jove fulfilled from the day on which the son of Atreus\x2C king of men\x2C and great Achilles\x2C first fell out with one another.</string>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_string_escape, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<string>&lt;Hello\x2C World!&gt;</string>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_string_small, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<string>foo</string>\r</plist>\r", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="UnitTestBaseClassKFS"
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
