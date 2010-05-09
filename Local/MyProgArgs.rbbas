#tag Class
Protected Class MyProgArgs
Inherits LinearArgDesequencerKFS
	#tag Method, Flags = &h1
		Protected Sub AddArgSpecifications()
		  // Created 4/24/2010 by Andrew Keller
		  
		  // Add the default argument set:
		  
		  Super.AddArgSpecifications
		  
		  // Add an argument that is:
		  //   - identified from within this class by "a"
		  //   - triggered by 'a' or "optionA"
		  //   - has one parcel
		  //   - is not an array (only last received parcel counts)
		  //   - is not unbounded (unexpected parcels will never be directed to this argument)
		  //   - is not terminal (encountering this argument will not terminate parsing)
		  
		  ArgSpecAdd "a", "a", "optionA", 1, False, False, False, "Option A"
		  
		  
		  // Add an argument that is:
		  //   - identified from within this class by "b"
		  //   - triggered by 'b' or "optionB"
		  //   - has two parcels
		  //   - is an array (all found parcels count)
		  //   - is not unbounded
		  //   - is not terminal
		  
		  ArgSpecAdd "b", "b", "optionB", 2, True, False, False, "Option B"
		  
		  
		  // Add an argument that is:
		  //   - identified from within this class by "c"
		  //   - triggered by 'c' or "optionC"
		  //   - has one parcel
		  //   - is an array
		  //   - is unbounded (unexpected parcels count for this argument, if this argument was the last unbounded argument triggered)
		  //   - is not terminal
		  
		  ArgSpecAdd "c", "c", "optionC", 1, True, True, False, "Option C"
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LogicalOptASummary() As String
		  // Created 4/24/2010 by Andrew Keller
		  
		  // Return a summary of the parcels for Option A.
		  
		  // If this argument was never triggered, then return nothing.
		  
		  If Me.GetTriggerCount( "a" ) = 0 Then Return ""
		  
		  // Get the parcels found for this argument:
		  
		  Dim parcels() As String = Me.GetRelevantParcels( "a" )
		  
		  // Return something in English:
		  
		  Return "'" + Join( parcels, "', '" ) + "'"
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LogicalOptBSummary() As String
		  // Created 4/24/2010 by Andrew Keller
		  
		  // Return a summary of the parcels for Option B.
		  
		  // If this argument was never triggered, then return nothing.
		  
		  If Me.GetTriggerCount( "b" ) = 0 Then Return ""
		  
		  // Get the parcels found for this argument:
		  
		  Dim parcels() As String = Me.GetRelevantParcels( "b" )
		  
		  // Return something in English:
		  
		  Return "'" + Join( parcels, "', '" ) + "'"
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function LogicalOptCSummary() As String
		  // Created 4/24/2010 by Andrew Keller
		  
		  // Return a summary of the parcels for Option C.
		  
		  // If this argument was never triggered, then return nothing.
		  
		  If Me.GetTriggerCount( "c" ) = 0 Then Return ""
		  
		  // Get the parcels found for this argument:
		  
		  Dim parcels() As String = Me.GetRelevantParcels( "c" )
		  
		  // Return something in English:
		  
		  Return "'" + Join( parcels, "', '" ) + "'"
		  
		  // done.
		  
		End Function
	#tag EndMethod


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
