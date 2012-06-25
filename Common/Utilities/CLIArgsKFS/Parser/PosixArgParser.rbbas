#tag Class
Protected Class PosixArgParser
Implements CLIArgsKFS.Parser.ArgParser
	#tag Method, Flags = &h0
		Sub Constructor(args() As String, app_resources As ResourceManagerKFS = Nil)
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Copies the given arguments into local storage.
		  
		  For Each arg As String in args
		    
		    p_src_args.Append arg
		    
		  Next
		  
		  If UBound( p_src_args ) > -1 Then
		    
		    p_next_type.Append CLIArgsKFS.Parser.Fields.AppInvocationString
		    p_next_value.Append p_src_args(0)
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
		Function GetNextItemValue() As String
		  // Created 6/24/2012 by Andrew Keller
		  
		  // Returns the next item value in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    
		    Dim result As String = p_next_value(0)
		    p_next_type.Remove 0
		    p_next_value.Remove 0
		    Return result
		    
		  End If
		  
		  Raise New CLIArgsKFS.Parser.ParserExahustedException( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextItem() As Boolean
		  // Created 6/24/2012 by Andrew Keller
		  
		  // Returns whether or not there is another item in the arguments.
		  
		  ProcessNextArgument
		  
		  Return UBound( p_next_value ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextItemType() As CLIArgsKFS.Parser.Fields
		  // Created 6/24/2012 by Andrew Keller
		  
		  // Returns the next item type in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_type ) > -1 Then
		    
		    Return p_next_type(0)
		    
		  End If
		  
		  Raise New CLIArgsKFS.Parser.ParserExahustedException( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextItemValue() As String
		  // Created 6/24/2012 by Andrew Keller
		  
		  // Returns the next item value in the arguments.
		  
		  ProcessNextArgument
		  
		  If UBound( p_next_value ) > -1 Then
		    
		    Return p_next_value(0)
		    
		  End If
		  
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
		  // Created 6/17/2012 by Andrew Keller
		  
		  // If the 'next queue' is empty, this method processes the
		  // next item in the source arguments.  Else, this method
		  // does nothing.  Feel free to call it whenever you would like.
		  
		  // If a parse error occurs, an exception is raised without
		  // modifying any of the data in this object.  This makes the
		  // class more predictable in the event of an error, because
		  // every time you try to access information about an argument,
		  // the same exception will be raised.
		  
		  If UBound( p_next_value ) < 0 Then
		    If UBound( p_src_args ) > -1 Then
		      
		      Dim item As String = p_src_args(0)
		      
		      If Not p_process_flags_as_parcels And item.Left(2) = "--" Then
		        
		        Dim attparcelpos As Integer = FirstOccurranceOfAny( item, ":", "=" )
		        
		        If attparcelpos > 0 Then
		          
		          p_next_type.Append CLIArgsKFS.Parser.Fields.Flag
		          p_next_value.Append item.Mid( 3, attparcelpos -3 )
		          p_next_type.Append CLIArgsKFS.Parser.Fields.AttachedParcel
		          p_next_value.Append item.Mid( attparcelpos +1 )
		          
		        Else
		          
		          p_next_type.Append CLIArgsKFS.Parser.Fields.Flag
		          p_next_value.Append item.Mid(3)
		          
		        End If
		        
		      ElseIf Not p_process_flags_as_parcels And item.Left(1) = "-" Then
		        
		        Dim attparcelpos As Integer = FirstOccurranceOfAny( item, ":", "=" )
		        Dim flags() As String
		        
		        If attparcelpos > 0 Then
		          flags = item.Mid( 2, attparcelpos -2 ).Split("")
		          If UBound( flags ) < 0 Then Raise New CLIArgsKFS.Parser.MissingFlagForAttachedParcelException( p_rsrc, item )
		        Else
		          flags = item.Mid(2).Split("")
		        End If
		        
		        For Each flag As String In flags
		          p_next_type.Append CLIArgsKFS.Parser.Fields.Flag
		          p_next_value.Append flag
		        Next
		        
		        If attparcelpos > 0 Then
		          p_next_type.Append CLIArgsKFS.Parser.Fields.AttachedParcel
		          p_next_value.Append item.Mid( attparcelpos +1 )
		        End If
		        
		      Else
		        
		        p_next_type.Append CLIArgsKFS.Parser.Fields.Parcel
		        p_next_value.Append item
		        
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
		Protected p_next_type(-1) As CLIArgsKFS.Parser.Fields
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


	#tag Constant, Name = kParseErrorCode_AttachedParcelWithNoFlag, Type = Double, Dynamic = False, Default = \"1", Scope = Public
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
