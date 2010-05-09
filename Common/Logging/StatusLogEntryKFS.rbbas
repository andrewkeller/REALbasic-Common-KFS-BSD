#tag Class
Protected Class StatusLogEntryKFS
	#tag Method, Flags = &h0
		Function CallingMethod() As String
		  // Created 4/15/2009 by Andrew Keller
		  
		  // return the calling method
		  
		  Return myCallingMethod
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // default constructor disabled for external use
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(myQO As StatusLogQueryKFS, pk As Integer, dTime As Date, ui64Time As Int64, callingMethod As String, debugLevel As Int8, isError As Boolean)
		  // Created 4/15/2009 by Andrew Keller
		  
		  // copy input to local variables
		  
		  myCallingMethod = CallingMethod
		  myDebugLevel = DebugLevel
		  myIsError = IsError
		  ReDim myMessages( -1 )
		  myMessagesAreLoaded = False
		  myMicroseconds = ui64Time
		  myPK = pk
		  myQueryRef = myQO
		  myTimestamp = dTime
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function DebugLevel() As Int8
		  // Created 4/15/2009 by Andrew Keller
		  
		  // return the debug level
		  
		  Return myDebugLevel
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function EntryID() As Integer
		  // Created 4/15/2009 by Andrew Keller
		  
		  // return the primary key of this entry
		  
		  Return myPK
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsError() As Boolean
		  // Created 4/15/2009 by Andrew Keller
		  
		  // return the error flag
		  
		  Return myIsError
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function MessagePreview(length As Integer = 200) As String
		  // Created 4/15/2009 by Andrew Keller
		  
		  // return a preview of the messages
		  
		  If length < 1 Then length = 1
		  
		  Return ReplaceAll( ReplaceAll( ReplaceAll( Left( Join( Messages, " " ), length ), chr(13)+chr(10), " " ), chr(13), " " ), chr(10), " " )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Messages() As String()
		  // Created 4/15/2009 by Andrew Keller
		  
		  // return a preview of the messages
		  
		  If Not myMessagesAreLoaded Then
		    
		    myMessages = myQueryRef.GetMessagesForEntry( myPK )
		    
		    myMessagesAreLoaded = True
		    
		  End If
		  
		  Return myMessages
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Microseconds() As UInt64
		  // Created 4/15/2009 by Andrew Keller
		  
		  // return the microseconds
		  
		  Return myMicroseconds
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Timestamp() As Date
		  // Created 4/15/2009 by Andrew Keller
		  
		  // return the timestamp
		  
		  Return myTimestamp
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected myCallingMethod As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myDebugLevel As Int8
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myIsError As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMessages() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMessagesAreLoaded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myMicroseconds As UInt64
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myPK As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myQueryRef As StatusLogQueryKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myTimestamp As Date
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
