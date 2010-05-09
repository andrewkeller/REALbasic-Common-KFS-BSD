#tag Class
Protected Class XgridBatchFileKFS
	#tag Method, Flags = &h0
		Sub AddJob(j As XgridJobKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Adds the given job to this instance.
		  
		  myJobs.Append j
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  // Created 5/7/2010 by Andrew Keller
		  
		  // Clears or initializes all the data in this task.
		  
		  ReDim myJobs(-1)
		  
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

	#tag Method, Flags = &h1000
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
		  
		  // Make sure the root node is an array.
		  
		  plist.Type = PropertyListKFS.kNodeTypeArray
		  
		  // Add the jobs.
		  
		  Dim index, last As Integer
		  last = UBound( myJobs )
		  
		  For index = 0 To last
		    
		    plist.Child( index ) = Job( index )
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub InsertJob(index As Integer, j As XgridJobKFS)
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Inserts the given job into this instance.
		  
		  myJobs.Insert index, j
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Job(index As Integer) As XgridJobKFS
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Provides access to the given job.
		  
		  Return myJobs( index )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Jobs() As XgridJobKFS()
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Provides access to the jobs array.
		  
		  Return myJobs
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NewJob() As XgridJobKFS
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Adds and returns a new job to this instance.
		  
		  Dim result As New XgridJobKFS
		  
		  AddJob result
		  
		  Return result
		  
		  // done.
		  
		End Function
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
		Function Operator_Convert() As PropertyListKFS_XML1
		  // Created 5/5/2010 by Andrew Keller
		  
		  // Convert constructor, to a PropertyListKFS instance.
		  
		  // Acquire a blank PropertyListKFS.
		  
		  Dim result As New PropertyListKFS_XML1
		  
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
		  
		  For Each item As PropertyListKFS In plist.Children
		    
		    myJobs.Append item
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected myJobs() As XgridJobKFS
	#tag EndProperty


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
