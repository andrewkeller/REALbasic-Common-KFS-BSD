#tag Class
Protected Class TestBigStringKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestAbstractFile_AbstractPath()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  AssertEquals kTestPath, s.AbstractFilePath
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_Addition()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    s = s + "Hello, World!"
		    
		    // That line should have failed.
		    
		    AssertFailure "BigStringKFS did not raise an IOException upon trying to add an abstract file to a String object."
		    
		  Catch err As IOException
		    
		    // exception worked correctly.
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeAbstractFile, s.LastErrorCode, "The Operator_Add function did not properly set the last error code."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_CanBeAccessed()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  AssertFalse s.StringDataCanBeAccessed
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_DataSourceSummary()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  AssertEquals kTestPath, s.GetDataSourceSummary
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_FolderitemAccess()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    AssertNil s.FolderitemValue, "GetFolderItemAccess should return Nil when dealing with an abstract file."
		    
		    // That line should have succeeded.
		    
		  Catch err As IOException
		    
		    AssertFailure "The GetFolderItemAccess function is not supposed to raise an IOException when the string data is an abstract file."
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeNone, s.LastErrorCode, "The GetFolderItemAccess function did not properly set the last error code."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_InvolvesAbstractFile()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  AssertTrue s.StringDataInvolvesAbstractFile
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_Length()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    Call s.Length
		    
		    // That line should have failed.
		    
		    AssertFailure "BigStringKFS did not raise an IOException upon trying to get the length of an abstract file."
		    
		  Catch err As IOException
		    
		    // exception worked correctly.
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeAbstractFile, s.LastErrorCode, "The Length property did not properly set the last error code."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_MemoryBlockValue()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    Call s.MemoryBlockValue
		    
		    // That line should have failed.
		    
		    AssertFailure "BigStringKFS did not raise an IOException upon trying to get the MemoryBlockValue of an abstract file."
		    
		  Catch err As IOException
		    
		    // exception worked correctly.
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeAbstractFile, s.LastErrorCode, "The MemoryBlockValue property did not properly set the last error code."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_Multiply()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    s = s * 4
		    
		    // That line should have failed.
		    
		    AssertFailure "BigStringKFS did not raise an IOException upon trying to multiply an abstract file."
		    
		  Catch err As IOException
		    
		    // exception worked correctly.
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeAbstractFile, s.LastErrorCode, "The Operator_Multiply function did not properly set the last error code."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_MultiplyRight()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    s = 4 * s
		    
		    // That line should have failed.
		    
		    AssertFailure "BigStringKFS did not raise an IOException upon trying to multiply an abstract file."
		    
		  Catch err As IOException
		    
		    // exception worked correctly.
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeAbstractFile, s.LastErrorCode, "The Operator_MultiplyRight function did not properly set the last error code."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_StreamAccess()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    Call s.GetStreamAccess
		    
		    // That line should have failed.
		    
		    AssertFailure "The GetStreamAccess function is supposed to raise an IOException when the string data is an abstract file."
		    
		  Catch err As IOException
		    
		    // exception worked correctly.
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeAbstractFile, s.LastErrorCode, "The GetStreamAccess function did not properly set the last error code."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAbstractFile_StringValue()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    Call s.StringValue
		    
		    // That line should have failed.
		    
		    AssertFailure "BigStringKFS did not raise an IOException upon trying to get the StringValue of an abstract file."
		    
		  Catch err As IOException
		    
		    // exception worked correctly.
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeAbstractFile, s.LastErrorCode, "The StringValue property did not properly set the last error code."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestClear()
		  // Created 7/8/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests the Clear method.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  AssertEquals kTestPath, s.AbstractFilePath, "The AbstractPath property did not inherit the given value."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using an abstract file as the data source."
		  AssertZero s.Length, "The Clear method did not make the length of the string zero after using an abstract file as the data source."
		  
		  s.StringValue = kTestString
		  s.FileTextEncoding = Encodings.ASCII
		  AssertEquals Len( kTestString ), s.Length, "The StringValue property did not set the data source to the given String object."
		  AssertEquals Encodings.ASCII, s.FileTextEncoding, "The FileTextEncoding property did not inherit the given value."
		  s.Clear
		  AssertNil s.FileTextEncoding, "The Clear method did not clear the FileTextEncoding property."
		  AssertZero s.Length, "The Clear method did not make the length of the string zero after using a String as the data source with the FileTextEncoding set."
		  
		  s.FolderitemValue = SpecialFolder.Desktop
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a FolderItem as the data source."
		  AssertZero s.Length, "The Clear method did not make the length of the string zero after using a FolderItem as the data source."
		  
		  s.MemoryBlockValue = kTestString
		  AssertEquals Len( kTestString ), s.Length, "The MemoryBlockValue property did not set the data source to the given MemoryBlock."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a MemoryBlock as the data source."
		  AssertZero s.Length, "The Clear method did not make the length of the string zero after using a MemoryBlock as the data source."
		  
		  s.StringValue = New BinaryStream( kTestString )
		  AssertEquals Len( kTestString ), s.Length, "The StringValue property did not set the data source to the given BinaryStream object."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a BinaryStream as the data source."
		  AssertZero s.Length, "The Clear method did not make the length of the string zero after using a BinaryStream as the data source."
		  
		  s.StringValue = kTestString
		  AssertEquals Len( kTestString ), s.Length, "The StringValue property did not set the data source to the given String object."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a String as the data source."
		  AssertZero s.Length, "The Clear method did not make the length of the string zero after using a String as the data source."
		  
		  s.StringValue = kTestString
		  AssertEquals Len( kTestString ), s.Length, "The StringValue property did not set the data source to the given String object."
		  s.ForceStringDataToDisk
		  Dim f As FolderItem = s.FolderitemValue
		  AssertNotNil f, "The FolderItemValue property did not return an expected FolderItem after forcing the string data to the disk."
		  AssertTrue f.Exists, "The FolderItemValue property did not return an expected FolderItem after forcing the string data to the disk."
		  AssertTrue s.StringDataInvolvesRealFile, "The StringDataInvolvesRealFile property appears to not know about the swap file."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a swap file as the data source."
		  AssertZero s.Length, "The Clear method did not make the length of the string zero after using a swap file as the data source."
		  AssertFalse f.Exists, "The Clear method did not delete the swap file after using a swap file for the data source."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConvertFromBinaryStream()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests initializing a BigStringKFS with a BinaryStream object.
		  
		  Dim testData As New BinaryStream( kTestString )
		  
		  Dim s1 As New BigStringKFS( testData )
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to initialize from a BinaryStream object."
		  
		  Dim s2 As BigStringKFS = testData
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to convert from a BinaryStream object."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConvertFromFile()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests initializing a BigStringKFS with a FolderItem.
		  
		  Dim testFile As FolderItem = AcquireSwapFile
		  
		  // Save our test string to the test file.
		  
		  Try
		    Dim bs As BinaryStream = BinaryStream.Create( testFile )
		    bs.Write kTestString
		    bs.Close
		  Catch
		    AssertFailure "Could not prepare a file that will be used for testing how the BigStringKFS class handles files."
		  End Try
		  
		  // Execute the tests.
		  
		  Dim s1 As New BigStringKFS( testFile )
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to initialize from a FolderItem."
		  
		  Dim s2 As BigStringKFS = testFile
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to convert from a FolderItem."
		  
		  // Release the test file.
		  
		  ReleaseSwapFile testFile
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConvertFromMemoryBlock()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests initializing a BigStringKFS with a MemoryBlock object.
		  
		  Dim testData As MemoryBlock = kTestString
		  
		  Dim s1 As New BigStringKFS( testData )
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to initialize from a MemoryBlock object."
		  
		  Dim s2 As BigStringKFS = testData
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to convert from a MemoryBlock object."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConvertFromString()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests initializing a BigStringKFS with a String object.
		  
		  Dim s1 As New BigStringKFS( kTestString )
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to initialize from a String object."
		  
		  Dim s2 As BigStringKFS = kTestString
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to convert from a String object."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFolderitemValue_Get()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure getting the FolderItemValue works correctly.
		  
		  Dim s As New BigStringKFS
		  AssertNil s.FolderitemValue, "The FolderItemValue of a new BigStringKFS should be Nil."
		  
		  s = "Hello, world!"
		  AssertNil s.FolderitemValue, "The FolderItemValue of a new BigStringKFS should be Nil."
		  
		  s.ForceStringDataToDisk
		  AssertNotNil s.FolderitemValue, "Either the ForceStringDataToDisk method doesn't work, or the FolderItemValue property doesn't work."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFolderitemValue_Set()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure setting the FolderItemValue works correctly.
		  
		  Dim testFile As FolderItem = AcquireSwapFile
		  Dim bs As BinaryStream = BinaryStream.Create( testFile )
		  AssertNotNil bs, "Could not open a BinaryStream to a swap file."
		  bs.Write kTestString
		  bs.Close
		  
		  Dim s As BigStringKFS = testFile
		  AssertNotNil s.FolderitemValue, "The BigStringKFS object did not acquire the given Folderitem."
		  AssertEquals kTestString, s.StringValue, "The BigStringKFS object did not acquire the data from the given Folderitem."
		  
		  ReleaseSwapFile testFile
		  
		  s = kTestString
		  s.ForceStringDataToDisk
		  s.FolderitemValue = s.FolderitemValue
		  AssertNotNil s.FolderitemValue, "Setting a BigStringKFS object equal to its own swap file makes the FolderitemValue Nil."
		  AssertEquals kTestString, s.StringValue, "Setting a BigStringKFS object equal to its own swap file should not change the string data."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestForceStringDataToDisk()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the ForceStringDataToDisk method works
		  
		  Dim s As BigStringKFS
		  
		  // Test with the source being a String
		  
		  s = kTestString
		  Try // Set the error code to non-zero
		    s.ModifyValue "hello, world"
		  Catch err As IOException
		  End Try
		  AssertNil s.FolderitemValue, kMsgSetupError
		  AssertEquals kTestString, s.StringValue, kMsgSetupError
		  s.ForceStringDataToDisk
		  AssertNotNil s.FolderitemValue, "The ForceStringDataToDisk method did not create a FolderItem when the source is a String."
		  AssertEquals kTestString, s.StringValue, "The ForceStringDataToDisk method did not preserve the string data when the source is a String."
		  AssertZero s.LastErrorCode, "The ForceStringDataToDisk method did not set the last error code to zero upon success."
		  
		  // Test with the source being an empty String
		  
		  s = New BinaryStream( "" )
		  Try // Set the error code to non-zero
		    s.ModifyValue "hello, world"
		  Catch err As IOException
		  End Try
		  AssertNil s.FolderitemValue, kMsgSetupError
		  AssertEquals "", s.StringValue, kMsgSetupError
		  s.ForceStringDataToDisk
		  AssertNotNil s.FolderitemValue, "The ForceStringDataToDisk method did not create a FolderItem when the source is an empty String."
		  AssertEquals "", s.StringValue, "The ForceStringDataToDisk method did not preserve the string data when the source is an empty String."
		  AssertZero s.LastErrorCode, "The ForceStringDataToDisk method did not set the last error code to zero upon success."
		  
		  // It is likely that the other souces of data will behave the same way.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestForceStringDataToDisk_Fail()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the ForceStringDataToDisk method works
		  
		  Dim s As BigStringKFS
		  
		  // Test with the source being a String
		  
		  s = New BigStringKFS
		  s.AbstractFilePath = kTestPath
		  AssertNil s.FolderitemValue, kMsgSetupError
		  Try
		    s.ForceStringDataToDisk
		    AssertFailure "The ForceStringDataToDisk method did not raise an exception upon failure."
		  Catch err As IOException
		  End Try
		  AssertNil s.FolderitemValue, "The ForceStringDataToDisk method created a Folderitem for an abstract file."
		  AssertEquals kTestPath, s.AbstractFilePath, "The ForceStringDataToDisk method did not retain its abstract path."
		  AssertNonZero s.LastErrorCode, "The ForceStringDataToDisk method did not set the last error code upon failure."
		  
		  // It is likely that the other souces of data will behave the same way.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestForceStringDataToMemory()
		  // Created 7/21/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the ForceStringDataToMemory method works
		  
		  Dim s As BigStringKFS
		  
		  // Test with the source being a FolderItem
		  
		  s = kTestString
		  s.ForceStringDataToDisk
		  
		  // Unfortunately, there is no way to set the error code to non-zero before
		  // running this test, so we'll just have to hope that the ForceStringDataToMemory
		  // method sets the error code to zero upon success.
		  
		  AssertNotNil s.FolderitemValue, "Unable to start with a FolderItem-backed String."
		  AssertEquals kTestString, s.StringValue, "The ForceStringDataToDisk method did not preserve the string data when the source is a String."
		  
		  s.ForceStringDataToMemory
		  
		  AssertNil s.FolderitemValue, "The ForceStringDataToMemory method did not clear the FolderItemValue."
		  AssertEquals kTestString, s.StringValue, "The ForceStringDataToMemory method did not preserve the string data when the source is a Folderitem."
		  AssertZero s.LastErrorCode, "Something cause the last error code to get set."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestForceStringDataToMemory_Fail()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the ForceStringDataToDisk method works
		  
		  Dim s As BigStringKFS
		  
		  // Test with the source being a String
		  
		  s = New BigStringKFS
		  s.AbstractFilePath = kTestPath
		  AssertNil s.FolderitemValue, kMsgSetupError
		  Try
		    s.ForceStringDataToMemory
		    AssertFailure "The ForceStringDataToMemory method did not raise an exception upon failure."
		  Catch err As IOException
		  End Try
		  AssertNil s.FolderitemValue, "The ForceStringDataToMemory method created a Folderitem for an abstract file."
		  AssertEquals kTestPath, s.AbstractFilePath, "The ForceStringDataToMemory method did not retain its abstract path."
		  AssertNonZero s.LastErrorCode, "The ForceStringDataToMemory method did not set the last error code upon failure."
		  
		  // It is likely that the other souces of data will behave the same way.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLastErrorCode_Clear()
		  // Created 7/10/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure all the methods and functions
		  // use the LastErrorCode property as expected.
		  
		  Dim s As New BigStringKFS
		  
		  // First, set the error code to non-zero:
		  
		  s.AbstractFilePath = kTestPath
		  Try
		    Call s.Length
		  Catch err As IOException
		  End Try
		  
		  // The error code of the BigStringKFS object is now non-zero.
		  
		  // Make sure the Clear method sets the last error code to zero.
		  
		  s.Clear
		  
		  AssertZero s.LastErrorCode, "The Clear method did not set the error code to zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLastErrorCode_Consolidate()
		  // Created 7/10/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure all the methods and functions
		  // use the LastErrorCode property as expected.
		  
		  Dim s As BigStringKFS
		  
		  // First, set the error code to non-zero:
		  
		  s = New BinaryStream( kTestString )
		  Try
		    s.ModifyValue( "foo bar" )
		    AssertFailure "Could not create a read-only data source."
		  Catch err As IOException
		  End Try
		  
		  // The error code of the BigStringKFS object is now non-zero.
		  
		  // Make sure the Consolidate method sets the last error code to zero.
		  
		  Try
		    
		    s.Consolidate
		    
		    AssertZero s.LastErrorCode, "The Consolidate method did not set the error code to zero."
		    
		  Catch err As IOException
		    
		    AssertFailure "The Consolidate method failed, which makes this test inconclusive, but the Consolidate method failing under these circumstances is in itself a big problem."
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLastErrorCode_Consolidate_Fail()
		  // Created 7/10/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure all the methods and functions
		  // use the LastErrorCode property as expected.
		  
		  Dim s As New BigStringKFS
		  
		  // The error code is already zero.
		  
		  s.AbstractFilePath = kTestPath
		  
		  // Make sure the Consolidate method sets the last error code in the event of an error.
		  
		  Try
		    
		    s.Consolidate
		    
		  Catch err As IOException
		  End Try
		  
		  AssertNonZero s.LastErrorCode, "The Consolidate method did not set the error code upon failure."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLastErrorCode_Folderitem()
		  // Created 7/10/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure all the methods and functions
		  // use the LastErrorCode property as expected.
		  
		  Dim s As BigStringKFS
		  
		  // First, set the error code to non-zero:
		  
		  s = New BinaryStream( kTestString )
		  Try
		    s.ModifyValue( "foo bar" )
		    AssertFailure "Could not create a read-only data source."
		  Catch err As IOException
		  End Try
		  
		  // The error code of the BigStringKFS object is now non-zero.
		  
		  // Make sure the FolderitemValue method doesn't touch the error code.
		  
		  Try
		    
		    AssertNil s.FolderitemValue, "The FolderitemValue property is supposed to be Nil for small strings."
		    AssertNonZero s.LastErrorCode, "Getting the FolderitemValue property is not supposed to set the error code to zero."
		    
		  Catch err As IOException
		    
		    AssertFailure "The FolderitemValue property is not supposed to throw an exception."
		    
		  End Try
		  
		  Try
		    
		    s.AbstractFilePath = kTestPath
		    AssertNil s.FolderitemValue, "The FolderItemValue property is supposed to be Nil for an abstract file."
		    AssertZero s.LastErrorCode, "Getting the FolderitemValue property is not supposed to set the error code to non-zero."
		    
		  Catch err As IOException
		    
		    AssertFailure "The FolderitemValue property is not supposed to throw an exception with abstract files."
		    
		  End Try
		  
		  Try
		    
		    s.FolderitemValue = New FolderItem
		    AssertNotNil s.FolderitemValue, "The BigStringKFS object did not inherit the given FolderItem."
		    AssertZero s.LastErrorCode, "Setting the FolderItemValue property is supposed to set the error code to zero."
		    
		  Catch err As IOException
		    
		    AssertFailure "Setting the FolderItemValue property should not throw an exception."
		    
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLastErrorCode_GetAbstractPath()
		  // Created 7/10/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure all the methods and functions
		  // use the LastErrorCode property as expected.
		  
		  Dim s As New BigStringKFS
		  
		  // First, set the error code to non-zero:
		  
		  s.AbstractFilePath = kTestPath
		  Try
		    Call s.Length
		  Catch err As IOException
		  End Try
		  
		  // The error code of the BigStringKFS object is now non-zero.
		  
		  // Make sure getting the AbstractFilePath does not change the last error code.
		  
		  Call s.AbstractFilePath
		  
		  AssertNonZero s.LastErrorCode, "Getting the value of the AbstractFilePath property is supposed to leave the LastErrorCode property alone."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLastErrorCode_SetAbstractPath()
		  // Created 7/10/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure all the methods and functions
		  // use the LastErrorCode property as expected.
		  
		  Dim s As New BigStringKFS
		  
		  // First, set the error code to non-zero:
		  
		  s.AbstractFilePath = kTestPath
		  Try
		    Call s.Length
		  Catch err As IOException
		  End Try
		  
		  // The error code of the BigStringKFS object is now non-zero.
		  
		  // Make sure setting the AbstractFilePath changes the last error code to zero.
		  
		  s.AbstractFilePath = "/foo/bar"
		  
		  AssertZero s.LastErrorCode, "Setting an abstract file path did not set the error code to zero."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewBigString()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure BigStringKFS.NewString works correctly.
		  
		  Dim s As BigStringKFS = BigStringKFS.NewString
		  
		  AssertEquals "", s.StringValue, "NewString did not return a blank string."
		  AssertNil s.FolderitemValue, "NewString should not be using a swap file."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewBigStringExpectingLargeContents()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure BigStringKFS.NewString works correctly.
		  
		  Dim s As BigStringKFS = BigStringKFS.NewStringExpectingLargeContents
		  
		  AssertEquals "", s.StringValue, "NewStringExpectingLargeContents did not return a blank string."
		  AssertNotNil s.FolderitemValue, "NewStringExpectingLargeContents should be using a swap file."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetToBinaryStream()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests setting a BigStringKFS object's data source to a BinaryStream.
		  
		  Dim testData As New BinaryStream( kTestString )
		  Dim s As New BigStringKFS
		  
		  s.StringValue = testData
		  AssertEquals kTestString, s.StringValue, "BigStringKFS was not able to set the data source to a BinaryStream."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetToFile()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests setting a BigStringKFS object's data source to a FolderItem.
		  
		  Dim testFile As FolderItem = AcquireSwapFile
		  
		  // Save our test string to the test file.
		  
		  Try
		    Dim bs As BinaryStream = BinaryStream.Create( testFile )
		    bs.Write kTestString
		    bs.Close
		  Catch
		    AssertFailure "Could not prepare a file that will be used for testing how the BigStringKFS class handles files."
		  End Try
		  
		  // Execute the tests.
		  
		  Dim s As New BigStringKFS
		  
		  s.StringValue = testFile
		  AssertEquals kTestString, s.StringValue, "BigStringKFS was not able to set the data source to a FolderItem."
		  
		  // Release the test file.
		  
		  ReleaseSwapFile testFile
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetToMemoryBlock()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests setting a BigStringKFS object's data source to a MemoryBlock.
		  
		  Dim testData As MemoryBlock = kTestString
		  Dim s As New BigStringKFS
		  
		  s.MemoryBlockValue = testData
		  AssertEquals testData, s.MemoryBlockValue, "BigStringKFS was not able to set the MemoryBlockValue property to a MemoryBlock."
		  AssertEquals kTestString, s.StringValue, "BigStringKFS was not able to retrieve the value of a MemoryBlock through the StringValue property."
		  
		  s = New BigStringKFS
		  
		  s.StringValue = testData
		  AssertNotEqual testData, s.MemoryBlockValue, "Something big changed...  Setting the StringValue to a MemoryBlock should have converted the MemoryBlock to a String in order to get into the BigStringKFS object.  The MemoryBlockValue property of the BigStringKFS object should not be the same as the original MemoryBlock object."
		  AssertEquals kTestString, s.StringValue, "BigStringKFS was not able to retrieve the value of a MemoryBlock through the StringValue property."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSetToString()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests setting a BigStringKFS object's data source to a String.
		  
		  Dim s As New BigStringKFS
		  
		  s.StringValue = kTestString
		  AssertEquals kTestString, s.StringValue, "BigStringKFS was not able to set the data source to a String object."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of its
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


	#tag Constant, Name = kMsgSetupError, Type = String, Dynamic = False, Default = \"Setup Error.", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kTestPath, Type = String, Dynamic = False, Default = \"/var/log/secure.log", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kTestString, Type = String, Dynamic = False, Default = \"Hello\x2C beautiful world!", Scope = Public
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
