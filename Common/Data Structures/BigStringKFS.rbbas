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
		Function AscB() As Integer
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Returns the character code of the first byte of the string data.
		  
		  Return Me.LeftB( 1 ).StringValue.AscB
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Clears all the data in this instance.
		  
		  RaiseError 0
		  
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    bGo = False
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    bGo = False
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "An abstract file cannot be consolidated."
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    bGo = True
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    bGo = True
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
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
		    
		    If LenB < kSwapThreshold Then
		      
		      myInternalString = New BinaryStream(New MemoryBlock(0))
		      dest = myInternalString
		      
		    Else
		      
		      myInternalFile = AutoDeletingFolderItemKFS.NewTemporaryFile
		      dest = BinaryStream.Create( myInternalFile, True )
		      
		    End If
		    
		    // Perform the copy, and let RB clean up the streams.
		    
		    StreamPipe GetStreamAccess, dest, True
		    
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
		Sub Constructor(instances() As BigStringKFS, delimiter As BigStringKFS = Nil)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // A constructor that makes this object contain the data
		  // of the given segments joined by the given delimiter.
		  
		  // The default delimiter is the empty string, unlike RB's Join function.
		  
		  Clear
		  
		  // Figure out the total length we're dealing with.
		  
		  If instances.Ubound < 0 Then Return
		  
		  // Note: abstract files are detected by an IOException
		  // thrown by the use of the Length property in the
		  // loop below.  The exception is not caught, and is
		  // considered to be the correct exception to be
		  // thrown by this constructor, anyways.
		  
		  Dim totalLength As UInt64 = 0
		  If Not ( delimiter Is Nil ) Then totalLength = delimiter.LenB * instances.Ubound
		  For Each s As BigStringKFS In instances
		    If Not ( s Is Nil ) Then
		      totalLength = totalLength + s.LenB
		    End If
		  Next
		  
		  // Prepare an internal destination.
		  
		  Dim source, dest As BinaryStream
		  
		  If totalLength < kSwapThreshold Then
		    
		    myInternalString = New BinaryStream(New MemoryBlock( totalLength ))
		    dest = myInternalString
		    
		  Else
		    
		    myInternalFile = AutoDeletingFolderItemKFS.NewTemporaryFile
		    dest = BinaryStream.Create( myInternalFile, True )
		    
		  End If
		  
		  If dest Is Nil Then RaiseError kErrCodeDestIO
		  
		  // Perform the copy, and let RB clean up the streams.
		  
		  If Not ( instances( 0 ) Is Nil ) Then StreamPipe instances( 0 ), dest, False
		  
		  For row As Integer = 1 To instances.Ubound
		    
		    If Not ( delimiter Is Nil ) Then StreamPipe delimiter, dest, False
		    
		    If Not ( instances( row ) Is Nil ) Then StreamPipe instances( row ), dest, False
		    
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
		Function CountFieldsB(delimiters() As BigStringKFS) As UInt64
		  // Created 9/6/2010 by Andrew Keller
		  
		  // A CountFieldsB function designed to run within this object.
		  
		  Dim myStream As BinaryStream = Me.GetStreamAccess
		  Dim myDelims() As BinaryStream
		  For Each s As BigStringKFS In delimiters
		    myDelims.Append s
		  Next
		  
		  Dim startPosition As UInt64 = 0
		  Dim iRegionStart, iRegionEnd As UInt64
		  Dim iDelimIndex As Integer
		  Dim endPosition As UInt64 = myStream.InStrB_BSa_KFS( iRegionStart, iRegionEnd, iDelimIndex, 0, myDelims )
		  Dim result As UInt64 = 1
		  
		  While endPosition > 0
		    
		    result = result +1
		    
		    startPosition = iRegionEnd
		    endPosition = myStream.InStrB_BSa_KFS( iRegionStart, iRegionEnd, iDelimIndex, startPosition, myDelims )
		    
		  Wend
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function CountFieldsB(ParamArray delimiters As BigStringKFS) As UInt64
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Alternate form of the CountFieldsB function.
		  
		  Return Me.CountFieldsB( delimiters )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CountLeadingWhitespace(src As BinaryStream) As UInt64
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Returns how much whitespace the given stream starts with.
		  
		  If src.Length = 0 Then Return 0
		  
		  src.Position = 0
		  Dim result As UInt64 = 0
		  Dim srcByte As Integer
		  Dim iOldPosition As Integer
		  
		  Do
		    
		    iOldPosition = src.Position
		    srcByte = src.ReadByte
		    If src.Position <> iOldPosition + 1 Then RaiseError kErrCodeSourceIO, src.LastErrorCode
		    
		    If Not IsWhitespace( srcByte ) Then Return result
		    
		    result = result + 1
		    
		  Loop Until src.EOF
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function CountTrailingWhitespace(src As BinaryStream) As UInt64
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Returns how much whitespace the given stream ends with.
		  
		  If src.Length = 0 Then Return 0
		  
		  Dim result As UInt64 = 0
		  Dim srcByte As Integer
		  Dim iOldPosition As Integer
		  
		  Do
		    
		    src.Position = src.Length - result - 1
		    iOldPosition = src.Position
		    srcByte = src.ReadByte
		    If src.Position <> iOldPosition + 1 Then RaiseError kErrCodeSourceIO, src.LastErrorCode
		    
		    If Not IsWhitespace( srcByte ) Then Return result
		    
		    result = result + 1
		    
		  Loop Until src.Position = 1
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function EndOfLineSet() As BigStringKFS()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Returns the set of all EndOfLine's.
		  
		  Return Array( New BigStringKFS( chr(13)+chr(10) ), New BigStringKFS( chr(10) ), New BigStringKFS( chr(13) ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FolderItemValue(Assigns newValue As FolderItem)
		  // Created 7/8/2010 by Andrew Keller
		  
		  // Imports the data in the given FolderItem into this instance.
		  
		  Clear
		  
		  myExternalFile = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function FolderItemValue(allowSwapAccess As Boolean = True) As FolderItem
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns the current FolderItem being used to store the string data.
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return Nil
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    If allowSwapAccess Then
		      Return myInternalFile
		    Else
		      Return Nil
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return Nil
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return Nil
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    Return myExternalFile
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    bGo = True
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    bGo = False
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "An abstract file cannot be relocated to a file."
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    bGo = True
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    bGo = False
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
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
		    
		    myInternalFile = AutoDeletingFolderItemKFS.NewTemporaryFile
		    dest = BinaryStream.Create( myInternalFile, True )
		    If dest Is Nil Then RaiseError kErrCodeDestIO
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    bGo = False
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    bGo = True
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "An abstract file cannot be relocated to MemoryBlock."
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    bGo = False
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    bGo = True
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
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
		    
		    myInternalString = New BinaryStream(New MemoryBlock( source.Length ))
		    
		    // Perform the copy, and let RB clean up the streams.
		    
		    StreamPipe source, myInternalString, True
		    
		    // Clean up the old data refs.
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return kDataSourceMemory
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    If myInternalFile.Exists And Not myInternalFile.Directory Then
		      Return myInternalFile.AbsolutePath
		    Else
		      Return kDataSourceMissing
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return myExternalAbstractFilePath
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return kDataSourceMemory
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    If myExternalFile.Exists And Not myExternalFile.Directory Then
		      Return myExternalFile.AbsolutePath
		    Else
		      Return kDataSourceMissing
		    End If
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    myInternalString.Position = 0
		    Return myInternalString
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    If requireWritable And Not myInternalFile.Exists Then
		      Return BinaryStream.Create( myInternalFile )
		    ElseIf myInternalFile.Exists Then
		      Return BinaryStream.Open( myInternalFile, requireWritable )
		    Else
		      Return New BinaryStream( "" )
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    RaiseError kErrCodeAbstractFile, "You cannot get stream access to an abstract file."
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return New BinaryStream( myExternalMemoryBlock )
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    If requireWritable And Not myExternalFile.Exists Then
		      Return BinaryStream.Create( myExternalFile )
		    ElseIf myExternalFile.Exists Then
		      Return BinaryStream.Open( myExternalFile, requireWritable )
		    Else
		      Return New BinaryStream( "" )
		    End If
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		      If LenB( myExternalString ) < kSwapThreshold Then
		        myInternalString = New BinaryStream(New MemoryBlock( LenB(myExternalString) ))
		        StreamPipe New BinaryStream( myExternalString ), myInternalString, True
		        myExternalString = ""
		        myInternalString.Position = 0
		        Return myInternalString
		      Else
		        myInternalFile = AutoDeletingFolderItemKFS.NewTemporaryFile
		        StreamPipe New BinaryStream( myExternalString ), BinaryStream.Create( myInternalFile, True ), True
		        myExternalString = ""
		        Return BinaryStream.Open( myInternalFile, True )
		      End If
		    Else
		      Return New BinaryStream( myExternalString )
		    End If
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB(subStrings() As BigStringKFS) As UInt64
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Alternate form of the InStrB function.
		  
		  Return Me.InStrB( 0, subStrings )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB(ParamArray subStrings As BigStringKFS) As UInt64
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Alternate form of the InStrB function.
		  
		  Return Me.InStrB( subStrings )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB(ByRef matchedObject As BigStringKFS, startPos As UInt64, subStrings() As BigStringKFS) As UInt64
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Alternate form of the InStrB function.
		  
		  Dim matchIndex As Integer
		  Dim iPos As UInt64 = Me.InStrB( matchIndex, startPos, subStrings )
		  
		  If iPos > 0 Then
		    
		    matchedObject = subStrings( matchIndex )
		    
		  Else
		    
		    matchedObject = Nil
		    
		  End If
		  
		  Return iPos
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB(ByRef matchedObject As BigStringKFS, startPos As UInt64, ParamArray subStrings As BigStringKFS) As UInt64
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Alternate form of the InStrB function.
		  
		  Return Me.InStrB( matchedObject, startPos, subStrings )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB(ByRef matchIndex As Integer, startPos As UInt64, subStrings() As BigStringKFS) As UInt64
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Returns the position of the first occurrence of the given substring
		  // after the given start position in this BigStringKFS object.
		  
		  Dim subStreams() As BinaryStream
		  For Each s As BigStringKFS In subStrings
		    If s Is Nil Then
		      subStreams.Append Nil
		    Else
		      subStreams.Append s
		    End If
		  Next
		  
		  Dim iRStart, iREnd As UInt64
		  Return Me.GetStreamAccess.InStrB_BSa_KFS( iRStart, iREnd, matchIndex, startPos, subStreams )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB(ByRef matchIndex As Integer, startPos As UInt64, ParamArray subStrings As BigStringKFS) As UInt64
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Alternate form of the InStrB function.
		  
		  Return Me.InStrB( matchIndex, startPos, subStrings )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB(startPos As UInt64, subStrings() As BigStringKFS) As UInt64
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Alternate form of the InStrB function.
		  
		  Dim iMch As Integer
		  
		  Return Me.InStrB( iMch, startPos, subStrings )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function InStrB(startPos As UInt64, ParamArray subStrings As BigStringKFS) As UInt64
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Alternate form of the InStrB function.
		  
		  Return Me.InStrB( startPos, subStrings )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function IsWhitespace(char As Integer) As Boolean
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Returns whether or not the given character code is whitespace in Unicode.
		  
		  // This function follows the definition of a white space character
		  // at http://www.unicode.org/Public/UNIDATA/PropList.txt
		  
		  Return ( char >= 9 And char <= 13 ) _
		  Or char = 32 _
		  Or char = 133 _
		  Or char = 160 _
		  Or char = 5760 _
		  Or char = 6158 _
		  Or ( char >= 8192 And char <= 8202 ) _
		  Or ( char >= 8206 And char <= 8207 ) _
		  Or char = 8232 _
		  Or char = 8233 _
		  Or char = 8239 _
		  Or char = 8287 _
		  Or char = 12288
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Join(segments() As BigStringKFS, delimiter As BigStringKFS = Nil) As BigStringKFS
		  // Created 9/25/2010 by Andrew Keller
		  
		  // Returns the given segments joined with the given delimiter.
		  
		  Return New BigStringKFS( segments, delimiter )
		  
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
		Function LeftB(byteCount As UInt64) As BigStringKFS
		  // Created 9/4/2010 by Andrew Keller
		  
		  // Exports the first <byteCount> bytes of this string as a new BigStringKFS.
		  
		  Dim result As New BigStringKFS
		  StreamPipe GetStreamAccess, result.GetStreamAccess( True ), byteCount, True
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LenB() As UInt64
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Returns the binary length of this string.
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return myInternalString.Length
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    Return myInternalFile.Length
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    RaiseError kErrCodeAbstractFile, "You cannot get the length of an abstract file."
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return myExternalMemoryBlock.Size
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    Return myExternalFile.Length
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
		    Return myExternalBinaryStream.Length
		    
		  ElseIf myExternalString = "" Then
		    
		    Return 0
		    
		  Else // must be an external string.
		    
		    Return LenB( myExternalString )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LTrim() As BigStringKFS
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Returns the string data, minus any leading whitespace.
		  
		  Return Me.MidB( 1 + CountLeadingWhitespace( Me.GetStreamAccess ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MemoryBlockValue() As MemoryBlock
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Exports the string data in this instance as a MemoryBlock.
		  
		  // Return the current MemoryBlock, if we're using one.
		  
		  If Not ( myInternalString Is Nil ) Then
		  ElseIf Not ( myInternalFile Is Nil ) Then
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "You cannot get the MemoryBlockValue of an abstract file."
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    Return myExternalMemoryBlock
		  ElseIf Not ( myExternalFile Is Nil ) Then
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
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
		Function MidB(startPosition As UInt64) As BigStringKFS
		  // Created 9/4/2010 by Andrew Keller
		  
		  // Exports the data of this string as a BigStringKFS, starting with byte number <startPosition>.
		  
		  Dim src As BinaryStream = GetStreamAccess
		  If startPosition > src.Length Then Return ""
		  
		  If startPosition > 0 Then src.Position = startPosition - 1
		  
		  Dim result As New BigStringKFS
		  StreamPipe src, result.GetStreamAccess( True ), True
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MidB(startPosition As UInt64, length As UInt64) As BigStringKFS
		  // Created 9/4/2010 by Andrew Keller
		  
		  // Exports <length> bytes of this string as a BigStringKFS, starting with byte number <startPosition>.
		  
		  Dim src As BinaryStream = GetStreamAccess
		  If startPosition > src.Length Then Return ""
		  
		  If startPosition > 0 Then src.Position = startPosition - 1
		  
		  Dim result As New BigStringKFS
		  StreamPipe src, result.GetStreamAccess( True ), length, True
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModifyValue(newValue As BigStringKFS)
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Sets the value of the string data in this instance
		  // without changing where the data is stored.
		  
		  Dim src As BinaryStream
		  Dim dest As BinaryStream = GetStreamAccess( True )
		  
		  If newValue Is Nil Then
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
		Function NthFieldB(ByRef fieldHintIndex As UInt64, ByRef fieldHintDelimEnd As UInt64, ByRef fieldHintRegionEnd As UInt64, fieldIndex As UInt64, delimiters() As BigStringKFS) As BigStringKFS
		  // Created 9/5/2010 by Andrew Keller
		  
		  // An NthFieldB function designed to run within this object.
		  
		  If fieldIndex < 1 Then Return ""
		  
		  Dim myStream As BinaryStream = Me.GetStreamAccess
		  Dim myDelims() As BinaryStream
		  Dim myDlens() As UInt64
		  For Each s As BigStringKFS In delimiters
		    myDlens.Append s.LenB
		    myDelims.Append s
		  Next
		  
		  Dim startPosition As UInt64
		  Dim iRegionStart, iRegionEnd As UInt64
		  Dim iDelimIndex As Integer
		  Dim endPosition As UInt64
		  Dim currentIndex As UInt64
		  
		  // Assimilate the provided hints.
		  
		  If fieldHintIndex > 0 And fieldHintIndex < fieldIndex Then
		    
		    // The hints refer to a useful index.
		    
		    If fieldHintDelimEnd > 0 And fieldHintRegionEnd > 0 Then
		      
		      // The hints tell the end of the previous delimiter.
		      
		      startPosition = fieldHintDelimEnd
		      currentIndex = fieldHintIndex +1
		      iRegionEnd = fieldHintRegionEnd
		      
		    Else
		      
		      // The hints tell that no end delimiter was found for a
		      // previous index, which means that this index cannot exist.
		      
		      Return ""
		      
		    End If
		  Else
		    
		    // The hints do not help find the requested index.
		    // Just start at the beginning like normal.
		    
		    startPosition = 1
		    iRegionEnd = 1
		    currentIndex = 1
		    
		  End If
		  
		  // Calculate the initial end delimiter:
		  endPosition = myStream.InStrB_BSa_KFS( iRegionStart, iRegionEnd, iDelimIndex, iRegionEnd, myDelims )
		  
		  // Loop until we find the end of the desired segment.
		  
		  Do
		    
		    // Did the user want this segment?
		    
		    If fieldIndex = currentIndex Then
		      
		      // Yes.  Deallocate the stream (so we can use MidB safely):
		      myStream = Nil
		      
		      // Set the hints for next time and return the result:
		      fieldHintIndex = currentIndex
		      
		      If endPosition > 0 Then
		        
		        fieldHintDelimEnd = endPosition + myDlens(iDelimIndex)
		        fieldHintRegionEnd = iRegionEnd
		        Return Me.MidB( startPosition, endPosition - startPosition )
		        
		      Else
		        
		        fieldHintDelimEnd = 0
		        fieldHintRegionEnd = 0
		        Return Me.MidB( startPosition )
		        
		      End If
		    End If
		    
		    // Nope...  was an end delimiter found?
		    
		    If iDelimIndex < 0 Then
		      
		      // Nope...  the requested index does not exist.
		      
		      fieldHintIndex = currentIndex
		      fieldHintDelimEnd = 0
		      fieldHintRegionEnd = 0
		      Return ""
		      
		    End If
		    
		    // Yup...  Recalculate the start position based on the found end:
		    startPosition = endPosition + myDlens(iDelimIndex)
		    
		    // And find the next end position starting with the end of the last region:
		    endPosition = myStream.InStrB_BSa_KFS( iRegionStart, iRegionEnd, iDelimIndex, iRegionEnd, myDelims )
		    
		    // Update the field index:
		    currentIndex = currentIndex + 1
		    
		    // Did the user want this segment?  Oh yea...  Loop back to the top.
		    
		  Loop
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NthFieldB(ByRef fieldHintIndex As UInt64, ByRef fieldHintDelimEnd As UInt64, ByRef fieldHintRegionEnd As UInt64, fieldIndex As UInt64, ParamArray delimiters As BigStringKFS) As BigStringKFS
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Alternate form of the NthField function.
		  
		  Return Me.NthFieldB( fieldHintIndex, fieldHintDelimEnd, fieldHintRegionEnd, fieldIndex, delimiters )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NthFieldB(fieldIndex As UInt64, delimiters() As BigStringKFS) As BigStringKFS
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Alternate form of the NthField function.
		  
		  Dim iHi, iHde, iHre As UInt64
		  Return Me.NthFieldB( iHi, iHde, iHre, fieldIndex, delimiters )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NthFieldB(fieldIndex As UInt64, ParamArray delimiters As BigStringKFS) As BigStringKFS
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Alternate form of the NthField function.
		  
		  Return Me.NthFieldB( fieldIndex, delimiters )
		  
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
		Function Operator_AddRight(left_operand As BigStringKFS) As BigStringKFS
		  // Created 9/25/2010 by Andrew Keller
		  
		  // Defines the behaviour of the (+) operator.
		  
		  // Add left_operand to Me.
		  
		  Return New BigStringKFS( left_operand, Me )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(other As BigStringKFS) As Integer
		  // Created 7/2/2010 by Andrew Keller
		  
		  // Returns a signed integer representing the signed difference index to 'other'.
		  
		  // The string data of this instance is compared to the string data of the other instance.
		  // The difference is case-insetive.
		  
		  If other Is Nil Then Return 1
		  
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
		    
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    
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

	#tag Method, Flags = &h0
		Function RightB(byteCount As UInt64) As BigStringKFS
		  // Created 9/4/2010 by Andrew Keller
		  
		  // Exports the last <byteCount> bytes of this string as a new BigStringKFS.
		  
		  Dim src As BinaryStream = GetStreamAccess
		  If src.Length > byteCount Then src.Position = src.Length - byteCount
		  
		  Dim result As New BigStringKFS
		  StreamPipe src, result.GetStreamAccess( True ), True
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function RTrim() As BigStringKFS
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Returns the string data, minus any trailing whitespace.
		  
		  Return Me.MidB( 0, Me.LenB - CountTrailingWhitespace( Me.GetStreamAccess ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SplitB(delimiters() As BigStringKFS) As BigStringKFS()
		  // Created 9/25/2010 by Andrew Keller
		  
		  // Returns an array of the segments of this string
		  // after being split by the given delimiters.
		  
		  Dim myStream As BinaryStream = Me.GetStreamAccess
		  Dim myDelims() As BinaryStream
		  Dim myDlens() As UInt64
		  For Each s As BigStringKFS In delimiters
		    myDlens.Append s.LenB
		    myDelims.Append s
		  Next
		  
		  Dim startPosition As UInt64 = 1
		  Dim iRegionStart, iRegionEnd As UInt64 = 0
		  Dim iDelimIndex As Integer = -1
		  Dim endPosition As UInt64 = 0
		  
		  // Acquire all the segments:
		  
		  Dim pile As New DataChainKFS
		  
		  Do
		    
		    // Find the next end position starting with the end of the last region:
		    endPosition = myStream.InStrB_BSa_KFS( iRegionStart, iRegionEnd, iDelimIndex, iRegionEnd, myDelims )
		    
		    // Add the bounds of this segment to the pile:
		    pile.Append startPosition : endPosition
		    
		    // Was that the last segment?
		    If iDelimIndex < 0 Then Exit
		    
		    // Nope...  Recalculate the start position based on the found end:
		    startPosition = endPosition + myDlens(iDelimIndex)
		    
		  Loop
		  
		  // Deallocate the stream (so we can use MidB safely):
		  myStream = Nil
		  
		  // Render the result:
		  
		  Dim result() As BigStringKFS
		  ReDim result( pile.Count -1 )
		  
		  For row As Integer = 0 To result.Ubound -1
		    
		    Dim p As Pair = pile.Pop
		    startPosition = p.Left
		    endPosition = p.Right
		    
		    result( row ) = Me.MidB( startPosition, endPosition - startPosition )
		    
		  Next
		  
		  result( result.Ubound ) = Me.MidB( Pair( pile.Pop ).Left )
		  
		  // Return the result:
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SplitB(ParamArray delimiters As BigStringKFS) As BigStringKFS()
		  // Created 9/25/2010 by Andrew Keller
		  
		  // Alternate form of the Split function.
		  
		  Return Me.SplitB( delimiters )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub StreamPipe(src As BinaryStream, dest As BinaryStream, autoTruncate As Boolean)
		  // Created 7/16/2010 by Andrew Keller
		  
		  // Copies all the data in the source stream into the dest stream.
		  
		  // The positions of each of the streams are assumed to already be set.
		  // The only automatic feature of this method is truncating the destination after the copy.
		  
		  If src Is Nil Then RaiseError kErrCodeInternal, "StreamPipe was called with a Nil source stream."
		  If dest Is Nil Then RaiseError kErrCodeInternal, "StreamPipe was called with a Nil destination stream."
		  
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
		Protected Sub StreamPipe(src As BinaryStream, dest As BinaryStream, byteCount As UInt64, autoTruncate As Boolean)
		  // Created 9/4/2010 by Andrew Keller
		  
		  // Copies the given length of data in the source stream into the dest stream.
		  
		  // The positions of each of the streams are assumed to already be set.
		  // The only automatic feature of this method is truncating the destination after the copy.
		  
		  If src Is Nil Then RaiseError kErrCodeInternal, "StreamPipe was called with a Nil source stream."
		  If dest Is Nil Then RaiseError kErrCodeInternal, "StreamPipe was called with a Nil destination stream."
		  
		  Dim startPos As UInt64 = dest.Position
		  
		  While Not src.EOF And dest.Position - startPos < byteCount
		    
		    StreamWrite dest, StreamRead( src, Min( kStreamPipeSegmentSize, byteCount - ( dest.Position - startPos ) ), Nil )
		    
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
		  
		  If bs Is Nil Then RaiseError kErrCodeInternal, "StreamRead was called with a Nil stream."
		  
		  Dim iOldPosition As UInt64 = bs.Position
		  
		  Dim result As String = bs.Read( byteCount, enc )
		  
		  If LenB( result ) = byteCount Then
		    
		    // The length of the retrieved string is expected.
		    
		    // Return the data.
		    
		  ElseIf bs.Length - iOldPosition = LenB( result ) Then
		    
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
		  
		  If bs Is Nil Then RaiseError kErrCodeInternal, "StreamWrite was called with a Nil stream."
		  
		  Dim iOldPosition As UInt64 = bs.Position
		  
		  bs.Write text
		  
		  If bs.Position - iOldPosition <> LenB( text ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return True
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    If myInternalFile.Directory Then
		      Return False
		    Else
		      Return myInternalFile.IsReadable
		    End If
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return True
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    If myExternalFile.Directory Then
		      Return False
		    Else
		      Return myExternalFile.IsReadable
		    End If
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    Return False
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return True
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    Return False
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return True
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    Return False
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return True
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    Return True
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    Return True
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    Return True
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		  
		  If Not ( myInternalString Is Nil ) Then
		    
		    Return True
		    
		  ElseIf Not ( myInternalFile Is Nil ) Then
		    
		    If myInternalFile.IsWriteable Then
		      Return True
		    End If
		    
		    Return False
		    
		  ElseIf myExternalAbstractFilePath <> "" Then
		    
		    Return False
		    
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    
		    Return True
		    
		  ElseIf Not ( myExternalFile Is Nil ) Then
		    
		    If myExternalFile.IsWriteable Then
		      Return True
		    End If
		    
		    Return False
		    
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
		    
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
		Function StringValue() As String
		  // Created 7/1/2010 by Andrew Keller
		  
		  // Exports the string data in this instance as a String.
		  
		  // Return the current String, if we're using one.
		  
		  If Not ( myInternalString Is Nil ) Then
		  ElseIf Not ( myInternalFile Is Nil ) Then
		  ElseIf myExternalAbstractFilePath <> "" Then
		    RaiseError kErrCodeAbstractFile, "You cannot get the StringValue of an abstract file."
		  ElseIf Not ( myExternalMemoryBlock Is Nil ) Then
		    Return myExternalMemoryBlock
		  ElseIf Not ( myExternalFile Is Nil ) Then
		  ElseIf Not ( myExternalBinaryStream Is Nil ) Then
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
		  
		  // Clear this instance, and import the data.
		  
		  Clear
		  
		  If newValue Is Nil Then
		    
		    Return
		    
		  ElseIf Not ( newValue.myInternalString Is Nil ) Then
		    
		    Try
		      myExternalBinaryStream = newValue.GetStreamAccess
		      Consolidate
		    Catch err As IOException
		      Clear
		      Raise err
		    End Try
		    
		  ElseIf Not ( newValue.myInternalFile Is Nil ) Then
		    
		    Try
		      myExternalBinaryStream = newValue.GetStreamAccess
		      Consolidate
		    Catch err As IOException
		      Clear
		      Raise err
		    End Try
		    
		  ElseIf newValue.myExternalAbstractFilePath <> "" Then
		    
		    myExternalAbstractFilePath = newValue.myExternalAbstractFilePath
		    
		  ElseIf Not ( newValue.myExternalMemoryBlock Is Nil ) Then
		    
		    myExternalMemoryBlock = newValue.myExternalMemoryBlock
		    
		  ElseIf Not ( newValue.myExternalFile Is Nil ) Then
		    
		    myExternalFile = newValue.myExternalFile
		    
		  ElseIf Not ( newValue.myExternalBinaryStream Is Nil ) Then
		    
		    myExternalBinaryStream = newValue.myExternalBinaryStream
		    
		  ElseIf newValue.myExternalString = "" Then
		    
		    myExternalString = ""
		    
		  Else // must be an external string.
		    
		    myExternalString = newValue.myExternalString
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Trim() As BigStringKFS
		  // Created 9/5/2010 by Andrew Keller
		  
		  // Returns the string data, minus any leading or trailing whitespace.
		  
		  Dim l, t As UInt64
		  
		  Dim src As BinaryStream = Me.GetStreamAccess
		  
		  l = CountLeadingWhitespace( src )
		  t = CountTrailingWhitespace( src )
		  
		  Return Me.MidB( 1 + l, Me.LenB - l - t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function WhiteSpaceSet(includeMultibyteChars As Boolean = True) As BigStringKFS()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Returns the set of all white space characters.
		  
		  // This function follows the definition of a white space character
		  // at http://www.unicode.org/Public/UNIDATA/PropList.txt
		  
		  If includeMultibyteChars Then
		    
		    Return Array( _
		    New BigStringKFS( chr( 9 ) ), _
		    New BigStringKFS( chr( 10 ) ), _
		    New BigStringKFS( chr( 11 ) ), _
		    New BigStringKFS( chr( 12 ) ), _
		    New BigStringKFS( chr( 13 ) ), _
		    New BigStringKFS( chr( 32 ) ), _
		    New BigStringKFS( chr( 133 ) ), _
		    New BigStringKFS( chr( 160 ) ), _
		    New BigStringKFS( chr( 5760 ) ), _
		    New BigStringKFS( chr( 6158 ) ), _
		    New BigStringKFS( chr( 8192 ) ), _
		    New BigStringKFS( chr( 8193 ) ), _
		    New BigStringKFS( chr( 8194 ) ), _
		    New BigStringKFS( chr( 8195 ) ), _
		    New BigStringKFS( chr( 8196 ) ), _
		    New BigStringKFS( chr( 8197 ) ), _
		    New BigStringKFS( chr( 8198 ) ), _
		    New BigStringKFS( chr( 8199 ) ), _
		    New BigStringKFS( chr( 8200 ) ), _
		    New BigStringKFS( chr( 8201 ) ), _
		    New BigStringKFS( chr( 8202 ) ), _
		    New BigStringKFS( chr( 8206 ) ), _
		    New BigStringKFS( chr( 8207 ) ), _
		    New BigStringKFS( chr( 8232 ) ), _
		    New BigStringKFS( chr( 8233 ) ), _
		    New BigStringKFS( chr( 8239 ) ), _
		    New BigStringKFS( chr( 8287 ) ), _
		    New BigStringKFS( chr( 12288 ) ) )
		    
		  Else
		    
		    Return Array( _
		    New BigStringKFS( chr( 9 ) ), _
		    New BigStringKFS( chr( 10 ) ), _
		    New BigStringKFS( chr( 11 ) ), _
		    New BigStringKFS( chr( 12 ) ), _
		    New BigStringKFS( chr( 13 ) ), _
		    New BigStringKFS( chr( 32 ) ), _
		    New BigStringKFS( chr( 133 ) ), _
		    New BigStringKFS( chr( 160 ) ) )
		    
		  End If
		  
		  // done.
		  
		End Function
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
		
		Copyright (c) 2008-2010 Andrew Keller.
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
