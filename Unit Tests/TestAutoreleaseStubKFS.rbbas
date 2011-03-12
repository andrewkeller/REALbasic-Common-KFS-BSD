#tag Class
Protected Class TestAutoreleaseStubKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub AfterTestCase(testMethodName As String)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Clean up the queues.
		  
		  c_dict.Clear
		  c_plain.Clear
		  c_var.Clear
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Setup the queues.
		  
		  c_dict = New DataChainKFS
		  c_plain = New DataChainKFS
		  c_var = New DataChainKFS
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub DictionaryHandler(d As Dictionary)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Records that a DictionaryMethod was invoked.
		  
		  c_dict.Append d
		  
		  // Cause some trouble to make sure exceptions are handled properly:
		  
		  #pragma BreakOnExceptions Off
		  If c_dict.Count = 1 Then Raise New NilObjectException
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PlainHandler()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Records that a PlainMethod was invoked.
		  
		  c_plain.Append Nil
		  
		  // Cause some trouble to make sure exceptions are handled properly:
		  
		  #pragma BreakOnExceptions Off
		  If c_plain.Count = 1 Then Raise New NilObjectException
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDictionary()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Makes sure a DictionaryMethod can be used.
		  
		  Dim arp As New AutoreleaseStubKFS
		  Dim d As New Dictionary
		  arp.Add AddressOf DictionaryHandler, d
		  arp = Nil
		  
		  AssertEquals 1, c_dict.Count, "The DictionaryHandler method didn't get invoked the correct number of times (1)."
		  AssertSame d, c_dict.Pop, "The DictionaryHandler method did not receive the correct argument (1)."
		  
		  arp = New AutoreleaseStubKFS( AddressOf DictionaryHandler, d )
		  arp = Nil
		  AssertEquals 1, c_dict.Count, "The DictionaryHandler method didn't get invoked the correct number of times (2)."
		  AssertSame d, c_dict.Pop, "The DictionaryHandler method did not receive the correct argument (2)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDictionary_Multi()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Makes sure a DictionaryMethod can be used.
		  
		  Dim arp As New AutoreleaseStubKFS
		  Dim d1 As New Dictionary( "value" : 1 )
		  Dim d2 As New Dictionary( "value" : 3 )
		  Dim d3 As New Dictionary( "value" : 5 )
		  arp.Add AddressOf DictionaryHandler, d1
		  arp.Add AddressOf DictionaryHandler, d2
		  arp.Add AddressOf DictionaryHandler, d3
		  arp = Nil
		  
		  AssertEquals 3, c_dict.Count, "The DictionaryHandler method didn't get invoked the correct number of times."
		  Dim result As Integer
		  PushMessageStack "Calculating checksum..."
		  While Not c_dict.IsEmpty
		    result = result + Dictionary( c_dict.Pop ).Value( "value" )
		  Wend
		  PopMessageStack
		  AssertEquals 9, result, "Checksum failed.  One or more of the DictionaryHandler invocation arguments was incorrect."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMulti()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Makes sure any method combination can be used.
		  
		  Dim arp As New AutoreleaseStubKFS
		  arp.Add AddressOf PlainHandler
		  arp.Add AddressOf PlainHandler
		  arp.Add AddressOf PlainHandler
		  Dim d1 As New Dictionary( "value" : 1 )
		  Dim d2 As New Dictionary( "value" : 2 )
		  Dim d3 As New Dictionary( "value" : 4 )
		  Dim d4 As New Dictionary( "value" : 8 )
		  arp.Add AddressOf DictionaryHandler, d1
		  arp.Add AddressOf DictionaryHandler, d2
		  arp.Add AddressOf DictionaryHandler, d3
		  arp.Add AddressOf DictionaryHandler, d4
		  Dim v1 As Variant = 1
		  Dim v2 As Variant = 2
		  Dim v3 As Variant = 4
		  Dim v4 As Variant = 8
		  Dim v5 As Variant = 16
		  arp.Add AddressOf VariantHandler, v1
		  arp.Add AddressOf VariantHandler, v2
		  arp.Add AddressOf VariantHandler, v3
		  arp.Add AddressOf VariantHandler, v4
		  arp.Add AddressOf VariantHandler, v5
		  arp = Nil
		  
		  AssertEquals 3, c_plain.Count, "The PlainHandler method didn't get invoked the correct number of times."
		  
		  AssertEquals 4, c_dict.Count, "The DictionaryHandler method didn't get invoked the correct number of times."
		  Dim result As Integer
		  PushMessageStack "Calculating DictionaryHandler checksum..."
		  While Not c_dict.IsEmpty
		    result = result + Dictionary( c_dict.Pop ).Value( "value" )
		  Wend
		  PopMessageStack
		  AssertEquals 15, result, "Checksum failed.  One or more of the DictionaryHandler invocation arguments was incorrect."
		  
		  AssertEquals 5, c_var.Count, "The VariantHandler method didn't get invoked the correct number of times."
		  result = 0
		  PushMessageStack "Calculating VariantHandler checksum..."
		  While Not c_var.IsEmpty
		    result = result + c_var.Pop
		  Wend
		  PopMessageStack
		  AssertEquals 31, result, "Checksum failed.  One or more of the VariantHandler invocation arguments was incorrect."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestPlain()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Makes sure a PlainMethod can be used.
		  
		  Dim arp As New AutoreleaseStubKFS
		  arp.Add AddressOf PlainHandler
		  arp = Nil
		  
		  AssertEquals 1, c_plain.Count, "The PlainHandler method didn't get invoked the correct number of times (1)."
		  Call c_plain.Pop
		  
		  arp = New AutoreleaseStubKFS( AddressOf PlainHandler )
		  arp = Nil
		  AssertEquals 1, c_plain.Count, "The PlainHandler method didn't get invoked the correct number of times (2)."
		  Call c_plain.Pop
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestPlain_Multi()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Makes sure a PlainMethod can be used.
		  
		  Dim arp As New AutoreleaseStubKFS
		  arp.Add AddressOf PlainHandler
		  arp.Add AddressOf PlainHandler
		  arp.Add AddressOf PlainHandler
		  arp = Nil
		  
		  AssertEquals 3, c_plain.Count, "The PlainHandler method didn't get invoked the correct number of times."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestVariant()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Makes sure a VariantMethod can be used.
		  
		  Dim arp As New AutoreleaseStubKFS
		  Dim v As Variant = New Timer
		  arp.Add AddressOf VariantHandler, v
		  arp = Nil
		  
		  AssertEquals 1, c_var.Count, "The VariantHandler method didn't get invoked the correct number of times (1)."
		  AssertSame v, c_var.Pop, "The VariantHandler method did not receive the correct argument (1)."
		  
		  arp = New AutoreleaseStubKFS( AddressOf VariantHandler, v )
		  arp = Nil
		  AssertEquals 1, c_var.Count, "The VariantHandler method didn't get invoked the correct number of times (2)."
		  AssertSame v, c_var.Pop, "The VariantHandler method did not receive the correct argument (2)."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestVariant_Multi()
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Makes sure a VariantMethod can be used.
		  
		  Dim arp As New AutoreleaseStubKFS
		  Dim v1 As Variant = 1
		  Dim v2 As Variant = 3
		  Dim v3 As Variant = 5
		  arp.Add AddressOf VariantHandler, v1
		  arp.Add AddressOf VariantHandler, v2
		  arp.Add AddressOf VariantHandler, v3
		  arp = Nil
		  
		  AssertEquals 3, c_var.Count, "The VariantHandler method didn't get invoked the correct number of times."
		  Dim result As Integer = 0
		  PushMessageStack "Calculating checksum..."
		  While Not c_var.IsEmpty
		    result = result + c_var.Pop
		  Wend
		  PopMessageStack
		  AssertEquals 9, result, "Checksum failed.  One or more of the VariantHandler invocation arguments was incorrect."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VariantHandler(v As Variant)
		  // Created 9/7/2010 by Andrew Keller
		  
		  // Records that a VariantMethod was invoked.
		  
		  c_var.Append v
		  
		  // Cause some trouble to make sure exceptions are handled properly:
		  
		  #pragma BreakOnExceptions Off
		  If c_var.Count = 1 Then Raise New NilObjectException
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller, et al.
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


	#tag Property, Flags = &h0
		c_dict As DataChainKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		c_plain As DataChainKFS
	#tag EndProperty

	#tag Property, Flags = &h0
		c_var As DataChainKFS
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="UnitTestBaseClassKFS"
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
