#tag Class
Protected Class XgridJobKFS
	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 5/7/2010 by Andrew Keller
		  
		  // Clears or initializes all the data in this task.
		  
		  If myJobDependancies = Nil Then
		    
		    myARTData = New Dictionary
		    myInputFiles = New Dictionary
		    myJobDependancies = New Dictionary
		    myTaskSpecifications = New Dictionary
		    myTaskPrototypes = New Dictionary
		    
		  End If
		  
		  myInputFiles.Clear
		  myJobDependancies.Clear
		  myMinimumTaskCount = 0
		  myName = ""
		  myNotificationEmail = ""
		  myTaskSpecifications.Clear
		  myTaskPrototypes.Clear
		  myTasksMustStartSimul = False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Default constructor.
		  
		  Clear
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(other As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the data contained in the
		  // given PropertyList into this instance.
		  
		  Revert other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ExportToPlist(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Exports the data in this class into the given plist.
		  
		  If plist = Nil Then Return
		  
		  // Make sure the root node is a Dictionary.
		  
		  plist.Type = PropertyListKFS.kNodeTypeDictionary
		  
		  // Add our data.
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As PropertyListKFS
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Convert constructor, to a PropertyListKFS instance.
		  
		  // Acquire a blank PropertyListKFS.
		  
		  Dim result As New PropertyListKFS
		  
		  // Add the contents of Me to the property list.
		  
		  ExportToPlist result
		  
		  // Return the result.
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(other As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Convert constructor, from a PropertyListKFS instance.
		  
		  Constructor other
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the data contained in the
		  // given PropertyList into this instance.
		  
		  Clear
		  
		  If plist = Nil Then Return
		  
		  // Get the name of this job.
		  myName = plist.Lookup( kPListKeyJobName, "" )
		  
		  // Get the application identifier of this job.
		  myAppID = plist.Lookup( kPListKeyApplicationIdentifier, "" )
		  
		  // Get the submission identifier of this job.
		  mySubmissionID = plist.Lookup( kPListKeySubmissionIdentifier, "" )
		  
		  // Get the notification email address for this job.
		  myNotificationEmail = plist.Lookup( kPListKeyNotificationEmail, "" )
		  
		  // Get the task specifications and prototypes.
		  Revert_Tasks plist.Child( kPListKeyTaskSpecifications ), plist.Child( kPListKeyTaskPrototypes )
		  
		  // Get the scheduler parameters.
		  Revert_SchedulerParameters plist.Child( kPListKeySchedulerParameters )
		  
		  // Get the scheduler hints.
		  Revert_SchedulerHints plist.Child( kPListKeySchedulerHints )
		  
		  // Get the input files.
		  Revert_InputFiles plist.Child( kPListKeyInputFiles )
		  
		  // Get the ART specifications and conditions
		  Revert_ART plist.Child( kPListKeyARTSpecifications ), plist.Child( kPListKeyARTConditions )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_ART(specs As PropertyListKFS, conds As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the ART specifications and conditions contained
		  // in the given PropertyList into this instance.
		  
		  If specs <> Nil Then
		    For Each k As Variant In specs.Keys
		      
		      Revert_ART_Specification k, specs.Child( k )
		      
		    Next
		  End If
		  
		  If conds <> Nil Then
		    For Each k As Variant In conds.Keys
		      
		      Revert_ART_Condition k, specs.Child( k )
		      
		    Next
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_ART_Condition(sName As String, cond As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the ART condition contained in
		  // the given PropertyList into this instance.
		  
		  If sName = "" Or cond = Nil Then Return
		  
		  If cond.HasKey( kPListKeyArtMin ) Then
		    
		    myARTData.Value( sName, kPListKeyArtMin ) = cond.Value( kPListKeyArtMin )
		    
		  Else
		    
		    myARTData.Remove( True, sName, kPListKeyArtMin )
		    
		  End If
		  
		  If cond.HasKey( kPListKeyArtMax ) Then
		    
		    myARTData.Value( sName, kPListKeyArtMax ) = cond.Value( kPListKeyArtMax )
		    
		  Else
		    
		    myARTData.Remove( True, sName, kPListKeyArtMax )
		    
		  End If
		  
		  If cond.HasKey( kPListKeyArtEquals ) Then
		    
		    myARTData.Value( sName, kPListKeyArtEquals ) = cond.Value( kPListKeyArtEquals )
		    
		  Else
		    
		    myARTData.Remove( True, sName, kPListKeyArtEquals )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_ART_Specification(sName As String, spec As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the ART specification contained in
		  // the given PropertyList into this instance.
		  
		  If sName = "" Or spec = Nil Then Return
		  
		  If spec.HasKey( kPListKeyArtData ) Then
		    
		    myARTData.Value( sName, kPListKeyArtData ) = spec.Value( kPListKeyArtData )
		    
		  Else
		    
		    myARTData.Remove( True, sName, kPListKeyArtData )
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_InputFiles(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the input files contained in the
		  // given PropertyList into this instance.
		  
		  If plist = Nil Then Return
		  
		  For Each v As Variant In plist.Keys
		    
		    Dim sData As String = ""
		    Dim bExe As Boolean = False
		    
		    Try
		      sData = plist.Child( v ).Lookup( kPListKeyInputFileData, "" ).StringValue
		    Catch
		    End Try
		    
		    Try
		      bExe = plist.Child( v ).Lookup( kPListKeyInputFileIsExecutable, False ).BooleanValue
		    Catch
		    End Try
		    
		    myInputFiles.Value( v ) = sData : bExe
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_SchedulerHints(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the scheduler hints contained in
		  // the given PropertyList into this instance.
		  
		  If plist = Nil Then Return
		  
		  For Each v As Variant In plist.Keys
		    
		    Dim t As XgridTaskKFS = myTaskSpecifications.Lookup( v, Nil )
		    
		    If t <> Nil Then t.SchedulerHint = plist.Lookup( v, "" )
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_SchedulerParameters(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the scheduler parameters contained in
		  // the given PropertyList into this instance.
		  
		  If plist = Nil Then Return
		  
		  // Get the tasksMustStartSimultaneously value.
		  
		  myTasksMustStartSimul = plist.Lookup( kPListKeyTasksMustStartSimul, False )
		  
		  // Get the minimum task count.
		  
		  myMinimumTaskCount = plist.Lookup( kPListKeyMinimumTaskCount, 0 )
		  
		  // Get the dependsOnJobs array
		  
		  Try
		    For Each v As Variant In plist.Child( kPListKeyJobDependancies ).Values
		      
		      myJobDependancies.Value( v ) = True
		      
		    Next
		  Catch
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_Tasks(specs As PropertyListKFS, proto As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the task specifications and conditions contained
		  // in the given PropertyList into this instance.
		  
		  If specs <> Nil Then
		    
		    
		    
		    
		    
		  End If
		  
		  If proto <> Nil Then
		    
		    
		    
		    
		    
		  End If
		  
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


	#tag Property, Flags = &h1
		Protected myAppID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myARTData As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myInputFiles As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myJobDependancies As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMinimumTaskCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myName As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myNotificationEmail As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mySchedulerHints As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mySubmissionID As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTaskPrototypes As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTasksMustStartSimul As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTaskSpecifications As Dictionary
	#tag EndProperty


	#tag Constant, Name = kPListKeyApplicationIdentifier, Type = String, Dynamic = False, Default = \"applicationIdentifier", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyARTConditions, Type = String, Dynamic = False, Default = \"artConditions", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyArtData, Type = String, Dynamic = False, Default = \"artData", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyArtEquals, Type = String, Dynamic = False, Default = \"artEquals", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyArtMax, Type = String, Dynamic = False, Default = \"artMax", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyArtMin, Type = String, Dynamic = False, Default = \"artMin", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyARTSpecifications, Type = String, Dynamic = False, Default = \"artSpecification", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyInputFileData, Type = String, Dynamic = False, Default = \"fileData", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyInputFileIsExecutable, Type = String, Dynamic = False, Default = \"isExecutable", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyInputFiles, Type = String, Dynamic = False, Default = \"inputFiles", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyJobDependancies, Type = String, Dynamic = False, Default = \"dependsOnJobs", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyJobName, Type = String, Dynamic = False, Default = \"name", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyMinimumTaskCount, Type = String, Dynamic = False, Default = \"minimumTaskCount", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyNotificationEmail, Type = String, Dynamic = False, Default = \"notificationEmail", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeySchedulerHints, Type = String, Dynamic = False, Default = \"schedulerHints", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeySchedulerParameters, Type = String, Dynamic = False, Default = \"schedulerParameters", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeySubmissionIdentifier, Type = String, Dynamic = False, Default = \"submissionIdentifier", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyTaskPrototypes, Type = String, Dynamic = False, Default = \"taskPrototypes", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyTasksMustStartSimul, Type = String, Dynamic = False, Default = \"tasksMustStartSimultaneously", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyTaskSpecifications, Type = String, Dynamic = False, Default = \"taskSpecifications", Scope = Protected
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
