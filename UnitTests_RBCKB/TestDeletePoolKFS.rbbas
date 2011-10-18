#tag Class
Protected Class TestDeletePoolKFS
Inherits UnitTestBaseClassKFS
	#tag Event
		Sub AfterTestCase(testMethodName As String)
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Empty the autodelete pool.
		  
		  For Each k As Variant In p_autodelete_pool.Keys
		    
		    If k IsA FolderItem Then
		      Dim f As FolderItem = FolderItem( k )
		      
		      Try
		        
		        f.DeleteKFS True
		        p_autodelete_pool.Remove f
		        
		      Catch err As CannotDeleteFilesystemEntryExceptionKFS
		        
		        StashException err
		        
		      End Try
		    Else
		      AssertFailure "I don't know how to clean up a " + Introspection.GetType( k ).Name + " object.", False
		    End If
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub ConstructorWithAssertionHandling()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Initialize properties of this class.
		  
		  p_autodelete_pool = New Dictionary
		  
		  // done.
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Destructor()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Last chance to empty the autodelete pool.
		  
		  For Each k As Variant In p_autodelete_pool.Keys
		    Dim f As FolderItem = FolderItem( k )
		    
		    Try
		      
		      f.DeleteKFS True
		      p_autodelete_pool.Remove f
		      
		    Catch err As CannotDeleteFilesystemEntryExceptionKFS
		      
		      System.Log System.LogLevelError, "Error: Cannot delete temporary file " + f.AbsolutePath + ": " + err.Message
		      
		    End Try
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub CleanUpFolderItemAfterTestCase(f As FolderItem)
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Adds the given FolderItem to the autodelete pool.
		  
		  If Not ( f Is Nil ) Then
		    
		    p_autodelete_pool.Value( New FolderItem( f ) ) = True
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

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
		Sub TestProp_Count()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the Count property works.
		  
		  Dim p As New DeletePoolKFS
		  
		  AssertZero p.Count, "The Count property should return zero by default."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_DelayBetweenRetries()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the DelayBetweenRetries property works.
		  
		  Dim p As New DeletePoolKFS
		  Dim d As DurationKFS = p.DelayBetweenRetries
		  
		  If PresumeNotIsNil( d, "The DelayBetweenRetries property is never supposed to return Nil (1)." ) Then
		    AssertEquals DurationKFS.NewFromValue( 1, DurationKFS.kSeconds ).MicrosecondsValue, d.MicrosecondsValue, "The default value for the DelayBetweenRetries property should be 1 second.", False
		  End If
		  
		  p.DelayBetweenRetries = DurationKFS.NewFromValue( 4, DurationKFS.kSeconds )
		  d = p.DelayBetweenRetries
		  
		  If PresumeNotIsNil ( d, "The DelayBetweenRetries property is never supposed to return Nil (2)." ) Then
		    AssertEquals DurationKFS.NewFromValue( 4, DurationKFS.kSeconds ).MicrosecondsValue, d.MicrosecondsValue, "Setting the DelayBetweenRetries property to a new value should cause the new value to be reported by the getter.", False
		  End If
		  
		  p.DelayBetweenRetries = Nil
		  d = p.DelayBetweenRetries
		  
		  If PresumeNotIsNil( d, "The DelayBetweenRetries property is never supposed to return Nil (3)." ) Then
		    AssertEquals DurationKFS.NewFromValue( 0 ).MicrosecondsValue, d.MicrosecondsValue, "Setting the DelayBetweenRetries property to Nil should cause the property to become zero.", False
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_InternalProcessingEnabled()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the InternalProcessingEnabled property works.
		  
		  Dim p As New DeletePoolKFS
		  Dim expected As Boolean = Not TargetConsole
		  
		  AssertEquals expected, p.InternalProcessingEnabled, "The default value for the InternalProcessingEnabled should be " + Str( expected ) + " for the current application type."
		  
		  expected = Not expected
		  p.InternalProcessingEnabled = expected
		  
		  AssertEquals expected, p.InternalProcessingEnabled, "Setting the InternalProcessingEnabled property to " + Str( expected ) + " did not cause the getter to return " + Str( expected ) + "."
		  
		  expected = Not expected
		  p.InternalProcessingEnabled = expected
		  
		  AssertEquals expected, p.InternalProcessingEnabled, "Setting the InternalProcessingEnabled property back to " + Str( expected ) + " did not cause the getter to return " + Str( expected ) + "."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_NumberOfFailuresUntilGiveUp()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the NumberOfFailuresUntilGiveUp property works.
		  
		  Dim p As New DeletePoolKFS
		  
		  AssertEquals 5, p.NumberOfFailuresUntilGiveUp, "The default value for the NumberOfFailuresUntilGiveUp property should be 5.", False
		  
		  p.NumberOfFailuresUntilGiveUp = 8
		  
		  AssertEquals 8, p.NumberOfFailuresUntilGiveUp, "Setting the NumberOfFailuresUntilGiveUp property to 8 did not cause the getter to return 8.", False
		  
		  p.NumberOfFailuresUntilGiveUp = -12
		  
		  AssertEquals 0, p.NumberOfFailuresUntilGiveUp, "The NumberOfFailuresUntilGiveUp property is supposed to sanitize negative values to zero.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_NumberOfPartialSuccessesUntilGiveUp()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the NumberOfPartialSuccessesUntilGiveUp property works.
		  
		  Dim p As New DeletePoolKFS
		  
		  AssertEquals 10, p.NumberOfPartialSuccessesUntilGiveUp, "The default value for the NumberOfPartialSuccessesUntilGiveUp property should be 10.", False
		  
		  p.NumberOfPartialSuccessesUntilGiveUp = 13
		  
		  AssertEquals 13, p.NumberOfPartialSuccessesUntilGiveUp, "Setting the NumberOfPartialSuccessesUntilGiveUp property to 13 did not cause the getter to return 13.", False
		  
		  p.NumberOfPartialSuccessesUntilGiveUp = -7
		  
		  AssertEquals 0, p.NumberOfPartialSuccessesUntilGiveUp, "The NumberOfPartialSuccessesUntilGiveUp property is supposed to sanitize negative values to zero.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestProp_TimeUntilNextProcessing()
		  // Created 10/18/2011 by Andrew Keller
		  
		  // Makes sure the TimeUntilNextProcessing property works.
		  
		  Dim p As New DeletePoolKFS
		  
		  AssertIsNil p.TimeUntilNextProcessing, "The TimeUntilNextProcessing property should return Nil by default."
		  
		  // done.
		  
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


	#tag Property, Flags = &h1
		Protected p_autodelete_pool As Dictionary
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
