#tag Class
Protected Class AutoDeletingFolderItemKFS
Inherits FolderItem
	#tag Method, Flags = &h0
		Function AutoDeleteEnabled() As Boolean
		  // Created 9/3/2011 by Andrew Keller
		  
		  // Returns whether automatically deleting this FolderItem is enabled.
		  
		  Return p_enable_autodelete
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AutoDeleteEnabled(Assigns new_value As Boolean)
		  // Created 9/3/2011 by Andrew Keller
		  
		  // Sets whether automatically deleting this FolderItem is enabled.
		  
		  p_enable_autodelete = new_value
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AutoDeleteIsRecursive() As Boolean
		  // Created 9/3/2011 by Andrew Keller
		  
		  // Returns whether automatically deleting this FolderItem is recursive.
		  
		  Return p_autodelete_recursive
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AutoDeleteIsRecursive(Assigns new_value As Boolean)
		  // Created 9/3/2011 by Andrew Keller
		  
		  // Sets whether automatically deleting this FolderItem is recursive.
		  
		  p_autodelete_recursive = new_value
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor()
		  // Created 9/4/2011 by Andrew Keller
		  
		  // The standard constructor.
		  
		  // Allocates a new temporary file rather than
		  // pointing to the application's directory.
		  
		  // This is implemented by allocating the file
		  // and redirecting to the clone constructor.
		  
		  Super.Constructor( core_autoallocate( Nil, "", "", True, False ) )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(other As AutoDeletingFolderItemKFS)
		  // Created 9/3/2011 by Andrew Keller
		  
		  // A clone constructor.
		  
		  Super.Constructor( other )
		  
		  p_autodelete_recursive = other.p_autodelete_recursive
		  p_enable_autodelete = other.p_enable_autodelete
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function core_autoallocate(parent_folder As FolderItem, base_name As String, extension As String, create_as_file As Boolean, create_as_folder As Boolean) As FolderItem
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  // Created 9/3/2011 by Andrew Keller
		  
		  // Delete this FolderItem from the disk.
		  
		  If AutoDeleteEnabled Then
		    
		    Try
		      
		      Me.DeleteKFS AutoDeleteIsRecursive
		      
		    Catch err As CannotDeleteFilesystemEntryExceptionKFS
		      
		      System.Log System.LogLevelError, err.Message + " (error code " + Str( err.ErrorNumber ) + ")"
		      
		    End Try
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewTemporaryFile(parent_folder As FolderItem, base_name As String = "", extension As String = "") As AutoDeletingFolderItemKFS
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a new temporary file within the given folder.
		  
		  Return New AutoDeletingFolderItemKFS( core_autoallocate( parent_folder, base_name, extension, True, False ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewTemporaryFile(base_name As String = "", extension As String = "") As AutoDeletingFolderItemKFS
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a new temporary file within the default temporary folder.
		  
		  Return New AutoDeletingFolderItemKFS( core_autoallocate( Nil, base_name, extension, True, False ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewTemporaryFolder(parent_folder As FolderItem, base_name As String = "", extension As String = "") As AutoDeletingFolderItemKFS
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a new temporary folder within the given folder.
		  
		  Return New AutoDeletingFolderItemKFS( core_autoallocate( parent_folder, base_name, extension, False, True ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewTemporaryFolder(base_name As String = "", extension As String = "") As AutoDeletingFolderItemKFS
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a new temporary folder within the default temporary folder.
		  
		  Return New AutoDeletingFolderItemKFS( core_autoallocate( Nil, base_name, extension, False, True ) )
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2011 Andrew Keller.
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
		Protected p_autodelete_recursive As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_enable_autodelete As Boolean = True
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AbsolutePath"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Alias"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Count"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Directory"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DisplayName"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Exists"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ExtensionVisible"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Group"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsReadable"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsWriteable"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LastErrorCode"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Locked"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacCreator"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacDirID"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacType"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="MacVRefNum"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Owner"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ResourceForkLength"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShellPath"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
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
		#tag ViewProperty
			Name="Type"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="URLPath"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Group="Behavior"
			InitialValue="0"
			Type="Boolean"
			InheritedFrom="FolderItem"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
