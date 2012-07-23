#tag Class
Protected Class DosArgParser
Implements CLIArgsKFS.Parser.ArgParser
	#tag Method, Flags = &h0
		Sub Constructor(args() As String, app_resources As ResourceManagerKFS = Nil)
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Copies the given arguments into local storage.
		  
		  For Each arg As String in args
		    
		    p_src_args.Append arg
		    
		  Next
		  
		  If UBound( p_src_args ) > -1 Then
		    
		    p_next.Append New CLIArgsKFS.Parser.Argument( p_src_args(0), CLIArgsKFS.Parser.Argument.kTypeAppInvocationString )
		    p_src_args.Remove 0
		    
		  End If
		  
		  p_process_flags_as_parcels = False
		  p_rsrc = app_resources
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Shared Function FirstOccurranceOfAny(src As String, ParamArray subStrings As String) As Integer
		  // Created 6/22/2012 by Andrew Keller
		  
		  // Returns the index of the first occurrance of any of the given subStrings in src.
		  
		  Dim result As Integer = src.InStr( subStrings(0) )
		  
		  For i As Integer = 1 To UBound( subStrings )
		    
		    Dim tmp As Integer = src.InStr( subStrings(i) )
		    
		    If tmp > 0 And ( result <= 0 Or tmp < result ) Then result = tmp
		    
		  Next
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextArgument() As CLIArgsKFS.Parser.Argument
		  // Created 6/24/2012 by Andrew Keller
		  
		  // Returns the next item in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next ) > -1 Then
		    
		    Dim result As CLIArgsKFS.Parser.Argument = p_next(0)
		    p_next.Remove 0
		    Return result
		    
		  End If
		  
		  Raise New CLIArgsKFS.Parser.ParserExahustedException( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextArgument() As Boolean
		  // Created 6/24/2012 by Andrew Keller
		  
		  // Returns whether or not there is another item in the arguments.
		  
		  ProcessNextArgument
		  
		  Return UBound( p_next ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextArgument() As CLIArgsKFS.Parser.Argument
		  // Created 6/24/2012 by Andrew Keller
		  
		  // Returns the next item in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next ) > -1 Then Return p_next(0)
		  
		  Raise New CLIArgsKFS.Parser.ParserExahustedException( p_rsrc )
		  
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
		  // Created 6/20/2012 by Andrew Keller
		  
		  // If the 'next queue' is empty, this method processes the
		  // next item in the source arguments.  Else, this method
		  // does nothing.  Feel free to call it whenever you would like.
		  
		  If UBound( p_next ) < 0 Then
		    If UBound( p_src_args ) > -1 Then
		      
		      Dim item As String = p_src_args(0)
		      
		      If Not p_process_flags_as_parcels And item.Left(1) = "/" Then
		        
		        Dim attparcelpos As Integer = FirstOccurranceOfAny( item, ":", "=" )
		        
		        If attparcelpos > 0 Then
		          
		          p_next.Append New CLIArgsKFS.Parser.Argument( item.Mid( 2, attparcelpos -2 ), CLIArgsKFS.Parser.Argument.kTypeFlag )
		          p_next.Append New CLIArgsKFS.Parser.Argument( item.Mid( attparcelpos +1 ), CLIArgsKFS.Parser.Argument.kTypeAttachedParcel )
		          
		        Else
		          
		          p_next.Append New CLIArgsKFS.Parser.Argument( item.Mid(2), CLIArgsKFS.Parser.Argument.kTypeFlag )
		          
		        End If
		      Else
		        
		        p_next.Append New CLIArgsKFS.Parser.Argument( item, CLIArgsKFS.Parser.Argument.kTypeParcel )
		        
		      End If
		      
		      p_src_args.Remove 0
		      
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
		Protected p_next(-1) As CLIArgsKFS.Parser.Argument
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
