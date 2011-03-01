#tag Module
Protected Module BSDGlobalsKFS_FileIO
	#tag Method, Flags = &h0
		Function EqualsKFS(Extends f As FolderItem, g As FolderItem) As Boolean
		  // Created 2005 by someone
		  
		  // returns whether or not the two given
		  // folderitems point to the same location
		  
		  If (f Is Nil) = (g Is Nil) Then
		    If f Is Nil Then
		      Return True // because both are Nil
		    Else
		      If TargetMacOS Then
		        Return f.Name = g.Name And f.MacDirID = g.MacDirID And f.MacVRefNum = g.MacVRefNum
		      ElseIf TargetWin32 Then
		        Return (f.AbsolutePath = g.AbsolutePath)
		      ElseIf TargetLinux Then
		        Return (StrComp(f.AbsolutePath,g.AbsolutePath,0)=0)
		      End If
		    End If
		  Else
		    Return False // because exactly one of them is Nil
		  End If
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetFolderitemKFS(path As String) As FolderItem
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Returns a folderitem representing the given path,
		  // taking the current working directory into account.
		  
		  #if TargetMacOSClassic
		    #pragma Error "The behavior of the GetFolderitemKFS function is not defined on Mac OS Classic."
		  #endif
		  
		  Try
		    Return GetFolderItem( path, FolderItem.PathTypeShell )
		  Catch
		  End Try
		  
		  Try
		    #if TargetWin32 then
		      Return GetFolderItem( SpecialFolder.CurrentWorkingDirectory.ShellPath + "\" + path, FolderItem.PathTypeShell )
		    #else
		      Return GetFolderItem( SpecialFolder.CurrentWorkingDirectory.ShellPath + "/" + path, FolderItem.PathTypeShell )
		    #endif
		  Catch
		  End Try
		  
		  Return Nil
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetStandardAccessErrorMessageKFS(f As FolderItem, mustExist As Boolean, mustBeAFile As Boolean, mustBeAFolder As Boolean, mustBeReadable As Boolean, mustBeWritable As Boolean) As String
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Returns a message explaining which criteria the given folderitem fails.
		  
		  If f Is Nil Then Return "File not found, or insufficient privileges to access parent directory"
		  
		  If mustExist And Not f.Exists Then
		    If Not ( f.Parent Is Nil ) Then
		      If f.Parent.IsReadable Then
		        
		        Return "File not found"
		        
		      Else
		        
		        Return "Permission denied"
		        
		      End If
		    End If
		  End If
		  
		  If f.Exists And mustBeAFile And f.Directory Then Return "Not a regular file"
		  
		  If f.Exists And mustBeAFolder And Not f.Directory Then Return "Not a directory"
		  
		  If f.Exists And mustBeReadable And Not f.IsReadable Then Return "Permission denied"
		  
		  If mustBeWritable And Not f.IsWriteable Then Return "Permission denied"
		  
		  Return ""
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextSerialNameKFS(Extends fDirectory As Folderitem, sFileName As String, sDeliminator As String = " ") As String
		  // returns the next unique file name
		  // based off sFileName in fDirectory
		  
		  // uses NextSerialNumber to add an integer
		  // right before the extension of sFileName
		  
		  // Created 8/16/2006 by Andrew Keller
		  // Modified 5/28/2008 by Andrew Keller
		  
		  // NOTE: TO CHECK FOR ERRORS...
		  //    make sure your result doesn't
		  //    start with "!err"
		  
		  Dim sLeft, sRight, sRslt As String
		  Dim iDecCount As Integer
		  
		  If Not ( fDirectory Is Nil ) Then
		    If fDirectory.Exists Then
		      
		      iDecCount = CountFields(sFileName, ".")
		      
		      If iDecCount > 1 Then
		        
		        sRight = "." + NthField(sFileName, ".", iDecCount)
		        
		        sLeft = Left(sFileName, len(sFileName) - len(sRight))
		        
		      Else
		        
		        sLeft = sFileName
		        sRight = ""
		        
		      End If
		      
		      sRslt = sLeft + fDirectory.NextSerialNumberKFS(sLeft, sRight, True, sDeliminator) + sRight
		      
		    Else
		      sRslt = "!err: fDirectory does not exist."
		    End If
		  Else
		    sRslt = "!err: fDirectory is Nil."
		  End If
		  
		  Return sRslt
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NextSerialNumberKFS(Extends fDirectory As Folderitem, sNameStart As String, sNameEnd As String, bZeroIsBlank As Boolean = True, sLeftSide As String = " ", sRightSide As String = "", sSerialFormat As String = "0", iSerialStart As Integer = 0) As String
		  // finds the next unused serial number
		  // given the folder and file name
		  
		  // Created 8/16/2006 by Andrew Keller
		  
		  // bZeroIsBlank = True means that
		  // item zero doesn't have any number on it
		  
		  // file names are constructed using:
		  // sNameStart + sLeftSide + Format(iCurNum, sSerialFormat) + sRightSide + sNameEnd
		  // and if bZeroIsBlank and iCurNum = 0:
		  // sNameStart + sNameEnd
		  
		  // regarding the above comment, notice
		  // that the default value for sLeftSide is a space
		  // and the default value for sRightSide is nothing
		  
		  // NOTE: TO CHECK FOR ERRORS...
		  //    make sure your result doesn't
		  //    start with "!err"
		  
		  Dim iCurNum As Integer = iSerialStart
		  Dim bContinue As Boolean = True
		  Dim sRslt As String
		  
		  If Not ( fDirectory Is Nil ) Then
		    If fDirectory.Exists Then
		      
		      If iCurNum = 0 And bZeroIsBlank Then
		        
		        If fDirectory.Child(sNameStart + sNameEnd).Exists Then
		          
		          iCurNum = iCurNum + 1
		        Else
		          sRslt = ""
		          bContinue = False
		          
		        End If
		        
		      End If
		      
		      
		      If bContinue Then
		        
		        While fDirectory.Child(sNameStart + sLeftSide + Format(iCurNum, sSerialFormat) + sRightSide + sNameEnd).Exists
		          
		          iCurNum = iCurNum + 1
		          
		        Wend
		        
		        sRslt = sLeftSide + Format(iCurNum, sSerialFormat) + sRightSide
		        
		      End If
		      
		      
		      // at this point, we have found a number that is unique number
		      
		      Return sRslt
		      
		    Else
		      Return "!err: fDirectory does not exist."
		    End If
		  Else
		    Return "!err: fDirectory is Nil."
		  End If
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ShellPathKFS(Extends f As Folderitem, bShellSpaces As Boolean = False, bForceUnixSlashes As Boolean = False) As String
		  // returns the given folderitem's path as a string
		  // the way I (Andrew Keller) want
		  
		  // available on all platforms
		  
		  // Created 10/1/2005 by Andrew Keller
		  // Modified 11/28/2008 --;
		  
		  Dim sRtn As String
		  
		  #if TargetCarbon then
		    
		    If bShellSpaces Then
		      sRtn = f.ShellPath
		    Else
		      sRtn = f.AbsolutePath
		      sRtn = Mid( sRtn, len( NthField( sRtn, ":", 1 ) ) +1 )
		      sRtn = ReplaceAll(sRtn, ":", "/")
		    End If
		    
		    If f.Directory And Right(sRtn,1) <> "/" Then
		      sRtn = sRtn + "/"
		    End If
		    
		  #elseif TargetLinux then
		    
		    sRtn = f.ShellPath
		    
		    If bShellSpaces Then
		      sRtn = ReplaceAll(sRtn, " ", "\ ")
		    End If
		    
		  #elseif TargetMacOSClassic then
		    
		    sRtn = f.AbsolutePath
		    
		    If bForceUnixSlashes Then
		      sRtn = ReplaceAll(sRtn, ":", "/")
		      sRtn = "/" + sRtn
		      
		      If bShellSpaces Then
		        sRtn = ReplaceAll(sRtn, " ", "\ ")
		      End If
		    End If
		    
		    If f.Directory And Right(sRtn,1) <> "/" Then
		      sRtn = sRtn + "/"
		    End If
		    
		  #elseif TargetWin32 then
		    
		    sRtn = f.AbsolutePath
		    
		    If f.Directory And Right(sRtn,1) <> "\" Then
		      sRtn = sRtn + "\"
		    End If
		    
		    If bForceUnixSlashes then
		      sRtn = sRtn.ReplaceAll("\", "/")
		      
		      If bShellSpaces Then
		        sRtn = ReplaceAll(sRtn, " ", "/ ")
		      End If
		    End If
		    
		  #endif
		  
		  Return sRtn
		  
		  // done.
		  
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This module is licensed as BSD.
		
		Copyright (c) 2010 Andrew Keller, et al.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a full list of all contributors.
		
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
End Module
#tag EndModule
