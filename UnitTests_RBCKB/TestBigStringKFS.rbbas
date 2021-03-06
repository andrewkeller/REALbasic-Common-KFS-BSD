#tag Class
Protected Class TestBigStringKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h1
		Protected Sub AssertArrayEquals(expected() As String, found() As BigStringKFS, failureMessage As String = "", isTerminal As Boolean = True)
		  // Created 10/25/2010 by Andrew Keller
		  
		  // Makes sure the found array contains the same data as the expected array.
		  
		  Dim sExpected As String = "Array{_}: " + Join( expected, "_" )
		  Dim sFound As BigStringKFS = "Array{_}: " + BigStringKFS.Join( found, "_" )
		  
		  AssertEquals sExpected, sFound.StringValue, failureMessage, isTerminal
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GenerateString(storageLocation As BSStorageLocation, contents As String, nonZeroErrorCode As Boolean) As BigStringKFS
		  // Created 7/23/2010 by Andrew Keller
		  
		  // Returns a BigStringKFS object preset with the given data located at the given location.
		  
		  #pragma BreakOnExceptions Off
		  
		  Dim s As New BigStringKFS
		  
		  Select Case storageLocation
		  Case BSStorageLocation.ExternalAbstractFile
		    
		    s.AbstractFilePath = contents
		    
		    If nonZeroErrorCode Then
		      Try
		        s.ModifyValue "abc"
		      Catch err As IOException
		      End Try
		    End If
		    
		  Case BSStorageLocation.ExternalBinaryStream
		    
		    s.StringValue = New BinaryStream( contents )
		    
		    If nonZeroErrorCode Then
		      Try
		        s.ModifyValue "abc"
		      Catch err As IOException
		      End Try
		    End If
		    
		  Case BSStorageLocation.ExternalBinaryStream_RW
		    
		    Dim mb As MemoryBlock = contents
		    Dim bs As New BinaryStream( mb )
		    s.StringValue = bs
		    
		    If nonZeroErrorCode Then Raise New UnsupportedFormatException
		    
		  Case BSStorageLocation.ExternalFile
		    
		    Dim f As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		    Dim bs As BinaryStream = BinaryStream.Create( f, True )
		    bs.Write contents
		    bs.Close
		    s.FolderItemValue = f
		    
		    If nonZeroErrorCode Then Raise New UnsupportedFormatException
		    
		  Case BSStorageLocation.ExternalMemoryBlock
		    
		    s.MemoryBlockValue = contents
		    
		    If nonZeroErrorCode Then Raise New UnsupportedFormatException
		    
		  Case BSStorageLocation.ExternalString
		    
		    s.StringValue = contents
		    
		    If nonZeroErrorCode Then Raise New UnsupportedFormatException
		    
		  Case BSStorageLocation.InternalString
		    
		    s.StringValue = contents
		    s.ForceStringDataToDisk
		    s.ForceStringDataToMemory
		    
		    If nonZeroErrorCode Then Raise New UnsupportedFormatException
		    
		  Case BSStorageLocation.InternalSwapFile
		    
		    s.StringValue = contents
		    s.ForceStringDataToDisk
		    
		    If nonZeroErrorCode Then Raise New UnsupportedFormatException
		    
		  Else
		    
		    Raise New UnsupportedFormatException
		    
		  End Select
		  
		  Return s
		  
		  // done.
		  
		End Function
	#tag EndMethod

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
		    
		    #pragma BreakOnExceptions Off
		    
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
		Sub TestAbstractFile_FolderItemAccess()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    AssertIsNil s.FolderItemValue, "GetFolderItemAccess should return Nil when dealing with an abstract file."
		    
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
		Sub TestAbstractFile_LenB()
		  // Created 7/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Tests how the BigStringKFS class handles abstract files.
		  
		  Dim s As BigStringKFS = kTestString
		  
		  s.AbstractFilePath = kTestPath
		  
		  Try
		    
		    #pragma BreakOnExceptions Off
		    
		    Call s.LenB
		    
		    // That line should have failed.
		    
		    AssertFailure "BigStringKFS did not raise an IOException upon trying to get the length of an abstract file."
		    
		  Catch err As IOException
		    
		    // exception worked correctly.
		    
		  End Try
		  
		  // And the error code should be set correctly.
		  AssertEquals BigStringKFS.kErrCodeAbstractFile, s.LastErrorCode, "The LenB property did not properly set the last error code."
		  
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
		    
		    #pragma BreakOnExceptions Off
		    
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
		    
		    #pragma BreakOnExceptions Off
		    
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
		    
		    #pragma BreakOnExceptions Off
		    
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
		    
		    #pragma BreakOnExceptions Off
		    
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
		    
		    #pragma BreakOnExceptions Off
		    
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
		Sub TestAdditionMultiplication()
		  // Created 7/26/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the addition and multiplication operators work at the basic level.
		  
		  Dim s As BigStringKFS = kTestString
		  s = s + s
		  AssertEquals kTestString + kTestString, s.StringValue, "Addition doesn't work."
		  
		  s = kTestString
		  s = s + "foo"
		  AssertEquals kTestString + "foo", s.StringValue, "Right addition doesn't work."
		  
		  s = kTestString
		  s = "foo" + s
		  AssertEquals "foo" + kTestString, s.StringValue, "Left addition doesn't work."
		  
		  s = kTestString
		  s = s * 2
		  AssertEquals kTestString + kTestString, s.StringValue, "Multiplication doesn't work."
		  
		  s = kTestString
		  s = 2 * s
		  AssertEquals kTestString + kTestString, s.StringValue, "Backwards multiplication doesn't work."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestAscB()
		  // Created 9/4/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the AscB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The AscB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.AscB
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.AscB
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Dim expected As Integer = kTestString.AscB
		  Try
		    AssertEquals expected, s.AscB, "did not return the correct value when the source is an external BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, True )
		  Try
		    AssertEquals expected, s.AscB, "did not return the correct value when the source is an external BinaryStream with the error code set."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream with the error code set."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		  Try
		    AssertEquals expected, s.AscB, "did not return the correct value when the source is an external read/write BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external read/write BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		  Try
		    AssertEquals expected, s.AscB, "did not return the correct value when the source is an external file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external file."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		  Try
		    AssertEquals expected, s.AscB, "did not return the correct value when the source is an external MemoryBlock."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external MemoryBlock."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.AscB, "did not return the correct value when the source is an external String."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external String."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.AscB, "did not return the correct value when the source is an internal string buffer."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal string buffer."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		  Try
		    AssertEquals expected, s.AscB, "did not return the correct value when the source is an internal swap file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal swap file."
		  End Try
		  
		  PopMessageStack
		  
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
		  AssertZero s.LenB, "The Clear method did not make the length of the string zero after using an abstract file as the data source."
		  
		  s.StringValue = kTestString
		  s.FileTextEncoding = Encodings.ASCII
		  AssertEquals LenB( kTestString ), s.LenB, "The StringValue property did not set the data source to the given String object."
		  AssertEquals Encodings.ASCII, s.FileTextEncoding, "The FileTextEncoding property did not inherit the given value."
		  s.Clear
		  AssertIsNil s.FileTextEncoding, "The Clear method did not clear the FileTextEncoding property."
		  AssertZero s.LenB, "The Clear method did not make the length of the string zero after using a String as the data source with the FileTextEncoding set."
		  
		  s.FolderItemValue = SpecialFolder.Desktop
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a FolderItem as the data source."
		  AssertZero s.LenB, "The Clear method did not make the length of the string zero after using a FolderItem as the data source."
		  
		  s.MemoryBlockValue = kTestString
		  AssertEquals LenB( kTestString ), s.LenB, "The MemoryBlockValue property did not set the data source to the given MemoryBlock."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a MemoryBlock as the data source."
		  AssertZero s.LenB, "The Clear method did not make the length of the string zero after using a MemoryBlock as the data source."
		  
		  s.StringValue = New BinaryStream( kTestString )
		  AssertEquals LenB( kTestString ), s.LenB, "The StringValue property did not set the data source to the given BinaryStream object."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a BinaryStream as the data source."
		  AssertZero s.LenB, "The Clear method did not make the length of the string zero after using a BinaryStream as the data source."
		  
		  s.StringValue = kTestString
		  AssertEquals LenB( kTestString ), s.LenB, "The StringValue property did not set the data source to the given String object."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a String as the data source."
		  AssertZero s.LenB, "The Clear method did not make the length of the string zero after using a String as the data source."
		  
		  s.StringValue = kTestString
		  AssertEquals LenB( kTestString ), s.LenB, "The StringValue property did not set the data source to the given String object."
		  s.ForceStringDataToDisk
		  Dim f As New FolderItem( s.FolderItemValue )
		  AssertNotIsNil f, "The FolderItemValue property did not return an expected FolderItem after forcing the string data to the disk."
		  AssertTrue f.Exists, "The FolderItemValue property did not return an expected FolderItem after forcing the string data to the disk."
		  AssertTrue s.StringDataInvolvesRealFile, "The StringDataInvolvesRealFile property appears to not know about the swap file."
		  s.Clear
		  AssertEquals BigStringKFS.kDataSourceMemory, s.GetDataSourceSummary, "The Clear method did not make the data source memory after using a swap file as the data source."
		  AssertZero s.LenB, "The Clear method did not make the length of the string zero after using a swap file as the data source."
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
		  
		  Dim testFile As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		  
		  // Save our test string to the test file.
		  
		  Try
		    Dim bs As BinaryStream = BinaryStream.Create( testFile, True )
		    bs.Write kTestString
		    bs.Close
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    AssertFailure err, "Could not prepare a file that will be used for testing how the BigStringKFS class handles files."
		  End Try
		  
		  // Execute the tests.
		  
		  Dim s1 As New BigStringKFS( testFile )
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to initialize from a FolderItem."
		  
		  Dim s2 As BigStringKFS = testFile
		  AssertEquals kTestString, s1.StringValue, "BigStringKFS was not able to convert from a FolderItem."
		  
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
		Sub TestCountFieldsB()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the CountFieldsB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The CountFieldsB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.CountFieldsB
		    AssertFailure "failed to throw an exception when the data source was an abstract file (no arguments)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.CountFieldsB( " " )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.CountFieldsB( " ", "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (two arguments)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.CountFieldsB
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (no arguments)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.CountFieldsB( " " )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.CountFieldsB( " ", "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (no argumets)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  
		  AssertEquals kTestString.CountFieldsB( "" ), s.CountFieldsB( "" ), "did not return an expected value (1)."
		  
		  AssertEquals kTestString.CountFieldsB( " " ), s.CountFieldsB( " " ), "did not return an expected value (2)."
		  
		  AssertEquals kTestString.CountFieldsB( "beau" ), s.CountFieldsB( "beau" ), "did not return an expected value (3)."
		  
		  AssertEquals 5, s.CountFieldsB( " ", "o" ), "did not return an expected value (4)."
		  
		  AssertEquals 2, s.CountFieldsB( "utif", "beautiful" ), "did not return an expected value (5)."
		  
		  AssertEquals 3, s.CountFieldsB( "eau", "o, ", "o, be", "ul wo", "world", " " ), "Did not return an expected value (6)."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFolderItemValue_Get()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure getting the FolderItemValue works correctly.
		  
		  Dim s As New BigStringKFS
		  AssertIsNil s.FolderItemValue, "The FolderItemValue of a new BigStringKFS should be Nil."
		  
		  s = "Hello, world!"
		  AssertIsNil s.FolderItemValue, "The FolderItemValue of a new BigStringKFS should be Nil."
		  
		  s.ForceStringDataToDisk
		  AssertNotIsNil s.FolderItemValue, "Either the ForceStringDataToDisk method doesn't work, or the FolderItemValue property doesn't work."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFolderItemValue_Set()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure setting the FolderItemValue works correctly.
		  
		  Dim testFile As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		  Dim bs As BinaryStream = BinaryStream.Create( testFile, True )
		  AssertNotIsNil bs, "Could not open a BinaryStream to a swap file."
		  bs.Write kTestString
		  bs.Close
		  
		  Dim s As BigStringKFS = testFile
		  AssertNotIsNil s.FolderItemValue, "The BigStringKFS object did not acquire the given FolderItem."
		  AssertEquals kTestString, s.StringValue, "The BigStringKFS object did not acquire the data from the given FolderItem."
		  
		  s = kTestString
		  s.ForceStringDataToDisk
		  s.FolderItemValue = s.FolderItemValue
		  AssertNotIsNil s.FolderItemValue, "Setting a BigStringKFS object equal to its own swap file made the FolderItemValue Nil."
		  AssertEquals kTestString, s.StringValue, "Setting a BigStringKFS object equal to its own swap file should not change the string data."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestForceStringDataToDisk()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the ForceStringDataToDisk method works.
		  
		  Dim s As BigStringKFS
		  
		  // Test with the source being a String
		  
		  s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  s.ForceStringDataToDisk
		  AssertNotIsNil s.FolderItemValue, "The ForceStringDataToDisk method did not create a FolderItem when the source is a String."
		  AssertEquals kTestString, s.StringValue, "The ForceStringDataToDisk method did not preserve the string data when the source is a String."
		  
		  // Test with the source being an empty String
		  
		  s = GenerateString( BSStorageLocation.ExternalString, "", False )
		  s.ForceStringDataToDisk
		  AssertNotIsNil s.FolderItemValue, "The ForceStringDataToDisk method did not create a FolderItem when the source is an empty String."
		  AssertEquals "", s.StringValue, "The ForceStringDataToDisk method did not preserve the string data when the source is an empty String."
		  
		  // It is likely that the other souces of data will behave the same way.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestForceStringDataToDisk_Fail()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the ForceStringDataToDisk method works.
		  
		  Dim s As BigStringKFS
		  
		  // Test with the source being a String
		  
		  s = New BigStringKFS
		  s.AbstractFilePath = kTestPath
		  AssertIsNil s.FolderItemValue, kMsgSetupError
		  Try
		    #pragma BreakOnExceptions Off
		    s.ForceStringDataToDisk
		    AssertFailure "The ForceStringDataToDisk method did not raise an exception upon failure."
		  Catch err As IOException
		  End Try
		  AssertIsNil s.FolderItemValue, "The ForceStringDataToDisk method created a FolderItem for an abstract file."
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
		  
		  // Makes sure the ForceStringDataToMemory method works.
		  
		  Dim s As BigStringKFS
		  
		  // Test with the source being a FolderItem
		  
		  s = kTestString
		  s.ForceStringDataToDisk
		  
		  // Unfortunately, there is no way to set the error code to non-zero before
		  // running this test, so we'll just have to hope that the ForceStringDataToMemory
		  // method sets the error code to zero upon success.
		  
		  AssertNotIsNil s.FolderItemValue, "Unable to start with a FolderItem-backed String."
		  AssertEquals kTestString, s.StringValue, "The ForceStringDataToDisk method did not preserve the string data when the source is a String."
		  
		  s.ForceStringDataToMemory
		  
		  AssertIsNil s.FolderItemValue, "The ForceStringDataToMemory method did not clear the FolderItemValue."
		  AssertEquals kTestString, s.StringValue, "The ForceStringDataToMemory method did not preserve the string data when the source is a FolderItem."
		  AssertZero s.LastErrorCode, "Something cause the last error code to get set."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestForceStringDataToMemory_Fail()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the ForceStringDataToDisk method works.
		  
		  Dim s As BigStringKFS
		  
		  // Test with the source being a String
		  
		  s = New BigStringKFS
		  s.AbstractFilePath = kTestPath
		  AssertIsNil s.FolderItemValue, kMsgSetupError
		  Try
		    #pragma BreakOnExceptions Off
		    s.ForceStringDataToMemory
		    AssertFailure "The ForceStringDataToMemory method did not raise an exception upon failure."
		  Catch err As IOException
		  End Try
		  AssertIsNil s.FolderItemValue, "The ForceStringDataToMemory method created a FolderItem for an abstract file."
		  AssertEquals kTestPath, s.AbstractFilePath, "The ForceStringDataToMemory method did not retain its abstract path."
		  AssertNonZero s.LastErrorCode, "The ForceStringDataToMemory method did not set the last error code upon failure."
		  
		  // It is likely that the other souces of data will behave the same way.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGenerateString()
		  // Created 7/21/2010 by Andrew Keller
		  
		  // TestBigStringKFS test case.
		  
		  // Makes sure the GenerateString function works.
		  // Or, makes sure the BigStringKFS class can return what's expected.
		  
		  Dim s As BigStringKFS
		  Dim msg As String
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		    msg = "Verification of a BigStringKFS object backed with an abstract file and a zero error code failed."
		    AssertEquals kTestPath, s.AbstractFilePath, msg
		    AssertZero s.LastErrorCode, msg
		    AssertZero s.LastSystemErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an external abstract file and a last error code of zero."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		    msg = "Verification of a BigStringKFS object backed with an abstract file and a nonzero error code failed."
		    AssertEquals kTestPath, s.AbstractFilePath, msg
		    AssertNonZero s.LastErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an external abstract file and a last error code of > 0."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		    msg = "Verification of a BigStringKFS object backed with an external read-only BinaryStream and a zero error code failed."
		    AssertEmptyString s.AbstractFilePath, msg
		    AssertEquals kTestString, s.StringValue, msg
		    AssertZero s.LastErrorCode, msg
		    AssertZero s.LastSystemErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an external read-only BinaryStream and a last error code of zero."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, True )
		    msg = "Verification of a BigStringKFS object backed with an external read-only BinaryStream and a nonzero error code failed."
		    AssertEmptyString s.AbstractFilePath, msg
		    AssertEquals kTestString, s.StringValue, msg
		    AssertNonZero s.LastErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an external read-only BinaryStream and a last error code of > 0."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		    msg = "Verification of a BigStringKFS object backed with an external read/write BinaryStream and a zero error code failed."
		    AssertEmptyString s.AbstractFilePath, msg
		    AssertEquals kTestString, s.StringValue, msg
		    AssertZero s.LastErrorCode, msg
		    AssertZero s.LastSystemErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with a read/write external BinaryStream and a last error code of zero."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, True )
		    AssertFailure "The GenerateString function is not currently able to create a BigStringKFS object with a read/write external BinaryStream and a last error code of > 0."
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		    msg = "Verification of a BigStringKFS object backed with an external file and a zero error code failed."
		    AssertEmptyString s.AbstractFilePath, msg
		    AssertEquals kTestString, s.StringValue, msg
		    AssertZero s.LastErrorCode, msg
		    AssertZero s.LastSystemErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an external file and a last error code of zero."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalFile, kTestString, True )
		    AssertFailure "The GenerateString function is not currently able to create a BigStringKFS object backed with an external file and a last error code of > 0."
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		    msg = "Verification of a BigStringKFS object backed with an external MemoryBlock and a zero error code failed."
		    AssertEmptyString s.AbstractFilePath, msg
		    AssertEquals kTestString, s.StringValue, msg
		    AssertZero s.LastErrorCode, msg
		    AssertZero s.LastSystemErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an external MemoryBlock and a last error code of zero."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, True )
		    AssertFailure "The GenerateString function is not currently able to create a BigStringKFS object backed with an external MemoryBlock and a last error code of > 0."
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		    msg = "Verification of a BigStringKFS object backed with an external String and a zero error code failed."
		    AssertEmptyString s.AbstractFilePath, msg
		    AssertEquals kTestString, s.StringValue, msg
		    AssertZero s.LastErrorCode, msg
		    AssertZero s.LastSystemErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an external String object and a last error code of zero."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.ExternalString, kTestString, True )
		    AssertFailure "The GenerateString function is not currently able to create a BigStringKFS object backed with an external String object and a last error code of > 0."
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		    msg = "Verification of a BigStringKFS object backed with an internal string and a zero error code failed."
		    AssertEmptyString s.AbstractFilePath, msg
		    AssertEquals kTestString, s.StringValue, msg
		    AssertZero s.LastErrorCode, msg
		    AssertZero s.LastSystemErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an internal string and a last error code of zero."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.InternalString, kTestString, True )
		    AssertFailure "The GenerateString function is not currently able to create a BigStringKFS object backed with an internal String object and a last error code of > 0."
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		    msg = "Verification of a BigStringKFS object backed with an internal swap file and a zero error code failed."
		    AssertEmptyString s.AbstractFilePath, msg
		    AssertEquals kTestString, s.StringValue, msg
		    AssertZero s.LastErrorCode, msg
		    AssertZero s.LastSystemErrorCode, msg
		  Catch err As UnsupportedFormatException
		    AssertFailure "The GenerateString function should have been able to create a BigStringKFS object with an internal swap file and a last error code of zero."
		  End Try
		  
		  Try
		    s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, True )
		    AssertFailure "The GenerateString function is not currently able to create a BigStringKFS object backed with an internal swap file and a last error code of > 0."
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetStreamAccess()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the GetStreamAccess method works.
		  
		  Dim s As BigStringKFS = kTestString
		  Dim bs As BinaryStream
		  
		  s.AbstractFilePath = kTestPath
		  AssertEquals kTestPath, s.AbstractFilePath, "This BigStringKFS object did not inherit the given abstract file path."
		  AssertFalse s.StringDataCanBeAccessed, "This BigStringKFS object seems to thing that an abstract file is readable."
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.GetStreamAccess
		    AssertFailure "The GetStreamAccess function did not throw an exception when the source is an abstract file."
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		  s.StringValue = kTestString
		  AssertTrue s.StringDataCanBeAccessed, "This BigStringKFS object doesn't seem to think that a String is readable."
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a String."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a String."
		  Call bs.Read( 10 )
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a String."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a String."
		  AssertEquals kTestString, bs.Read( LenB( kTestString ) ), "The stream returned by the GetStreamAccess function did not contain the original String data."
		  
		  s.StringValue = kTestString
		  s.ForceStringDataToDisk
		  AssertNotIsNil s.FolderItemValue, "The FolderItemValue property did not return an expected FolderItem after forcing the string data to the disk."
		  AssertTrue s.StringDataCanBeAccessed, "This BigStringKFS object doesn't seem to think that a swap file is readable."
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a swap file."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a swap file."
		  Call bs.Read( 10 )
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a swap file."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a swap file."
		  AssertEquals kTestString, bs.Read( LenB( kTestString ) ), "The stream returned by the GetStreamAccess function did not contain the original swap file data."
		  
		  s.StringValue = kTestString
		  s.ForceStringDataToDisk
		  s.ForceStringDataToMemory
		  AssertTrue s.StringDataCanBeAccessed, "This BigStringKFS object doesn't seem to think that an internal string is readable."
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was an internal string."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was an internal string."
		  Call bs.Read( 10 )
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was an internal string."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was an internal string."
		  AssertEquals kTestString, bs.Read( LenB( kTestString ) ), "The stream returned by the GetStreamAccess function did not contain the original internal string data."
		  
		  Dim f As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		  bs = BinaryStream.Create( f, True )
		  bs.Write kTestString
		  bs.Close
		  s.FolderItemValue = f
		  AssertTrue s.StringDataCanBeAccessed, "This BigStringKFS object doesn't seem to think that a FolderItem is readable."
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a FolderItem."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a FolderItem."
		  Call bs.Read( 10 )
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a FolderItem."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a FolderItem."
		  AssertEquals kTestString, bs.Read( LenB( kTestString ) ), "The stream returned by the GetStreamAccess function did not contain the original FolderItem data."
		  
		  s.MemoryBlockValue = kTestString
		  AssertTrue s.StringDataCanBeAccessed, "This BigStringKFS object doesn't seem to think that a MemoryBlock is readable."
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a MemoryBlock."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a MemoryBlock."
		  Call bs.Read( 10 )
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a MemoryBlock."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a MemoryBlock."
		  AssertEquals kTestString, bs.Read( LenB( kTestString ) ), "The stream returned by the GetStreamAccess function did not contain the original MemoryBlock data."
		  
		  s.StringValue = New BinaryStream( kTestString )
		  AssertTrue s.StringDataCanBeAccessed, "This BigStringKFS object doesn't seem to think that a BinaryStream is readable."
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a BinaryStream."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a BinaryStream."
		  Call bs.Read( 10 )
		  bs = s.GetStreamAccess
		  AssertNotIsNil bs, "The GetStreamAccess function returned a Nil stream when the source was a BinaryStream."
		  AssertZero bs.Position, "The GetStreamAccess function returned a stream with a position > 0 when the source was a BinaryStream."
		  AssertEquals kTestString, bs.Read( LenB( kTestString ) ), "The stream returned by the GetStreamAccess function did not contain the original BinaryStream data."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGetStreamAccess_ReadWrite()
		  // Created 7/19/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the GetStreamAccess( True ) method works.
		  
		  // Since GetStreamAccess( True ) is what is used in the
		  // ModifyValue function, this test case will only test that
		  // exceptions are thrown at the correct times.  The test
		  // for the ModifyValue method will make sure data can
		  // actually be written.
		  
		  Dim s As BigStringKFS = kTestString
		  Dim bs As BinaryStream
		  
		  s.AbstractFilePath = kTestPath
		  AssertEquals kTestPath, s.AbstractFilePath, "This BigStringKFS object did not inherit the given abstract file path."
		  AssertFalse s.StringDataIsModifiable, "This BigStringKFS object seems to think that an abstract file can be written to."
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.GetStreamAccess( True )
		    AssertFailure "The GetStreamAccess(True) function did not throw an exception when the source is an abstract file."
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		  s.StringValue = kTestString
		  AssertTrue s.StringDataIsModifiable, "This BigStringKFS object doesn't seem to think that a String object can be written to."
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a String object."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a String object."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a String object."
		  Call bs.Read( 10 )
		  Try
		    bs = Nil
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a String object."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a String object."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a String object."
		  
		  s.StringValue = kTestString
		  s.ForceStringDataToDisk
		  AssertNotIsNil s.FolderItemValue, "The FolderItemValue property did not return an expected FolderItem after forcing the string data to the disk."
		  AssertTrue s.StringDataIsModifiable, "This BigStringKFS object doesn't seem to think that a swap file can be written to."
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a swap file."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a swap file."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a swap file."
		  Call bs.Read( 10 )
		  Try
		    bs = Nil
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a swap file."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a swap file."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a swap file."
		  
		  s.StringValue = kTestString
		  s.ForceStringDataToDisk
		  s.ForceStringDataToMemory
		  AssertIsNil s.FolderItemValue, "The FolderItemValue property did not return a Nil FolderItem after forcing the string data to memory."
		  AssertTrue s.StringDataIsModifiable, "This BigStringKFS object doesn't seem to think that an internal string can be written to."
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was an internal string."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was an internal string."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was an internal string."
		  Call bs.Read( 10 )
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was an internal string."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was an internal string."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was an internal string."
		  
		  Dim f As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		  bs = BinaryStream.Create( f, True )
		  bs.Write kTestString
		  bs.Close
		  s.FolderItemValue = f
		  AssertTrue s.StringDataIsModifiable, "This BigStringKFS object doesn't seem to think that a FolderItem can be written to."
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a FolderItem."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a FolderItem."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a FolderItem."
		  Call bs.Read( 10 )
		  Try
		    bs = Nil
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a FolderItem."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a FolderItem."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a FolderItem."
		  
		  s.MemoryBlockValue = kTestString
		  AssertTrue s.StringDataIsModifiable, "This BigStringKFS object doesn't seem to think that a MemoryBlock can be written to."
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a MemoryBlock."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a MemoryBlock."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a MemoryBlock."
		  Call bs.Read( 10 )
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a MemoryBlock."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a MemoryBlock."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a MemoryBlock."
		  
		  s.StringValue = New BinaryStream( kTestString )
		  AssertTrue s.StringDataIsModifiable, "This BigStringKFS object doesn't seem to think that a BinaryStream can be written to."
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a BinaryStream."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a BinaryStream."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a BinaryStream."
		  Call bs.Read( 10 )
		  Try
		    bs = s.GetStreamAccess( True )
		  Catch err As IOException
		    AssertFailure "The GetStreamAccess(True) function raised an IOException when the source was a BinaryStream."
		  End Try
		  AssertNotIsNil bs, "The GetStreamAccess(True) function returned a Nil stream when the source was a BinaryStream."
		  AssertZero bs.Position, "The GetStreamAccess(True) function returned a stream with position > 0 when the source was a BinaryStream."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_bs_i_s1()
		  // Created 9/13/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the InStrB method works correctly.
		  
		  Dim s As BigStringKFS
		  Dim m As BigStringKFS
		  PushMessageStack "The InStrB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( m, 4 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( m, 4, "" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the empty optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( m, 4, "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( m, 4, "foo", "bar" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with multiple substrings)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( m, 4 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( m, 4, "" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with the empty optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( m, 4, "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( m, 4, "foo", "bar" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with multiple substrings)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Try
		    AssertEquals kTestString.InStrB( 0, "orl" ), s.InStrB( m, 0, "orl" ), "did not return the correct value when the source is an external BinaryStream (1)."
		    AssertEquals "orl", m.StringValue, "did not return the correct substring object (1)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (1)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 5, "orl" ), s.InStrB( m, 5, "orl" ), "did not return the correct value when the source is an external BinaryStream (2)."
		    AssertEquals "orl", m.StringValue, "did not return the correct substring object (2)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (2)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 20, "orl" ), s.InStrB( m, 20, "orl" ), "did not return zero when the substring didn't exist (3)."
		    AssertSame Nil, m, "did not return the correct substring object (3)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (3)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 4, "foo" ), s.InStrB( m, 4, "foo" ), "did not return zero when the substring didn't exist (4)."
		    AssertSame Nil, m, "did not return the correct substring object (4)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (4)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 0, "beau" ), s.InStrB( m, 0, "beautiful", "aut" ), "did not return the correct value when dealing with multiple substrings (5)."
		    AssertEquals "beautiful", m.StringValue, "did not return the correct substring object (5)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (5)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 0, "aut" ), s.InStrB( m, 0, "aut", "beautiful" ), "did not return the correct value when dealing with multiple substrings (6)."
		    AssertEquals "aut", m.StringValue, "did not return the correct substring index (6)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (6)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 0, "aut" ), s.InStrB( m, 0, "beautifully", "aut" ), "did not return the correct value when dealing with multiple substrings (7)."
		    AssertEquals "aut", m.StringValue, "did not return the correct substring index (7)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (7)."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_i_i_s()
		  // Created 9/8/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the InStrB method works correctly.
		  
		  Dim s As BigStringKFS
		  Dim i As Integer
		  PushMessageStack "The InStrB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( i, 4 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( i, 4, "" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the empty optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( i, 4, "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( i, 4, "foo", "bar" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with multiple substrings)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( i, 4 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( i, 4, "" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with the empty optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( i, 4, "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( i, 4, "foo", "bar" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with multiple substrings)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Try
		    AssertEquals kTestString.InStrB( 0, "orl" ), s.InStrB( i, 0, "orl" ), "did not return the correct value when the source is an external BinaryStream (1)."
		    AssertEquals 0, i, "did not return the correct substring index (1)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (1)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 5, "orl" ), s.InStrB( i, 5, "orl" ), "did not return the correct value when the source is an external BinaryStream (2)."
		    AssertEquals 0, i, "did not return the correct substring index (2)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (2)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 20, "orl" ), s.InStrB( i, 20, "orl" ), "did not return zero when the substring didn't exist (3)."
		    AssertEquals -1, i, "did not return the correct substring index (3)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (3)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 4, "foo" ), s.InStrB( i, 4, "foo" ), "did not return zero when the substring didn't exist (4)."
		    AssertEquals -1, i, "did not return the correct substring index (4)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (4)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 0, "beau" ), s.InStrB( i, 0, "beautiful", "aut" ), "did not return the correct value when dealing with multiple substrings (5)."
		    AssertEquals 0, i, "did not return the correct substring index (5)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (5)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 0, "aut" ), s.InStrB( i, 0, "aut", "beautiful" ), "did not return the correct value when dealing with multiple substrings (6)."
		    AssertEquals 0, i, "did not return the correct substring index (6)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (6)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 0, "aut" ), s.InStrB( i, 0, "beautifully", "aut" ), "did not return the correct value when dealing with multiple substrings (7)."
		    AssertEquals 1, i, "did not return the correct substring index (7)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (7)."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_i_s()
		  // Created 9/8/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the InStrB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The InStrB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( 4 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( 4, "" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the empty optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( 4, "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( 4, "foo", "bar" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with multiple substrings)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( 4 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( 4, "" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with the empty optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( 4, "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( 4, "foo", "bar" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with multiple substrings)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Try
		    AssertEquals kTestString.InStrB( 0, "orl" ), s.InStrB( 0, "orl" ), "did not return the correct value when the source is an external BinaryStream (1)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (1)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 5, "orl" ), s.InStrB( 5, "orl" ), "did not return the correct value when the source is an external BinaryStream (2)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (2)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 20, "orl" ), s.InStrB( 20, "orl" ), "did not return zero when the substring didn't exist (3)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (3)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 4, "foo" ), s.InStrB( 4, "foo" ), "did not return zero when the substring didn't exist (4)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (4)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( 0, "beau" ), s.InStrB( 0, "beautiful", "aut" ), "did not return the correct value when dealing with multiple substrings (5)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (5)."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_s()
		  // Created 9/8/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the InStrB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The InStrB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( "" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the empty optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( "foo", "bar" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with multiple substrings)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( "" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with the empty optimization)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.InStrB( "foo", "bar" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (with multiple substrings)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Try
		    AssertEquals kTestString.InStrB( "orl" ), s.InStrB( "orl" ), "did not return the correct value when the source is an external BinaryStream (1)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (1)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( "foo" ), s.InStrB( "foo" ), "did not return zero when the substring didn't exist (2)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (2)."
		  End Try
		  
		  Try
		    AssertEquals kTestString.InStrB( "beau" ), s.InStrB( "beautiful", "aut" ), "did not return the correct value when dealing with multiple substrings (3)."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream (3)."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestJoin()
		  // Created 10/25/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the Join method works correctly.
		  
		  Dim s() As BigStringKFS
		  PushMessageStack "The Join method "
		  PushMessageStack "failed to throw an exception when the data source was "
		  
		  s.Append GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call BigStringKFS.Join( s )
		    AssertFailure "an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call BigStringKFS.Join( s, " " )
		    AssertFailure "an abstract file (2)."
		  Catch e As IOException
		  End Try
		  
		  s(0) = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call BigStringKFS.Join( s )
		    AssertFailure "an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call BigStringKFS.Join( s, " " )
		    AssertFailure "an abstract file with the error code set (2)."
		  Catch e As IOException
		  End Try
		  
		  s(0) = "Hello, World!"
		  s.Append GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call BigStringKFS.Join( s )
		    AssertFailure "a real file, and an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call BigStringKFS.Join( s, " " )
		    AssertFailure "a real file, and an abstract file (2)."
		  Catch e As IOException
		  End Try
		  
		  PopMessageStack
		  PushMessageStack "did not return an expected value "
		  
		  s(0) = "Hello,"
		  s(1) = "beautiful"
		  s.Append "world!"
		  
		  AssertEquals "Hello,beautifulworld!", BigStringKFS.Join( s ).StringValue, "when provided with no delimiter."
		  
		  AssertEquals "Hello,beautifulworld!", BigStringKFS.Join( s, Nil ).StringValue, "when provided with a Nil delimiter."
		  
		  AssertEquals "Hello,beautifulworld!", BigStringKFS.Join( s, "" ).StringValue, "when provided with an empty string as a delimiter."
		  
		  AssertEquals "Hello, beautiful world!", BigStringKFS.Join( s, " " ).StringValue, "when provided with a non-empty string as a delimiter."
		  
		  PopMessageStack
		  
		  Dim d As BigStringKFS = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call BigStringKFS.Join( s, d )
		    AssertFailure "failed to throw an exception when the delimiter was an abstract file."
		  Catch e As IOException
		  End Try
		  
		  PopMessageStack
		  
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
		    #pragma BreakOnExceptions Off
		    Call s.LenB
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
		    #pragma BreakOnExceptions Off
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
		    
		    #pragma BreakOnExceptions Off
		    s.Consolidate
		    
		  Catch err As IOException
		  End Try
		  
		  AssertNonZero s.LastErrorCode, "The Consolidate method did not set the error code upon failure."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLastErrorCode_FolderItem()
		  // Created 7/10/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure all the methods and functions
		  // use the LastErrorCode property as expected.
		  
		  Dim s As BigStringKFS
		  
		  // First, set the error code to non-zero:
		  
		  s = New BinaryStream( kTestString )
		  Try
		    #pragma BreakOnExceptions Off
		    s.ModifyValue( "foo bar" )
		    AssertFailure "Could not create a read-only data source."
		  Catch err As IOException
		  End Try
		  
		  // The error code of the BigStringKFS object is now non-zero.
		  
		  // Make sure the FolderItemValue method doesn't touch the error code.
		  
		  Try
		    
		    AssertIsNil s.FolderItemValue, "The FolderItemValue property is supposed to be Nil for small strings."
		    AssertNonZero s.LastErrorCode, "Getting the FolderItemValue property is not supposed to set the error code to zero."
		    
		  Catch err As IOException
		    
		    AssertFailure "The FolderItemValue property is not supposed to throw an exception."
		    
		  End Try
		  
		  Try
		    
		    s.AbstractFilePath = kTestPath
		    AssertIsNil s.FolderItemValue, "The FolderItemValue property is supposed to be Nil for an abstract file."
		    AssertZero s.LastErrorCode, "Getting the FolderItemValue property is not supposed to set the error code to non-zero."
		    
		  Catch err As IOException
		    
		    AssertFailure "The FolderItemValue property is not supposed to throw an exception with abstract files."
		    
		  End Try
		  
		  Try
		    
		    s.FolderItemValue = New FolderItem
		    AssertNotIsNil s.FolderItemValue, "The BigStringKFS object did not inherit the given FolderItem."
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
		    #pragma BreakOnExceptions Off
		    Call s.LenB
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
		    #pragma BreakOnExceptions Off
		    Call s.LenB
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
		Sub TestLeftB()
		  // Created 9/4/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the LeftB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The LeftB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.LeftB( 5 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.LeftB( 0 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.LeftB( 5 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Dim expected As String = kTestString.LeftB( 5 )
		  Try
		    AssertEquals expected, s.LeftB( 5 ).StringValue, "did not return the correct data when the source is an external BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, True )
		  Try
		    AssertEquals expected, s.LeftB( 5 ).StringValue, "did not return the correct data when the source is an external BinaryStream with the error code set."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream with the error code set."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		  Try
		    AssertEquals expected, s.LeftB( 5 ).StringValue, "did not return the correct data when the source is an external read/write BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external read/write BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		  Try
		    AssertEquals expected, s.LeftB( 5 ).StringValue, "did not return the correct data when the source is an external file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external file."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		  Try
		    AssertEquals expected, s.LeftB( 5 ).StringValue, "did not return the correct data when the source is an external MemoryBlock."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external MemoryBlock."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.LeftB( 5 ).StringValue, "did not return the correct data when the source is an external String."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external String."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.LeftB( 5 ).StringValue, "did not return the correct data when the source is an internal string buffer."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal string buffer."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		  Try
		    AssertEquals expected, s.LeftB( 5 ).StringValue, "did not return the correct data when the source is an internal swap file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal swap file."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLenB()
		  // Created 7/23/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the LenB property works correctly.
		  
		  Dim s As New BigStringKFS
		  
		  s.AbstractFilePath = kTestPath
		  AssertNotIsNil s, "WTF???"
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.LenB
		    AssertFailure "Trying to get the length of an abstract file should raise an exception."
		  Catch err As IOException
		  End Try
		  
		  s = kTestString
		  AssertNotIsNil s, "WTF???"
		  AssertEquals LenB( kTestString ), s.LenB, "The LenB property did not return the correct length of a String."
		  
		  s.ForceStringDataToDisk
		  AssertEquals LenB( kTestString ), s.LenB, "The LenB property did not return the correct length of a swap file."
		  
		  s.ForceStringDataToMemory
		  AssertEquals LenB( kTestString ), s.LenB, "The LenB property did not return the correct length of an internal string."
		  
		  s.MemoryBlockValue = kTestString
		  AssertNotIsNil s, "WTF???"
		  AssertEquals LenB( kTestString ), s.LenB, "The LenB property did not return the correct length of a MemoryBlock."
		  
		  Dim f As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		  Dim bs As BinaryStream = BinaryStream.Create( f, True )
		  bs.Write kTestString
		  bs.Close
		  s = f
		  AssertNotIsNil s, "WTF???"
		  AssertEquals LenB( kTestString ), s.LenB, "The LenB property did not return the correct length of an external file."
		  
		  s = New BinaryStream( kTestString )
		  AssertNotIsNil s, "WTF???"
		  AssertEquals LenB( kTestString ), s.LenB, "The LenB property did not return the correct length of a binary stream."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestLTrim()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the LTrim method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The LTrim method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.LTrim
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.LTrim
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  AssertEquals LTrim(s), s.LTrim.StringValue, "did not return the same string when nothing could be trimmed."
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, "    "+kTestString, False )
		  AssertEquals LTrim(s), s.LTrim.StringValue, "did not return the expected result."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMemoryBlockValue_Get()
		  // Created 7/23/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure getting the MemoryBlockValue property works correctly.
		  
		  Dim s As New BigStringKFS
		  Dim ilen As Integer = Len( kTestString )
		  
		  s.AbstractFilePath = kTestPath
		  AssertNotIsNil s, "WTF???"
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.MemoryBlockValue
		    AssertFailure "Trying to get the MemoryBlockValue of an abstract file should raise an exception."
		  Catch err As IOException
		  End Try
		  
		  s = kTestString
		  AssertNotIsNil s, "WTF???"
		  AssertNotIsNil s.MemoryBlockValue, "The MemoryBlockValue property shouldn't return Nil when the ource is a String."
		  AssertEquals kTestString, s.MemoryBlockValue.StringValue(0,ilen), "The MemoryBlockValue property didn't return the correct data when the source is a String."
		  
		  s.ForceStringDataToDisk
		  AssertNotIsNil s.MemoryBlockValue, "The MemoryBlockValue property shouldn't return Nil when the ource is a swap file."
		  AssertEquals kTestString, s.MemoryBlockValue.StringValue(0,ilen), "The MemoryBlockValue property didn't return the correct data when the source is a swap file."
		  
		  s.ForceStringDataToMemory
		  AssertNotIsNil s.MemoryBlockValue, "The MemoryBlockValue property shouldn't return Nil when the ource is an internal string."
		  AssertEquals kTestString, s.MemoryBlockValue.StringValue(0,ilen), "The MemoryBlockValue property didn't return the correct data when the source is an internal string."
		  
		  Dim sm As MemoryBlock = kTestString
		  s.MemoryBlockValue = sm
		  AssertNotIsNil s, "WTF???"
		  AssertNotIsNil s.MemoryBlockValue, "The MemoryBlockValue property shouldn't return Nil when the ource is a MemoryBlock."
		  AssertEquals sm, s.MemoryBlockValue, "The MemoryBlockValue property didn't return the correct data when the source is a MemoryBlock."
		  
		  Dim f As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		  Dim bs As BinaryStream = BinaryStream.Create( f, True )
		  bs.Write kTestString
		  bs.Close
		  s = f
		  AssertNotIsNil s, "WTF???"
		  AssertNotIsNil s.MemoryBlockValue, "The MemoryBlockValue property shouldn't return Nil when the ource is a FolderItem."
		  AssertEquals kTestString, s.MemoryBlockValue.StringValue(0,ilen), "The MemoryBlockValue property didn't return the correct data when the source is a FolderItem."
		  
		  s = New BinaryStream( kTestString )
		  AssertNotIsNil s, "WTF???"
		  AssertNotIsNil s.MemoryBlockValue, "The MemoryBlockValue property shouldn't return Nil when the ource is a BinaryStream."
		  AssertEquals kTestString, s.MemoryBlockValue.StringValue(0,ilen), "The MemoryBlockValue property didn't return the correct data when the source is a BinaryStream."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMemoryBlockValue_Set()
		  // Created 7/23/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure setting the MemoryBlockValue property works correctly.
		  
		  Dim s As New BigStringKFS
		  Dim sm As MemoryBlock = kTestString
		  
		  s.MemoryBlockValue = sm
		  AssertNotIsNil s, "WTF???"
		  AssertNotIsNil s.MemoryBlockValue, "The MemoryBlockValue property shouldn't return Nil when the ource is a MemoryBlock."
		  AssertEquals sm, s.MemoryBlockValue, "The MemoryBlockValue property didn't return the correct data when the source is a MemoryBlock."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMidB_endchar()
		  // Created 10/3/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the MidB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The MidB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Try
		    AssertEquals kTestString.MidB( kTestString.Len -1 ), s.MidB( kTestString.Len -1 ).StringValue, "was not able to return the last two characters."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when asked to return the last two characters."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Try
		    AssertEquals kTestString.MidB( kTestString.Len ), s.MidB( kTestString.Len ).StringValue, "was not able to return the last character."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when asked to return the last character."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Try
		    AssertEquals kTestString.MidB( kTestString.Len +1 ), s.MidB( kTestString.Len +1 ).StringValue, "was not able to return the last zero characters."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when asked to return the last zero characters."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMidB_endchar_length()
		  // Created 10/3/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the MidB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The MidB method "
		  
		  For iLen As Integer = 0 To 2
		    
		    s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		    Try
		      AssertEquals kTestString.MidB( kTestString.Len -1, iLen ), s.MidB( kTestString.Len -1, iLen ).StringValue, "was not able to return the second to last two characters (+"+str(iLen)+" len)."
		    Catch e As IOException
		      AssertFailure "is not supposed to throw an exception when asked to return the last two characters (+"+str(iLen)+" len)."
		    End Try
		    
		    s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		    Try
		      AssertEquals kTestString.MidB( kTestString.Len, iLen ), s.MidB( kTestString.Len, iLen ).StringValue, "was not able to return the last character (+"+str(iLen)+" len)."
		    Catch e As IOException
		      AssertFailure "is not supposed to throw an exception when asked to return the last character (+"+str(iLen)+" len)."
		    End Try
		    
		    s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		    Try
		      AssertEquals kTestString.MidB( kTestString.Len +1, iLen ), s.MidB( kTestString.Len +1, iLen ).StringValue, "was not able to return the last zero characters (+"+str(iLen)+" len)."
		    Catch e As IOException
		      AssertFailure "is not supposed to throw an exception when asked to return the last zero characters (+"+str(iLen)+" len)."
		    End Try
		    
		  Next
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMidB_start()
		  // Created 9/4/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the MidB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The MidB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.MidB( 5 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.MidB( 100000 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the out-of-bounds optimization)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.MidB( 5 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Dim expected As String = kTestString.MidB( 5 )
		  Try
		    AssertEquals expected, s.MidB( 5 ).StringValue, "did not return the correct data when the source is an external BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, True )
		  Try
		    AssertEquals expected, s.MidB( 5 ).StringValue, "did not return the correct data when the source is an external BinaryStream with the error code set."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream with the error code set."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5 ).StringValue, "did not return the correct data when the source is an external read/write BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external read/write BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5 ).StringValue, "did not return the correct data when the source is an external file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external file."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5 ).StringValue, "did not return the correct data when the source is an external MemoryBlock."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external MemoryBlock."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5 ).StringValue, "did not return the correct data when the source is an external String."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external String."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5 ).StringValue, "did not return the correct data when the source is an internal string buffer."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal string buffer."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5 ).StringValue, "did not return the correct data when the source is an internal swap file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal swap file."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMidB_start_length()
		  // Created 9/4/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the MidB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The MidB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.MidB( 5, 8 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.MidB( 5, 0 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.MidB( 5, 8 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Dim expected As String = kTestString.MidB( 5, 8 )
		  Try
		    AssertEquals expected, s.MidB( 5, 8 ).StringValue, "did not return the correct data when the source is an external BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, True )
		  Try
		    AssertEquals expected, s.MidB( 5, 8 ).StringValue, "did not return the correct data when the source is an external BinaryStream with the error code set."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream with the error code set."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5, 8 ).StringValue, "did not return the correct data when the source is an external read/write BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external read/write BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5, 8 ).StringValue, "did not return the correct data when the source is an external file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external file."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5, 8 ).StringValue, "did not return the correct data when the source is an external MemoryBlock."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external MemoryBlock."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5, 8 ).StringValue, "did not return the correct data when the source is an external String."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external String."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5, 8 ).StringValue, "did not return the correct data when the source is an internal string buffer."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal string buffer."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		  Try
		    AssertEquals expected, s.MidB( 5, 8 ).StringValue, "did not return the correct data when the source is an internal swap file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal swap file."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestModifyValue()
		  // Created 7/23/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the ModifyValue method works correctly.
		  
		  Dim s(7), subject As BigStringKFS
		  Dim m(7) As String
		  
		  Const kNewTestString = "This is yet another test string, to show that values can get modified."
		  
		  s(0) = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  s(1) = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  s(2) = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		  s(3) = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		  s(4) = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		  s(5) = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  s(6) = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		  s(7) = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		  
		  m(0) = "an external abstract file"
		  m(1) = "an external read-only binary stream"
		  m(2) = "an external read/write binary stream"
		  m(3) = "an external file"
		  m(4) = "an external MemoryBlock"
		  m(5) = "an external String"
		  m(6) = "an internal string"
		  m(7) = "an internal swap file"
		  
		  For segment As Integer = 0 To 7
		    
		    subject = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		    Try
		      #pragma BreakOnExceptions Off
		      subject.ModifyValue( s( segment ) )
		      AssertFailure "The ModifyValue method is supposed to throw an exception when dealing with an abstract file."
		    Catch err As IOException
		    End Try
		    
		    subject = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		    Try
		      #pragma BreakOnExceptions Off
		      subject.ModifyValue( s( segment ) )
		      AssertFailure "The ModifyValue method is supposed to throw an exception when modifying an external read-only BinaryStream with "+m(segment)+"."
		    Catch err As IOException
		    End Try
		    
		    subject = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		    Try
		      #pragma BreakOnExceptions Off
		      subject.ModifyValue( s( segment ) )
		      If segment = 0 Then AssertFailure "The ModifyValue method is supposed to throw an exception when modifying an external read/write BinaryStream with "+m(segment)+"."
		    Catch err As IOException
		      If segment <> 0 Then AssertFailure "The ModifyValue method is not supposed to throw an exception when modifying an external read/write BinaryStream with "+m(segment)+"."
		    End Try
		    
		    subject = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		    Try
		      #pragma BreakOnExceptions Off
		      subject.ModifyValue( s( segment ) )
		      If segment = 0 Then AssertFailure "The ModifyValue method is supposed to throw an exception when modifying an external file with "+m(segment)+"."
		    Catch err As IOException
		      If segment <> 0 Then AssertFailure "The ModifyValue method is not supposed to throw an exception when modifying an external file with "+m(segment)+"."
		    End Try
		    
		    subject = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		    Try
		      #pragma BreakOnExceptions Off
		      subject.ModifyValue( s( segment ) )
		      If segment = 0 Then AssertFailure "The ModifyValue method is supposed to throw an exception when modifying an external MemoryBlock with "+m(segment)+"."
		    Catch err As IOException
		      If segment <> 0 Then AssertFailure "The ModifyValue method is not supposed to throw an exception when modifying an external MemoryBlock with "+m(segment)+"."
		    End Try
		    
		    subject = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		    Try
		      #pragma BreakOnExceptions Off
		      subject.ModifyValue( s( segment ) )
		      If segment = 0 Then AssertFailure "The ModifyValue method is supposed to throw an exception when modifying an external String with "+m(segment)+"."
		    Catch err As IOException
		      If segment <> 0 Then AssertFailure "The ModifyValue method is not supposed to throw an exception when modifying an external String with "+m(segment)+"."
		    End Try
		    
		    subject = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		    Try
		      #pragma BreakOnExceptions Off
		      subject.ModifyValue( s( segment ) )
		      If segment = 0 Then AssertFailure "The ModifyValue method is supposed to throw an exception when modifying an internal String with "+m(segment)+"."
		    Catch err As IOException
		      If segment <> 0 Then AssertFailure "The ModifyValue method is not supposed to throw an exception when modifying an internal String with "+m(segment)+"."
		    End Try
		    
		    subject = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		    Try
		      #pragma BreakOnExceptions Off
		      subject.ModifyValue( s( segment ) )
		      If segment = 0 Then AssertFailure "The ModifyValue method is supposed to throw an exception when modifying an internal swap file with "+m(segment)+"."
		    Catch err As IOException
		      If segment <> 0 Then AssertFailure "The ModifyValue method is not supposed to throw an exception when modifying an internal swap file with "+m(segment)+"."
		    End Try
		    
		  Next
		  
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
		  AssertIsNil s.FolderItemValue, "NewString should not be using a swap file."
		  
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
		  AssertNotIsNil s.FolderItemValue, "NewStringExpectingLargeContents should be using a swap file."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNthFieldB()
		  // Created 9/13/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the NthFieldB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The NthFieldB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.NthFieldB( 4 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (no arguments)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.NthFieldB( 2, " " )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.NthFieldB( 3, " ", "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (two arguments)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.NthFieldB( 3 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (no arguments)."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.NthFieldB( 4, " " )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.NthFieldB( 2, " ", "foo" )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set (no argumets)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  
		  AssertEquals "", s.NthFieldB( 0, "" ).StringValue, "did not return an expected value (1.0)."
		  AssertEquals kTestString, s.NthFieldB( 1, "" ).StringValue, "did not return an expected value (1.1)."
		  AssertEquals "", s.NthFieldB( 2, "" ).StringValue, "did not return an expected value (1.2)."
		  
		  AssertEquals kTestString.NthFieldB( " ", 0 ), s.NthFieldB( 0, " " ).StringValue, "did not return an expected value (2.0)."
		  AssertEquals kTestString.NthFieldB( " ", 1 ), s.NthFieldB( 1, " " ).StringValue, "did not return an expected value (2.1)."
		  AssertEquals kTestString.NthFieldB( " ", 2 ), s.NthFieldB( 2, " " ).StringValue, "did not return an expected value (2.2)."
		  AssertEquals kTestString.NthFieldB( " ", 3 ), s.NthFieldB( 3, " " ).StringValue, "did not return an expected value (2.3)."
		  AssertEquals kTestString.NthFieldB( " ", 4 ), s.NthFieldB( 4, " " ).StringValue, "did not return an expected value (2.4)."
		  
		  AssertEquals kTestString.NthFieldB( "beau", 0 ), s.NthFieldB( 0, "beau" ).StringValue, "did not return an expected value (3.0)."
		  AssertEquals kTestString.NthFieldB( "beau", 1 ), s.NthFieldB( 1, "beau" ).StringValue, "did not return an expected value (3.1)."
		  AssertEquals kTestString.NthFieldB( "beau", 2 ), s.NthFieldB( 2, "beau" ).StringValue, "did not return an expected value (3.2)."
		  AssertEquals kTestString.NthFieldB( "beau", 3 ), s.NthFieldB( 3, "beau" ).StringValue, "did not return an expected value (3.3)."
		  
		  AssertEquals "", s.NthFieldB( 0, " ", "o" ).StringValue, "did not return an expected value (4.0)."
		  AssertEquals "Hell", s.NthFieldB( 1, " ", "o" ).StringValue, "did not return an expected value (4.1)."
		  AssertEquals ",", s.NthFieldB( 2, " ", "o" ).StringValue, "did not return an expected value (4.2)."
		  AssertEquals "beautiful", s.NthFieldB( 3, " ", "o" ).StringValue, "did not return an expected value (4.3)."
		  AssertEquals "w", s.NthFieldB( 4, " ", "o" ).StringValue, "did not return an expected value (4.4)."
		  AssertEquals "rld!", s.NthFieldB( 5, " ", "o" ).StringValue, "did not return an expected value (4.5)."
		  AssertEquals "", s.NthFieldB( 6, " ", "o" ).StringValue, "did not return an expected value (4.6)."
		  
		  AssertEquals "", s.NthFieldB( 0, "utif", "beautiful" ).StringValue, "did not return an expected value (5.0)."
		  AssertEquals "Hello, bea", s.NthFieldB( 1, "utif", "beautiful" ).StringValue, "did not return an expected value (5.1)."
		  AssertEquals "ul world!", s.NthFieldB( 2, "utif", "beautiful" ).StringValue, "did not return an expected value (5.2)."
		  AssertEquals "", s.NthFieldB( 3, "utif", "beautiful" ).StringValue, "did not return an expected value (5.3)."
		  
		  AssertEquals "", s.NthFieldB( 0, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.0)."
		  AssertEquals "Hello, b", s.NthFieldB( 1, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.1)."
		  AssertEquals "tif", s.NthFieldB( 2, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.2)."
		  AssertEquals "rld!", s.NthFieldB( 3, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.3)."
		  AssertEquals "", s.NthFieldB( 4, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.4)."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNthFieldB_Hint()
		  // Created 9/14/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the NthFieldB method works correctly.
		  
		  Dim s As BigStringKFS
		  Dim iHfi, iHde, iHre As UInt64
		  PushMessageStack "The NthFieldB method (with hints) "
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 0, "" ).StringValue, "did not return an expected value (1.0)."
		  AssertEquals kTestString, s.NthFieldB( iHfi, iHde, iHre, 1, "" ).StringValue, "did not return an expected value (1.1)."
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 2, "" ).StringValue, "did not return an expected value (1.2)."
		  
		  AssertEquals kTestString.NthFieldB( " ", 0 ), s.NthFieldB( iHfi, iHde, iHre, 0, " " ).StringValue, "did not return an expected value (2.0)."
		  AssertEquals kTestString.NthFieldB( " ", 1 ), s.NthFieldB( iHfi, iHde, iHre, 1, " " ).StringValue, "did not return an expected value (2.1)."
		  AssertEquals kTestString.NthFieldB( " ", 1 ), s.NthFieldB( iHfi, iHde, iHre, 1, " " ).StringValue, "did not return an expected value (2.1-2)."
		  AssertEquals kTestString.NthFieldB( " ", 2 ), s.NthFieldB( iHfi, iHde, iHre, 2, " " ).StringValue, "did not return an expected value (2.2)."
		  AssertEquals kTestString.NthFieldB( " ", 2 ), s.NthFieldB( iHfi, iHde, iHre, 2, " " ).StringValue, "did not return an expected value (2.2-2)."
		  AssertEquals kTestString.NthFieldB( " ", 3 ), s.NthFieldB( iHfi, iHde, iHre, 3, " " ).StringValue, "did not return an expected value (2.3)."
		  AssertEquals kTestString.NthFieldB( " ", 3 ), s.NthFieldB( iHfi, iHde, iHre, 3, " " ).StringValue, "did not return an expected value (2.3-2)."
		  AssertEquals kTestString.NthFieldB( " ", 4 ), s.NthFieldB( iHfi, iHde, iHre, 4, " " ).StringValue, "did not return an expected value (2.4)."
		  AssertEquals kTestString.NthFieldB( " ", 4 ), s.NthFieldB( iHfi, iHde, iHre, 4, " " ).StringValue, "did not return an expected value (2.4-2)."
		  
		  AssertEquals kTestString.NthFieldB( "beau", 0 ), s.NthFieldB( iHfi, iHde, iHre, 0, "beau" ).StringValue, "did not return an expected value (3.0)."
		  AssertEquals kTestString.NthFieldB( "beau", 1 ), s.NthFieldB( iHfi, iHde, iHre, 1, "beau" ).StringValue, "did not return an expected value (3.1)."
		  AssertEquals kTestString.NthFieldB( "beau", 1 ), s.NthFieldB( iHfi, iHde, iHre, 1, "beau" ).StringValue, "did not return an expected value (3.1-2)."
		  AssertEquals kTestString.NthFieldB( "beau", 2 ), s.NthFieldB( iHfi, iHde, iHre, 2, "beau" ).StringValue, "did not return an expected value (3.2)."
		  AssertEquals kTestString.NthFieldB( "beau", 2 ), s.NthFieldB( iHfi, iHde, iHre, 2, "beau" ).StringValue, "did not return an expected value (3.2-2)."
		  AssertEquals kTestString.NthFieldB( "beau", 3 ), s.NthFieldB( iHfi, iHde, iHre, 3, "beau" ).StringValue, "did not return an expected value (3.3)."
		  
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 0, " ", "o" ).StringValue, "did not return an expected value (4.0)."
		  AssertEquals "Hell", s.NthFieldB( iHfi, iHde, iHre, 1, " ", "o" ).StringValue, "did not return an expected value (4.1)."
		  AssertEquals ",", s.NthFieldB( iHfi, iHde, iHre, 2, " ", "o" ).StringValue, "did not return an expected value (4.2)."
		  AssertEquals ",", s.NthFieldB( iHfi, iHde, iHre, 2, " ", "o" ).StringValue, "did not return an expected value (4.2-2)."
		  AssertEquals "beautiful", s.NthFieldB( iHfi, iHde, iHre, 3, " ", "o" ).StringValue, "did not return an expected value (4.3)."
		  AssertEquals "w", s.NthFieldB( iHfi, iHde, iHre, 4, " ", "o" ).StringValue, "did not return an expected value (4.4)."
		  AssertEquals "w", s.NthFieldB( iHfi, iHde, iHre, 4, " ", "o" ).StringValue, "did not return an expected value (4.4-2)."
		  AssertEquals "rld!", s.NthFieldB( iHfi, iHde, iHre, 5, " ", "o" ).StringValue, "did not return an expected value (4.5)."
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 6, " ", "o" ).StringValue, "did not return an expected value (4.6)."
		  
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 0, "utif", "beautiful" ).StringValue, "did not return an expected value (5.0)."
		  AssertEquals "Hello, bea", s.NthFieldB( iHfi, iHde, iHre, 1, "utif", "beautiful" ).StringValue, "did not return an expected value (5.1)."
		  AssertEquals "Hello, bea", s.NthFieldB( iHfi, iHde, iHre, 1, "utif", "beautiful" ).StringValue, "did not return an expected value (5.1-2)."
		  AssertEquals "ul world!", s.NthFieldB( iHfi, iHde, iHre, 2, "utif", "beautiful" ).StringValue, "did not return an expected value (5.2)."
		  AssertEquals "ul world!", s.NthFieldB( iHfi, iHde, iHre, 2, "utif", "beautiful" ).StringValue, "did not return an expected value (5.2-2)."
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 3, "utif", "beautiful" ).StringValue, "did not return an expected value (5.3)."
		  
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 0, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.0)."
		  AssertEquals "Hello, b", s.NthFieldB( iHfi, iHde, iHre, 1, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.1)."
		  AssertEquals "Hello, b", s.NthFieldB( iHfi, iHde, iHre, 1, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.1-2)."
		  AssertEquals "tif", s.NthFieldB( iHfi, iHde, iHre, 2, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.2)."
		  AssertEquals "tif", s.NthFieldB( iHfi, iHde, iHre, 2, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.2-2)."
		  AssertEquals "rld!", s.NthFieldB( iHfi, iHde, iHre, 3, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.3)."
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 4, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.4)."
		  AssertEquals "", s.NthFieldB( iHfi, iHde, iHre, 4, "eau", "o, ", "o, be", "ul wo", "world", " " ).StringValue, "did not return an expected value (6.4-2)."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestRightB()
		  // Created 9/4/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the RightB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The RightB method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.RightB( 5 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.RightB( 0 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file (with the zero optimization)."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.RightB( 5 )
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Dim expected As String = kTestString.RightB( 5 )
		  Try
		    AssertEquals expected, s.RightB( 5 ).StringValue, "did not return the correct data when the source is an external BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, True )
		  Try
		    AssertEquals expected, s.RightB( 5 ).StringValue, "did not return the correct data when the source is an external BinaryStream with the error code set."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream with the error code set."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		  Try
		    AssertEquals expected, s.RightB( 5 ).StringValue, "did not return the correct data when the source is an external read/write BinaryStream."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external read/write BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		  Try
		    AssertEquals expected, s.RightB( 5 ).StringValue, "did not return the correct data when the source is an external file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external file."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		  Try
		    AssertEquals expected, s.RightB( 5 ).StringValue, "did not return the correct data when the source is an external MemoryBlock."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external MemoryBlock."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.RightB( 5 ).StringValue, "did not return the correct data when the source is an external String."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an external String."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		  Try
		    AssertEquals expected, s.RightB( 5 ).StringValue, "did not return the correct data when the source is an internal string buffer."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal string buffer."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		  Try
		    AssertEquals expected, s.RightB( 5 ).StringValue, "did not return the correct data when the source is an internal swap file."
		  Catch e As IOException
		    AssertFailure "is not supposed to throw an exception when the data source is an internal swap file."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestRTrim()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the RTrim method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The RTrim method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.RTrim
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.RTrim
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  AssertEquals RTrim(s), s.RTrim.StringValue, "did not return the same string when nothing could be trimmed."
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString+"        ", False )
		  AssertEquals RTrim(s), s.RTrim.StringValue, "did not return the expected result."
		  
		  PopMessageStack
		  
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
		  
		  Dim testFile As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		  
		  // Save our test string to the test file.
		  
		  Try
		    Dim bs As BinaryStream = BinaryStream.Create( testFile, True )
		    bs.Write kTestString
		    bs.Close
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "Could not prepare a file that will be used for testing how the BigStringKFS class handles files."
		  End Try
		  
		  // Execute the tests.
		  
		  Dim s As New BigStringKFS
		  
		  s.StringValue = testFile
		  AssertEquals kTestString, s.StringValue, "BigStringKFS was not able to set the data source to a FolderItem."
		  
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

	#tag Method, Flags = &h0
		Sub TestSplitB()
		  // Created 10/25/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the SplitB method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The SplitB method "
		  PushMessageStack "failed to throw an exception when the data source was "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.SplitB( " " )
		    AssertFailure "an abstract file."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.SplitB( " " )
		    AssertFailure "an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  PopMessageStack
		  PushMessageStack "did not return an expected value "
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  
		  AssertArrayEquals Array( kTestString ), s.SplitB( "" ), "(1)."
		  
		  AssertArrayEquals kTestString.SplitB( " " ), s.SplitB( " " ), "(2)."
		  
		  AssertArrayEquals kTestString.SplitB( "beau" ), s.SplitB( "beau" ), "(3)."
		  
		  AssertArrayEquals Array( "Hell", ",", "beautiful", "w", "rld!" ), s.SplitB( " ", "o" ), "(4)."
		  
		  AssertArrayEquals Array( "Hello, bea", "ul world!" ), s.SplitB( "utif", "beautiful" ), "(5)."
		  
		  AssertArrayEquals Array( "Hello, b", "tif", "rld!" ), s.SplitB( "eau", "o, ", "o, be", "ul wo", "world", " " ), "(6)."
		  
		  PopMessageStack
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStorageDescriptors()
		  // Created 7/26/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the StringData* properties work correctly.
		  
		  Dim s As BigStringKFS
		  
		  PushMessageStack "An external abstract file "
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  
		  AssertFalse s.StringDataCanBeAccessed, "should not be accessible.", False
		  AssertTrue s.StringDataInvolvesAbstractFile, "should involve an abstract file.", False
		  AssertFalse s.StringDataInvolvesBinaryStream, "should not involve a BinaryStream.", False
		  AssertFalse s.StringDataInvolvesMemoryBlock, "should not involve a MemoryBlock.", False
		  AssertFalse s.StringDataInvolvesRealFile, "should not involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertFalse s.StringDataIsModifiable, "should not be modifiable.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An external abstract file with the error code set "
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  
		  AssertFalse s.StringDataCanBeAccessed, "should not be accessible.", False
		  AssertTrue s.StringDataInvolvesAbstractFile, "should involve an abstract file.", False
		  AssertFalse s.StringDataInvolvesBinaryStream, "should not involve a BinaryStream.", False
		  AssertFalse s.StringDataInvolvesMemoryBlock, "should not involve a MemoryBlock.", False
		  AssertFalse s.StringDataInvolvesRealFile, "should not involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertFalse s.StringDataIsModifiable, "should not be modifiable.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An external BinaryStream "
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  
		  AssertTrue s.StringDataCanBeAccessed, "should be accessible.", False
		  AssertFalse s.StringDataInvolvesAbstractFile, "should not involve an abstract file.", False
		  AssertTrue s.StringDataInvolvesBinaryStream, "should involve a BinaryStream.", False
		  AssertFalse s.StringDataInvolvesMemoryBlock, "should not involve a MemoryBlock.", False
		  AssertFalse s.StringDataInvolvesRealFile, "should not involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertTrue s.StringDataIsModifiable, "should think it is modifiable, even if it is not.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An external BinaryStream with the error code set "
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, True )
		  
		  AssertTrue s.StringDataCanBeAccessed, "should be accessible.", False
		  AssertFalse s.StringDataInvolvesAbstractFile, "should not involve an abstract file.", False
		  AssertTrue s.StringDataInvolvesBinaryStream, "should involve a BinaryStream.", False
		  AssertFalse s.StringDataInvolvesMemoryBlock, "should not involve a MemoryBlock.", False
		  AssertFalse s.StringDataInvolvesRealFile, "should not involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertTrue s.StringDataIsModifiable, "should think it is modifiable, even if it is not.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An external read/write BinaryStream "
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		  
		  AssertTrue s.StringDataCanBeAccessed, "should be accessible.", False
		  AssertFalse s.StringDataInvolvesAbstractFile, "should not involve an abstract file.", False
		  AssertTrue s.StringDataInvolvesBinaryStream, "should involve a BinaryStream.", False
		  AssertFalse s.StringDataInvolvesMemoryBlock, "should not involve a MemoryBlock.", False
		  AssertFalse s.StringDataInvolvesRealFile, "should not involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertTrue s.StringDataIsModifiable, "should be modifiable.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An external file "
		  s = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		  
		  AssertTrue s.StringDataCanBeAccessed, "should be accessible.", False
		  AssertFalse s.StringDataInvolvesAbstractFile, "should not involve an abstract file.", False
		  AssertFalse s.StringDataInvolvesBinaryStream, "should not involve a BinaryStream.", False
		  AssertFalse s.StringDataInvolvesMemoryBlock, "should not involve a MemoryBlock.", False
		  AssertTrue s.StringDataInvolvesRealFile, "should involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertTrue s.StringDataIsModifiable, "should be modifiable.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An external MemoryBlock "
		  s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		  
		  AssertTrue s.StringDataCanBeAccessed, "should be accessible.", False
		  AssertFalse s.StringDataInvolvesAbstractFile, "should not involve an abstract file.", False
		  AssertFalse s.StringDataInvolvesBinaryStream, "should not involve a BinaryStream.", False
		  AssertTrue s.StringDataInvolvesMemoryBlock, "should involve a MemoryBlock.", False
		  AssertFalse s.StringDataInvolvesRealFile, "should not involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertTrue s.StringDataIsModifiable, "should be modifiable.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An external String object "
		  s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  
		  AssertTrue s.StringDataCanBeAccessed, "should be accessible.", False
		  AssertFalse s.StringDataInvolvesAbstractFile, "should not involve an abstract file.", False
		  AssertFalse s.StringDataInvolvesBinaryStream, "should not involve a BinaryStream.", False
		  AssertTrue s.StringDataInvolvesMemoryBlock, "should involve a MemoryBlock.", False
		  AssertFalse s.StringDataInvolvesRealFile, "should not involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertTrue s.StringDataIsModifiable, "should be modifiable.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An internal string buffer "
		  s = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		  
		  AssertTrue s.StringDataCanBeAccessed, "should be accessible.", False
		  AssertFalse s.StringDataInvolvesAbstractFile, "should not involve an abstract file.", False
		  AssertFalse s.StringDataInvolvesBinaryStream, "should not involve a BinaryStream.", False
		  AssertTrue s.StringDataInvolvesMemoryBlock, "should involve a MemoryBlock.", False
		  AssertFalse s.StringDataInvolvesRealFile, "should not involve a real file.", False
		  AssertFalse s.StringDataInvolvesSwapFile, "should not involve a swap file.", False
		  AssertTrue s.StringDataIsModifiable, "should be modifiable.", False
		  
		  PopMessageStack
		  
		  PushMessageStack "An internal swap file "
		  s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		  
		  AssertTrue s.StringDataCanBeAccessed, "should be accessible.", False
		  AssertFalse s.StringDataInvolvesAbstractFile, "should not involve an abstract file.", False
		  AssertFalse s.StringDataInvolvesBinaryStream, "should not involve a BinaryStream.", False
		  AssertFalse s.StringDataInvolvesMemoryBlock, "should not involve a MemoryBlock.", False
		  AssertTrue s.StringDataInvolvesRealFile, "should involve a real file.", False
		  AssertTrue s.StringDataInvolvesSwapFile, "should involve a swap file.", False
		  AssertTrue s.StringDataIsModifiable, "should be modifiable.", False
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStringValue_Get()
		  // Created 7/26/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure getting the StringValue property works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The StringValue property "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.StringValue
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.StringValue
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  Try
		    AssertEquals kTestString, s.StringValue, "did not return the correct data when the source is an external BinaryStream."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, True )
		  Try
		    AssertEquals kTestString, s.StringValue, "did not return the correct data when the source is an external BinaryStream with the error code set."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "is not supposed to throw an exception when the data source is an external BinaryStream with the error code set."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream_RW, kTestString, False )
		  Try
		    AssertEquals kTestString, s.StringValue, "did not return the correct data when the source is an external read/write BinaryStream."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "is not supposed to throw an exception when the data source is an external read/write BinaryStream."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalFile, kTestString, False )
		  Try
		    AssertEquals kTestString, s.StringValue, "did not return the correct data when the source is an external file."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "is not supposed to throw an exception when the data source is an external file."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalMemoryBlock, kTestString, False )
		  Try
		    AssertEquals kTestString, s.StringValue, "did not return the correct data when the source is an external MemoryBlock."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "is not supposed to throw an exception when the data source is an external MemoryBlock."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalString, kTestString, False )
		  Try
		    AssertEquals kTestString, s.StringValue, "did not return the correct data when the source is an external String."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "is not supposed to throw an exception when the data source is an external String."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalString, kTestString, False )
		  Try
		    AssertEquals kTestString, s.StringValue, "did not return the correct data when the source is an internal string buffer."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "is not supposed to throw an exception when the data source is an internal string buffer."
		  End Try
		  
		  s = GenerateString( BSStorageLocation.InternalSwapFile, kTestString, False )
		  Try
		    AssertEquals kTestString, s.StringValue, "did not return the correct data when the source is an internal swap file."
		  Catch e As UnitTestExceptionKFS
		    StashException e
		  Catch e As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS e
		    AssertFailure "is not supposed to throw an exception when the data source is an internal swap file."
		  End Try
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestStringValue_Set()
		  // Created 7/26/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure setting the StringValue property works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The StringValue property was unable to retrieve "
		  
		  // Test with a String:
		  
		  s = New BigStringKFS
		  s.StringValue = kTestString
		  AssertEquals kTestString, s.StringValue, "a String value.", False
		  
		  // Test with a BinaryStream:
		  
		  s = New BigStringKFS
		  s.StringValue = New BinaryStream( kTestString )
		  AssertEquals kTestString, s.StringValue, "a BinaryStream value.", False
		  
		  // Test with a MemoryBlock:
		  
		  Dim mb As MemoryBlock = kTestString
		  s = New BigStringKFS
		  s.StringValue = mb
		  AssertEquals kTestString, s.StringValue, "a MemoryBlock value.", False
		  
		  // Test with a FolderItem:
		  
		  Dim f As FolderItem = AutoDeletingFolderItemKFS.NewTemporaryFile
		  Dim bs As BinaryStream = BinaryStream.Open( f, True )
		  bs.Write kTestString
		  bs.Close
		  s = New BigStringKFS
		  s.StringValue = f
		  AssertEquals kTestString, s.StringValue, "a FolderItem value.", False
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestTrim()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // BigStringKFS test case.
		  
		  // Makes sure the Trim method works correctly.
		  
		  Dim s As BigStringKFS
		  PushMessageStack "The Trim method "
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, False )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.Trim
		    AssertFailure "failed to throw an exception when the data source was an abstract file."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalAbstractFile, kTestPath, True )
		  Try
		    #pragma BreakOnExceptions Off
		    Call s.Trim
		    AssertFailure "failed to throw an exception when the data source was an abstract file with the error code set."
		  Catch e As IOException
		  End Try
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, kTestString, False )
		  AssertEquals Trim(s), s.Trim.StringValue, "did not return the same string when nothing could be trimmed."
		  
		  s = GenerateString( BSStorageLocation.ExternalBinaryStream, "    "+kTestString+"        ", False )
		  AssertEquals Trim(s), s.Trim.StringValue, "did not return the expected result."
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This class is licensed as BSD.  This generally means you may do
		whatever you want with this class so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this class does NOT require
		your work to inherit the license of this class.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this class.
		
		The full official license is as follows:
		
		Copyright (c) 2010, 2012 Andrew Keller.
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or without
		modification, are permitted provided that the following conditions
		are met:
		
		  Redistributions of source code must retain the above
		  copyright notice, this list of conditions and the
		  following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the
		  following disclaimer in the documentation and/or other
		  materials provided with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
		  contributors may be used to endorse or promote products
		  derived from this software without specific prior written
		  permission.
		
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


	#tag Enum, Name = BSStorageLocation, Type = Integer, Flags = &h0
		InternalString
		  InternalSwapFile
		  ExternalAbstractFile
		  ExternalMemoryBlock
		  ExternalFile
		  ExternalBinaryStream
		  ExternalBinaryStream_RW
		ExternalString
	#tag EndEnum


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
