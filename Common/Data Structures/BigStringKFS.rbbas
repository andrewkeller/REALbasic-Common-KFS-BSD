#tag Class
Protected Class BigStringKFS
	#tag Method, Flags = &h0
		Sub Clear()
		  // Destroys all the string data and reinitializes this instance.
		  
		  // Created 4/29/2008 by Andrew Keller
		  // Modified 12/25/2009 --;
		  // Modified 1/8/2010 --;
		  
		  FileTextEncoding = Nil
		  iErrCode = 0
		  myOriginalFolderitem = Nil
		  myStringCopy = ""
		  myUserEnteredPath = ""
		  
		  If mySwapFolderitem <> Nil Then
		    
		    ReleaseSwapFile mySwapFolderitem
		    
		    mySwapFolderitem = Nil
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Consolidate()
		  // Releases the dependency on OriginalFolderitem, if it is currently active.
		  
		  // Created 5/28/2008 by Andrew Keller
		  // Rewritten 12/25/2009 --;
		  
		  If myOriginalFolderitem <> Nil Then
		    If myOriginalFolderitem.Exists Then
		      
		      Dim bs As BinaryStream = BinaryStream.Open( myOriginalFolderitem )
		      
		      If bs <> Nil Then
		        
		        StringValue = bs
		        
		        bs.Close
		        
		      End If
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Basic Constructor.
		  
		  // Created 4/29/2008 by Andrew Keller
		  // Rewritten 12/25/2009 --;
		  
		  StringValue = ""
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As BigStringKFS)
		  // Standard Convert Constructor.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  StringValue = other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As BinaryStream)
		  // Standard Convert Constructor.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  StringValue = other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As FolderItem, autoConsolidate As Boolean = False)
		  // Standard Convert Constructor.
		  
		  // Created 12/25/2009 by Andrew Keller
		  // Modified 1/13/2010 --;
		  
		  StringValue = other
		  
		  If autoConsolidate Then Consolidate
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As MemoryBlock)
		  // Standard Convert Constructor.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  StringValue = other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As String)
		  // Standard Convert Constructor.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  StringValue = other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Make sure all the data is freed.
		  
		  // Created 4/29/2008 by Andrew Keller
		  
		  Clear
		  
		  // done.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ForceStringDataToDisk()
		  // Relocates the data segment of this instance to a swap
		  // file if it is currently in memory.  Has no effect if
		  // the segment is currently a file in the user-scope or
		  // is inaccessible.
		  
		  // Created 1/8/2010 by Andrew Keller
		  
		  If myOriginalFolderitem = Nil And mySwapFolderitem = Nil And myUserEnteredPath = "" Then
		    
		    Dim currentData As BinaryStream = GetDataStream
		    
		    If currentData <> Nil Then
		      
		      // Send the current data to a swap file.
		      
		      mySwapFolderitem = AcquireSwapFile
		      
		      Dim outStream As BinaryStream
		      outStream = BinaryStream.Create( mySwapFolderitem, True )
		      
		      outStream.Write currentData.Read( currentData.Length, FileTextEncoding )
		      
		      outStream.Length = currentData.Length
		      
		      currentData.Close
		      outStream.Close
		      
		      // Clear the other references.
		      
		      myStringCopy = ""
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDataFolderitem(allowAccessToSwapFile As Boolean = False) As FolderItem
		  // Returns the folderitem that contains this instance's data,
		  // only if the data is represented by a file in the user scope.
		  
		  // Created 12/26/2009 by Andrew Keller
		  // Modified 1/8/2010 --;
		  
		  // Note: There are plenty of legitimate cases
		  // where this function may return Nil.
		  
		  If allowAccessToSwapFile And mySwapFolderitem <> Nil Then Return mySwapFolderitem
		  
		  Return myOriginalFolderitem
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDataSourceSummary(includeErrorMsgs As Boolean = True) As String
		  // Returns a description of where
		  // the data in this string comes from.
		  
		  // Created 4/29/2008 by Andrew Keller
		  // Rewritten 12/25/2009 --;
		  
		  // Also note: if includeErrorMsgs is True, then
		  // non-computer-readable strings can be returned,
		  // such as "Loaded in Memory".
		  
		  If mySwapFolderitem <> Nil Then
		    
		    If mySwapFolderitem.Exists Then
		      
		      Return mySwapFolderitem.ShellPathKFS
		      
		    End If
		    
		    Return kDataSourceMissing
		    
		  ElseIf myOriginalFolderitem <> Nil Then
		    
		    If myOriginalFolderitem.Exists Then
		      
		      Return myOriginalFolderitem.ShellPathKFS
		      
		    End If
		    
		    Return kDataSourceMissing
		    
		  ElseIf myUserEnteredPath <> "" Then
		    
		    Return myUserEnteredPath
		    
		  ElseIf includeErrorMsgs Then
		    
		    Return kDataSourceMemory
		    
		  Else
		    
		    Return ""
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetDataStream() As BinaryStream
		  // Returns a BinaryStream set to read the data in this instance.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  // Note: There are legitimate non-error cases
		  // where this function may return Nil.
		  
		  Dim result As BinaryStream = Nil
		  
		  If mySwapFolderitem <> Nil Then
		    If mySwapFolderitem.Exists Then
		      
		      result = BinaryStream.Open( mySwapFolderitem )
		      
		    End If
		    
		  ElseIf myOriginalFolderitem <> Nil Then
		    If myOriginalFolderitem.Exists Then
		      
		      result = BinaryStream.Open( myOriginalFolderitem )
		      
		    End If
		    
		  ElseIf myUserEnteredPath = "" Then
		    
		    result = New BinaryStream( myStringCopy )
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length() As UInt64
		  // Returns the length of the data in this class.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  // Note that a length of zero *may* have been an error,
		  // So also check the last error code.
		  
		  Dim data As BinaryStream = GetDataStream
		  
		  If data = Nil Then Return 0
		  
		  Return data.Length
		  
		  // Done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModifyValue(newValue As BigStringKFS)
		  // Grabs the current data stream, and overwrites
		  // it with the data in the given BigStringKFS.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  // This function tries as hard as it can to
		  // do this operation ByRef, but the String
		  // class is not desireable for ByRef logic,
		  // so passing a new value as a String
		  // operates using ByVal logic.
		  
		  // Pass this request off to a more
		  // specific function.
		  
		  If newValue.mySwapFolderitem <> Nil Then
		    
		    ModifyValue newValue.myOriginalFolderitem
		    
		  ElseIf newValue.myOriginalFolderitem <> Nil Then
		    
		    ModifyValue newValue.myOriginalFolderitem
		    
		  ElseIf newValue.UserEnteredPath <> "" Then
		    
		    Clear
		    myUserEnteredPath = newValue.UserEnteredPath
		    
		  Else
		    
		    ModifyValue newValue.myStringCopy
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModifyValue(newValue As BinaryStream)
		  // Grabs the current data stream, and overwrites
		  // it with the data in the given BinaryStream.
		  
		  // Created 12/25/2009 by Andrew Keller
		  // Modified 3/14/2010 --;
		  
		  // The data in the BinaryStream is imported
		  // into this instance using ByRef logic.
		  
		  // Currently, this class' support of BinaryStreams
		  // and MemoryBlocks only includes accepting
		  // data.  Because of this, they behave like
		  // Strings do in this class.
		  
		  If myOriginalFolderitem <> Nil Then
		    
		    // This instance is pointing to data that is physically
		    // located somewhere within the user's filesystem.  In
		    // this case, modifying the data implies that the data
		    // at the target location is being modified, not just
		    // this instance.
		    
		    Dim outStream As BinaryStream
		    outStream = BinaryStream.Create( myOriginalFolderitem, True )
		    
		    If outStream <> Nil Then
		      
		      outStream.Write newValue.Read( newValue.Length, FileTextEncoding )
		      
		      If outStream.LastErrorCode <> 0 Then Raise New IOException
		      
		      Return
		      
		    Else
		      Raise New IOException
		    End If
		    
		  Else
		    
		    // This instance is not pointing to a file in the user's
		    // filesystem, so it really doesn't matter where the new
		    // data is stored as long as it's this instance that is
		    // storing it.
		    
		    StringValue = newValue
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModifyValue(newValue As FolderItem)
		  // Grabs the current data stream, and overwrites
		  // it with the data in the given FolderItem.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  // The data in the FolderItem is imported
		  // into this instance using ByRef logic.
		  
		  ModifyValue BinaryStream.Open( newValue )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModifyValue(newValue As MemoryBlock)
		  // Grabs the current data stream, and overwrites
		  // it with the data in the given MemoryBlock.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  // The data in the MemoryBlock is imported
		  // into this instance using ByRef logic.
		  
		  // Currently, this class' support of BinaryStreams
		  // and MemoryBlocks only includes accepting
		  // data.  Because of this, they behave like
		  // Strings do in this class.
		  
		  ModifyValue New BinaryStream( newValue )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ModifyValue(newValue As String)
		  // Grabs the current data stream, and overwrites
		  // it with the data in the given String.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  // This function tries as hard as it can to
		  // do this operation ByRef, but the String
		  // class is not desireable for ByRef logic,
		  // so passing a new value as a String
		  // operates using ByVal logic.
		  
		  ModifyValue New BinaryStream( newValue )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As BinaryStream
		  // Overloads the equals operator.
		  
		  // Created 1/13/2010 by Andrew Keller
		  
		  Return GetDataStream
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  // Overloads the equals operator.
		  
		  // Created 1/13/2010 by Andrew Keller
		  
		  Return StringValue
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As BinaryStream)
		  // Overloads the equals operator.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  Constructor other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As FolderItem)
		  // Overloads the equals operator.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  Constructor other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As MemoryBlock)
		  // Overloads the equals operator.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  Constructor other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As String)
		  // Overloads the equals operator.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  Constructor other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataCanBeAccessed() As Boolean
		  // Returns whether or not the contents of this
		  // instance can be accessed.
		  
		  // Created 6/9/2008 by Andrew Keller
		  // Rewritten 12/25/2009 --;
		  
		  If mySwapFolderitem <> Nil Then
		    
		    If mySwapFolderitem.Exists Then
		      If mySwapFolderitem.IsReadable Then
		        
		        Return True
		        
		      End If
		    End If
		    
		    iErrCode = kErrCodeDoesntExist
		    Return False
		    
		  ElseIf myOriginalFolderitem <> Nil Then
		    
		    If myOriginalFolderitem.Exists Then
		      If myOriginalFolderitem.IsReadable Then
		        
		        Return True
		        
		      End If
		    End If
		    
		    iErrCode = kErrCodeDoesntExist
		    Return False
		    
		  ElseIf myUserEnteredPath <> "" Then
		    
		    iErrCode = kErrCodeAbstractFile
		    Return False
		    
		  Else
		    
		    Return True
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataInvolvesAbstractFile() As Boolean
		  // Returns whether or not this data stream in
		  // this instance uses an abstract file.
		  
		  // Created 12/26/2009 by Andrew Keller
		  
		  If mySwapFolderitem <> Nil Then
		    
		    // Internal data (swap)
		    
		    Return False
		    
		  ElseIf myOriginalFolderitem <> Nil Then
		    
		    // User data
		    
		    Return False
		    
		  ElseIf myUserEnteredPath <> "" Then
		    
		    // Abstract data
		    
		    Return True
		    
		  Else
		    
		    // Internal data (memory)
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataInvolvesInternalData() As Boolean
		  // Returns whether or not this data stream in
		  // this instance uses data stored internally.
		  
		  // Created 12/26/2009 by Andrew Keller
		  
		  If mySwapFolderitem <> Nil Then
		    
		    // Internal data (swap)
		    
		    Return True
		    
		  ElseIf myOriginalFolderitem <> Nil Then
		    
		    // User data
		    
		    Return False
		    
		  ElseIf myUserEnteredPath <> "" Then
		    
		    // Abstract data
		    
		    Return False
		    
		  Else
		    
		    // Internal data (memory)
		    
		    Return True
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringDataInvolvesUserFile() As Boolean
		  // Returns whether or not this data stream in
		  // this instance uses a file in the user scope.
		  
		  // Created 12/26/2009 by Andrew Keller
		  
		  If mySwapFolderitem <> Nil Then
		    
		    // Internal data (swap)
		    
		    Return False
		    
		  ElseIf myOriginalFolderitem <> Nil Then
		    
		    // User data
		    
		    Return True
		    
		  ElseIf myUserEnteredPath <> "" Then
		    
		    // Abstract data
		    
		    Return False
		    
		  Else
		    
		    // Internal data (memory)
		    
		    Return False
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As String
		  // Returns the string value of this instance.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  Dim data As BinaryStream = GetDataStream
		  
		  If data <> Nil Then Return data.Read( data.Length, FileTextEncoding )
		  
		  Return ""
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Assigns newValue As BigStringKFS)
		  // Sets the value of this class to the data
		  // contained in the given BigStringKFS.
		  
		  // Created 12/25/2008 by Andrew Keller
		  
		  Clear
		  
		  If newValue.myOriginalFolderitem <> Nil Then
		    
		    myOriginalFolderitem = newValue.myOriginalFolderitem
		    
		  ElseIf newValue.UserEnteredPath <> "" Then
		    
		    myUserEnteredPath = newValue.UserEnteredPath
		    
		  Else
		    
		    StringValue = newValue.GetDataStream
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Assigns newValue As BinaryStream)
		  // Sets the value of this class to the data
		  // contained in the given BinaryStream.
		  
		  // Created 12/25/2008 by Andrew Keller
		  
		  Clear
		  
		  StringValue = newValue.Read( newValue.Length, FileTextEncoding )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Assigns newValue As FolderItem)
		  // Sets the value of this class to the data
		  // contained in the given FolderItem.
		  
		  // Created 12/25/2008 by Andrew Keller
		  
		  Clear
		  
		  myOriginalFolderitem = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Assigns newValue As MemoryBlock)
		  // Sets the value of this class to the data
		  // contained in the given MemoryBlock.
		  
		  // Created 12/25/2008 by Andrew Keller
		  
		  Clear
		  
		  Dim temp As String = newValue
		  
		  StringValue = temp
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub StringValue(Assigns newValue As String)
		  // Sets the value of this class to the data
		  // contained in the given String.
		  
		  // Created 12/25/2008 by Andrew Keller
		  // Modified 1/8/2010 --;
		  
		  Clear
		  
		  If newValue.Len < kSwapThreshold Then
		    
		    myStringCopy = newValue
		    
		  Else
		    
		    mySwapFolderitem = AcquireSwapFile
		    
		    Dim outStream As BinaryStream
		    outStream = BinaryStream.Create( mySwapFolderitem, True )
		    
		    outStream.Write newValue
		    
		    outStream.Length = newValue.Len
		    
		    outStream.Close
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function UserEnteredPath() As String
		  // Returns the current UserEnteredPath.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  Return myUserEnteredPath
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub UserEnteredPath(Assigns newValue As String)
		  // Sets the contents of this string to an abstract file path.
		  
		  // Created 12/25/2009 by Andrew Keller
		  
		  Clear
		  
		  myUserEnteredPath = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		FileTextEncoding As TextEncoding
	#tag EndProperty

	#tag Property, Flags = &h0
		iErrCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myOriginalFolderitem As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myStringCopy As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mySwapFolderitem As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myUserEnteredPath As String
	#tag EndProperty


	#tag Constant, Name = kDataSourceMemory, Type = String, Dynamic = False, Default = \"Loaded in Memory", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kDataSourceMissing, Type = String, Dynamic = False, Default = \"File Data is Missing", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeAbstractFile, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeDoesntExist, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeIOError, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrCodeNone, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSwapThreshold, Type = Double, Dynamic = False, Default = \"1000000", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kUIDCat, Type = String, Dynamic = False, Default = \"BigStringKFS Pool Entry UID", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="iErrCode"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
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
