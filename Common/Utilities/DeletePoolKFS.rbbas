#tag Class
Protected Class DeletePoolKFS
	#tag Method, Flags = &h0
		Sub Add(obj As Object, delete_method As DeletePoolKFS.ObjectDeletingMethod)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddFolderitem(f As FolderItem, recursive As Boolean = True)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AutoProcessingEnabled() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AutoProcessingEnabled(Assigns new_value As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DelayBetweenRetries() As DurationKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DelayBetweenRetries(Assigns new_value As DurationKFS)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function FolderItemDeleter(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumberOfFailuresUntilGiveUp() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NumberOfFailuresUntilGiveUp(Assigns new_value As Integer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NumberOfPartialSuccessesUntilGiveUp() As Integer
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub NumberOfPartialSuccessesUntilGiveUp(Assigns new_value As Integer)
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ObjectDeletingMethod(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		 Shared Function RecursiveFolderItemDeleter(obj As Object) As DeletePoolKFS.ObjectDeletingMethodResult
		  
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
		Protected p_data As Dictionary
	#tag EndProperty


	#tag Constant, Name = kOptDeleter, Type = String, Dynamic = False, Default = \"deleter", Scope = Protected
	#tag EndConstant


	#tag Enum, Name = ObjectDeletingMethodResult, Type = Integer, Flags = &h0
		AchievedSuccess
		  AchievedPartialSuccess
		  EncounteredFailure
		  EncounteredTerminalFailure
		CannotHandleObject
	#tag EndEnum


End Class
#tag EndClass
