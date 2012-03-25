#tag Module
Protected Module PropertyListGlobalsKFS
	#tag Method, Flags = &h21
		Private Function core_deserialize(srcData As BinaryStream, fmt As PropertyListKFS.SerialFormats, pgd As ProgressDelegateKFS) As PropertyListKFS
		  // Created 12/7/2010 by Andrew Keller
		  
		  // The core deserialize function.
		  
		  Select Case fmt
		  Case PropertyListKFS.SerialFormats.ApplePList
		    
		    Return ApplePListSerialHelper.core_deserialize( srcData, pgd )
		    
		  Case PropertyListKFS.SerialFormats.Undefined
		    
		    Try
		      #pragma BreakOnExceptions Off
		      Return ApplePListSerialHelper.core_deserialize( srcData, pgd )
		    Catch err As UnsupportedFormatException
		    End Try
		    
		    fail_fmt "None of the known PropertyListKFS subclasses were able to parse the given data."
		    
		  Else
		    
		    fail_fmt "The requested format is not supported by any of the known PropertyListKFS subclasses."
		    
		  End Select
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub core_serialize_to(destBuffer As BinaryStream, srcNode As PropertyListKFS, fmt As PropertyListKFS.SerialFormats, pgd As ProgressDelegateKFS, truncate As Boolean)
		  // Created 12/7/2010 by Andrew Keller
		  
		  // The core serialize function.
		  
		  // Exceptions are considered not normal, and are expected to be caught by the calling method.
		  
		  Select Case fmt
		  Case PropertyListKFS.SerialFormats.ApplePList
		    
		    ApplePListSerialHelper.core_serialize( srcNode, destBuffer, pgd, truncate )
		    
		  Case PropertyListKFS.SerialFormats.Undefined
		    
		    ApplePListSerialHelper.core_serialize( srcNode, destBuffer, pgd, truncate )
		    
		  Else
		    
		    fail_fmt "The requested format is not supported by any of the known PropertyListKFS subclasses."
		    
		  End Select
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeserializePList(srcData As BigStringKFS) As PropertyListKFS
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Deserializes the given data into a PropertyListKFS object and returns the result.
		  
		  Return core_deserialize( srcData, PropertyListKFS.SerialFormats.Undefined, Nil )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeserializePList(srcData As BigStringKFS, pgd As ProgressDelegateKFS) As PropertyListKFS
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Deserializes the given data into a PropertyListKFS object and returns the result.
		  
		  Return core_deserialize( srcData, PropertyListKFS.SerialFormats.Undefined, pgd )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeserializePList(srcData As BigStringKFS, fmt As PropertyListKFS.SerialFormats) As PropertyListKFS
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Deserializes the given data into a PropertyListKFS object and returns the result.
		  
		  Return core_deserialize( srcData, fmt, Nil )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DeserializePList(srcData As BigStringKFS, fmt As PropertyListKFS.SerialFormats, pgd As ProgressDelegateKFS) As PropertyListKFS
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Deserializes the given data into a PropertyListKFS object and returns the result.
		  
		  Return core_deserialize( srcData, fmt, pgd )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeserializePListTo(plist As PropertyListKFS, srcData As BigStringKFS, clearFirst As Boolean = True)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Deserializes the given data into the given PropertyListKFS object.
		  
		  If plist Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "The given destination PropertyListKFS object is Nil."
		    Raise e
		    
		  Else
		    
		    Dim p As PropertyListKFS = DeserializePList( srcData )
		    
		    If clearFirst Then
		      
		      plist.DataCore = p.DataCore
		      plist.TreatAsArray = p.TreatAsArray
		      
		    Else
		      
		      plist.Import p
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeserializePListTo(plist As PropertyListKFS, srcData As BigStringKFS, pgd As ProgressDelegateKFS, clearFirst As Boolean = True)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Deserializes the given data into the given PropertyListKFS object.
		  
		  If plist Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "The given destination PropertyListKFS object is Nil."
		    Raise e
		    
		  Else
		    
		    Dim p As PropertyListKFS = DeserializePList( srcData, pgd )
		    
		    If clearFirst Then
		      
		      plist.DataCore = p.DataCore
		      plist.TreatAsArray = p.TreatAsArray
		      
		    Else
		      
		      plist.Import p
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeserializePListTo(plist As PropertyListKFS, srcData As BigStringKFS, fmt As PropertyListKFS.SerialFormats, clearFirst As Boolean = True)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Deserializes the given data into the given PropertyListKFS object.
		  
		  If plist Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "The given destination PropertyListKFS object is Nil."
		    Raise e
		    
		  Else
		    
		    Dim p As PropertyListKFS = DeserializePList( srcData, fmt )
		    
		    If clearFirst Then
		      
		      plist.DataCore = p.DataCore
		      plist.TreatAsArray = p.TreatAsArray
		      
		    Else
		      
		      plist.Import p
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeserializePListTo(plist As PropertyListKFS, srcData As BigStringKFS, fmt As PropertyListKFS.SerialFormats, pgd As ProgressDelegateKFS, clearFirst As Boolean = True)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Deserializes the given data into the given PropertyListKFS object.
		  
		  If plist Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "The given destination PropertyListKFS object is Nil."
		    Raise e
		    
		  Else
		    
		    Dim p As PropertyListKFS = DeserializePList( srcData, fmt, pgd )
		    
		    If clearFirst Then
		      
		      plist.DataCore = p.DataCore
		      plist.TreatAsArray = p.TreatAsArray
		      
		    Else
		      
		      plist.Import p
		      
		    End If
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub fail_fmt(msg As String)
		  // Created 12/17/2010 by Andrew Keller
		  
		  // Raises an UnsupportedFormatException with the given message.
		  
		  Dim e As New UnsupportedFormatException
		  e.Message = msg
		  
		  #pragma BreakOnExceptions Off
		  
		  Raise e
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GuessSerializedPListFormat(srcData As BigStringKFS) As PropertyListKFS.SerialFormats
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Guesses the format of the given data.
		  
		  If ApplePListSerialHelper.core_data_could_be_APList( srcData ) Then Return PropertyListKFS.SerialFormats.ApplePList
		  
		  Return PropertyListKFS.SerialFormats.Undefined
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerializePList(srcNode As PropertyListKFS) As BigStringKFS
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Returns a serialized copy of the given property list.
		  
		  Dim s As New BigStringKFS
		  
		  SerializePListTo s, srcNode
		  
		  Return s
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerializePList(srcNode As PropertyListKFS, pgd As ProgressDelegateKFS) As BigStringKFS
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Returns a serialized copy of the given property list.
		  
		  Dim s As New BigStringKFS
		  
		  SerializePListTo s, srcNode, pgd
		  
		  Return s
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerializePList(srcNode As PropertyListKFS, fmt As PropertyListKFS.SerialFormats) As BigStringKFS
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Returns a serialized copy of the given property list.
		  
		  Dim s As New BigStringKFS
		  
		  SerializePListTo s, srcNode, fmt
		  
		  Return s
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerializePList(srcNode As PropertyListKFS, fmt As PropertyListKFS.SerialFormats, pgd As ProgressDelegateKFS) As BigStringKFS
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Returns a serialized copy of the given property list.
		  
		  Dim s As New BigStringKFS
		  
		  SerializePListTo s, srcNode, fmt, pgd
		  
		  Return s
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SerializePListTo(destBuffer As BigStringKFS, srcNode As PropertyListKFS)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Serializes the given property list into the given buffer.
		  
		  If destBuffer Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "The given destination buffer is Nil."
		    Raise e
		    
		  Else
		    
		    core_serialize_to destBuffer.GetStreamAccess( True ), srcNode, PropertyListKFS.SerialFormats.Undefined, Nil, True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SerializePListTo(destBuffer As BigStringKFS, srcNode As PropertyListKFS, pgd As ProgressDelegateKFS)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Serializes the given property list into the given buffer.
		  
		  If destBuffer Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "The given destination buffer is Nil."
		    Raise e
		    
		  Else
		    
		    core_serialize_to destBuffer.GetStreamAccess( True ), srcNode, PropertyListKFS.SerialFormats.Undefined, pgd, True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SerializePListTo(destBuffer As BigStringKFS, srcNode As PropertyListKFS, fmt As PropertyListKFS.SerialFormats)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Serializes the given property list into the given buffer.
		  
		  If destBuffer Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "The given destination buffer is Nil."
		    Raise e
		    
		  Else
		    
		    core_serialize_to destBuffer.GetStreamAccess( True ), srcNode, fmt, Nil, True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SerializePListTo(destBuffer As BigStringKFS, srcNode As PropertyListKFS, fmt As PropertyListKFS.SerialFormats, pgd As ProgressDelegateKFS)
		  // Created 3/9/2011 by Andrew Keller
		  
		  // Serializes the given property list into the given buffer.
		  
		  If destBuffer Is Nil Then
		    
		    Dim e As New NilObjectException
		    e.Message = "The given destination buffer is Nil."
		    Raise e
		    
		  Else
		    
		    core_serialize_to destBuffer.GetStreamAccess( True ), srcNode, fmt, pgd, True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This module is licensed as BSD.  This generally means you may do
		whatever you want with this module so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this module does NOT require
		your work to inherit the license of this module.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this module.
		
		The full official license is as follows:
		
		Copyright (c) 2009-2011 Andrew Keller.
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
