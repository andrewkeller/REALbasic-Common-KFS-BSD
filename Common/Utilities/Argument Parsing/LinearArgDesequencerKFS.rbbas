#tag Class
Protected Class LinearArgDesequencerKFS
	#tag Method, Flags = &h1
		Protected Sub AddArgSpecifications()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Add argument specifications to this instance.
		  
		  ArgSpecAdd kArgIDHelp, "h", "help", 0, False, False, True, "Help"
		  ArgSpecAdd kArgIDVerbose, "v", "verbose", 0, True, False, "Increase Verbosity"
		  ArgSpecAdd kArgIDAppVersion, "", "version", 0, False, False, True, "Print Version"
		  
		  // Add required arguments to requiredArgIDs.
		  
		  'None...  Sample:
		  'requiredArgIDs.Append kArgID_Some_Argument_ID
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function AppExecutionString() As String
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the string used to launch this program.
		  
		  Try
		    
		    Return myOrigArgs(0)
		    
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		  End Try
		  
		  Return ""
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ArgSpecAdd(id As String, flags As String, ParamArray switches As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Adds the given information into the given argument specification.
		  
		  Dim argObject As LinearCLArgumentKFS = MakeGetArgObject( id )
		  
		  argObject.AddFlags flags
		  argObject.AddSwitches switches
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ArgSpecAdd(id As String, flags As String, switch As String, parcelCount As Integer, isArray As Boolean, isUnbounded As Boolean, isTerminal As Boolean, displayName As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Adds the given information into the given argument specification.
		  
		  Dim argObject As LinearCLArgumentKFS = MakeGetArgObject( id )
		  
		  argObject.AddFlags flags
		  argObject.AddSwitches switch
		  argObject.ParcelCount = parcelCount
		  argObject.IsArray = isArray
		  argObject.IsUnbounded = isUnbounded
		  argObject.IsTerminal = isTerminal
		  argObject.Name = displayName
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ArgSpecAdd(id As String, flags As String, switch As String, parcelCount As Integer, isArray As Boolean, isUnbounded As Boolean, displayName As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Adds the given information into the given argument specification.
		  
		  Dim argObject As LinearCLArgumentKFS = MakeGetArgObject( id )
		  
		  argObject.AddFlags flags
		  argObject.AddSwitches switch
		  argObject.ParcelCount = parcelCount
		  argObject.IsArray = isArray
		  argObject.IsUnbounded = isUnbounded
		  argObject.Name = displayName
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ArgSpecRemove(argID As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Deletes the given argument specification.
		  
		  If myArgs.HasKey( argID ) Then myArgs.Remove argID
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ArgsUsageMessage() As String
		  // Created 1/4/2010 by Andrew Keller
		  
		  // Returns a human-readable string including the flags
		  // and display name of all loaded arguments.  Text
		  // spacing is designed to work with fixed-width fonts.
		  
		  Dim working() As String
		  
		  Dim argKeys() As Variant = myArgs.Keys
		  Dim row, lastArg As Integer = argKeys.Ubound
		  
		  If lastArg = -1 Then Return AppExecutionString
		  
		  ReDim working( lastArg )
		  
		  // Start with the program execution point.
		  
		  Dim result As String = "Usage: " + AppExecutionString
		  Dim defaultIndent As String = "    "
		  
		  // Add the required parcels.
		  
		  For Each key As String In requiredArgIDs
		    For count As Integer = GetArgObject(key).ParcelCount DownTo 1
		      
		      result = result + " " + key
		      
		    Next
		  Next
		  
		  // Now for the options.
		  
		  For row = 0 To lastArg
		    
		    Dim flags As String = GetArgObject(argKeys(row)).Flags
		    
		    If flags = "" Then
		      
		      working( row ) = defaultIndent
		    Else
		      working( row ) = defaultIndent + "-" + flags
		      
		      If GetArgObject(argKeys(row)).Switches.Ubound = -1 Then
		        
		        working( row ) = working( row ) + " "
		      Else
		        working( row ) = working( row ) + ", "
		        
		      End If
		    End If
		    
		  Next
		  
		  MatchStringLengths working
		  
		  For row = 0 To lastArg
		    For Each switch As String In GetArgObject(argKeys(row)).Switches
		      
		      working( row ) = working( row ) + "--" + switch + "  "
		      
		    Next
		  Next
		  
		  MatchStringLengths working
		  
		  For row = 0 To lastArg
		    
		    working( row ) = working( row ) + GetArgObject(argKeys(row)).Name
		    
		    If requiredArgIDs.IndexOf( argKeys(row) ) > -1 Then _
		    working( row ) = working( row ) + "  (" + argKeys(row) + ")"
		    
		  Next
		  
		  Return result + EndOfLine + EndOfLine + "Options:" + EndOfLine + Join( working, EndOfLine )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Basic Constructor - Pretend as
		  // if we have an empty args array.
		  
		  Dim args( -1 ) As String
		  
		  Constructor( args )
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(args() As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Standard Constructor.
		  
		  // First, initialize our variables
		  
		  myArgs = New Dictionary
		  myLastErrorCode = 0
		  myLastErrorMsg = ""
		  myOrigArgs = args
		  ReDim requiredArgIDs( -1 )
		  
		  // Next, load the specifications we are looking for.
		  
		  AddArgSpecifications
		  
		  // Finally, parse the argument set.
		  
		  Desequence_Core
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Desequence_Core()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Primary Desequencing Function.
		  
		  // Initialize the current unbounded parcel
		  
		  Dim unboundedParcelKey As String = ""
		  
		  // Initialize the queue of parcels.
		  
		  Dim parcelQueue() As String = InitialParcelQueue
		  
		  // Begin scanning the array.
		  
		  Dim iWord, iLastWord As Integer = myOrigArgs.Ubound
		  For iWord = 1 To iLastWord
		    
		    Dim arg As String = myOrigArgs( iWord )
		    
		    If arg.Len > 0 Then
		      
		      // The first character tells a lot.
		      
		      Dim fc As String = arg.Left(1)
		      
		      If fc = "-" Then
		        
		        // This is an option argument.
		        
		        If arg.Len > 1 Then
		          
		          If arg.Mid( 2, 1 ) = "-" Then
		            
		            // This is a word-argument, AKA a switch.
		            
		            // Figure out which one it is.
		            
		            Dim switch As String = arg.Mid( 3 )
		            
		            Dim argID As String = GetArgIDForSwitch( switch )
		            
		            If argID <> "" Then
		              
		              GetArgObject( argID ).FoundTrigger parcelQueue, argID
		              
		              If GetArgObject( argID ).IsTerminal Then Return
		              
		            Else
		              
		              // This is an unknown switch.
		              
		              myLastErrorCode = kErrUndefinedTrigger
		              myLastErrorMsg = "Unknown switch: '--" + switch + "'"
		              Return
		              
		            End If
		          Else
		            
		            // This is a character-argument, AKA a flag.
		            
		            For Each char As String In arg.Mid(2).Split("")
		              
		              Dim argID As String = GetArgIDForFlag( char )
		              
		              If argID <> "" Then
		                
		                GetArgObject( argID ).FoundTrigger parcelQueue, argID
		                
		                If GetArgObject( argID ).IsTerminal Then Return
		                
		              Else
		                
		                // This is an unknown flag.
		                
		                myLastErrorCode = kErrUndefinedTrigger
		                myLastErrorMsg = "Unknown flag: '-" + char + "'"
		                Return
		                
		              End If
		            Next
		          End If
		        End If
		        
		      ElseIf parcelQueue.Ubound > -1 Or unboundedParcelKey <> "" Then
		        
		        // We are expecting a parcel.
		        
		        // Which one?
		        
		        Dim which As String
		        
		        If parcelQueue.Ubound = -1 Then
		          which = unboundedParcelKey
		        Else
		          which = parcelQueue(0)
		        End If
		        
		        If which = "" Then
		          
		          myLastErrorCode = kErrUndefinedArgID
		          myLastErrorMsg = "Internal Error: While assigning a parcel to an argument: the ID of an expected parcel is null."
		          Return
		          
		        End If
		        
		        // Add this parcel to the correct bin in myArgs.
		        
		        GetArgObject( which ).FoundParcel arg
		        
		        // Set the current unboundedParcelKey.
		        
		        If GetArgObject( which ).IsUnbounded Then unboundedParcelKey = which
		        
		        // Advance the queue.
		        
		        If parcelQueue.Ubound >= 0 Then parcelQueue.Remove 0
		        
		      Else
		        
		        // This is an unexpected parcel.
		        
		        myLastErrorCode = kErrUnexpectedParcel
		        myLastErrorMsg = "Unexpected argument: '" + arg + "'"
		        Return
		        
		      End If
		    End If
		  Next
		  
		  // The queue had better be empty at this point.
		  
		  If parcelQueue.Ubound > -1 Then
		    
		    myLastErrorCode = kErrMissingParcel
		    myLastErrorMsg = "Expected argument: " + GetArgObject(parcelQueue(0)).Name
		    Return
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Error() As Boolean
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns whether or not this
		  // instance has encountered an error.
		  
		  Return myLastErrorCode <> 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorCode() As Integer
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the last error code of this instance.
		  
		  Return myLastErrorCode
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ErrorMessage() As String
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the last error message of this instance.
		  
		  Return myLastErrorMsg
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetArgIDForFlag(flag As String) As String
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the argument ID that responds to the given flag.
		  
		  For Each argID As String In myArgs.Keys
		    
		    Try
		      
		      If GetArgObject( argID ).HasFlag( flag ) Then Return argID
		      
		    Catch err As RuntimeException
		      ReRaiseRBFrameworkExceptionsKFS err
		    End Try
		    
		  Next
		  
		  Return ""
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function GetArgIDForSwitch(switch As String) As String
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the argument ID that responds to the given switch.
		  
		  For Each argID As String In myArgs.Keys
		    
		    Try
		      
		      If GetArgObject( argID ).HasSwitch( switch ) Then Return argID
		      
		    Catch err As RuntimeException
		      ReRaiseRBFrameworkExceptionsKFS err
		    End Try
		    
		  Next
		  
		  Return ""
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetArgObject(id As String) As LinearCLArgumentKFS
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the given argument specification.
		  
		  Return myArgs.Lookup( id, Nil )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetMostRelevantParcel(argID As String) As String
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the most relevant parcel found for this argument.
		  
		  Dim argObject As LinearCLArgumentKFS = myArgs.Lookup( argID, Nil )
		  
		  If Not ( argObject Is Nil ) Then
		    
		    Return argObject.GetMostRelevantParcel
		    
		  Else
		    
		    Return ""
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetParcelCount(argID As String) As Integer
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the number of parcels found for this argument.
		  
		  Dim argObject As LinearCLArgumentKFS = myArgs.Lookup( argID, Nil )
		  
		  If Not ( argObject Is Nil ) Then
		    
		    Return argObject.GetParcelCount
		    
		  Else
		    
		    Return 0
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetParcels(argID As String) As String()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the parcels found for this argument.
		  
		  Dim argObject As LinearCLArgumentKFS = myArgs.Lookup( argID, Nil )
		  
		  If Not ( argObject Is Nil ) Then
		    
		    Return argObject.GetParcels
		    
		  Else
		    
		    Dim result( -1 ) As String
		    Return result
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetRelevantParcels(argID As String) As String()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns only the relevant parcels found for this argument.
		  
		  Dim argObject As LinearCLArgumentKFS = myArgs.Lookup( argID, Nil )
		  
		  If Not ( argObject Is Nil ) Then
		    
		    Return argObject.GetRelevantParcels
		    
		  Else
		    
		    Dim result( -1 ) As String
		    Return result
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function GetTriggerCount(argID As String) As Integer
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Returns the number of times this argument was triggered.
		  
		  Dim argObject As LinearCLArgumentKFS = myArgs.Lookup( argID, Nil )
		  
		  If Not ( argObject Is Nil ) Then
		    
		    Return argObject.GetTriggerCount
		    
		  Else
		    
		    Return 0
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function InitialParcelQueue() As String()
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Generates and returns the initial parcel queue.
		  
		  Dim result( -1 ) As String
		  
		  For index As Integer = requiredArgIDs.Ubound DownTo 0
		    
		    Dim argObject As LinearCLArgumentKFS = myArgs.Lookup( requiredArgIDs(index), Nil )
		    
		    If argObject Is Nil Then
		      
		      myLastErrorCode = kErrUndefinedArgID
		      myLastErrorMsg = "Internal Error: While expanding the list of required arguments: Undefined argument ID"
		      Return result
		      
		    End If
		    
		    For count As Integer = argObject.ParcelCount DownTo 1
		      
		      result.Insert 0, requiredArgIDs( index )
		      
		    Next
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogicalAppVersion() As Boolean
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Convenience function that returns whether or
		  // not the user wants to return the app's version.
		  
		  Return GetTriggerCount( kArgIDAppVersion ) > 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogicalHelp() As Boolean
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Convenience function that returns
		  // whether or not the user wants help.
		  
		  Return GetTriggerCount( kArgIDHelp ) > 0
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogicalVerbosity() As Integer
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Convenience function that returns the
		  // verbosity level indicated by the arguments.
		  
		  Return GetTriggerCount( kArgIDVerbose )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function MakeGetArgObject(id As String) As LinearCLArgumentKFS
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Creates if necessary and returns the given argument specification.
		  
		  Dim argObject As LinearCLArgumentKFS
		  
		  If myArgs.HasKey( id ) Then
		    
		    argObject = myArgs.Value( id )
		    
		  Else
		    
		    argObject = New LinearCLArgumentKFS
		    myArgs.Value( id ) = argObject
		    
		  End If
		  
		  Return argObject
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub MatchStringLengths(ByRef ary() As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Adds spaces to the shortest string in ary
		  // until all elemens in ary are the same length.
		  
		  Dim row, last As Integer = ary.Ubound
		  
		  Dim maxLength As Integer = 0
		  
		  For row = 0 To last
		    
		    maxLength = Max( maxLength, ary(row).Len )
		    
		  Next
		  
		  For row = 0 To last
		    While ary(row).Len < maxLength
		      
		      ary(row) = ary(row) + " "
		      
		    Wend
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(args() As String)
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Convert Constructor -
		  // Ask the Standard Constructor to handle this.
		  
		  Constructor args
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function Parse(args() As String) As LinearArgDesequencerKFS
		  // Created 1/3/2010 by Andrew Keller
		  
		  // Provides an additional syntax
		  // for parsing an arguments array.
		  
		  Return args
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		Thank you for using the REALbasic Common KFS BSD Library!
		
		The latest version of this library can be downloaded from:
		  https://github.com/andrewkeller/REALbasic-Common-KFS-BSD
		
		This class is licensed as BSD.  This generally means you may do
		whatever you want with this class so long as the new work includes
		the names of all the contributors of the parts you used.  Unlike some
		other open source licenses, the use of this class does NOT require
		your work to inherit the license of this class.  However, the license
		you choose for your work does not have the ability to overshadow,
		override, or in any way disable the requirements put forth in the
		license for this class.
		
		The full official license is as follows:
		
		Copyright (c) 2010 Andrew Keller.
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or without
		modification, are permitted provided that the following conditions
		are met:
		
		  Redistributions of source code must retain the above
		  copyright notice, this list of conditions and the
		  following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the
		  following disclaimer in the documentation and/or other
		  materials provided with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
		  contributors may be used to endorse or promote products
		  derived from this software without specific prior written
		  permission.
		
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
		Protected myArgs As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myLastErrorCode As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myLastErrorMsg As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected myOrigArgs() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected requiredArgIDs() As String
	#tag EndProperty


	#tag Constant, Name = kArgIDAppVersion, Type = String, Dynamic = False, Default = \"appversion", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kArgIDHelp, Type = String, Dynamic = False, Default = \"help", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kArgIDVerbose, Type = String, Dynamic = False, Default = \"verbose", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = kErrMissingParcel, Type = Double, Dynamic = False, Default = \"4", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrNone, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrUndefinedArgID, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrUndefinedTrigger, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kErrUnexpectedParcel, Type = Double, Dynamic = False, Default = \"3", Scope = Public
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
