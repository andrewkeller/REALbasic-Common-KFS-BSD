#tag Class
Private Class ApplePListSerialHelper
Inherits PropertyListKFS
	#tag Method, Flags = &h0
		 Shared Function core_data_could_be_APList(srcData As BigStringKFS) As Boolean
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Returns whether or not it is likely that the given data is an Apple Property List.
		  
		  If srcData Is Nil Then Return False
		  If srcData.LenB = 0 Then Return False
		  
		  Dim firstFewBytes As String = srcData.LeftB( 1000 ).LTrim
		  
		  If firstFewBytes.LeftB( 1 ) = "<" Then
		    
		    // See if we can find evidence of an Apple PList.
		    
		    Dim i As Integer = firstFewBytes.InStrB( "-//Apple//DTD PLIST 1.0//EN" )
		    
		    If i > 0 Then
		      
		      If firstFewBytes.InStrB( "http://www.apple.com/DTDs/PropertyList-1.0.dtd" ) > i Then
		        
		        Return True
		        
		      End If
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function core_deserialize(srcData As BinaryStream, pgd As ProgressDelegateKFS) As PropertyListKFS
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Deserializes the given data, assuming it is an Apple Property List.
		  
		  // Set up a sandboxed parsing environment.
		  
		  Dim p As New ApplePListSerialHelper
		  Dim xr As New XmlReader
		  
		  AddHandler xr.Characters, AddressOf p.xre_ElementText
		  AddHandler xr.EndDoctypeDecl, AddressOf p.xre_DoctypeDeclEnd
		  AddHandler xr.EndDocument, AddressOf p.xre_DocumentEnd
		  AddHandler xr.EndElement, AddressOf p.xre_ElementEnd
		  AddHandler xr.ExternalEntityRef, AddressOf p.xre_DoctypeVerifyExternalEntityRef
		  AddHandler xr.StartDocument, AddressOf p.xre_DocumentStart
		  AddHandler xr.StartDoctypeDecl, AddressOf p.xre_DoctypeDeclStart
		  AddHandler xr.StartElement, AddressOf p.xre_ElementStart
		  AddHandler xr.XmlDecl, AddressOf p.xre_DocumentXmlDecl
		  
		  // Feed the data to the parser.
		  
		  Try
		    
		    // If an IOException is raised here, then there is something wrong with
		    // the source data, and we can't fix it from here.  Let the exception go.
		    
		    #pragma BreakOnExceptions Off
		    
		    // We could just feed the whole thing all at once, but doing it
		    // piece by piece allows for easily updating the progress delegate.
		    
		    // In the future, try alternating the comments in the following lines.
		    // In development, parsing the data piece by piece caused problems.
		    
		    xr.Parse srcData.Read( srcData.Length ), True
		    'While Not srcData.EOF
		    'xr.Parse srcData.Read( 10 ), False
		    'If Not ( pgd Is Nil ) Then pgd.Value = srcData.Position / srcData.Length
		    'Wend
		    'xr.Parse "", True
		    
		  Catch err As XmlException
		    fail_fmt "The XML parser failed with message: " + err.Message
		  Catch err As XmlReaderException
		    fail_fmt "The XML parser failed with message: " + err.Message
		  End Try
		  
		  // It looks like the parser finished without raising an exception.
		  
		  // We're done here.
		  
		  Return p
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Sub core_serialize(srcNode As PropertyListKFS, destBuffer As BinaryStream, pgd As ProgressDelegateKFS, truncate As Boolean)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Serializes the given PropertyListKFS node
		  // into the given destination buffer using the
		  // Apple Property List format, and reports
		  // progress through the given progress delegate.
		  
		  If destBuffer Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "Cannot serialize a PropertyListKFS object to a Nil output stream."
		    Raise e
		    
		  End If
		  
		  destBuffer.Position = 0
		  
		  destBuffer.Write kAPListHeader
		  
		  If Not ( srcNode Is Nil ) Then
		    
		    write_dir srcNode, destBuffer, pgd, 0
		    
		  End If
		  
		  destBuffer.Write kAPListFooter
		  
		  If truncate Then destBuffer.Length = destBuffer.Position
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function strv(v As Variant) As String
		  // Created 3/14/2011 by Andrew Keller
		  
		  // Converts the given value into a string.
		  
		  Return v
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub write_dir(srcNode As PropertyListKFS, destBuffer As BinaryStream, pgd As ProgressDelegateKFS, indent As Integer)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Serializes the given PropertyListKFS node
		  // into the given destination buffer using the
		  // Apple Property List format, and reports
		  // progress through the given progress delegate.
		  
		  If Not ( srcNode Is Nil ) Then
		    
		    Dim core As Dictionary = srcNode
		    
		    // What type of directory is this?
		    
		    If srcNode.TreatAsArray Then
		      
		      // This is an array.
		      
		      If srcNode.DataCore.Count > 0 Then
		        
		        write_text destBuffer, indent, "<array>"
		        
		        For Each k As Variant In srcNode.Keys
		          
		          write_value core.Value( k ), destBuffer, pgd, indent + 1
		          
		        Next
		        
		        write_text destBuffer, indent, "</array>"
		        
		      Else
		        
		        write_text destBuffer, indent, "<array/>"
		        
		      End If
		      
		    Else
		      
		      // This is a Dictionary.
		      
		      If core.Count > 0 Then
		        
		        write_text destBuffer, indent, "<dict>"
		        
		        For Each k As Variant In srcNode.Keys
		          
		          write_value k, destBuffer, pgd, indent + 1, True
		          write_value core.Value( k ), destBuffer, pgd, indent + 1
		          
		        Next
		        
		        write_text destBuffer, indent, "</dict>"
		        
		      Else
		        
		        write_text destBuffer, indent, "<dict/>"
		        
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub write_text(out As BinaryStream, indent As Integer, text As String, newline As Boolean = True)
		  // Created 3/14/2011 by Andrew Keller
		  
		  // Writes the given text to the given stream,
		  // with the given number of tabs, and optionally,
		  // a newline character.
		  
		  While indent > 0
		    
		    out.Write chr(9)
		    indent = indent -1
		    
		  Wend
		  
		  out.Write text
		  
		  If newline Then out.Write chr(10)
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Sub write_value(v As Variant, destBuffer As BinaryStream, pgd As ProgressDelegateKFS, indent As Integer, isAKey As Boolean = False)
		  // Created 3/13/2011 by Andrew Keller
		  
		  // Serializes the given variant object
		  // into the given destination buffer using the
		  // Apple Property List format, and reports
		  // progress through the given progress delegate.
		  
		  If isAKey Then
		    
		    write_text destBuffer, indent, "<key>" + strv(v) + "</key>"
		    
		  ElseIf v.IsNull Then
		    
		    write_text destBuffer, indent, "<data/>"
		    
		  ElseIf v.Type = Variant.TypeBoolean Then
		    
		    write_text destBuffer, indent, "<" + Lowercase( Str( v.BooleanValue ) ) + "/>"
		    
		  ElseIf v.Type = Variant.TypeDate Then
		    
		    write_text destBuffer, indent, "<date>" + SerializeISO8610DateKFS( v.DateValue ) + "</date>"
		    
		  ElseIf v.Type = Variant.TypeDouble Then
		    
		    write_text destBuffer, indent, "<real>" + Str( v.DoubleValue ) + "</real>"
		    
		  ElseIf v.Type = Variant.TypeInteger _
		    Or v.Type = Variant.TypeLong _
		    Or v.Type = Variant.TypeSingle Then
		    
		    write_text destBuffer, indent, "<integer>" + Str( v ) + "</integer>"
		    
		  ElseIf v IsA MemoryBlock Then
		    
		    write_text destBuffer, indent, "<data>" + EncodeBase64( MemoryBlock( v ) ) + "</data>"
		    
		  ElseIf v IsA Dictionary Then
		    
		    write_dir Dictionary( v ), destBuffer, pgd, indent
		    
		  ElseIf v IsA PropertyListKFS Then
		    
		    write_dir PropertyListKFS( v ), destBuffer, pgd, indent
		    
		  Else
		    
		    write_text destBuffer, indent, "<string>" + v + "</string>"
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xre_DoctypeDeclEnd(xr As XmlReader)
		  // Created 12/7/2010 by Andrew Keller
		  
		  // This is the end of the document type declaration.
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xre_DoctypeDeclStart(xr As XmlReader, doctypeName as String, systemID as String, publicID as String, has_internal_subset as Boolean)
		  // Created 12/10/2010 by Andrew Keller
		  
		  // This is the start of the document type declaration.
		  
		  If doctypeName = "plist" Then
		    If has_internal_subset = False Then
		      
		      Return
		      
		    End If
		  End If
		  
		  fail_fmt "The given data has an unknown doctype declaration."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function xre_DoctypeVerifyExternalEntityRef(xr As XmlReader, context as String, base as String, systemID as String, publicID as String) As Boolean
		  // Created 12/7/2010 by Andrew Keller
		  
		  // This is an Apple Property List, so there's only one DTD we'll accept.
		  
		  If systemID = "http://www.apple.com/DTDs/PropertyList-1.0.dtd" Then
		    If publicID = "-//Apple//DTD PLIST 1.0//EN" Then
		      
		      Return True
		      
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xre_DocumentEnd(xr As XmlReader)
		  // Created 12/7/2010 by Andrew Keller
		  
		  // This is the end of the property list.  Clean up.
		  
		  currentElement = ""
		  ReDim dirStack(-1)
		  foundKey = False
		  keyName = ""
		  plistKeyCount = 0
		  textbuf = Nil
		  textstore = Nil
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xre_DocumentStart(xr As XmlReader)
		  // Created 12/10/2010 by Andrew Keller
		  
		  // Called when we are beginning to read a document.
		  
		  // Initialize all the working variables.
		  
		  currentElement = ""
		  ReDim dirStack(-1)
		  foundKey = False
		  keyName = ""
		  plistKeyCount = 0
		  textbuf = Nil
		  textstore = Nil
		  
		  p_core = New Dictionary
		  p_treatAsArray = False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xre_DocumentXmlDecl(xr As XmlReader, version as String, xmlEncoding as String, standalone as Boolean)
		  // Created 12/10/2010 by Andrew Keller
		  
		  // This is an XML declaration.
		  
		  If version = "1.0" Then
		    If standalone Then
		      
		      Return
		      
		    End If
		  End If
		  
		  fail_fmt "The given data has an unknown XML declaration."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xre_ElementEnd(xr As XmlReader, name As String)
		  // Created 12/10/2010 by Andrew Keller
		  
		  // This is the end of an element.
		  
		  Dim v As Variant
		  If Not ( textbuf Is Nil ) Then textbuf.Position = 0
		  
		  If name = "dict" or name = "array" Then
		    
		    dirStack.Remove 0
		    
		  Else
		    
		    If foundKey Then
		      
		      If currentElement = "data" Then
		        
		        textstore = DecodeBase64( textbuf.Read( textbuf.Length ) )
		        dirStack(0).Value( keyName ) = textstore
		        
		      ElseIf currentElement = "date" Then
		        
		        v = textbuf.Read( textbuf.Length )
		        dirStack(0).Value( keyName ) = DeserializeISO8610StringAsDateKFS( v )
		        
		      ElseIf currentElement = "real" Then
		        
		        v = textbuf.Read( textbuf.Length )
		        dirStack(0).Value( keyName ) = v.DoubleValue
		        
		      ElseIf currentElement = "integer" Then
		        
		        v = textbuf.Read( textbuf.Length )
		        dirStack(0).Value( keyName ) = v.Int64Value
		        
		      ElseIf currentElement = "string" Then
		        
		        dirStack(0).Value( keyName ) = textbuf.Read( textbuf.Length )
		        
		      ElseIf currentElement = "true" Then
		        
		        dirStack(0).Value( keyName ) = True
		        
		      ElseIf currentElement = "false" Then
		        
		        dirStack(0).Value( keyName ) = False
		        
		      End If
		      
		      foundKey = False
		      keyName = ""
		      
		    Else
		      
		      If currentElement = "key" Then
		        
		        foundKey = True
		        
		      ElseIf currentElement = "data" Then
		        
		        textstore = DecodeBase64( textbuf.Read( textbuf.Length ) )
		        dirStack(0).WedgeAfter( textstore, 0 )
		        
		      ElseIf currentElement = "date" Then
		        
		        v = textbuf.Read( textbuf.Length )
		        dirStack(0).WedgeAfter( DeserializeISO8610StringAsDateKFS( v ), 0 )
		        
		      ElseIf currentElement = "real" Then
		        
		        v = textbuf.Read( textbuf.Length )
		        dirStack(0).WedgeAfter( v.DoubleValue, 0 )
		        
		      ElseIf currentElement = "integer" Then
		        
		        v = textbuf.Read( textbuf.Length )
		        dirStack(0).WedgeAfter( v.Int64Value, 0 )
		        
		      ElseIf currentElement = "string" Then
		        
		        dirStack(0).WedgeAfter( textbuf.Read( textbuf.Length ), 0 )
		        
		      ElseIf currentElement = "true" Then
		        
		        dirStack(0).WedgeAfter( True, 0 )
		        
		      ElseIf currentElement = "false" Then
		        
		        dirStack(0).WedgeAfter( False, 0 )
		        
		      End If
		      
		    End If
		    
		    textbuf = Nil
		    textstore = Nil
		    currentElement = ""
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xre_ElementStart(xr As XmlReader, name as String, attributeList as XMLAttributeList)
		  // Created 12/10/2010 by Andrew Keller
		  
		  // This is the beginning of an XML element.
		  
		  If name = "plist" Then
		    plistKeyCount = plistKeyCount +1
		    If plistKeyCount > 1 Then fail_fmt "An Apple Property List is only supposed to have one plist key."
		    
		  ElseIf name = "key" Then
		    
		    If foundKey Then
		      fail_fmt "There cannot be multiple keys in a row."
		    Else
		      
		      currentElement = name
		      keyName = ""
		      
		    End If
		    
		  ElseIf name = "dict" or name = "array" Then
		    
		    If UBound( dirStack ) < 0 Then
		      
		      dirStack.Append Me
		      If name = "array" Then dirStack(0).p_treatAsArray = True
		      
		    Else
		      
		      Dim c As New PropertyListKFS
		      If name = "array" Then c.p_treatAsArray = True
		      
		      If foundKey Then
		        
		        dirStack(0).Child( keyName ) = c
		        keyName = ""
		        foundKey = False
		        
		      Else
		        
		        dirStack(0).WedgeAfter c, 0
		        
		      End If
		      
		      dirStack.Insert 0, c
		      
		    End If
		    
		  ElseIf name = "data" or name = "date" or name = "real" or name = "integer" or name = "string" or name = "true" or name = "false" Then
		    
		    If UBound( dirStack ) < 0 Then fail_fmt "Encountered a terminal node while the directory stack is empty."
		    
		    currentElement = name
		    textstore = New MemoryBlock(0)
		    textbuf = New BinaryStream( textstore )
		    
		  Else
		    fail_fmt "Unknown key: " + name
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub xre_ElementText(xr As XmlReader, s As String)
		  // Created 12/10/2010 by Andrew Keller
		  
		  // Add the characters to the buffer.
		  
		  If currentElement = "key" Then
		    
		    keyName = keyName + s
		    
		  ElseIf currentElement = "data" or currentElement = "date" or currentElement = "real" or currentElement = "integer" or currentElement = "string" Then
		    
		    textbuf.Write s
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = Apple PList DTD
		For the convenience of the developer, this is a copy of the Apple PList DTD found at <http://www.apple.com/DTDs/PropertyList-1.0.dtd>.
		
		
		<!ENTITY % plistObject "(array | data | date | dict | real | integer | string | true | false )" >
		<!ELEMENT plist %plistObject;>
		<!ATTLIST plist version CDATA "1.0" >
		
		<!-- Collections -->
		<!ELEMENT array (%plistObject;)*>
		<!ELEMENT dict (key, %plistObject;)*>
		<!ELEMENT key (#PCDATA)>
		
		<!--- Primitive types -->
		<!ELEMENT string (#PCDATA)>
		<!ELEMENT data (#PCDATA)> <!-- Contents interpreted as Base-64 encoded -->
		<!ELEMENT date (#PCDATA)> <!-- Contents should conform to a subset of ISO 8601 (in particular, YYYY '-' MM '-' DD 'T' HH ':' MM ':' SS 'Z'.  Smaller units may be omitted with a loss of precision) -->
		
		<!-- Numerical primitives -->
		<!ELEMENT true EMPTY>  <!-- Boolean constant true -->
		<!ELEMENT false EMPTY> <!-- Boolean constant false -->
		<!ELEMENT real (#PCDATA)> <!-- Contents should represent a floating point number matching ("+" | "-")? d+ ("."d*)? ("E" ("+" | "-") d+)? where d is a digit 0-9.  -->
		<!ELEMENT integer (#PCDATA)> <!-- Contents should represent a (possibly signed) integer number in base 10 -->
	#tag EndNote

	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, 2011 Andrew Keller.
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
		Protected currentElement As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected dirStack() As PropertyListKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected foundKey As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected keyName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected plistKeyCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected textbuf As BinaryStream
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected textstore As MemoryBlock
	#tag EndProperty


	#tag Constant, Name = kAPListFooter, Type = String, Dynamic = False, Default = \"</plist>\n", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kAPListHeader, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\n<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n<plist version\x3D\"1.0\">\n", Scope = Protected
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
