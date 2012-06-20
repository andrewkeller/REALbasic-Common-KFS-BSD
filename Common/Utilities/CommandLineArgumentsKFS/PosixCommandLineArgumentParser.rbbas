#tag Class
Protected Class PosixCommandLineArgumentParser
Implements CommandLineArgumentParser
	#tag Method, Flags = &h0
		Sub Constructor(args() As String, app_resources As ResourceManagerKFS = Nil)
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Copies the given arguments into local storage.
		  
		  For Each arg As String in args
		    
		    p_src_args.Append arg
		    
		  Next
		  
		  If UBound( p_src_args ) > -1 Then
		    
		    p_next_type.Append ParserFields.AppInvocationString
		    p_next_value.Append p_src_args(0)
		    p_src_args.Remove 0
		    
		  End If
		  
		  p_process_flags_as_parcels = False
		  p_rsrc = app_resources
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextAppInvocationString() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next flag in the arguments.  If the next item is not a flag, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    If p_next_type(0) = ParserFields.AppInvocationString Then
		      
		      Dim result As String = p_next_value(0)
		      p_next_type.Remove 0
		      p_next_value.Remove 0
		      Return result
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotTheAppInvocationString( p_rsrc, p_next_value(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextAttachedParcel() As String
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Returns the next attached parcel in the arguments.  If the next item is not an attached parcel, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    If p_next_type(0) = ParserFields.AttachedParcel Then
		      
		      Dim result As String = p_next_value(0)
		      p_next_type.Remove 0
		      p_next_value.Remove 0
		      Return result
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAnAttachedParcel( p_rsrc, p_next_value(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextFlag() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next flag in the arguments.  If the next item is not a flag, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    If p_next_type(0) = ParserFields.Flag Then
		      
		      Dim result As String = p_next_value(0)
		      p_next_type.Remove 0
		      p_next_value.Remove 0
		      Return result
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAFlag( p_rsrc, p_next_value(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextParcel() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next parcel in the arguments.  If the next item is not a parcel, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    If p_next_type(0) = ParserFields.Parcel Then
		      
		      Dim result As String = p_next_value(0)
		      p_next_type.Remove 0
		      p_next_value.Remove 0
		      Return result
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAParcel( p_rsrc, p_next_value(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextAppInvocationString() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is an application invocation string next in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_type ) > -1 Then
		    
		    Return p_next_type(0) = ParserFields.AppInvocationString
		    
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextAttachedParcel() As Boolean
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Returns whether or not there is a parcel next in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_type ) > -1 Then
		    
		    Return p_next_type(0) = ParserFields.AttachedParcel
		    
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextFlag() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is a flag next in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_type ) > -1 Then
		    
		    Return p_next_type(0) = ParserFields.Flag
		    
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextParcel() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is a parcel next in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_type ) > -1 Then
		    
		    Return p_next_type(0) = ParserFields.Parcel
		    
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextSomething() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is anything left to return.
		  
		  Return UBound( p_next_value ) > -1 Or UBound( p_src_args ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextAppInvocationString() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next application invocation string in the arguments.  If the next item is not the application invocation string, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    If p_next_type(0) = ParserFields.AppInvocationString Then
		      
		      Return p_next_value(0)
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotTheAppInvocationString( p_rsrc, p_next_value(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextAttachedParcel() As String
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Returns the next attached parcel in the arguments.  If the next item is not an attached parcel, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    If p_next_type(0) = ParserFields.AttachedParcel Then
		      
		      Return p_next_value(0)
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAnAttachedParcel( p_rsrc, p_next_value(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextFlag() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next flag in the arguments.  If the next item is not a flag, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    If p_next_type(0) = ParserFields.Flag Then
		      
		      Return p_next_value(0)
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAFlag( p_rsrc, p_next_value(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextParcel() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next parcel in the arguments.  If the next item is not a parcel, an exception is raised.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    If p_next_type(0) = ParserFields.Parcel Then
		      
		      Return p_next_value(0)
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAParcel( p_rsrc, p_next_value(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ProcessFlagsAsParcels() As Boolean
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Returns whether or not this parser is currently configured to treat flags as parcels.
		  
		  Return p_process_flags_as_parcels
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ProcessFlagsAsParcels(Assigns newValue As Boolean)
		  // Created 6/20/2012 by Andrew Keller
		  
		  // Sets whether or not this parser should treat flags as parcels.
		  
		  p_process_flags_as_parcels = newValue
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub ProcessNextArgument()
		  // Created 6/17/2012 by Andrew Keller
		  
		  // If the 'next queue' is empty, this method processes the
		  // next item in the source arguments.  Else, this method
		  // does nothing.  Feel free to call it whenever you would like.
		  
		  If UBound( p_next_value ) < 0 Then
		    If UBound( p_src_args ) > -1 Then
		      
		      Dim item As String = p_src_args(0)
		      p_src_args.Remove 0
		      
		      If Not p_process_flags_as_parcels And item.Left(2) = "--" Then
		        
		        p_next_type.Append ParserFields.Flag
		        p_next_value.Append item.Mid(3)
		        
		      ElseIf Not p_process_flags_as_parcels And item.Left(1) = "-" Then
		        
		        For Each flag As String In item.Mid(2).Split("")
		          p_next_type.Append ParserFields.Flag
		          p_next_value.Append flag
		        Next
		        
		      Else
		        
		        p_next_type.Append ParserFields.Parcel
		        p_next_value.Append item
		        
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
		Protected p_next_type(-1) As ParserFields
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_next_value(-1) As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_process_flags_as_parcels As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_rsrc As ResourceManagerKFS
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_src_args(-1) As String
	#tag EndProperty


	#tag Enum, Name = ParserFields, Flags = &h1
		AppInvocationString
		  Flag
		  AttachedParcel
		Parcel
	#tag EndEnum


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
