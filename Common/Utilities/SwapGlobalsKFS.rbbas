#tag Module
Protected Module SwapGlobalsKFS
	#tag Method, Flags = &h0
		Function AcquireSwapFile(bTrack As Boolean = True) As FolderItem
		  // Created 6/23/2008 by Andrew Keller
		  
		  // Generates and returns a new swap file.
		  
		  Dim iTmp As Integer
		  
		  If Not SwapModuleInitialized Then Initialize
		  
		  Dim targetFolder As FolderItem = Nil
		  
		  For Each f As Folderitem In vmFolders
		    
		    If targetFolder = Nil Then
		      
		      targetFolder = f
		      
		    End If
		  Next
		  
		  Dim swapFile As FolderItem = targetFolder.Child( targetFolder.NextSerialNameKFS( "KFS_Swap_File", "-" ) )
		  Dim bs As BinaryStream = BinaryStream.Create( swapFile, True )
		  If bs = Nil Then
		    Dim e As New IOException
		    e.Message = "Could not create a swap file at path " + swapFile.AbsolutePath
		    Raise e
		  End If
		  bs.Close
		  
		  If bTrack Then
		    
		    NewStatusReportKFS "SwapGlobalsKFS.AcquireSwapFile", 3, False, "Initialized a new swap file.", "Path: " + swapFile.ShellPathKFS
		    
		    fSwapFiles.Append swapFile
		    iSwapFileUsage.Append 1
		    
		  Else
		    
		    NewStatusReportKFS "SwapGlobalsKFS.AcquireSwapFile", 3, False, "Initialized a new untracked swap file.", "Path: " + swapFile.ShellPathKFS
		    
		  End If
		  
		  Return swapFile
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetSwapFileIndex(fFile As FolderItem) As Integer
		  // Creatd 6/23/2008 by Andrew Keller
		  
		  // Returns the index of the given file.
		  
		  If fFile = Nil Then Return -1
		  
		  Dim iTmp, iLast As Integer
		  
		  iLast = UBound( fSwapFiles )
		  
		  For iTmp = 0 to iLast
		    
		    If fFile.EqualsKFS( fSwapFiles( iTmp ) ) Then
		      
		      Return iTmp
		      
		    End If
		    
		  Next
		  
		  Return -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Initialize()
		  // Created 6/23/2008 by Andrew Keller
		  
		  // Initializes this module.
		  
		  vmFolders.Append SpecialFolder.Temporary
		  
		  SwapModuleInitialized = True
		  
		  // done.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ReleaseAllSwapFiles()
		  // Created 6/23/2008 by Andrew Keller
		  
		  // Deletes all swap files registered here.
		  
		  While UBound( fSwapFiles ) > -1
		    
		    If fSwapFiles( 0 ) <> Nil Then
		      
		      If fSwapFiles( 0 ).Exists Then
		        
		        NewStatusReportKFS "SwapGlobalsKFS.ReleaseAllSwapFiles", 5, False, "Cleaning swap file " + fSwapFiles( 0 ).ShellPathKFS
		        
		        fSwapFiles( 0 ).Delete
		        
		      End If
		      
		    End If
		    
		    fSwapFiles.Remove 0
		    iSwapFileUsage.Remove 0
		    
		  Wend
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ReleaseSwapFile(f As FolderItem)
		  // Created 6/23/2008 by Andrew Keller
		  
		  // Decrements the number of processies using the given swap file.
		  // If the number hits zero, the file is deleted.  Else, no action is taken.
		  
		  Dim iRow As Integer = GetSwapFileIndex( f )
		  
		  If iRow > -1 Then
		    
		    iSwapFileUsage( iRow ) = iSwapFileUsage( iRow ) -1
		    
		    If iSwapFileUsage( iRow ) > 0 Then
		      
		      NewStatusReportKFS "SwapGlobalsKFS.ReleaseSwapFile", 3, False, "Swap file ref count decremented.", "Path: " + fSwapFiles( iRow ).ShellPathKFS, "Count: " + str( iSwapFileUsage( iRow ) )
		      
		    Else
		      
		      NewStatusReportKFS "SwapGlobalsKFS.ReleaseSwapFile", 3, False, "Swap file ref count hit zero.  Deallocating...", "Path: " + fSwapFiles( iRow ).ShellPathKFS
		      
		      If fSwapFiles( iRow ) <> Nil Then
		        If fSwapFiles( iRow ).Exists Then
		          fSwapFiles( iRow ).Delete
		        End If
		      End If
		      
		      fSwapFiles.Remove iRow
		      iSwapFileUsage.Remove iRow
		      
		    End If
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub RetainSwapFile(f As FolderItem)
		  // Created 6/23/2008 by Andrew Keller
		  
		  // Increments the usage count of the given swap file.
		  // If the given file is not tracked, then no action is taken.
		  
		  If Not SwapModuleInitialized Then Initialize
		  
		  Dim iTmp As Integer = GetSwapFileIndex( f )
		  
		  If iTmp > -1 Then
		    
		    iSwapFileUsage( iTmp ) = iSwapFileUsage( iTmp ) + 1
		    
		    NewStatusReportKFS "SwapGlobalsKFS.RetainSwapFile", 3, False, "Swap file ref count incremented.", "Path: " + f.ShellPathKFS, "Count: " + str( iSwapFileUsage( iTmp ) )
		    
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


	#tag Property, Flags = &h21
		Private fSwapFiles() As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h21
		Private iSwapFileUsage() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private SwapModuleInitialized As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected vmFolders() As FolderItem
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="2147483648"
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
End Module
#tag EndModule
