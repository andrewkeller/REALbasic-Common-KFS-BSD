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
		  
		  iErrCode = 0
		  
		  // Release dependencies:
		  
		  If myInternalFile <> Nil Then ReleaseSwapFile( myInternalFile )
		  
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
		  
		  Dim bGo As Boolean
		  
		  If myInternalString <> NIl Then
		    bGo = False
		  ElseIf myInternalFile <> Nil Then
		    bGo = False
		  ElseIf myExternalAbstractFilePath <> "" Then
		    bGo = False
		  ElseIf myExternalMemoryBlock <> Nil Then
		    bGo = True
		  ElseIf myExternalFile <> Nil Then
		    bGo = True
		  ElseIf myExternalBinaryStream <> Nil Then
		    bGo = True
		  Else // must be an external string.
		    bGo = False
		  End If
		  
		  If bGo Then
		    
		    // Pipe the existing data into an internal structure.
		    
		    Dim source, dest As BinaryStream
		    
		    // Get access to the source.
		    
		    source = GetStreamAccess
		    If source <> Nil Then Return
		    
		    // Prepare the new destination.
		    
		    If Length < kSwapThreshold Then
		      
		      myInternalString = New BinaryStream(New MemoryBlock(0))
		      dest = myInternalString
		      
		    Else
		      
		      myInternalFile = AcquireSwapFile
		      dest = BinaryStream.Open( myInternalFile, True )
		      
		    End If
		    
		    If dest = Nil Then Raise New IOException
		    
		    // Perform the copy, and let RB clean up the streams.
		    
		    dest.Write source.Read( source.Length )
		    
		    // Clean up the external items.
		    
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
		    dest = BinaryStream.Open( myInternalFile, True )
		    
		  End If
		  
		  If dest = Nil Then Raise New IOException
		  
		  // Perform the copy, and let RB clean up the streams.
		  
		  For Each s As BigStringKFS In instances
		    If s <> Nil Then
		      source = s.GetStreamAccess
		      dest.Write source.Read( source.Length )
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
		  
		  Dim bGo As Boolean
		  
		  If myInternalString <> NIl Then
		    bGo = True
		  ElseIf myInternalFile <> Nil Then
		    bGo = False
		  ElseIf myExternalAbstractFilePath <> "" Then
		    bGo = False
		  ElseIf myExternalMemoryBlock <> Nil Then
		    bGo = True
		  ElseIf myExternalFile <> Nil Then
		    bGo = False
		  ElseIf myExternalBinaryStream <> Nil Then
		    bGo = True
		  Else // must be an external string.
		    bGo = True
		  End If
		  
		  If bGo Then
		    
		    Dim source, dest As BinaryStream
		    
		    // Get access to the source.
		    
		    source = GetStreamAccess
		    If source <> Nil Then Return
		    
		    // Prepare the new destination.
		    
		    myInternalFile = AcquireSwapFile
		    dest = BinaryStream.Open( myInternalFile, True )
		    If dest = Nil Then Raise New IOException
		    
		    // Perform the copy, and let RB clean up the streams.
		    
		    dest.Write source.Read( source.Length )
		    
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
		    bGo = False
		  ElseIf myExternalMemoryBlock <> Nil Then
		    bGo = False
		  ElseIf myExternalFile <> Nil Then
		    bGo = True
		  ElseIf myExternalBinaryStream <> Nil Then
		    bGo = False
		  Else // must be an external string.
		    bGo = False
		  End If
		  
		  If bGo Then
		    
		    Dim source, dest As BinaryStream
		    
		    // Get access to the source.
		    
		    source = GetStreamAccess
		    If source <> Nil Then Return
		    
		    // Prepare the new destination.
		    
		    myInternalString = New BinaryStream(New MemoryBlock(0))
		    dest = myInternalString
		    If dest = Nil Then Raise New IOException
		    
		    // Perform the copy, and let RB clean up the streams.
		    
		    dest.Write source.Read( source.Length )
		    
		    // Clean up the old data refs.
		    
		    If myInternalFile <> Nil Then ReleaseSwapFile( myInternalFile )
		    
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
		    
		    If requireWritable Then
		      Return BinaryStream.Create( myInternalFile )
		    ElseIf myInternalFile.Exists Then
		      Return BinaryStream.Open( myInternalFile )
		    Else
		      Return New BinaryStream( "" )
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Raise New IOException
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return New BinaryStream( myExternalMemoryBlock )
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    If requireWritable Then
		      Return BinaryStream.Create( myExternalFile )
		    ElseIf myExternalFile.Exists Then
		      Return BinaryStream.Open( myExternalFile )
		    Else
		      Return New BinaryStream( "" )
		    End If
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return myExternalBinaryStream
		    
		  Else // must be an external string.
		    
		    Return New BinaryStream( myExternalString )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LastErrorCode() As Integer
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns the last error code of this instance.
		  
		  Return iErrCode
		  
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
		    
		    Return 0
		    
		  ElseIf myExternalMemoryBlock <> Nil Then
		    
		    Return myExternalMemoryBlock.Size
		    
		  ElseIf myExternalFile <> Nil Then
		    
		    Return myExternalFile.Length
		    
		  ElseIf myExternalBinaryStream <> Nil Then
		    
		    Return myExternalBinaryStream.Length
		    
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
		  ElseIf myExternalMemoryBlock <> Nil Then
		    Return myExternalMemoryBlock
		  ElseIf myExternalFile <> Nil Then
		  ElseIf myExternalBinaryStream <> Nil Then
		  Else // must be an external string.
		  End If
		  
		  // Okay, fine.  Let's spend the time building one.
		  
		  Dim bs As BinaryStream = GetStreamAccess
		  
		  bs.Position = 0
		  
		  Dim result As New MemoryBlock( bs.Length )
		  
		  Dim w As New BinaryStream( result )
		  w.Write bs.Read( bs.Length )
		  
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
		  
		  // Exports the string data in this instance as a String.
		  
		  Dim dest As BinaryStream = GetStreamAccess( True )
		  
		  Dim source As BinaryStream
		  If newValue = Nil Then
		    source = New BinaryStream( "" )
		  Else
		    source = newValue.GetStreamAccess
		  End If
		  
		  If source = Nil Then Raise New IOException
		  
		  source.Position = 0
		  dest.Position = 0
		  dest.Write source.Read( source.Length )
		  dest.Length = source.Length
		  
		  // done.
		  
		End Sub
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
		    
		    myStream.Position = 0
		    otherStream.Position = 0
		    
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
		  ElseIf myExternalMemoryBlock <> Nil Then
		  ElseIf myExternalFile <> Nil Then
		  ElseIf myExternalBinaryStream <> Nil Then
		  Else // must be an external string.
		    Return myExternalString
		  End If
		  
		  // Okay, fine.  Let's spend the time building one.
		  
		  Dim bs As BinaryStream = GetStreamAccess
		  
		  bs.Position = 0
		  Return bs.Read( bs.Length )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Assigns newValue As BigStringKFS)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Imports the data in the given BigStringKFS instance into this instance.
		  
		  Clear
		  
		  If newValue = Nil Then
		    
		    Return
		    
		  ElseIf newValue.myInternalString <> Nil Then
		    
		    newValue.myInternalString.Position = 0
		    myExternalString = newValue.myInternalString.Read( newValue.myInternalString.Length )
		    
		  ElseIf newValue.myInternalFile <> Nil Then
		    
		    myExternalFile = newValue.myInternalFile
		    
		  ElseIf newValue.myExternalAbstractFilePath <> "" Then
		    
		    myExternalAbstractFilePath = newValue.myExternalAbstractFilePath
		    
		  ElseIf newValue.myExternalMemoryBlock <> Nil Then
		    
		    myExternalMemoryBlock = newValue.myExternalMemoryBlock
		    
		  ElseIf newValue.myExternalFile <> Nil Then
		    
		    myExternalFile = newValue.myExternalFile
		    
		  ElseIf newValue.myExternalBinaryStream <> Nil Then
		    
		    myExternalBinaryStream = newValue.myExternalBinaryStream
		    
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
		Protected iErrCode As Integer
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


	#tag Constant, Name = kDataSourceMemory, Type = String, Dynamic = False, Default = \"Loaded in Memory", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDataSourceMissing, Type = String, Dynamic = False, Default = \"File Data is Missing", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDataSourceStream, Type = String, Dynamic = False, Default = \"Stream", Scope = Public
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
