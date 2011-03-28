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
		Protected Sub AssertEquals_date(expected As Date, found As Date, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 3/2/2011 by Andrew Keller
		  
		  // A polarizing wrapper for AssertEquals that forces the input to Dates.
		  // Also sanitizes the input to some extent to get the comparison to be accurate.
		  
		  Dim e, f As Date
		  
		  If Not ( expected Is Nil ) Then
		    
		    e = NewDateKFS( expected )
		    e.GMTOffset = 0
		    
		  End If
		  
		  If Not ( found Is Nil ) Then
		    
		    f = NewDateKFS( found )
		    f.GMTOffset = 0
		    
		  End If
		  
		  AssertEquals e, f, failureMessage, isTerminal
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub AssertEquals_str(expected As String, found As String, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 1/16/2010 by Andrew Keller
		  
		  // A polarizing wrapper for AssertEquals that forces the input to Strings.
		  
		  AssertEquals expected, found, failureMessage, isTerminal
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GeneratePList(template As Dictionary, dirIsFulPListKey As Variant = "_difp", treatAsArrayKey As Variant = "_taary") As PropertyListKFS
		  // Created 3/3/2011 by Andrew Keller
		  
		  // A wrapper around GeneratePListDir that forces the result to a PropertyListKFS object.
		  
		  Dim plist As Variant = GeneratePListDir( template, dirIsFulPListKey, treatAsArrayKey )
		  
		  If plist Is Nil Then
		    
		    Return Nil
		    
		  ElseIf plist IsA PropertyListKFS Then
		    
		    Return PropertyListKFS( plist )
		    
		  ElseIf plist IsA Dictionary Then
		    
		    Return Dictionary( plist )
		    
		  Else
		    
		    AssertFailure "The GeneratePList function cannot handle the GeneratePListDir function returning " + plist.TypeDescriptionKFS + "."
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GeneratePListDir(template As Dictionary, dirIsFulPListKey As Variant = "_difp", treatAsArrayKey As Variant = "_taary") As Variant
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Returns a Dictionary that represents the core of the plist described by the given template.
		  
		  If template Is Nil Then Return Nil
		  
		  Dim core As New Dictionary
		  
		  For Each k As Variant In template.Keys
		    
		    If k = dirIsFulPListKey Or k = treatAsArrayKey Then
		      
		      // Ignore this key.
		      
		    Else
		      
		      Dim v As Variant = template.Value( k )
		      
		      If v IsA Dictionary Then
		        
		        core.Value( k ) = GeneratePListDir( Dictionary( v ), dirIsFulPListKey, treatAsArrayKey )
		        
		      Else
		        
		        core.Value( k ) = v
		        
		      End If
		    End If
		  Next
		  
		  If template.Lookup( dirIsFulPListKey, True ).BooleanValue Then
		    
		    Dim plist As PropertyListKFS = core
		    
		    plist.TreatAsArray = template.Lookup( treatAsArrayKey, False ).BooleanValue
		    
		    Return plist
		    
		  Else
		    
		    Return core
		    
		  End If
		  
		  // done.
		  
		End Function
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
		    
		    AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListGlobalsKFS.GuessSerializedPListFormat( SamplePLists.Value( k ).StringValue ), "(" + k + ")"
		    
		  Next
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGuessSerializedFormat_Undefined()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure the GuessSerializedPListFormat function can identify undefined plist formats.
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListGlobalsKFS.GuessSerializedPListFormat( Nil ), "Did not return Undefined for a Nil string."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListGlobalsKFS.GuessSerializedPListFormat( "" ), "Did not return Undefined for an empty string."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListGlobalsKFS.GuessSerializedPListFormat( " " ), "Did not return Undefined for a single space."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListGlobalsKFS.GuessSerializedPListFormat( "          " ), "Did not return Undefined for 10 spaces."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListGlobalsKFS.GuessSerializedPListFormat( "  blah  foobar  " ), "Did not return Undefined for arbitrary text."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_array_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_array_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : True ), _
		  1 : New Dictionary( "_taary" : True ), _
		  2 : New Dictionary( "_taary" : True ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_array_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_array_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : True ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_bool_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_bool_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : True, _
		  1 : False, _
		  2 : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_bool_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_bool_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_data_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "foo"
		  Dim m2 As MemoryBlock = "bar"
		  Dim m3 As MemoryBlock = "fish"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_data_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : m1, _
		  1 : m2, _
		  2 : m3 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_data_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "foo"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_data_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : m1 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_date_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_date_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ), _
		  1 : NewDateKFS( 2010, 1, 1, 10, 11, 12, 0 ), _
		  2 : NewDateKFS( 2010, 1, 1, 11, 12, 13, 0 ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_date_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_date_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_dict_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_dict_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ), _
		  1 : New Dictionary( "_taary" : False ), _
		  2 : New Dictionary( "_taary" : False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_dict_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_dict_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_empty()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_empty, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_int_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_int_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : 15, _
		  1 : 16, _
		  2 : 17 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_int_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_int_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : 15 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_multiple()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_multiple, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  1 : m1, _
		  2 : True, _
		  3 : 15, _
		  4 : 15.4, _
		  5 : "Hello, World!", _
		  6 : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  7 : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  8 : New Dictionary( "_taary" : False, "dog" : "13" ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_real_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_real_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : 15.4, _
		  1 : 15.5, _
		  2 : 15.6 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_real_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_real_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : 15.4 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_string_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_string_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : "foo", _
		  1 : "bar", _
		  2 : "fish" )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_array_string_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_string_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : True, _
		  0 : "foo" )
		  
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
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_array_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : True ), _
		  "bar" : New Dictionary( "_taary" : True ), _
		  "fish" : New Dictionary( "_taary" : True ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_array_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_array_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : True ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_bool_m()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_bool_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : True, _
		  "bar" : False, _
		  "fish" : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_bool_s()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_bool_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_data_m()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "bar"
		  Dim m2 As MemoryBlock = "cat"
		  Dim m3 As MemoryBlock = "dog"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_data_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : m1, _
		  "fish" : m2, _
		  "bird" : m3 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_data_s()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "bar"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_data_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : m1 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_date_m()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_date_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ), _
		  "bar" : NewDateKFS( 2010, 1, 1, 10, 11, 12, 0 ), _
		  "fish" : NewDateKFS( 2010, 1, 1, 11, 12, 13, 0 ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_date_s()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_date_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_dict_m()
		  // Created 1/16/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_dict_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ), _
		  "bar" : New Dictionary( "_taary" : False ), _
		  "fish" : New Dictionary( "_taary" : False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_dict_s()
		  // Created 1/16/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_dict_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_empty()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_empty, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_int_m()
		  // Created 1/13/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_int_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : 15, _
		  "bar" : 16, _
		  "fish" : 17 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_int_s()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_int_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : 15 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_multiple()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_multiple, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "tval" : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  "mval" : m1, _
		  "bval" : True, _
		  "ival" : 15, _
		  "dval" : 15.4, _
		  "sval" : "Hello, World!", _
		  "c1" : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  "c2" : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  "c3" : New Dictionary( "_taary" : False, "dog" : "13" ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_real_m()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_real_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : 15.4, _
		  "bar" : 15.5, _
		  "fish" : 15.6 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_real_s()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_real_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : 15.4 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_string_m()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_string_m, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : "bar", _
		  "fish" : "cat", _
		  "bird" : "dog" )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_ex_APList_dict_string_s()
		  // Created 1/15/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_string_s, PropertyListKFS.SerialFormats.ApplePList ), New Dictionary( "_taary" : False, _
		  "foo" : "bar" )
		  
		  // done.
		  
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
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_array_m ), New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : True ), _
		  1 : New Dictionary( "_taary" : True ), _
		  2 : New Dictionary( "_taary" : True ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_array_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_array_s ), New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : True ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_bool_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_bool_m ), New Dictionary( "_taary" : True, _
		  0 : True, _
		  1 : False, _
		  2 : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_bool_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_bool_s ), New Dictionary( "_taary" : True, _
		  0 : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_data_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "foo"
		  Dim m2 As MemoryBlock = "bar"
		  Dim m3 As MemoryBlock = "fish"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_data_m ), New Dictionary( "_taary" : True, _
		  0 : m1, _
		  1 : m2, _
		  2 : m3 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_data_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "foo"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_data_s ), New Dictionary( "_taary" : True, _
		  0 : m1 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_date_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_date_m ), New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ), _
		  1 : NewDateKFS( 2010, 1, 1, 10, 11, 12, 0 ), _
		  2 : NewDateKFS( 2010, 1, 1, 11, 12, 13, 0 ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_date_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_date_s ), New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_dict_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_dict_m ), New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ), _
		  1 : New Dictionary( "_taary" : False ), _
		  2 : New Dictionary( "_taary" : False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_dict_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_dict_s ), New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_empty()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_empty ), New Dictionary( "_taary" : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_int_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_int_m ), New Dictionary( "_taary" : True, _
		  0 : 15, _
		  1 : 16, _
		  2 : 17 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_int_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_int_s ), New Dictionary( "_taary" : True, _
		  0 : 15 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_multiple()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_multiple ), New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  1 : m1, _
		  2 : True, _
		  3 : 15, _
		  4 : 15.4, _
		  5 : "Hello, World!", _
		  6 : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  7 : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  8 : New Dictionary( "_taary" : False, "dog" : "13" ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_real_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_real_m ), New Dictionary( "_taary" : True, _
		  0 : 15.4, _
		  1 : 15.5, _
		  2 : 15.6 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_real_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_real_s ), New Dictionary( "_taary" : True, _
		  0 : 15.4 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_string_m()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_string_m ), New Dictionary( "_taary" : True, _
		  0 : "foo", _
		  1 : "bar", _
		  2 : "fish" )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_array_string_s()
		  // Created 1/17/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_array_string_s ), New Dictionary( "_taary" : True, _
		  0 : "foo" )
		  
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
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_array_m ), New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : True ), _
		  "bar" : New Dictionary( "_taary" : True ), _
		  "fish" : New Dictionary( "_taary" : True ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_array_s()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_array_s ), New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : True ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_bool_m()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_bool_m ), New Dictionary( "_taary" : False, _
		  "foo" : True, _
		  "bar" : False, _
		  "fish" : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_bool_s()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_bool_s ), New Dictionary( "_taary" : False, _
		  "foo" : True )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_data_m()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "bar"
		  Dim m2 As MemoryBlock = "cat"
		  Dim m3 As MemoryBlock = "dog"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_data_m ), New Dictionary( "_taary" : False, _
		  "foo" : m1, _
		  "fish" : m2, _
		  "bird" : m3 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_data_s()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "bar"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_data_s ), New Dictionary( "_taary" : False, _
		  "foo" : m1 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_date_m()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_date_m ), New Dictionary( "_taary" : False, _
		  "foo" : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ), _
		  "bar" : NewDateKFS( 2010, 1, 1, 10, 11, 12, 0 ), _
		  "fish" : NewDateKFS( 2010, 1, 1, 11, 12, 13, 0 ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_date_s()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_date_s ), New Dictionary( "_taary" : False, _
		  "foo" : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_dict_m()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_dict_m ), New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ), _
		  "bar" : New Dictionary( "_taary" : False ), _
		  "fish" : New Dictionary( "_taary" : False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_dict_s()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_dict_s ), New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_empty()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_empty ), New Dictionary( "_taary" : False )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_int_m()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_int_m ), New Dictionary( "_taary" : False, _
		  "foo" : 15, _
		  "bar" : 16, _
		  "fish" : 17 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_int_s()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_int_s ), New Dictionary( "_taary" : False, _
		  "foo" : 15 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_multiple()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_multiple ), New Dictionary( "_taary" : False, _
		  "tval" : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  "mval" : m1, _
		  "bval" : True, _
		  "ival" : 15, _
		  "dval" : 15.4, _
		  "sval" : "Hello, World!", _
		  "c1" : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  "c2" : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  "c3" : New Dictionary( "_taary" : False, "dog" : "13" ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_real_m()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_real_m ), New Dictionary( "_taary" : False, _
		  "foo" : 15.4, _
		  "bar" : 15.5, _
		  "fish" : 15.6 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_real_s()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_real_s ), New Dictionary( "_taary" : False, _
		  "foo" : 15.4 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_string_m()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_string_m ), New Dictionary( "_taary" : False, _
		  "foo" : "bar", _
		  "fish" : "cat", _
		  "bird" : "dog" )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_dser_im_APList_dict_string_s()
		  // Created 1/18/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly deserializing an Apple PList.
		  
		  VerifyPListContents New PropertyListKFS( k_APList_dict_string_s ), New Dictionary( "_taary" : False, _
		  "foo" : "bar" )
		  
		  // done.
		  
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
		Sub Test_ser_ex_APList_array_array_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : True ), _
		  1 : New Dictionary( "_taary" : True ), _
		  2 : New Dictionary( "_taary" : True ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_array_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_array_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : True ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_array_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_bool_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : True, _
		  1 : False, _
		  2 : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_bool_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_bool_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_bool_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_data_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "foo"
		  Dim m2 As MemoryBlock = "bar"
		  Dim m3 As MemoryBlock = "fish"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : m1, _
		  1 : m2, _
		  2 : m3 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_data_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_data_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "foo"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : m1 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_data_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_date_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ), _
		  1 : NewDateKFS( 2010, 1, 1, 10, 11, 12, 0 ), _
		  2 : NewDateKFS( 2010, 1, 1, 11, 12, 13, 0 ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_date_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_date_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_date_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_dict_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ), _
		  1 : New Dictionary( "_taary" : False ), _
		  2 : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_dict_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_dict_m_heterogeneous()
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ), _
		  1 : New Dictionary( "_taary" : False, "_difp" : False ), _
		  2 : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_dict_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_dict_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_dict_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_empty()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_empty, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_int_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : 15, _
		  1 : 16, _
		  2 : 17 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_int_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_int_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : 15 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_int_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_multiple()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  1 : m1, _
		  2 : True, _
		  3 : 15, _
		  4 : 15.4, _
		  5 : "Hello, World!", _
		  6 : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  7 : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  8 : New Dictionary( "_taary" : False, "dog" : "13" ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_multiple, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_multiple_heterogeneous()
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  1 : m1, _
		  2 : True, _
		  3 : 15, _
		  4 : 15.4, _
		  5 : "Hello, World!", _
		  6 : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  7 : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  8 : New Dictionary( "_taary" : False, "_difp" : False, "dog" : "13" ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_multiple, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_real_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : 15.4, _
		  1 : 15.5, _
		  2 : 15.6 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_real_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_real_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : 15.4 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_real_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_string_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : "foo", _
		  1 : "bar", _
		  2 : "fish" ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_string_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_array_string_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : "foo" ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_string_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_bool_false()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_bool_true()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_data_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_data_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_data_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_date()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_array_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : True ), _
		  "bar" : New Dictionary( "_taary" : True ), _
		  "fish" : New Dictionary( "_taary" : True ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_array_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_array_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : True ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_array_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_bool_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : True, _
		  "bar" : False, _
		  "fish" : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_bool_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_bool_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_bool_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_data_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "bar"
		  Dim m2 As MemoryBlock = "cat"
		  Dim m3 As MemoryBlock = "dog"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : m1, _
		  "fish" : m2, _
		  "bird" : m3 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_data_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_data_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "bar"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : m1 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_data_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_date_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ), _
		  "bar" : NewDateKFS( 2010, 1, 1, 10, 11, 12, 0 ), _
		  "fish" : NewDateKFS( 2010, 1, 1, 11, 12, 13, 0 ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_date_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_date_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_date_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_dict_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ), _
		  "bar" : New Dictionary( "_taary" : False ), _
		  "fish" : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_dict_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_dict_m_heterogeneous()
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ), _
		  "bar" : New Dictionary( "_taary" : False, "_difp" : False ), _
		  "fish" : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_dict_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_dict_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_dict_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_empty()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_empty, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_int_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : 15, _
		  "bar" : 16, _
		  "fish" : 17 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_int_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_int_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : 15 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_int_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_multiple()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "tval" : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  "mval" : m1, _
		  "bval" : True, _
		  "ival" : 15, _
		  "dval" : 15.4, _
		  "sval" : "Hello, World!", _
		  "c1" : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  "c2" : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  "c3" : New Dictionary( "_taary" : False, "dog" : "13" ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_multiple, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_multiple_heterogeneous()
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "tval" : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  "mval" : m1, _
		  "bval" : True, _
		  "ival" : 15, _
		  "dval" : 15.4, _
		  "sval" : "Hello, World!", _
		  "c1" : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  "c2" : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  "c3" : New Dictionary( "_taary" : False, "_difp" : False, "dog" : "13" ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_multiple, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_real_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : 15.4, _
		  "bar" : 15.5, _
		  "fish" : 15.6 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_real_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_real_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : 15.4 ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_real_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_string_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : "bar", _
		  "fish" : "cat", _
		  "bird" : "dog" ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_string_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_dict_string_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of explicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : "bar" ) )
		  
		  Dim s As BigStringKFS = p.Serialize( PropertyListKFS.SerialFormats.ApplePList )
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_string_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_int()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_real()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_string_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_string_escape()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_ex_APList_string_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_array_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : True ), _
		  1 : New Dictionary( "_taary" : True ), _
		  2 : New Dictionary( "_taary" : True ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_array_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_array_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : True ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_array_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_bool_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : True, _
		  1 : False, _
		  2 : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_bool_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_bool_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_bool_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_data_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "foo"
		  Dim m2 As MemoryBlock = "bar"
		  Dim m3 As MemoryBlock = "fish"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : m1, _
		  1 : m2, _
		  2 : m3 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_data_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_data_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "foo"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : m1 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_data_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_date_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ), _
		  1 : NewDateKFS( 2010, 1, 1, 10, 11, 12, 0 ), _
		  2 : NewDateKFS( 2010, 1, 1, 11, 12, 13, 0 ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_date_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_date_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_date_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_dict_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ), _
		  1 : New Dictionary( "_taary" : False ), _
		  2 : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_dict_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_dict_m_heterogeneous()
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ), _
		  1 : New Dictionary( "_taary" : False, "_difp" : False ), _
		  2 : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_dict_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_dict_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_dict_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_empty()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_empty, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_int_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : 15, _
		  1 : 16, _
		  2 : 17 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_int_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_int_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : 15 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_int_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_multiple()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  1 : m1, _
		  2 : True, _
		  3 : 15, _
		  4 : 15.4, _
		  5 : "Hello, World!", _
		  6 : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  7 : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  8 : New Dictionary( "_taary" : False, "dog" : "13" ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_multiple, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_multiple_heterogeneous()
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  1 : m1, _
		  2 : True, _
		  3 : 15, _
		  4 : 15.4, _
		  5 : "Hello, World!", _
		  6 : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  7 : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  8 : New Dictionary( "_taary" : False, "_difp" : False, "dog" : "13" ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_multiple, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_real_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : 15.4, _
		  1 : 15.5, _
		  2 : 15.6 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_real_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_real_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : 15.4 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_real_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_string_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : "foo", _
		  1 : "bar", _
		  2 : "fish" ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_string_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_array_string_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : True, _
		  0 : "foo" ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_array_string_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_bool_false()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_bool_true()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_data_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_data_empty()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_data_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_date()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_array_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : True ), _
		  "bar" : New Dictionary( "_taary" : True ), _
		  "fish" : New Dictionary( "_taary" : True ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_array_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_array_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : True ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_array_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_bool_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : True, _
		  "bar" : False, _
		  "fish" : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_bool_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_bool_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : True ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_bool_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_data_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "bar"
		  Dim m2 As MemoryBlock = "cat"
		  Dim m3 As MemoryBlock = "dog"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : m1, _
		  "fish" : m2, _
		  "bird" : m3 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_data_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_data_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "bar"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : m1 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_data_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_date_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ), _
		  "bar" : NewDateKFS( 2010, 1, 1, 10, 11, 12, 0 ), _
		  "fish" : NewDateKFS( 2010, 1, 1, 11, 12, 13, 0 ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_date_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_date_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : NewDateKFS( 2010, 1, 1, 9, 10, 11, 0 ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_date_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_dict_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ), _
		  "bar" : New Dictionary( "_taary" : False ), _
		  "fish" : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_dict_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_dict_m_heterogeneous()
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ), _
		  "bar" : New Dictionary( "_taary" : False, "_difp" : False ), _
		  "fish" : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_dict_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_dict_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : New Dictionary( "_taary" : False ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_dict_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_empty()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_empty, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_int_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : 15, _
		  "bar" : 16, _
		  "fish" : 17 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_int_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_int_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : 15 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_int_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_multiple()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "tval" : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  "mval" : m1, _
		  "bval" : True, _
		  "ival" : 15, _
		  "dval" : 15.4, _
		  "sval" : "Hello, World!", _
		  "c1" : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  "c2" : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  "c3" : New Dictionary( "_taary" : False, "dog" : "13" ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_multiple, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_multiple_heterogeneous()
		  // Created 3/8/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim m1 As MemoryBlock = "Hello, World!"
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "tval" : NewDateKFS( 2011, 1, 10, 6, 3, 27, 0 ), _
		  "mval" : m1, _
		  "bval" : True, _
		  "ival" : 15, _
		  "dval" : 15.4, _
		  "sval" : "Hello, World!", _
		  "c1" : New Dictionary( "_taary" : False, "foo" : "bar" ), _
		  "c2" : New Dictionary( "_taary" : True, 0 : "fishcat" ), _
		  "c3" : New Dictionary( "_taary" : False, "_difp" : False, "dog" : "13" ) ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_multiple, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_real_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : 15.4, _
		  "bar" : 15.5, _
		  "fish" : 15.6 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_real_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_real_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : 15.4 ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_real_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_string_m()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : "bar", _
		  "fish" : "cat", _
		  "bird" : "dog" ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_string_m, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_dict_string_s()
		  // Created 3/3/2011 by Andrew Keller
		  
		  // Checks a specific case of implicitly serializing an Apple PList.
		  
		  Dim p As PropertyListKFS = GeneratePList( New Dictionary( "_taary" : False, _
		  "foo" : "bar" ) )
		  
		  Dim s As BigStringKFS = p.Serialize
		  
		  AssertNotIsNil s, "The serialization process should never return Nil."
		  AssertEquals_str k_APList_dict_string_s, s, "The serialization process did not return the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_int()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_real()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_string_big()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_string_escape()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Test_ser_im_APList_string_small()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifyPListContents(p As PropertyListKFS, expectedData As Dictionary, treatAsArrayKey As Variant = "_taary", ignoreValueValue As Variant = Nil, plistDesc As String = "the plist")
		  // Created 1/13/2011 by Andrew Keller
		  
		  // Verifies that the given PropertyListKFS object has the given data.
		  
		  AssertNotIsNil p, "Cannot verify a Nil PropertyListKFS object."
		  AssertNotIsNil expectedData, "Cannot verify against expected data that is Nil."
		  
		  If expectedData.Lookup( treatAsArrayKey, False ) Then
		    
		    AssertTrue p.TreatAsArray, plistDesc+" is supposed to be an array."
		  Else
		    AssertFalse p.TreatAsArray, plistDesc+" is supposed to be a Dictionary."
		  End If
		  
		  Dim d As Dictionary = p
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  Dim extraKeys As New Dictionary
		  Dim ev, fv As Variant
		  
		  For Each k As Variant In d.Keys
		    extraKeys.Value( k ) = True
		  Next
		  
		  For Each k As Variant In expectedData.Keys
		    
		    If k <> treatAsArrayKey Then
		      If PresumeTrue( d.HasKey( k ), plistDesc+" is missing the key "+k.DescriptionKFS+"." ) Then
		        
		        extraKeys.Remove k
		        ev = expectedData.Value( k )
		        fv = d.Value( k )
		        
		        VerifyPListValue k, ev, fv, treatAsArrayKey, ignoreValueValue, plistDesc
		        
		      End If
		    End If
		  Next
		  
		  For Each k As Variant in extraKeys.Keys
		    AssertFailure plistDesc+" is not supposed to have the key "+k.DescriptionKFS+".", False
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifyPListValue(k As Variant, ev As Variant, fv As Variant, treatAsArrayKey As Variant = "_taary", ivv As Variant = Nil, plistDesc As String = "the plist")
		  // Created 1/16/2011 by Andrew Keller
		  
		  // Verifies that the given value in a PropertyListKFS object has an expected value.
		  
		  // Compare the object types:
		  
		  PushMessageStack "The value referenced by the key "+k.DescriptionKFS+" in "+plistDesc+" is supposed to be "
		  
		  If ev = ivv Then
		    
		    // ignore this value
		    
		  ElseIf ev.Type = Variant.TypeCFStringRef _
		    Or ev.Type = Variant.TypeCString _
		    Or ev.Type = Variant.TypePString _
		    Or ev.Type = Variant.TypeString _
		    Or ev.Type = Variant.TypeWString Then
		    
		    AssertTrue fv.Type = Variant.TypeCFStringRef _
		    Or fv.Type = Variant.TypeCString _
		    Or fv.Type = Variant.TypePString _
		    Or fv.Type = Variant.TypeString _
		    Or fv.Type = Variant.TypeWString, "a String (is " + fv.TypeDescriptionKFS + " instead).", False
		    
		  ElseIf ev.Type = Variant.TypeInteger _
		    Or ev.Type = Variant.TypeLong _
		    Or ev.Type = Variant.TypeSingle Then
		    
		    AssertTrue fv.Type = Variant.TypeInteger _
		    Or fv.Type = Variant.TypeLong _
		    Or fv.Type = Variant.TypeSingle, "an Integer (is " + fv.TypeDescriptionKFS + " instead).", False
		    
		  ElseIf ev IsA Dictionary Then
		    
		    AssertTrue fv IsA PropertyListKFS, "a PropertyListKFS object (is " + fv.TypeDescriptionKFS + " instead).", False
		    
		  Else
		    
		    AssertEquals ev.Type, fv.Type, ev.TypeDescriptionKFS + " (is " + fv.TypeDescriptionKFS + " instead).", False
		    
		  End If
		  
		  PopMessageStack
		  
		  // Compare the object values:
		  
		  If ev IsA MemoryBlock Then
		    AssertEquals_str ev, fv, "Key "+k.DescriptionKFS+" in "+plistDesc+" has an unexpected value.", False
		    
		  ElseIf ev IsA Date And fv IsA Date Then
		    AssertEquals_date ev, fv, "Key "+k.DescriptionKFS+" in "+plistDesc+" has an unexpected value.", False
		    
		  ElseIf ev IsA Dictionary And fv IsA PropertyListKFS Then
		    VerifyPListContents PropertyListKFS( fv ), Dictionary( ev ), treatAsArrayKey, ivv, "child "+k.DescriptionKFS+" of "+plistDesc
		    
		  Else
		    AssertEquals ev, fv, "Key "+k.DescriptionKFS+" in "+plistDesc+" has an unexpected value.", False
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, 2011 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a list of all contributors for this library.
		
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


	#tag Constant, Name = kApplePListFooter, Type = String, Dynamic = False, Default = \"</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kApplePListHeader, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kTheIliad, Type = String, Dynamic = False, Default = \"Sing\x2C O goddess\x2C the anger of Achilles son of Peleus\x2C that brought countless ills upon the Achaeans. Many a brave soul did it send hurrying down to Hades\x2C and many a hero did it yield a prey to dogs and vultures\x2C for so were the counsels of Jove fulfilled from the day on which the son of Atreus\x2C king of men\x2C and great Achilles\x2C first fell out with one another.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_array_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<array/>\n\t<array/>\n\t<array/>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_array_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<array/>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_bool_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<true/>\n\t<false/>\n\t<true/>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_bool_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<true/>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_data_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<data>Zm9v</data>\n\t<data>YmFy</data>\n\t<data>ZmlzaA\x3D\x3D</data>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_data_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<data>Zm9v</data>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_date_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<date>2010-01-01T09:10:11Z</date>\n\t<date>2010-01-01T10:11:12Z</date>\n\t<date>2010-01-01T11:12:13Z</date>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_date_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<date>2010-01-01T09:10:11Z</date>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_dict_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<dict/>\n\t<dict/>\n\t<dict/>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_dict_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<dict/>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_empty, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array/>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_int_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<integer>15</integer>\n\t<integer>16</integer>\n\t<integer>17</integer>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_int_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<integer>15</integer>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_multiple, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<date>2011-01-10T06:03:27Z</date>\n\t<data>SGVsbG8sIFdvcmxkIQ\x3D\x3D</data>\n\t<true/>\n\t<integer>15</integer>\n\t<real>15.4</real>\n\t<string>Hello\x2C World!</string>\n\t<dict>\n\t\t<key>foo</key>\n\t\t<string>bar</string>\n\t</dict>\n\t<array>\n\t\t<string>fishcat</string>\n\t</array>\n\t<dict>\n\t\t<key>dog</key>\n\t\t<string>13</string>\n\t</dict>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_real_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<real>15.4</real>\n\t<real>15.5</real>\n\t<real>15.6</real>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_real_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<real>15.4</real>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_string_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<string>foo</string>\n\t<string>bar</string>\n\t<string>fish</string>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_array_string_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<array>\n\t<string>foo</string>\n</array>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_bool_false, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<false/>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_bool_true, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<true/>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_data_big, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<data>U2luZywgTyBnb2RkZXNzLCB0aGUgYW5nZXIgb2YgQWNoaWxsZXMgc29uIG9mIFBlbGV1cywgdGhhdCBicm91Z2h0IGNvdW50bGVzcyBpbGxzIHVwb24gdGhlIEFjaGFlYW5zLiBNYW55IGEgYnJhdmUgc291bCBkaWQgaXQgc2VuZCBodXJyeWluZyBkb3duIHRvIEhhZGVzLCBhbmQgbWFueSBhIGhlcm8gZGlkIGl0IHlpZWxkIGEgcHJleSB0byBkb2dzIGFuZCB2dWx0dXJlcywgZm9yIHNvIHdlcmUgdGhlIGNvdW5zZWxzIG9mIEpvdmUgZnVsZmlsbGVkIGZyb20gdGhlIGRheSBvbiB3aGljaCB0aGUgc29uIG9mIEF0cmV1cywga2luZyBvZiBtZW4sIGFuZCBncmVhdCBBY2hpbGxlcywgZmlyc3QgZmVsbCBvdXQgd2l0aCBvbmUgYW5vdGhlci4\x3D</data>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_data_empty, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<data></data>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_data_small, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<data>SGVsbG8sIFdvcmxkIQ\x3D\x3D</data>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_date, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<date>2011-01-09T19:04:17Z</date>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_array_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<array/>\n\t<key>bar</key>\n\t<array/>\n\t<key>fish</key>\n\t<array/>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_array_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<array/>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_bool_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<true/>\n\t<key>bar</key>\n\t<false/>\n\t<key>fish</key>\n\t<true/>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_bool_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<true/>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_data_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<data>YmFy</data>\n\t<key>fish</key>\n\t<data>Y2F0</data>\n\t<key>bird</key>\n\t<data>ZG9n</data>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_data_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<data>YmFy</data>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_date_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<date>2010-01-01T09:10:11Z</date>\n\t<key>bar</key>\n\t<date>2010-01-01T10:11:12Z</date>\n\t<key>fish</key>\n\t<date>2010-01-01T11:12:13Z</date>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_date_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<date>2010-01-01T09:10:11Z</date>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_dict_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<dict/>\n\t<key>bar</key>\n\t<dict/>\n\t<key>fish</key>\n\t<dict/>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_dict_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<dict/>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_empty, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict/>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_int_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<integer>15</integer>\n\t<key>bar</key>\n\t<integer>16</integer>\n\t<key>fish</key>\n\t<integer>17</integer>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_int_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<integer>15</integer>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_multiple, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>tval</key>\n\t<date>2011-01-10T06:03:27Z</date>\n\t<key>mval</key>\n\t<data>SGVsbG8sIFdvcmxkIQ\x3D\x3D</data>\n\t<key>bval</key>\n\t<true/>\n\t<key>ival</key>\n\t<integer>15</integer>\n\t<key>dval</key>\n\t<real>15.4</real>\n\t<key>sval</key>\n\t<string>Hello\x2C World!</string>\n\t<key>c1</key>\n\t<dict>\n\t\t<key>foo</key>\n\t\t<string>bar</string>\n\t</dict>\n\t<key>c2</key>\n\t<array>\n\t\t<string>fishcat</string>\n\t</array>\n\t<key>c3</key>\n\t<dict>\n\t\t<key>dog</key>\n\t\t<string>13</string>\n\t</dict>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_real_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<real>15.4</real>\n\t<key>bar</key>\n\t<real>15.5</real>\n\t<key>fish</key>\n\t<real>15.6</real>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_real_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<real>15.4</real>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_string_m, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<string>bar</string>\n\t<key>fish</key>\n\t<string>cat</string>\n\t<key>bird</key>\n\t<string>dog</string>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_dict_string_s, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<dict>\n\t<key>foo</key>\n\t<string>bar</string>\n</dict>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_int, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<integer>15</integer>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_real, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<real>15.4</real>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_string_big, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<string>Sing\x2C O goddess\x2C the anger of Achilles son of Peleus\x2C that brought countless ills upon the Achaeans. Many a brave soul did it send hurrying down to Hades\x2C and many a hero did it yield a prey to dogs and vultures\x2C for so were the counsels of Jove fulfilled from the day on which the son of Atreus\x2C king of men\x2C and great Achilles\x2C first fell out with one another.</string>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_string_escape, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<string>&lt;Hello\x2C World!&gt;</string>\n</plist>\n", Scope = Public
	#tag EndConstant

	#tag Constant, Name = k_APList_string_small, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n<string>foo</string>\n</plist>\n", Scope = Public
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
