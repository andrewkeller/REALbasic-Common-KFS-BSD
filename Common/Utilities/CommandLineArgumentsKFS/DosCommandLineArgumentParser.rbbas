#tag Class
Protected Class DosCommandLineArgumentParser
Implements CommandLineArgumentParser
	#tag Method, Flags = &h0
		Sub Constructor(args() As String, app_resources As ResourceManagerKFS)
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Copies the given arguments into local storage.
		  
		  For Each arg As String in args
		    
		    p_args.Append arg
		    
		  Next
		  
		  p_rsrc = app_resources
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextFlag() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next flag in the arguments.  If the next item is not a flag, an exception is raised.
		  
		  If UBound( p_args ) > -1 Then
		    If p_args(0).Left( 1 ) = "/" Then
		      
		      Dim result As String = p_args(0).Mid( 2 )
		      p_args.Remove 0
		      Return result
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAFlag( p_rsrc, p_args(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetNextParcel() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next parcel in the arguments.  If the next item is not a parcel, an exception is raised.
		  
		  If UBound( p_args ) > -1 Then
		    If p_args(0).Left( 1 ) <> "/" Then
		      
		      Dim result As String = p_args(0).Mid( 2 )
		      p_args.Remove 0
		      Return result
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAParcel( p_rsrc, p_args(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextFlag() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is a flag next in the arguments.
		  
		  If UBound( p_args ) > -1 Then
		    If p_args(0).Left( 1 ) = "/" Then
		      
		      Return True
		      
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextParcel() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is a parcel next in the arguments.
		  
		  If UBound( p_args ) > -1 Then
		    If p_args(0).Left( 1 ) <> "/" Then
		      
		      Return True
		      
		    End If
		  End If
		  
		  Return False
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function HasNextSomething() As Boolean
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns whether or not there is anything left to return.
		  
		  Return HasNextFlag Or HasNextParcel
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextFlag() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next flag in the arguments.  If the next item is not a flag, an exception is raised.
		  
		  If UBound( p_args ) > -1 Then
		    If p_args(0).Left( 1 ) = "/" Then
		      
		      Return p_args(0).Mid( 2 )
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAFlag( p_rsrc, p_args(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PeekNextParcel() As String
		  // Created 6/17/2012 by Andrew Keller
		  
		  // Returns the next parcel in the arguments.  If the next item is not a parcel, an exception is raised.
		  
		  If UBound( p_args ) > -1 Then
		    If p_args(0).Left( 1 ) <> "/" Then
		      
		      Return p_args(0).Mid( 2 )
		      
		    End If
		    
		    Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_NextItemIsNotAParcel( p_rsrc, p_args(0) )
		    
		  End If
		  
		  Raise CommandLineArgumentsKFS.CommandLineArgumentParserException.New_ThereIsNoNextItem( p_rsrc )
		  
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
		Protected p_args(-1) As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected p_rsrc As ResourceManagerKFS
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
