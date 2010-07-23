#tag Class
Protected Class BigStringKFS
	#tag Method, Flags = &h0
		Function AbstractFilePath() As String
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns the current abstract file path, if it exists.
		  
		  Return myExternalAbstractFilePath
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AbstractFilePath(Assigns newPath As String)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Sets this instance to point to an abstract file path.
		  
		  Clear
		  
		  myExternalAbstractFilePath = newPath
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Clears all the data in this instance.
		  
		  RaiseError 0
		  
		  // Release dependencies:
		  
		  ReleaseSwapFile myInternalFile
		  ReleaseSwapFile myExternalFile
		  
		  // Clear local variables:
		  
		  FileTextEncoding = Nil
		  
		  myInternalString = Nil
		  myInternalFile = Nil
		  myExternalAbstractFilePath = ""
		  myExternalMemoryBlock = Nil
		  myExternalFile = Nil
		  myExternalBinaryStream = Nil
		  myExternalString = ""
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Consolidate()
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Moves all data to internal storage.
		  
		  RaiseError 0
		  
		  Dim bGo As Boolean
		  
		  If myInternalString <> NIl Then
		    bGo = False
		  ElseIf myInternalFile <> Nil Then
		    bGo = False
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "An abstract file cannot be consolidated."
		  ElseIf myExternalMemoryBlock <> Nil Then
		    bGo = True
		  ElseIf myExternalFile <> Nil Then
		    bGo = True
		  ElseIf myExternalBinaryStream <> Nil Then
		    bGo = True
		  ElseIf myExternalString = "" Then
		    bGo = False
		  Else // must be an external string.
		    bGo = False
		  End If
		  
		  If bGo Then
		    
		    // Pipe the existing data into an internal structure.
		    
		    Dim source, dest As BinaryStream
		    
		    // Prepare the new destination.
		    
		    If Length < kSwapThreshold Then
		      
		      myInternalString = New BinaryStream(New MemoryBlock(0))
		      dest = myInternalString
		      
		    Else
		      
		      myInternalFile = AcquireSwapFile
		      dest = BinaryStream.Create( myInternalFile, True )
		      
		    End If
		    
		    // Perform the copy, and let RB clean up the streams.
		    
		    StreamPipe GetStreamAccess, dest, True
		    
		    // Clean up the external items.
		    
		    ReleaseSwapFile myExternalFile
		    
		    myExternalAbstractFilePath = ""
		    myExternalMemoryBlock = Nil
		    myExternalFile = Nil
		    myExternalBinaryStream = Nil
		    myExternalString = ""
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Basic constructor.
		  
		  Clear
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(instances() As BigStringKFS)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // A constructor that inherits the concatenated
		  // value of a series of BigStringKFS instances.
		  
		  Clear
		  
		  // Figure out the total length we're dealing with.
		  
		  // Note: abstract files are detected by an IOException
		  // thrown by the use of the Length property in the
		  // loop below.  The exception is not caught, and is
		  // considered to be the correct exception to be
		  // thrown by this constructor, anyways.
		  
		  Dim totalLength As UInt64 = 0
		  For Each s As BigStringKFS In instances
		    If s <> Nil Then
		      totalLength = totalLength + s.Length
		    End If
		  Next
		  
		  // Prepare an internal destination.
		  
		  Dim source, dest As BinaryStream
		  
		  If totalLength < kSwapThreshold Then
		    
		    myInternalString = New BinaryStream(New MemoryBlock(0))
		    dest = myInternalString
		    
		  Else
		    
		    myInternalFile = AcquireSwapFile
		    dest = BinaryStream.Create( myInternalFile, True )
		    
		  End If
		  
		  If dest = Nil Then RaiseError kErrCodeDestIO
		  
		  // Perform the copy, and let RB clean up the streams.
		  
		  For Each s As BigStringKFS In instances
		    If s <> Nil Then
		      source = s.GetStreamAccess
		      dest.Write source.Read( source.Length, FileTextEncoding )
		    End If
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(first As BigStringKFS, second As BigStringKFS, ParamArray additional As BigStringKFS)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // A constructor that inherits the concatenated
		  // value of a series of BigStringKFS instances.
		  
		  additional.Insert( 0, second )
		  additional.Insert( 0, first )
		  
		  Constructor( additional )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As BigStringKFS, autoConsolidate As Boolean = False)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // A constructor that accepts another BigStringKFS instance,
		  // and can optionally consolidate the data.
		  
		  StringValue = other
		  
		  If autoConsolidate Then Consolidate
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Release our references before this instance closes.
		  
		  Clear
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FolderitemValue(Assigns newValue As FolderItem)
		  // Created 7/8/2010 by Andrew Keller
		  
		  // Imports the data in the given FolderItem into this instance.
		  
		  RetainSwapFile newValue
		  
		  Clear
		  
		  myExternalFile = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FolderitemValue(allowSwapAccess As Boolean = True) As FolderItem
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns the current FolderItem being used to store the string data.
		  
		  If myInternalString <> NIl Then
		    
		    Return Nil
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    If allowSwapAccess Then
		      Return myInternalFile
		    Else
		      Return Nil
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return Nil
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return Nil
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    Return myExternalFile
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return Nil
		    
		  ElseIf myExternalString = "" Then
		    
		    Return Nil
		    
		  Else // must be an external string.
		    
		    Return Nil
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ForceStringDataToDisk()
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Moves the data into a structure that is located in memory.
		  
		  RaiseError 0
		  Dim bGo As Boolean
		  
		  If myInternalString <> NIl Then
		    bGo = True
		  ElseIf myInternalFile <> Nil Then
		    bGo = False
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "An abstract file cannot be relocated to a file."
		  ElseIf myExternalMemoryBlock <> Nil Then
		    bGo = True
		  ElseIf myExternalFile <> Nil Then
		    bGo = False
		  ElseIf myExternalBinaryStream <> Nil Then
		    bGo = True
		  ElseIf myExternalString = "" Then
		    bGo = True
		  Else // must be an external string.
		    bGo = True
		  End If
		  
		  If bGo Then
		    
		    Dim source, dest As BinaryStream
		    
		    // Get access to the source.
		    
		    source = GetStreamAccess
		    
		    // Prepare the new destination.
		    
		    myInternalFile = AcquireSwapFile
		    dest = BinaryStream.Create( myInternalFile, True )
		    If dest = Nil Then RaiseError kErrCodeDestIO
		    
		    // Perform the copy, and let RB clean up the streams.
		    
		    StreamPipe source, dest, True
		    
		    // Clean up the old data refs.
		    
		    myInternalString = Nil
		    myExternalAbstractFilePath = ""
		    myExternalMemoryBlock = Nil
		    myExternalFile = Nil
		    myExternalBinaryStream = Nil
		    myExternalString = ""
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ForceStringDataToMemory()
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Moves the data into a structure that is located on the hard drive.
		  
		  Dim bGo As Boolean
		  
		  If myInternalString <> NIl Then
		    bGo = False
		  ElseIf myInternalFile <> Nil Then
		    bGo = True
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "An abstract file cannot be relocated to MemoryBlock."
		  ElseIf myExternalMemoryBlock <> Nil Then
		    bGo = False
		  ElseIf myExternalFile <> Nil Then
		    bGo = True
		  ElseIf myExternalBinaryStream <> Nil Then
		    bGo = False
		  ElseIf myExternalString = "" Then
		    bGo = False
		  Else // must be an external string.
		    bGo = False
		  End If
		  
		  If bGo Then
		    
		    Dim source, dest As BinaryStream
		    
		    // Get access to the source.
		    
		    source = GetStreamAccess
		    
		    // Prepare the new destination.
		    
		    myInternalString = New BinaryStream(New MemoryBlock(0))
		    dest = myInternalString
		    If dest = Nil Then RaiseError kErrCodeDestIO
		    
		    // Perform the copy, and let RB clean up the streams.
		    
		    StreamPipe source, dest, True
		    
		    // Clean up the old data refs.
		    
		    ReleaseSwapFile myInternalFile
		    ReleaseSwapFile myExternalFile
		    
		    myInternalFile = Nil
		    myExternalAbstractFilePath = ""
		    myExternalMemoryBlock = Nil
		    myExternalFile = Nil
		    myExternalBinaryStream = Nil
		    myExternalString = ""
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDataSourceSummary() As String
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns a human readable summary of the source of the string data.
		  
		  If myInternalString <> NIl Then
		    
		    Return kDataSourceMemory
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    If myInternalFile.Exists And Not myInternalFile.Directory Then
		      Return myInternalFile.AbsolutePath
		    Else
		      Return kDataSourceMissing
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return myExternalAbstractFilePath
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return kDataSourceMemory
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    If myExternalFile.Exists And Not myExternalFile.Directory Then
		      Return myExternalFile.AbsolutePath
		    Else
		      Return kDataSourceMissing
		    End If
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return kDataSourceStream
		    
		  ElseIf myExternalString = "" Then
		    
		    Return kDataSourceMemory
		    
		  Else // must be an external string.
		    
		    Return kDataSourceMemory
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStreamAccess(requireWritable As Boolean = False) As BinaryStream
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns a BinaryStream accessing the string data.
		  
		  If myInternalString <> NIl Then
		    
		    Return myInternalString
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    If requireWritable And Not myInternalFile.Exists Then
		      Return BinaryStream.Create( myInternalFile )
		    ElseIf myInternalFile.Exists Then
		      Return BinaryStream.Open( myInternalFile, requireWritable )
		    Else
		      Return New BinaryStream( "" )
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    RaiseError kErrCodeAbstractFile, "You cannot get stream access to an abstract file."
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return New BinaryStream( myExternalMemoryBlock )
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    If requireWritable And Not myExternalFile.Exists Then
		      Return BinaryStream.Create( myExternalFile )
		    ElseIf myExternalFile.Exists Then
		      Return BinaryStream.Open( myExternalFile, requireWritable )
		    Else
		      Return New BinaryStream( "" )
		    End If
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    myExternalBinaryStream.Position = 0
		    Return myExternalBinaryStream
		    
		  ElseIf myExternalString = "" Then
		    
		    If requireWritable Then
		      myInternalString = New BinaryStream( New MemoryBlock(0) )
		      Return myInternalString
		    Else
		      Return New BinaryStream( "" )
		    End If
		    
		  Else // must be an external string.
		    
		    If requireWritable Then
		      RaiseError kErrCodeSourceIO
		    Else
		      Return New BinaryStream( myExternalString )
		    End If
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastErrorCode() As Integer
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns the last error code of this instance.
		  
		  Return myErrCode
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastSystemErrorCode() As Integer
		  // Created 7/11/2010 by Andrew Keller
		  
		  // Returns the last system error code of this instance.
		  
		  Return mySystemErrCode
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length() As UInt64
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns the length of this string.
		  
		  If myInternalString <> NIl Then
		    
		    Return myInternalString.Length
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    Return myInternalFile.Length
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    RaiseError kErrCodeAbstractFile, "You cannot get the length of an abstract file."
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return myExternalMemoryBlock.Size
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    Return myExternalFile.Length
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return myExternalBinaryStream.Length
		    
		  ElseIf myExternalString = "" Then
		    
		    Return 0
		    
		  Else // must be an external string.
		    
		    Return Len( myExternalString )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MemoryBlockValue() As MemoryBlock
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Exports the string data in this instance as a MemoryBlock.
		  
		  // Return the current MemoryBlock, if we're using one.
		  
		  If myInternalString <> NIl Then
		  ElseIf myInternalFile <> Nil Then
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "You cannot get the MemoryBlockValue of an abstract file."
		  ElseIf myExternalMemoryBlock <> Nil Then
		    Return myExternalMemoryBlock
		  ElseIf myExternalFile <> Nil Then
		  ElseIf myExternalBinaryStream <> Nil Then
		  ElseIf myExternalString = "" Then
		    Return ""
		  Else // must be an external string.
		  End If
		  
		  // Okay, fine.  Let's spend the time building one.
		  
		  Dim src As BinaryStream = GetStreamAccess
		  Dim result As New MemoryBlock( src.Length )
		  
		  StreamPipe src, New BinaryStream( result ), False
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub MemoryBlockValue(Assigns newValue As MemoryBlock)
		  // Created 7/2/2010 by Andrew Keller
		  
		  // Imports the data in the given MemoryBlock into this instance.
		  
		  Clear
		  
		  myExternalMemoryBlock = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModifyValue(newValue As BigStringKFS)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Sets the value of the string data in this instance
		  // without changing where the data is stored.
		  
		  Dim src As BinaryStream
		  Dim dest As BinaryStream = GetStreamAccess( True )
		  
		  If newValue = Nil Then
		    src = New BinaryStream( "" )
		  Else
		    src = newValue.GetStreamAccess
		  End If
		  
		  StreamPipe src, dest, True
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewString() As BigStringKFS
		  // Created 7/18/2010 by Andrew Keller
		  
		  // Returns a new BigStringKFS object.
		  
		  Return New BigStringKFS
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewStringExpectingLargeContents() As BigStringKFS
		  // Created 7/18/2010 by Andrew Keller
		  
		  // Returns a new BigStringKFS object with the
		  // internal storage pre-rigged for a swap file.
		  
		  Dim s As New BigStringKFS
		  
		  s.ForceStringDataToDisk
		  
		  Return s
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(right_operand As BigStringKFS) As BigStringKFS
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Defines the behaviour of the (+) operator.
		  
		  // Add Me to right_operand.
		  
		  Return New BigStringKFS( Me, right_operand )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(other As BigStringKFS) As Integer
		  // Created 7/2/2010 by Andrew Keller
		  
		  // Returns a signed integer representing the signed difference index to 'other'.
		  
		  // The string data of this instance is compared to the string data of the other instance.
		  // The difference is case-insetive.
		  
		  If other = Nil Then Return 1
		  
		  // Get the streams for both parties.
		  
		  Dim myStream, otherStream As BinaryStream
		  Dim myLetter, otherLetter As String
		  
		  Try
		    
		    myStream = GetStreamAccess
		    otherStream = other.GetStreamAccess
		    
		    // The streams are now ready for comparison.
		    
		    Do
		      
		      If myStream.EOF And otherStream.EOF Then
		        Return 0
		      ElseIf myStream.EOF And Not otherStream.EOF Then
		        Return -1
		      ElseIf Not myStream.EOF And otherStream.EOF Then
		        Return 1
		      Else
		        
		        myLetter = myStream.Read( 1, FileTextEncoding )
		        otherLetter = otherStream.Read( 1, FileTextEncoding )
		        
		        If myLetter = otherLetter Then
		          Return 0
		        ElseIf myLetter < otherLetter Then
		          Return -1
		        ElseIf myLetter > otherLetter Then
		          Return 1
		        Else
		          
		          // So far, the streams are identical.  Let the loop continue.
		          
		        End If
		      End If
		    Loop
		    
		  Catch
		    
		    // One or both of the streams cannot be accessed,
		    // so these strings cannot be compared.
		    
		    Return 0
		    
		  End Try
		  
		  Return 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As BinaryStream
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Exports the data in this class as a BinaryStream.
		  
		  Return GetStreamAccess
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Exports the data in this class as a String.
		  
		  Return StringValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As BinaryStream)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // A constructor that accepts a BinaryStream instance.
		  
		  Clear
		  
		  myExternalBinaryStream = other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As FolderItem)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // A constructor that accepts a FolderItem instance.
		  
		  RetainSwapFile other
		  
		  Clear
		  
		  myExternalFile = other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As String)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // A constructor that accepts a String instance.
		  
		  Clear
		  
		  myExternalString = other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Multiply(iScalar As Integer) As BigStringKFS
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Defines the behaviour of the (*) operator.
		  
		  // Return iScalar times Me.
		  
		  If iScalar = 0 Then Return New BigStringKFS
		  If iScalar < 0 Then Raise New OutOfBoundsException
		  
		  Dim times() As BigStringKFS
		  ReDim times( iScalar -1 )
		  
		  For row As Integer = iScalar -1 DownTo 0
		    
		    times( row ) = Me
		    
		  Next
		  
		  Return New BigStringKFS( times )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_MultiplyRight(iScalar As Integer) As BigStringKFS
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Defines the behaviour of the (*) operator.
		  
		  // Same as the left multiply algorithm.
		  
		  Return Operator_Multiply( iScalar )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RaiseError(iPrimaryErrorCode As Integer, iSystemErrorCode As Integer, sMessage As String = "")
		  // Created 7/11/2010 by Andrew Keller
		  
		  // Provides an easy method for other methods in this class
		  // to raise exceptions and set error codes at the same time.
		  
		  // If iPrimaryErrorCode is zero, then the error codes are reset.
		  // Else, If iSystemErrorCode is zero, then no action is taken.
		  // Else, the error codes are set to the given and an
		  // appropriate exception is raised.
		  
		  If iPrimaryErrorCode = 0 Then
		    
		    // This is a reserved instruction.
		    
		    // Clear the error codes.
		    
		    myErrCode = 0
		    mySystemErrCode = 0
		    
		  ElseIf iSystemErrorCode <> 0 Then
		    
		    // Store the error codes, and raise an appropriate exception.
		    
		    myErrCode = iPrimaryErrorCode
		    mySystemErrCode = iSystemErrorCode
		    
		    Dim e As RuntimeException
		    
		    e = New IOException
		    e.Message = sMessage
		    
		    Raise e
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RaiseError(iPrimaryErrorCode As Integer, sMessage As String = "")
		  // Created 7/13/2010 by Andrew Keller
		  
		  // Provides an easy method for other methods in this class
		  // to raise exceptions and set error codes at the same time.
		  
		  // If iPrimaryErrorCode is zero, then the error codes are reset.
		  // Else, the error codes are set to the given and an
		  // appropriate exception is raised.
		  
		  If iPrimaryErrorCode = 0 Then
		    
		    // This is a reserved instruction.
		    
		    // Clear the error codes.
		    
		    myErrCode = 0
		    mySystemErrCode = 0
		    
		  Else
		    
		    // Store the error codes, and raise an appropriate exception.
		    
		    myErrCode = iPrimaryErrorCode
		    mySystemErrCode = 0
		    
		    Dim e As RuntimeException
		    
		    e = New IOException
		    e.Message = sMessage
		    
		    Raise e
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StreamPipe(src As BinaryStream, dest As BinaryStream, autoTruncate As Boolean)
		  // Created 7/16/2010 by Andrew Keller
		  
		  // Copies the data in the source stream into the dest stream.
		  
		  // The positions of each of the streams are assumed to already be set.
		  // The only automatic feature of this method is truncating the destination after the copy.
		  
		  If src = Nil Then RaiseError kErrCodeInternal, "StreamPipe was called with a Nil source stream."
		  If dest = Nil Then RaiseError kErrCodeInternal, "StreamPipe was called with a Nil destination stream."
		  
		  While Not src.EOF
		    
		    StreamWrite dest, StreamRead( src, kStreamPipeSegmentSize, Nil )
		    
		  Wend
		  
		  If autoTruncate Then
		    If dest.Length <> dest.Position Then
		      
		      dest.Length = dest.Position
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function StreamRead(bs As BinaryStream, byteCount As UInt64, enc As TextEncoding) As String
		  // Created 7/16/2010 by Andrew Keller
		  
		  // Reads the given number of bytes from the given BinaryStream,
		  // and throws an IOException if an error occurs.
		  
		  If bs = Nil Then RaiseError kErrCodeInternal, "StreamRead was called with a Nil stream."
		  
		  Dim iOldPosition As UInt64 = bs.Position
		  
		  Dim result As String = bs.Read( byteCount, enc )
		  
		  If LenB( result ) = byteCount Then
		    
		    // The length of the retrieved string is expected.
		    
		    // Return the data.
		    
		  ElseIf bs.Length - iOldPosition = Len( result ) Then
		    
		    // We read the entire remainder of the stream.
		    
		    // Return the data.
		    
		  Else
		    
		    // Some data is unaccounted for.
		    
		    RaiseError kErrCodeSourceIO, bs.LastErrorCode
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StreamWrite(bs As BinaryStream, text As String)
		  // Created 7/16/2010 by Andrew Keller
		  
		  // Writes the given data to the given BinaryStream,
		  // and throws an IOException if an error occurs.
		  
		  If bs = Nil Then RaiseError kErrCodeInternal, "StreamWrite was called with a Nil stream."
		  
		  Dim iOldPosition As UInt64 = bs.Position
		  
		  bs.Write text
		  
		  If bs.Position - iOldPosition <> Len( text ) Then
		    
		    // The position of the stream did not move as expected.
		    
		    RaiseError kErrCodeDestIO, bs.LastErrorCode
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataCanBeAccessed() As Boolean
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns whether or not the data in this instance can be accessed.
		  
		  If myInternalString <> NIl Then
		    
		    Return True
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    If myInternalFile.Directory Then
		      Return False
		    Else
		      Return myInternalFile.IsReadable
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    If myExternalFile.Directory Then
		      Return False
		    Else
		      Return myExternalFile.IsReadable
		    End If
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalString = "" Then
		    
		    Return True
		    
		  Else // must be an external string.
		    
		    Return True
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataInvolvesAbstractFile() As Boolean
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns whether or not the data in this instance is based on an abstract file.
		  
		  If myInternalString <> NIl Then
		    
		    Return False
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return True
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalString = "" Then
		    
		    Return False
		    
		  Else // must be an external string.
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataInvolvesBinaryStream() As Boolean
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns whether or not the data in this instance is based on a BinaryStream.
		  
		  If myInternalString <> NIl Then
		    
		    Return False
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalString = "" Then
		    
		    Return False
		    
		  Else // must be an external string.
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataInvolvesMemoryBlock() As Boolean
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns whether or not the data in this instance is based on a MemoryBlock or String.
		  
		  If myInternalString <> NIl Then
		    
		    Return True
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalString = "" Then
		    
		    Return True
		    
		  Else // must be an external string.
		    
		    Return True
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataInvolvesRealFile() As Boolean
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns whether or not the data in this instance is based on a file on the hard drive.
		  
		  If myInternalString <> NIl Then
		    
		    Return False
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalString = "" Then
		    
		    Return False
		    
		  Else // must be an external string.
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataInvolvesSwapFile() As Boolean
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns whether or not the data in this instance is based on an internal swap file.
		  
		  If myInternalString <> NIl Then
		    
		    Return False
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return False
		    
		  ElseIf myExternalString = "" Then
		    
		    Return False
		    
		  Else // must be an external string.
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataIsModifiable() As Boolean
		  // Created 7/18/2010 by Andrew Keller
		  
		  // Tells whether or not GetStreamAccess has the
		  // ability to return a read/write BinaryStream.
		  
		  If myInternalString <> NIl Then
		    
		    Return True
		    
		  ElseIf myInternalFile <> Nil Then
		    
		    If myInternalFile.Exists Then
		      If myInternalFile.IsWriteable Then
		        Return True
		      End If
		    End If
		    
		    Return False
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    If myExternalFile.Exists Then
		      If myExternalFile.IsWriteable Then
		        Return True
		      End If
		    End If
		    
		    Return False
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return True
		    
		  ElseIf myExternalString = "" Then
		    
		    Return True
		    
		  Else // must be an external string.
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Exports the string data in this instance as a String.
		  
		  // Return the current String, if we're using one.
		  
		  If myInternalString <> NIl Then
		  ElseIf myInternalFile <> Nil Then
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "You cannot get the StringValue of an abstract file."
		  ElseIf myExternalMemoryBlock <> Nil Then
		    Return myExternalMemoryBlock
		  ElseIf myExternalFile <> Nil Then
		  ElseIf myExternalBinaryStream <> Nil Then
		  ElseIf myExternalString = "" Then
		    Return ""
		  Else // must be an external string.
		    Return myExternalString
		  End If
		  
		  // Okay, fine.  Let's spend the time building one.
		  
		  Dim bs As BinaryStream = GetStreamAccess
		  Return bs.Read( bs.Length, FileTextEncoding )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Assigns newValue As BigStringKFS)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Imports the data in the given BigStringKFS instance into this instance.
		  
		  // First, retain any new files before we clear.
		  
		  If newValue = Nil Then
		  ElseIf newValue.myInternalString <> Nil Then
		  ElseIf newValue.myInternalFile <> Nil Then
		    
		    RetainSwapFile newValue.myInternalFile
		    
		  ElseIf newValue.myExternalAbstractFilePath <> "" Then
		  ElseIf newValue.myExternalMemoryBlock <> Nil Then
		  ElseIf newValue.myExternalFile <> Nil Then
		    
		    RetainSwapFile newValue.myExternalFile
		    
		  ElseIf newValue.myExternalBinaryStream <> Nil Then
		  ElseIf newValue.myExternalString = "" Then
		  Else // must be an external string.
		  End If
		  
		  // Clear this instance, and import the data.
		  
		  Clear
		  
		  If newValue = Nil Then
		    
		    Return
		    
		  ElseIf newValue.myInternalString <> Nil Then
		    
		    Try
		      myExternalBinaryStream = newValue.GetStreamAccess
		      Consolidate
		    Catch err As IOException
		      Clear
		      Raise err
		    End Try
		    
		  ElseIf newValue.myInternalFile <> Nil Then
		    
		    Try
		      myExternalBinaryStream = newValue.GetStreamAccess
		      Consolidate
		    Catch err As IOException
		      Clear
		      Raise err
		    End Try
		    
		  ElseIf newValue.myExternalAbstractFilePath <> "" Then
		    
		    myExternalAbstractFilePath = newValue.myExternalAbstractFilePath
		    
		  ElseIf newValue.myExternalMemoryBlock <> Nil Then
		    
		    myExternalMemoryBlock = newValue.myExternalMemoryBlock
		    
		  ElseIf newValue.myExternalFile <> Nil Then
		    
		    myExternalFile = newValue.myExternalFile
		    
		  ElseIf newValue.myExternalBinaryStream <> Nil Then
		    
		    myExternalBinaryStream = newValue.myExternalBinaryStream
		    
		  ElseIf newValue.myExternalString = "" Then
		    
		    myExternalString = ""
		    
		  Else // must be an external string.
		    
		    myExternalString = newValue.myExternalString
		    
		  End If
		  
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


	#tag Property, Flags = &h0
		FileTextEncoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myErrCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExternalAbstractFilePath As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExternalBinaryStream As BinaryStream
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExternalFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExternalMemoryBlock As MemoryBlock
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExternalString As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myInternalFile As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myInternalString As BinaryStream
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mySystemErrCode As Integer
	#tag EndProperty


	#tag Constant, Name = kDataSourceMemory, Type = String, Dynamic = False, Default = \"Loaded in Memory", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDataSourceMissing, Type = String, Dynamic = False, Default = \"File Data is Missing", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDataSourceStream, Type = String, Dynamic = False, Default = \"Stream", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeAbstractFile, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeDestIO, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeInternal, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeNone, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeSourceIO, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kStreamPipeSegmentSize, Type = Double, Dynamic = False, Default = \"1024", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSwapThreshold, Type = Double, Dynamic = False, Default = \"1000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kUIDCat, Type = String, Dynamic = False, Default = \"BigStringKFS Pool Entry UID", Scope = Protected
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
End Class
#tag EndClass
