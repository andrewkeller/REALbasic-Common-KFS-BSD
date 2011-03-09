#tag Module
Protected Module PropertyListGlobalsKFS
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
		  // Created 12/4/2010 by Andrew Keller
		  
		  // Returns a serialized copy of the given property list.
		  
		  If srcNode Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Return srcNode.Serialize
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerializePList(srcNode As PropertyListKFS, pgd As ProgressDelegateKFS) As BigStringKFS
		  // Created 12/4/2010 by Andrew Keller
		  
		  // Returns a serialized copy of the given property list.
		  
		  If srcNode Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Return srcNode.Serialize( pgd )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerializePList(srcNode As PropertyListKFS, fmt As PropertyListKFS.SerialFormats) As BigStringKFS
		  // Created 12/4/2010 by Andrew Keller
		  
		  // Returns a serialized copy of the given property list.
		  
		  If srcNode Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Return srcNode.Serialize( fmt )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SerializePList(srcNode As PropertyListKFS, fmt As PropertyListKFS.SerialFormats, pgd As ProgressDelegateKFS) As BigStringKFS
		  // Created 12/4/2010 by Andrew Keller
		  
		  // Returns a serialized copy of the given property list.
		  
		  If srcNode Is Nil Then
		    
		    Return Nil
		    
		  Else
		    
		    Return srcNode.Serialize( fmt, pgd )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SerializePListTo(srcNode As PropertyListKFS, destBuffer As BigStringKFS)
		  // Created 12/4/2010 by Andrew Keller
		  
		  // Serializes the given property list into the given buffer.
		  
		  If srcNode Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    srcNode.SerializeTo destBuffer
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SerializePListTo(srcNode As PropertyListKFS, destBuffer As BigStringKFS, pgd As ProgressDelegateKFS)
		  // Created 12/4/2010 by Andrew Keller
		  
		  // Serializes the given property list into the given buffer.
		  
		  If srcNode Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    srcNode.SerializeTo destBuffer, pgd
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SerializePListTo(srcNode As PropertyListKFS, destBuffer As BigStringKFS, fmt As PropertyListKFS.SerialFormats)
		  // Created 12/4/2010 by Andrew Keller
		  
		  // Serializes the given property list into the given buffer.
		  
		  If srcNode Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    srcNode.SerializeTo destBuffer, fmt
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SerializePListTo(srcNode As PropertyListKFS, destBuffer As BigStringKFS, fmt As PropertyListKFS.SerialFormats, pgd As ProgressDelegateKFS)
		  // Created 12/4/2010 by Andrew Keller
		  
		  // Serializes the given property list into the given buffer.
		  
		  If srcNode Is Nil Then
		    
		    // Do nothing.
		    
		  Else
		    
		    srcNode.SerializeTo destBuffer, fmt, pgd
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2009-2011 Andrew Keller.
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
