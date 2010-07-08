#tag Class
Protected Class PropertyListKFS_XML1
Inherits PropertyListKFS
	#tag Method, Flags = &h1000
		Sub Constructor(_file As FolderItem)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Initializes this instance with the data contained in the given FolderItem.
		  
		  Constructor
		  
		  File = _file
		  
		  Revert
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1000
		Sub Constructor(xdoc As XmlDocument)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Initializes this instance with the data contained in the given XmlDocument.
		  
		  Constructor
		  
		  File = Nil
		  
		  Revert xdoc
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function EscapeString(original As String) As String
		  // Created 1/9/2010 by Andrew Keller
		  
		  // Returns an escaped version of the given string.
		  
		  Dim xdoc As New XmlDocument
		  
		  xdoc.AppendChild xdoc.CreateTextNode( original )
		  
		  // xdoc now contains something like: <?xml version="1.0" encoding="UTF-8"?>hello&lt;world
		  
		  // We do not know how long either section is, however we
		  // do know the first section is enclosed in <> brackets,
		  // and <> brackets are illegal in the second section.
		  
		  Dim result() As String = xdoc.ToString.Split( ">" )
		  
		  Dim index As Integer = result.Ubound
		  
		  If index < 0 Then Return ""
		  
		  Return result( index )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Log(ParamArray msgs As String)
		  // Created 1/8/2010 by Andrew Keller
		  
		  // Symlink to the NewStatusReportKFS function.
		  
		  NewStatusReportKFS "PropertyListKFS_XML1.Revert*", 4, False, msgs
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Revert()
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Reinitializes this instance with the data contained in the default FolderItem.
		  
		  If File <> Nil Then
		    
		    Revert File
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Revert(src As BigStringKFS)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Reinitializes this instance with the data contained in the given FolderItem.
		  
		  Dim xdoc As XmlDocument = Nil
		  
		  If src <> Nil And src.StringDataCanBeAccessed Then
		    
		    // First, make sure this thing is not in the BPList or CPList format.
		    
		    Dim beginning As String = src.GetStreamAccess.Read( 6 )
		    
		    If beginning.Left( 6 ) = "bplist" Or beginning.Left( 1 ) = "{" Or beginning.Left( 1 ) = "(" Then
		      
		      // The file contains a binary property list (first condition),
		      // or it contains a text property list (second and third conditions)
		      
		      #if TargetMacOS then
		        
		        Try
		          
		          src.Consolidate
		          src.ForceStringDataToDisk
		          
		          Dim sh As New Shell
		          sh.Execute "plutil -convert xml1 " + src.FolderitemValue(True).ShellPath
		          
		        Catch err
		          
		          Raise New UnsupportedFormatException
		          
		        End Try
		        
		      #else
		        
		        Raise New UnsupportedFormatException
		        
		      #endif
		      
		    End If
		    
		    xdoc = New XmlDocument( src.StringValue )
		    
		  End If
		  
		  Revert xdoc
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Revert(xdoc As XmlDocument)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Reinitializes this instance with the data contained in the given XmlDocument.
		  
		  If xdoc <> Nil Then
		    
		    // This XML file may or may not contain more than
		    // just an Apple Property List.  If it does, we
		    // don't care.  All we care about is the plist key,
		    // which is the containing node of Apple Property Lists.
		    
		    Log "Received an XmlDocument to import.", "Contents:", xdoc.ToString
		    
		    Dim xele, node As XmlNode = xdoc.DocumentElement
		    
		    If xele <> Nil Then
		      
		      node = xele.Lookup( "dict" )
		      
		      If node <> Nil Then
		        
		        // found a dictionary node.
		        
		        Revert node
		        
		      Else
		        
		        node = xele.Lookup( "array" )
		        
		        If node <> Nil Then
		          
		          // found an array node.
		          
		          Revert node
		          
		        Else
		          
		          // could not find either a dictionary or array node.
		          
		        End If
		      End If
		    Else
		      
		      // Could not access the document element.
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Revert(xele As XmlNode)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Reinitializes this instance with the data contained in the given XmlDocument.
		  
		  Clear
		  
		  If xele <> Nil Then
		    
		    // Insert code here.
		    
		    Log "Received an XmlNode to import.", "Name: " + xele.Name, "Number of children: " + str( xele.ChildCount )
		    
		    Select Case xele.Name
		      
		    Case "dict"
		      Me.Type = kNodeTypeDictionary
		      
		      // This node has children.  Add them.
		      
		      Dim xKey, xValue As XmlNode
		      Dim index, last As Integer = xele.ChildCount -1
		      
		      If last Mod 2 = 0 Then Raise New UnsupportedFormatException
		      
		      For index = 1 To last Step 2
		        
		        // In a dictionary node, all odd indices MUST be keys, all even
		        // indices MUST be values, and keys and values must be pairs.
		        
		        xKey = xele.Child( index -1 )
		        xValue = xele.Child( index )
		        
		        // Basic verification...
		        
		        If xKey = Nil Or xValue = Nil Then Raise New UnsupportedFormatException
		        If xKey.Name <> "key" Then Raise New UnsupportedFormatException
		        
		        Log "Found a key-value pair: " + xKey.Name + " => " + xValue.Name
		        
		        // Add this child
		        
		        Dim c As New PropertyListKFS_XML1
		        c.Revert xValue
		        Me.Child( xKey.FirstChild.Value ) = c
		        
		      Next
		      
		    Case "array"
		      Me.Type = kNodeTypeArray
		      
		      // This node has children.  Add them.
		      
		      Dim xValue As XmlNode
		      Dim index, last As Integer = xele.ChildCount -1
		      
		      For index = 0 To last
		        
		        // An array node has a simple list of items.
		        
		        xValue = xele.Child( index )
		        
		        // Basic verification...
		        
		        If xValue = Nil Then Raise New UnsupportedFormatException
		        
		        Log "Found an array item: " + xValue.Name
		        
		        // Add this child
		        
		        Dim c As New PropertyListKFS_XML1
		        c.Revert xValue
		        Me.Child( index ) = c
		        
		      Next
		      
		    Case "true"
		      Me.Type = kNodeTypeBoolean
		      Me.Value = True
		      
		    Case "false"
		      Me.Type = kNodeTypeBoolean
		      Me.Value = False
		      
		    Case "integer"
		      Me.Type = kNodeTypeNumber
		      If xele.FirstChild = Nil Then
		        Me.Value = 0
		      Else
		        Me.Value = xele.FirstChild.Value
		      End If
		      
		    Case "real"
		      Me.Type = kNodeTypeNumber
		      If xele.FirstChild = Nil Then
		        Me.Value = 0
		      Else
		        Me.Value = xele.FirstChild.Value
		      End If
		      
		    Case "string"
		      Me.Type = kNodeTypeString
		      If xele.FirstChild = Nil Then
		        Me.Value = ""
		      Else
		        Me.Value = xele.FirstChild.Value
		      End If
		      
		    Case "date"
		      Me.Type = kNodeTypeDate
		      If xele.FirstChild = Nil Then
		        Me.Value = ""
		      Else
		        Me.Value = xele.FirstChild.Value
		      End If
		      
		    Case "data"
		      Me.Type = kNodeTypeData
		      If xele.FirstChild = Nil Then
		        Me.Value = ""
		      Else
		        Me.Value = DecodeBase64( xele.FirstChild.Value )
		      End If
		      
		    Else
		      
		      NewStatusReportKFS "PropertyListKFS_XML1.Revert( XmlNode )", 0, True, "Unsupported PList value: " + xele.Name
		      
		    End Select
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save()
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Saves the data contained in this instance to the default FolderItem.
		  
		  If File <> Nil Then
		    
		    Save BinaryStream.Create( File, True )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Save(dest As BinaryStream)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Saves the data contained in this instance to the given BinaryStream.
		  
		  If dest <> Nil Then
		    
		    // Write the standard header.
		    
		    dest.Write kXML1Prefix
		    
		    // Write the core data
		    
		    SaveChild Me, dest, ""
		    
		    dest.Write "</plist>" + chr(10)
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub SaveChild(node As PropertyListKFS, dest As BinaryStream, tabs As String)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Saves the data contained in this instance to the given BinaryStream.
		  
		  If dest <> Nil Then
		    
		    Select Case node.Type
		      
		    Case kNodeTypeDictionary
		      
		      If node.Count > 0 Then
		        
		        dest.Write tabs + "<dict>" + chr(10)
		        
		        For Each k As Variant In node.Keys
		          
		          dest.Write tabs+chr(9) + "<key>" + EscapeString(k) + "</key>" + chr(10)
		          
		          SaveChild node.Child(k), dest, tabs+chr(9)
		          
		        Next
		        
		        dest.Write tabs + "</dict>" + chr(10)
		        
		      Else
		        dest.Write tabs + "<dict/>" + chr(10)
		      End If
		      
		    Case kNodeTypeArray
		      
		      If node.Count > 0 Then
		        
		        dest.Write tabs + "<array>" + chr(10)
		        
		        For Each n As PropertyListKFS In node.Children
		          
		          SaveChild n, dest, tabs+chr(9)
		          
		        Next
		        
		        dest.Write tabs + "</array>" + chr(10)
		        
		      Else
		        dest.Write tabs + "<array/>" + chr(10)
		      End If
		      
		    Case kNodeTypeBoolean
		      
		      If node.Value.BooleanValue Then
		        
		        dest.Write tabs + "<true/>" + chr(10)
		      Else
		        dest.Write tabs + "<false/>" + chr(10)
		      End If
		      
		    Case kNodeTypeNumber
		      
		      Dim dNum As Double = node.Value
		      Dim iNum As Integer = dNum
		      
		      If iNum = dNum Then
		        
		        dest.Write tabs + "<integer>" + str( iNum ) + "</integer>" + chr(10)
		      Else
		        dest.Write tabs + "<real>" + str( dNum ) + "</real>" + chr(10)
		      End If
		      
		    Case kNodeTypeString
		      dest.Write tabs + "<string>" + EscapeString(node.Value.StringValue) + "</string>" + chr(10)
		      
		    Case kNodeTypeDate
		      dest.Write tabs + "<date>" + EscapeString(node.Value.StringValue) + "</date>" + chr(10)
		      
		    Case kNodeTypeData
		      dest.Write tabs + "<data>" + EncodeBase64( node.Value.StringValue, 0 ) + "</data>" + chr(10)
		      
		    Else
		      Raise New UnsupportedFormatException
		    End Select
		    
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
		File As FolderItem
	#tag EndProperty


	#tag Constant, Name = kXML1Prefix, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="AutoSaveInDestructor"
			Group="Behavior"
			Type="Boolean"
			InheritedFrom="PropertyListKFS"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BinCount"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Dictionary"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Count"
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			InheritedFrom="Dictionary"
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
