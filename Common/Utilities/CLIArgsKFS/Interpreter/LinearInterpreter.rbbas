#tag Class
Protected Class LinearInterpreter
	#tag Method, Flags = &h0
		Sub AssociateFlagWithArgument(flag As String, argument_id As String)
		  // Created 8/10/2012 by Andrew Keller
		  
		  // Associates the given flag with the given argument.
		  
		  p_flags.Value( flag ) = argument_id
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AssociateNextNParcelsWithArgument(parcel_count As Integer, argument_id As String)
		  // Created 8/10/2012 by Andrew Keller
		  
		  // When the given argument is encountered, associate the next parcel_count parcels with the argument.
		  
		  p_arg_ex_parcel_counts.Value( argument_id ) = parcel_count
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Created 8/10/2012 by Andrew Keller
		  
		  // Sets up this object.
		  
		  p_arg_ex_parcel_counts = New Dictionary
		  p_flags = New Dictionary
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Parse(args As CLIArgsKFS.Parser.ArgParser) As CLIArgsKFS.Interpreter.LinearlyInterpretedResults
		  // Created 8/2/2012 by Andrew Keller
		  
		  // Parses the given arguments, and returns a
		  // CLIArgsKFS.Interpreter.LinearlyInterpretedResults object.
		  
		  Dim result As New CLIArgsKFS.Interpreter.LinearlyInterpretedResults
		  Dim expected_arg_queue(-1) As String
		  
		  While args.HasNextArgument
		    
		    Dim nextarg As CLIArgsKFS.Parser.Argument = args.GetNextArgument
		    
		    Select Case nextarg.Type
		    Case nextarg.kTypeAppInvocationString
		      
		      result = result.SetAppInvocationString( nextarg.Text )
		      
		    Case nextarg.kTypeFlag
		      
		      If p_flags.HasKey( nextarg.Text ) Then
		        
		        Dim arg_id As String = p_flags.Value( nextarg.Text )
		        
		        result = result.AddEncounteredFlag( arg_id, nextarg.Text )
		        
		        For i As Integer = p_arg_ex_parcel_counts.Lookup( arg_id, 0 ) DownTo 1
		          expected_arg_queue.Append arg_id
		        Next
		        
		      Else
		        Dim err As New CLIArgsKFS.Interpreter.Err.UnknownFlagException
		        err.Message = "An unknown flag ('" + nextarg.Text + "') was encountered.  Cannot associate an unknown flag with an argument."
		        err.OffendingFlag = nextarg.Text
		        Raise err
		      End If
		      
		    Case nextarg.kTypeParcel
		      
		      If UBound( expected_arg_queue ) > -1 Then
		        
		        result = result.AddEncounteredParcel( expected_arg_queue(0), nextarg.Text )
		        expected_arg_queue.Remove 0
		        
		      Else
		        Dim err As New CLIArgsKFS.Interpreter.Err.UnexpectedParcelException
		        err.Message = "An unexpected parcel ('" + nextarg.Text + "') was encountered.  Cannot associate an unexpected parcel with an argument."
		        err.OffendingParcel = nextarg.Text
		        Raise err
		      End If
		      
		    Else
		      
		      Dim err As New CLIArgsKFS.Interpreter.Err.InterpretingException
		      err.Message = "An argument with an unsupported type code (" + Str( nextarg.Type ) + ") was encountered.  Don't know how to proceed."
		      Raise err
		      
		    End Select
		    
		  Wend
		  
		  Return result
		  
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
		Protected p_arg_ex_parcel_counts As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_flags As Dictionary
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
