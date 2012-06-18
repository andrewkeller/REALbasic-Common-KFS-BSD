#tag Class
Protected Class PosixCommandLineArgumentParser
Implements CommandLineArgumentParser
	#tag Method, Flags = &h0
		Sub Constructor(args() As String, app_resources As ResourceManagerKFS)
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Copies the given arguments into local storage.
		  
		  For Each arg As String in args
		    
		    p_src_args.Append arg
		    
		  Next
		  
		  If UBound( p_src_args ) > -1 Then
		    
		    p_next_appinvstrs.Append p_src_args(0)
		    p_src_args.Remove 0
		    
		  End If
		  
		  p_rsrc = app_resources
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextAppInvocationString() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next flag in the arguments.  If the next item is not a flag, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_appinvstrs ) > -1 Then
		    
		    Dim result As String = p_next_flags(0)
		    p_next_flags.Remove 0
		    Return result
		    
		  ElseIf UBound( p_next_flags ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotTheAppInvocationString( p_rsrc, p_next_flags(0) )
		    
		  ElseIf UBound( p_next_parcels ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotTheAppInvocationString( p_rsrc, p_next_parcels(0) )
		    
		  Else
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextFlag() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next flag in the arguments.  If the next item is not a flag, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_flags ) > -1 Then
		    
		    Dim result As String = p_next_flags(0)
		    p_next_flags.Remove 0
		    Return result
		    
		  ElseIf UBound( p_next_appinvstrs ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAFlag( p_rsrc, p_next_appinvstrs(0) )
		    
		  ElseIf UBound( p_next_parcels ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAFlag( p_rsrc, p_next_parcels(0) )
		    
		  Else
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextParcel() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next parcel in the arguments.  If the next item is not a parcel, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_parcels ) > -1 Then
		    
		    Dim result As String = p_next_parcels(0)
		    p_next_parcels.Remove 0
		    Return result
		    
		  ElseIf UBound( p_next_appinvstrs ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAParcel( p_rsrc, p_next_appinvstrs(0) )
		    
		  ElseIf UBound( p_next_flags ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAParcel( p_rsrc, p_next_flags(0) )
		    
		  Else
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextAppInvocationString() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is an application invocation string next in the arguments.
		  
		  ProcessNextArgument
		  
		  Return UBound( p_next_flags ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextFlag() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is a flag next in the arguments.
		  
		  ProcessNextArgument
		  
		  Return UBound( p_next_flags ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextParcel() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is a parcel next in the arguments.
		  
		  ProcessNextArgument
		  
		  Return UBound( p_next_parcels ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextSomething() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is anything left to return.
		  
		  ProcessNextArgument
		  
		  Return UBound( p_next_appinvstrs ) > -1 Or UBound( p_next_flags ) > -1 Or UBound( p_next_parcels ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextAppInvocationString() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next application invocation string in the arguments.  If the next item is not the application invocation string, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_appinvstrs ) > -1 Then
		    
		    Return p_next_appinvstrs(0)
		    
		  ElseIf UBound( p_next_flags ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotTheAppInvocationString( p_rsrc, p_next_flags(0) )
		    
		  ElseIf UBound( p_next_parcels ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotTheAppInvocationString( p_rsrc, p_next_parcels(0) )
		    
		  Else
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextFlag() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next flag in the arguments.  If the next item is not a flag, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_flags ) > -1 Then
		    
		    Return p_next_flags(0)
		    
		  ElseIf UBound( p_next_appinvstrs ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAFlag( p_rsrc, p_next_appinvstrs(0) )
		    
		  ElseIf UBound( p_next_parcels ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAFlag( p_rsrc, p_next_parcels(0) )
		    
		  Else
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextParcel() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next parcel in the arguments.  If the next item is not a parcel, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_parcels ) > -1 Then
		    
		    Return p_next_parcels(0)
		    
		  ElseIf UBound( p_next_appinvstrs ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAParcel( p_rsrc, p_next_appinvstrs(0) )
		    
		  ElseIf UBound( p_next_flags ) > -1 Then
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAParcel( p_rsrc, p_next_flags(0) )
		    
		  Else
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProcessNextArgument()
		  // Created 6/17/2012 by Andrew Keller
		  
		  // If the 'next queue' is empty, this method processes the
		  // next item in the source arguments.  Else, this method
		  // does nothing.  Feel free to call it whenever you would like.
		  
		  If UBound( p_next_appinvstrs ) < 0 And UBound( p_next_flags ) < 0 And UBound( p_next_parcels ) < 0 Then
		    
		    If UBound( p_src_args ) > -1 Then
		      
		      Dim item As String = p_src_args(0)
		      
		      If item = "" Then
		        
		        p_next_parcels.Append ""
		        
		      ElseIf item = "-" Or item = "--" Then
		        
		        p_next_flags.Append ""
		        
		      ElseIf item.Left(2) = "--" Then
		        
		        p_next_flags.Append item.Mid(3)
		        
		      ElseIf item.Left(1) = "-" Then
		        
		        For Each flag As String In item.Mid(2).Split("")
		          p_next_flags.Append flag
		        Next
		        
		      Else
		        
		        p_next_parcels.Append item
		        
		      End If
		    End If
		  End If
		  
		  // done.
		  
		End Sub
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
		
		Copyright (c) 2012 Andrew Keller.
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
		Protected p_next_appinvstrs(-1) As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_next_flags(-1) As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_next_parcels(-1) As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_rsrc As ResourceManagerKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_src_args(-1) As String
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
