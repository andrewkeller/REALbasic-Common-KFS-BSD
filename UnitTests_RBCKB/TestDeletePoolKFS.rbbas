#tag Class
Protected Class TestDeletePoolKFS
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestFlow_EventuallySuccessfulThroughput()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFlow_UnsuccessfulThroughput()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestFuncSuccessfulThroughput()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_FolderItemDelete()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestHandler_RecursiveFolderItemDelete()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_DelayBetweenRetries()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_InternalProcessingEnabled()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_NumberOfFailuresUntilGiveUp()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_NumberOfPartialSuccessesUntilGiveUp()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_TimeUntilNextProcessing()
		  
		End Sub
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
