#tag Class
Protected Class XgridTaskKFS
	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 5/7/2010 by Andrew Keller
		  
		  // Clears or initializes all the data in this task.
		  
		  If myTaskDependancies = Nil Then
		    
		    myEnvironment = New Dictionary
		    myInputFileMap = New Dictionary
		    myTaskDependancies = New Dictionary
		    
		  End If
		  
		  ReDim myArguments(-1)
		  myCommand = ""
		  myEnvironment.Clear
		  myInputFileMap.Clear
		  myInputStream = ""
		  myTaskDependancies.Clear
		  myTaskPrototypeIdentifier = ""
		  
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
		  
		  // Get this task's command.
		  myCommand = plist.Lookup( kPListKeyCommand, "" )
		  
		  // Get this task's arguments.
		  Revert_Arguments plist.Child( kPListKeyArguments )
		  
		  // Get this task's prototype identifier.
		  myTaskPrototypeIdentifier = plist.Lookup( kPListKeyTaskPrototypeIdentifier, "" )
		  
		  // Get this task's input stream.
		  myInputStream = plist.Lookup( kPListKeyInputStream, "" )
		  
		  // Get this task's environment.
		  Revert_Environment plist.Child( kPListKeyEnvironment )
		  
		  // Get this task's input file map.
		  Revert_InputFileMap plist.Child( kPListKeyInputFileMap )
		  
		  // Get this task's dependency list.
		  Revert_TaskDependancies plist.Child( kPListKeyTaskDependancies )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_Arguments(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the task arguments contained in the
		  // given PropertyList into this instance.
		  
		  If plist = Nil Then Return
		  
		  // Get this task's arguments.
		  
		  For Each v As Variant In plist.Values
		    
		    myArguments.Append v
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_Environment(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the task environment contained in the
		  // given PropertyList into this instance.
		  
		  If plist = Nil Then Return
		  
		  // Get this task's environment.
		  
		  For Each v As Variant In plist.Keys
		    
		    myEnvironment.Value( v ) = plist.Value( v )
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_InputFileMap(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the task input file map contained in
		  // the given PropertyList into this instance.
		  
		  If plist = Nil Then Return
		  
		  // Get this task's input file map.
		  
		  For Each v As Variant In plist.Keys
		    
		    myInputFileMap.Value( v ) = plist.Value( v )
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Revert_TaskDependancies(plist As PropertyListKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Loads the task dependencies contained in
		  // the given PropertyList into this instance.
		  
		  If plist = Nil Then Return
		  
		  // Get this task's arguments.
		  
		  For Each v As Variant In plist.Values
		    
		    myTaskDependancies.Value( v ) = True
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected myArguments() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myCommand As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myEnvironment As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myInputFileMap As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myInputStream As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mySchedulerHint As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTaskDependancies As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTaskPrototypeIdentifier As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mySchedulerHint
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mySchedulerHint = value
			End Set
		#tag EndSetter
		SchedulerHint As String
	#tag EndComputedProperty


	#tag Constant, Name = kPListKeyArguments, Type = String, Dynamic = False, Default = \"arguments", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyCommand, Type = String, Dynamic = False, Default = \"command", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyEnvironment, Type = String, Dynamic = False, Default = \"environment", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyInputFileMap, Type = String, Dynamic = False, Default = \"inputFileMap", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyInputStream, Type = String, Dynamic = False, Default = \"inputStream", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyTaskDependancies, Type = String, Dynamic = False, Default = \"dependsOnTasks", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kPListKeyTaskPrototypeIdentifier, Type = String, Dynamic = False, Default = \"taskPrototypeIdentifier", Scope = Protected
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
