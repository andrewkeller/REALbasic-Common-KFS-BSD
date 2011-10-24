#tag Class
Protected Class AutoDeletingFolderItemKFS
Inherits FolderItem
	#tag Method, Flags = &h0
		Function AutoDeleteEnabled() As Boolean
		  // Created 9/3/2011 by Andrew Keller
		  
		  // Returns whether automatically deleting this FolderItem is enabled.
		  
		  Return p_autodelete_enabled
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AutoDeleteEnabled(Assigns new_value As Boolean)
		  // Created 9/3/2011 by Andrew Keller
		  
		  // Sets whether automatically deleting this FolderItem is enabled.
		  
		  p_autodelete_enabled = new_value
		  
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

	#tag Method, Flags = &h0
		Function AutoDeleteTriesInCurrentThreadFirst() As Boolean
		  // Created 10/22/2011 by Andrew Keller
		  
		  // Returns whether or not deleting is done in a background thread.
		  
		  Return p_autodelete_tryincurrentthreadfirst
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AutoDeleteTriesInCurrentThreadFirst(Assigns new_value As Boolean)
		  // Created 10/22/2011 by Andrew Keller
		  
		  // Sets whether or not deleting is done in a background thread.
		  
		  p_autodelete_tryincurrentthreadfirst = new_value
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Attributes( Hidden = True )  Sub Constructor(other As AutoDeletingFolderItemKFS)
		  // Created 9/3/2011 by Andrew Keller
		  
		  // A clone constructor.
		  
		  Super.Constructor( other )
		  
		  p_autodelete_enabled = other.p_autodelete_enabled
		  p_autodelete_recursive = other.p_autodelete_recursive
		  p_autodelete_tryincurrentthreadfirst = other.p_autodelete_tryincurrentthreadfirst
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function core_autoallocate(parent_folder As FolderItem, base_name As String, extension As String, create_as_file As Boolean, create_as_folder As Boolean) As FolderItem
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a FolderItem inside the given parent folder with
		  // the given name characteristics.  Optionally can also
		  // create the FolderItem as a file or folder.
		  
		  // Verify that the given parent folder is valid:
		  
		  parent_folder = core_verifytempfolder( parent_folder )
		  
		  // At this point, the parent folder exists, is a folder, and is likely writable.
		  
		  Dim index As Integer = -1
		  Dim result As FolderItem = Nil
		  
		  Do
		    
		    index = index + 1
		    result = parent_folder.Child( generate_name( base_name, index, extension ) )
		    
		    If Not result.Exists Then
		      
		      // Yay!  We found a name that's not used!
		      
		      If create_as_file Then
		        
		        Dim bs As BinaryStream = BinaryStream.Create( result, True )
		        
		        If Not ( bs Is Nil ) Then
		          
		          // Yay!  The file has been reserved!
		          
		          bs.Close
		          Return result
		          
		        ElseIf result.Exists Then
		          
		          // This is the only error we will let slide.
		          
		        Else
		          
		          Dim err As New CannotCreateFilesystemEntryExceptionKFS
		          err.ErrorNumber = result.LastErrorCode
		          err.Message = "Cannot create a temporary file at "+result.AbsolutePath+" due to an error of type "+Str(result.LastErrorCode)+"."
		          Raise err
		          
		        End If
		        
		      ElseIf create_as_folder Then
		        
		        result.CreateAsFolder
		        
		        If result.Directory Then
		          
		          // Yay!  The folder creation worked!
		          
		          Return result
		          
		        ElseIf result.Exists Then
		          
		          // This is the only error we will let slide.
		          
		        Else
		          
		          Dim err As New CannotCreateFilesystemEntryExceptionKFS
		          err.ErrorNumber = result.LastErrorCode
		          err.Message = "Cannot create a temporary folder at "+result.AbsolutePath+" due to an error of type "+Str(result.LastErrorCode)+"."
		          Raise err
		          
		        End If
		        
		      Else
		        
		        // The calling function did not want anything done with the new file or folder.
		        
		        Return result
		        
		      End If
		    End If
		  Loop
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function core_gettempfolder() As FolderItem
		  // Created 9/10/2011 by Andrew Keller
		  
		  // Returns a temporary folder that we have write access to.
		  
		  Dim result As FolderItem = SpecialFolder.Temporary
		  
		  // Make sure the temporary folder is valid:
		  
		  If result Is Nil Then
		    
		    System.Log System.LogLevelError, "Error: SpecialFolder.Temporary returned Nil."
		    
		    Dim err As New NilObjectException
		    err.Message = "Unable to access the temporary folder because SpecialFolder.Temporary returned Nil."
		    Raise err
		    
		  End If
		  
		  If Not result.Exists Then
		    
		    System.Log System.LogLevelError, "Error: SpecialFolder.Temporary returned a path that does not exist: " + result.AbsolutePath
		    
		    Dim err As New CannotAccessFilesystemEntryExceptionKFS
		    err.ErrorNumber = result.DestDoesNotExistError
		    err.Message = "Unable to access the temporary folder.  SpecialFolder.Temporary returned a path that does not exist."
		    Raise err
		    
		  End If
		  
		  If result.Exists And Not result.Directory Then
		    
		    System.Log System.LogLevelError, "Error: SpecialFolder.Temporary returned a path that is a file: " + result.AbsolutePath
		    
		    Dim err As New CannotAccessFilesystemEntryExceptionKFS
		    err.ErrorNumber = result.InvalidName
		    err.Message = "Unable to use the temporary folder.  SpecialFolder.Temporary returned a file."
		    Raise err
		    
		  End If
		  
		  If Not result.IsWriteable Then
		    
		    System.Log System.LogLevelError, "Error: SpecialFolder.Temporary returned a directory that this program does not have write access to: " + result.AbsolutePath
		    
		    Dim err As New CannotAccessFilesystemEntryExceptionKFS
		    err.ErrorNumber = result.AccessDenied
		    err.Message = "Cannot access '"+result.AbsolutePath+"': Access Denied."
		    Raise err
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function core_verifytempfolder(f As FolderItem) As FolderItem
		  // Created 9/10/2011 by Andrew Keller
		  
		  // Makes sure that the given FolderItem is a valid temporary folder.
		  
		  // Returns the FolderItem if it is valid.  Raises an exception if it is not.
		  
		  Dim result As FolderItem = f
		  
		  If result Is Nil Then
		    
		    Dim err As New NilObjectException
		    err.Message = "Unable to access the given FolderItem because it is Nil."
		    Raise err
		    
		  End If
		  
		  If Not result.Exists Then
		    
		    result.CreateAsFolder
		    
		    If Not result.Exists Then
		      
		      Dim err As New CannotCreateFilesystemEntryExceptionKFS
		      err.ErrorNumber = result.LastErrorCode
		      err.Message = "Unable to create the directory '"+result.AbsolutePath+"' because of an error of type "+Str(result.LastErrorCode)+"."
		      Raise err
		      
		    End If
		  End If
		  
		  If result.Exists And Not result.Directory Then
		    
		    Dim err As New CannotAccessFilesystemEntryExceptionKFS
		    err.ErrorNumber = result.InvalidName
		    err.Message = "Cannot use '"+result.AbsolutePath+"' because it is not a folder (a directory is required)."
		    Raise err
		    
		  End If
		  
		  If Not result.IsWriteable Then
		    
		    Dim err As New CannotAccessFilesystemEntryExceptionKFS
		    err.ErrorNumber = result.AccessDenied
		    err.Message = "Cannot access '"+result.AbsolutePath+"': Access Denied."
		    Raise err
		    
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function DefaultDeletePool() As DeletePoolKFS
		  // Created 10/16/2011 by Andrew Keller
		  
		  // Returns the current default delete pool object.
		  
		  Return p_default_delete_pool
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub DefaultDeletePool(Assigns new_value As DeletePoolKFS)
		  // Created 10/16/2011 by Andrew Keller
		  
		  // Returns the current default delete pool object.
		  
		  p_default_delete_pool = new_value
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeletePool() As DeletePoolKFS
		  // Created 10/16/2011 by Andrew Keller
		  
		  // Returns the current delete pool object.
		  
		  Return p_delete_pool
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeletePool(Assigns new_value As DeletePoolKFS)
		  // Created 10/16/2011 by Andrew Keller
		  
		  // Returns the current delete pool object.
		  
		  p_delete_pool = new_value
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Attributes( Hidden = True )  Sub Destructor()
		  // Created 9/3/2011 by Andrew Keller
		  
		  // Delete this FolderItem from the disk.
		  
		  If AutoDeleteEnabled Then
		    
		    GetDeletePool.AddFolderitem New FolderItem( Me ), AutoDeleteIsRecursive, AutoDeleteTriesInCurrentThreadFirst
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function generate_name(base_name As String, index As Integer, extension As String) As String
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a file name based on the given info.
		  
		  If base_name = "" And extension = "" Then
		    
		    Return Format( index, kFileNameIndexFormatWithoutBaseName )
		    
		  ElseIf base_name = "" Then
		    
		    Return Format( index, kFileNameIndexFormatWithoutBaseName ) + "." + extension
		    
		  ElseIf extension = "" Then
		    
		    Return base_name + Format( index, kFileNameIndexFormatAfterBaseName )
		    
		  Else
		    
		    Return base_name + Format( index, kFileNameIndexFormatAfterBaseName ) + "." + extension
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetDeletePool() As DeletePoolKFS
		  // Created 10/16/2011 by Andrew Keller
		  
		  // Returns the delete pool object that
		  // should be used if needed right now.
		  
		  If Not ( p_delete_pool Is Nil ) Then
		    
		    Return p_delete_pool
		    
		  End If
		  
		  If p_default_delete_pool Is Nil Then
		    
		    p_default_delete_pool = New DeletePoolKFS
		    
		  End If
		  
		  Return p_default_delete_pool
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewTemporaryFile(parent_folder As FolderItem, base_name As String = kDefaultBaseName, extension As String = "") As AutoDeletingFolderItemKFS
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a new temporary file within the given folder.
		  
		  Dim result As New AutoDeletingFolderItemKFS( core_autoallocate( parent_folder, base_name, extension, True, False ) )
		  
		  result.AutoDeleteEnabled = True
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewTemporaryFile(base_name As String = kDefaultBaseName, extension As String = "") As AutoDeletingFolderItemKFS
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a new temporary file within the default temporary folder.
		  
		  Dim result As New AutoDeletingFolderItemKFS( core_autoallocate( core_gettempfolder, base_name, extension, True, False ) )
		  
		  result.AutoDeleteEnabled = True
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewTemporaryFolder(parent_folder As FolderItem, base_name As String = kDefaultBaseName, extension As String = "") As AutoDeletingFolderItemKFS
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a new temporary folder within the given folder.
		  
		  Dim result As New AutoDeletingFolderItemKFS( core_autoallocate( parent_folder, base_name, extension, False, True ) )
		  
		  result.AutoDeleteEnabled = True
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function NewTemporaryFolder(base_name As String = kDefaultBaseName, extension As String = "") As AutoDeletingFolderItemKFS
		  // Created 9/4/2011 by Andrew Keller
		  
		  // Returns a new temporary folder within the default temporary folder.
		  
		  Dim result As New AutoDeletingFolderItemKFS( core_autoallocate( core_gettempfolder, base_name, extension, False, True ) )
		  
		  result.AutoDeleteEnabled = True
		  
		  Return result
		  
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
		Protected p_autodelete_enabled As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_autodelete_recursive As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_autodelete_tryincurrentthreadfirst As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected Shared p_default_delete_pool As DeletePoolKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_delete_pool As DeletePoolKFS
	#tag EndProperty


	#tag Constant, Name = kDefaultBaseName, Type = String, Dynamic = False, Default = \"AutoDeletingFolderItemKFS", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kFileNameIndexFormatAfterBaseName, Type = String, Dynamic = False, Default = \"\\-0;\\-0;", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kFileNameIndexFormatWithoutBaseName, Type = String, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant


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
