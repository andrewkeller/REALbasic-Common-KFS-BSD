#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  // Created 3/26/2011 by Andrew Keller
		  
		  // Run the test cases, and report the result.
		  
		  stderr.WriteLine "Processing test cases..."
		  
		  // Create a new UnitTestArbiterKFS class:
		  
		  Dim arbiter As New UnitTestArbiterKFS
		  
		  arbiter.EnableAutomaticProcessing = False
		  
		  // Load up our test cases:
		  
		  arbiter.CreateJobsForTestClasses UnitTests_RBCKB.ListTestClasses
		  
		  // Process each test case:
		  
		  Dim t As Int64 = Microseconds
		  
		  While arbiter.ProcessNextTestCase
		    
		    If Microseconds - t >= kRefreshSpeed Then
		      
		      stderr.Write OverPrint( arbiter.q_GetStatusBlurb ) + chr(13)
		      t = Microseconds
		      
		    End If
		    
		  Wend
		  
		  stderr.WriteLine OverPrint( arbiter.q_GetStatusBlurb )
		  
		  // done.
		  
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function OverPrint(str As String) As String
		  // Created 3/26/2011 by Andrew Keller
		  
		  // Pads the given string with spaces so that
		  // it will completely overwrite the previous
		  // string to pass through this function.
		  
		  Static previous_length As Integer = 0
		  
		  Dim current_length As Integer = Len( str )
		  
		  While Len( str ) < previous_length
		    
		    str = str + " "
		    
		  Wend
		  
		  previous_length = current_length
		  
		  Return str
		  
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
		
		Copyright (c) 2011 Andrew Keller.
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


	#tag Constant, Name = kRefreshSpeed, Type = Double, Dynamic = False, Default = \"200000", Scope = Public
	#tag EndConstant


End Class
#tag EndClass
