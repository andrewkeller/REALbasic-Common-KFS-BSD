#tag Class
Protected Class ProgressDelegateKFS
	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub AddAutoUpdatedObject(f As ProgressBar)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetHasGUI
		Sub AddAutoUpdatedObject(f As StaticText)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddMessageChangedCallback(f As ProgressDelegateKFS.BasicEventHandler)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddValueChangedCallback(f As ProgressDelegateKFS.BasicEventHandler)
		  
		End Sub
	#tag EndMethod

	#tag DelegateDeclaration, Flags = &h0
		Delegate Sub BasicEventHandler(pgd As ProgressDelegateKFS)
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Children() As ProgressDelegateKFS()
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub EventRouter()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ExpectedWeightOfChildren() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExpectedWeightOfChildren(Assigns newValue As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IndeterminateValue() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IndeterminateValue(Assigns newValue As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Lock() As CriticalSection
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Message() As String
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Message(Assigns newValue As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function OverallValue() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Parent() As ProgressDelegateKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Parent(Assigns newParent As ProgressDelegateKFS)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SpawnChild(weight As Double = 1, value As Double = 0, msg As String = "") As ProgressDelegateKFS
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SynchronousEvents() As Boolean
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SynchronousEvents(Assigns newValue As Boolean)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function TotalWeightOfChildren() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Sub Update(lbl As Label)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1, CompatibilityFlags = TargetHasGUI
		Protected Sub Update(pb As ProgressBar)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Update(d As ProgressDelegateKFS.BasicEventHandler)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Assigns newValue As Double)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Weight() As Double
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Weight(Assigns newValue As Double)
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event MessageChanged()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event ValueChanged()
	#tag EndHook


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


	#tag Property, Flags = &h1, CompatibilityFlags =    TargetHasGUI
		Protected myAUObjects_Labels() As StaticText
	#tag EndProperty

	#tag Property, Flags = &h1, CompatibilityFlags =    TargetHasGUI
		Protected myAUObjects_ProgressBars() As ProgressBar
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myChildren() As WeakRef
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myDecimalDone As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myEnableSynchEvents As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myExpectedTotalChildrenWeight As Double
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myIndeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMessage As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myParent As ProgressDelegateKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myPCHandlers_Message() As ProgressDelegateKFS.BasicEventHandler
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myPCHandlers_Value() As ProgressDelegateKFS.BasicEventHandler
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myWeight As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private p_oldIndeterminate As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private p_oldMessage As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private p_oldValue As Double
	#tag EndProperty

	#tag Property, Flags = &h21
		Private _lock As CriticalSection
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
