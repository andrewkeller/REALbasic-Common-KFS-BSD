#tag Class
Protected Class TestBSDGlobalsKFS_String
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestEndOfLineKFS()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the EndOfLineKFS function works correctly.
		  
		  #if TargetWin32 then
		    
		    AssertEquals Chr(13)+Chr(10), EndOfLineKFS, "The EndOfLineKFS function is supposed to return Chr(13)+Chr(10) on Windows."
		    
		  #elseif TargetMacOSClassic then
		    
		    AssertEquals Chr(13), EndOfLineKFS, "The EndOfLineKFS function is supposed to return Chr(13) on Mac OS Classic."
		    
		  #else
		    
		    AssertEquals Chr(10), EndOfLineKFS, "The EndOfLineKFS function is supposed to return Chr(10) on all platforms except Windows and Mac OS Classic."
		    
		  #endif
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Basic()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is" )
		  
		  Dim iLen As UInt64 = 25
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct offset of the substring."
		  AssertEquals 2, iLen, "Did not return the correct length of the substring."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_EmptyStr()
		  // Created 9/8/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "" )
		  
		  Try
		    iLen = 25
		    AssertEquals 0, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return a zero position after searching for an empty string."
		    AssertEquals 0, iLen, "Did not return a zero length."
		  Catch e As RuntimeException
		    If Not e IsA UnitTestExceptionKFS Then AssertFailure e, "Getting the position of an empty string should not cause an error to be raised."
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_InvalidStart()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is" )
		  
		  Dim iLen As UInt64 = 25
		  AssertEquals 0, src.InStrB_BS_BSa_KFS( 100, iLen, search ), "Did not return a zero offset when starting the search off the end of the source string."
		  AssertEquals 0, iLen, "Did not return a zero length when starting the search off the end of the source string."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_LongSubStr()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is some text.  ha ha now this is longer!" )
		  
		  Dim iLen As UInt64 = 25
		  AssertEquals 0, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return a zero offset when given a substring longer than the source string."
		  AssertEquals 0, iLen, "Did not return a zero length when given a substring longer than the source string."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Multiples()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "Here" )
		  search.Append New BinaryStream( "is" )
		  search.Append New BinaryStream( "some" )
		  search.Append New BinaryStream( "text" )
		  
		  iLen = 25
		  AssertEquals 1, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct offset of the first substring."
		  AssertEquals 4, iLen, "Did not return the correct length of the first substring."
		  
		  iLen = 25
		  search.Remove 0
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct offset of the second substring."
		  AssertEquals 2, iLen, "Did not return the correct length of the second substring."
		  
		  iLen = 25
		  search.Remove 0
		  AssertEquals 9, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct offset of the thrid substring."
		  AssertEquals 4, iLen, "Did not return the correct length of the thrid substring."
		  
		  iLen = 25
		  search.Remove 0
		  AssertEquals 14, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct offset of the fourth substring."
		  AssertEquals 4, iLen, "Did not return the correct length of the fourth substring."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_NoSrcStr()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "" )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "foo" )
		  
		  Dim iLen As UInt64 = 25
		  AssertEquals 0, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return a zero offset when given a zero source string."
		  AssertEquals 0, iLen, "Did not return a zero length when given a zero source string."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_NoSubStr()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  
		  Dim iLen As UInt64 = 25
		  AssertEquals 0, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return a zero offset when given no substrings to search for."
		  AssertEquals 0, iLen, "Did not return a zero length when given no substrings to search for."
		  
		  iLen = 25
		  search.Append Nil
		  AssertEquals 0, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return a zero offset when given no valid substrings to search for."
		  AssertEquals 0, iLen, "Did not return a zero length when given no valid substrings to search for."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Overlap()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is some too" )
		  search.Append New BinaryStream( "some" )
		  
		  // The start of 'is some too' should be found first
		  // The start of 'some' should be found second
		  // The end of 'some' should be reached, but it's not the highest priority of the delimiters to search for.
		  // 'is some too' should fail the match AFTER the end of 'some' is reached.
		  // 'some' is now the delimiter with the highest priority and earliest start position, and it has already been confirmed to exist.
		  
		  // 'some' should be the delimiter described.
		  
		  iLen = 25
		  Dim p As UInt64 = src.InStrB_BS_BSa_KFS( 0, iLen, search )
		  AssertNotEqual 0, p, "Did not find the delimiter at all."
		  AssertNotEqual 6, p, "Returned the position of the delimiter that doesn't actually match anywhere."
		  AssertEquals 9, p, "Did not return the correct position."
		  AssertEquals 4, iLen, "Did not return the correct length of the delimiter."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Priorities_Center()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "some" )
		  search.Append New BinaryStream( "is some text" )
		  
		  // The 'some' should take priority.
		  
		  iLen = 25
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct location."
		  AssertNotEqual 12, iLen, "Was not able to prioritize a shorter string over a longer one (center justified overlap)."
		  AssertEquals 4, iLen, "Did not return the correct length of the delimiter."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Priorities_Center_R()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is some text" )
		  search.Append New BinaryStream( "some" )
		  
		  // The 'is some text' should take priority.
		  
		  iLen = 25
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct location."
		  AssertNotEqual 4, iLen, "Was not able to prioritize a longer string over a shorter one (center justified overlap)."
		  AssertEquals 12, iLen, "Did not return the correct length of the delimiter."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Priorities_Left()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is" )
		  search.Append New BinaryStream( "is some" )
		  
		  // The 'is' should take priority.
		  
		  iLen = 25
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct location."
		  AssertNotEqual 7, iLen, "Was not able to prioritize a shorter string over a longer one (left justified overlap)."
		  AssertEquals 2, iLen, "Did not return the correct length of the delimiter."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Priorities_Left_R()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is some" )
		  search.Append New BinaryStream( "is" )
		  
		  // The 'is some' should take priority.
		  
		  iLen = 25
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct location."
		  AssertNotEqual 2, iLen, "Was not able to prioritize a longer string over a shorter one (left justified overlap)."
		  AssertEquals 7, iLen, "Did not return the correct length of the delimiter."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Priorities_Right()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "some" )
		  search.Append New BinaryStream( "is some" )
		  
		  // The 'some' should take priority.
		  
		  iLen = 25
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct location."
		  AssertNotEqual 7, iLen, "Was not able to prioritize a shorter string over a longer one (right justified overlap)."
		  AssertEquals 4, iLen, "Did not return the correct length of the delimiter."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_Priorities_Right_R()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is some" )
		  search.Append New BinaryStream( "some" )
		  
		  // The 'is some' should take priority.
		  
		  iLen = 25
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct location."
		  AssertNotEqual 4, iLen, "Was not able to prioritize a longer string over a shorter one (right justified overlap)."
		  AssertEquals 7, iLen, "Did not return the correct length of the delimiter."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_SingleCharStr()
		  // Created 9/8/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iLen As UInt64
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( " " )
		  
		  Try
		    iLen = 25
		    AssertEquals 5, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct position."
		    AssertEquals 1, iLen, "Did not return the correct length."
		  Catch e As RuntimeException
		    If Not e IsA UnitTestExceptionKFS Then AssertFailure e, "Getting the position of a single character substring should not cause an error to be raised."
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BS_BSa_KFS_StartMultiples()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BS_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "Here" )
		  search.Append New BinaryStream( "is" )
		  search.Append New BinaryStream( "some" )
		  search.Append New BinaryStream( "text" )
		  
		  Dim iLen As UInt64 = 25
		  AssertEquals 1, src.InStrB_BS_BSa_KFS( 0, iLen, search ), "Did not return the correct offset of the first substring."
		  AssertEquals 4, iLen, "Did not return the correct length of the first substring."
		  
		  iLen = 25
		  AssertEquals 6, src.InStrB_BS_BSa_KFS( 2, iLen, search ), "Did not return the correct offset of the second substring."
		  AssertEquals 2, iLen, "Did not return the correct length of the second substring."
		  
		  iLen = 25
		  AssertEquals 9, src.InStrB_BS_BSa_KFS( 7, iLen, search ), "Did not return the correct offset of the thrid substring."
		  AssertEquals 4, iLen, "Did not return the correct length of the thrid substring."
		  
		  iLen =25
		  AssertEquals 14, src.InStrB_BS_BSa_KFS( 10, iLen, search ), "Did not return the correct offset of the fourth substring."
		  AssertEquals 4, iLen, "Did not return the correct length of the fourth substring."
		  
		  // done.
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller
		All rights reserved.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of its
		  contributors may be used to endorse or promote products derived
		  from this software without specific prior written permission.
		
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


	#tag ViewBehavior
		#tag ViewProperty
			Name="AssertionCount"
			Group="Behavior"
			Type="Integer"
			InheritedFrom="UnitTestBaseClassKFS"
		#tag EndViewProperty
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
