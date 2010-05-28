#tag Class
Protected Class LinearCLArgumentKFS
	#tag Method, Flags = &h0
		Sub AddFlags(newFlags As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Adds the given flags to the flags already here.
		  
		  Flags = Flags + newFlags
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddSwitches(newSwitches() As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Adds the given switches to the switches already here.
		  
		  For Each switch As String In newSwitches
		    
		    If Switches.IndexOf( switch ) = -1 Then
		      
		      Switches.Append switch
		      
		    End If
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddSwitches(ParamArray newSwitches As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Adds the given switches to the switches already here.
		  
		  AddSwitches newSwitches
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Basic Constructor.
		  
		  Flags = ""
		  IsArray = False
		  IsTerminal = False
		  IsUnbounded = False
		  ReDim myParcels( -1 )
		  Name = ""
		  ParcelCount = 0
		  ReDim Switches( -1 )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FoundParcel(parcel As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Somebody found a parcel.
		  
		  myParcels.Append parcel
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub FoundTrigger(ByRef parcelQueue() As String, myID As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Somebody found a flag or switch that triggers this argument.
		  
		  myParcels.Append ""
		  
		  For counter As Integer = ParcelCount DownTo 1
		    
		    parcelQueue.Append myID
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetMostRelevantParcel() As String
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the last non-blank parcel.
		  
		  For index As Integer = myParcels.Ubound DownTo 0
		    
		    If myParcels( index ) <> "" Then Return myParcels( index )
		    
		  Next
		  
		  Return ""
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetParcelCount() As Integer
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns number of parcels currently found.
		  
		  Dim count As Integer = 0
		  
		  For index As Integer = myParcels.Ubound DownTo 0
		    
		    If myParcels( index ) <> "" Then count = count + 1
		    
		  Next
		  
		  Return count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetParcels() As String()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the parcels currently found.
		  
		  Dim result( -1 ) As String
		  
		  For index As Integer = myParcels.Ubound DownTo 0
		    
		    If myParcels( index ) <> "" Then result.Insert 0, myParcels( index )
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetRelevantParcels() As String()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns only the relevant parcels.
		  
		  Dim result( -1 ) As String
		  
		  For index As Integer = myParcels.Ubound DownTo 0
		    
		    If Not IsArray Then
		      
		      If result.Ubound = 0 Then Return result
		      
		    ElseIf Not IsUnbounded Then
		      
		      If result.Ubound = ParcelCount -1 Then Return result
		      
		    End If
		    
		    If myParcels( index ) <> "" Then result.Insert 0, myParcels( index )
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetTriggerCount() As Integer
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns number of times this argument was triggered.
		  
		  Dim count As Integer = 0
		  
		  For index As Integer = myParcels.Ubound DownTo 0
		    
		    If myParcels( index ) = "" Then count = count + 1
		    
		  Next
		  
		  Return count
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasFlag(flag As String) As Boolean
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns whether or not this argument has the given flag.
		  
		  Return Flags.InStrB( flag.Left(1) ) > 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasSwitch(switch As String) As Boolean
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns whether or not this argument has the given switch.
		  
		  Return Switches.IndexOf( switch ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Flags As String
	#tag EndProperty

	#tag Property, Flags = &h0
		IsArray As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		IsTerminal As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		IsUnbounded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myParcels() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ParcelCount As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Switches() As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Flags"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsArray"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsTerminal"
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IsUnbounded"
			Group="Behavior"
			Type="Boolean"
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
			Name="ParcelCount"
			Group="Behavior"
			Type="Integer"
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