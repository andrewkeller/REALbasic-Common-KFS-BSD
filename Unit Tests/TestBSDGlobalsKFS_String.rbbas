#tag Class
Protected Class TestBSDGlobalsKFS_String
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub OverlapTestRouter(srcString As String, leftNonMatchingPadding() As Integer, leftAnchors() As Integer, rightAnchors() As Integer, rightNonMatchingPadding() As Integer, startPos As Integer, correctMatchIndex As Integer)
		  // Created 9/10/2010 by Andrew Keller
		  
		  // Splits the given test into a left, center, right, and more right versions.
		  
		  // First, make sure all of the given arrays are valid sizes:
		  
		  AssertEquals leftAnchors.Ubound, rightAnchors.Ubound, "The leftAnchors and rightAnchors arrays must be the same size."
		  AssertEquals leftAnchors.Ubound, leftNonMatchingPadding.Ubound, "The leftNonMatchingPadding array must be the same size as the other arrays."
		  AssertEquals leftAnchors.Ubound, rightNonMatchingPadding.Ubound, "The rightNonMatchingPadding array must be the same size as the other arrays."
		  AssertTrue correctMatchIndex <= leftAnchors.Ubound, "The supposedly correct substring index doesn't actually exist in the arrays that were provided."
		  ' Note: the arrays are allowed to be empty, because InStrB_BSa_KFS is supposed to be able to handle an empty array of substrings.
		  
		  // Okay, good.  Now, let's generate the shifted test cases:
		  
		  Dim strLen As Integer = srcString.LenB
		  
		  Dim l_shift As Integer = strLen * -1000
		  Dim l_leftAnchors() As Integer
		  Dim l_rightAnchors() As Integer
		  
		  Dim r_shift As Integer = strLen * 1000
		  Dim r_leftAnchors() As Integer
		  Dim r_rightAnchors() As Integer
		  
		  Dim o_shift As Integer = strLen * 1000
		  Dim o_leftAnchors() As Integer
		  Dim o_rightAnchors() As Integer
		  
		  For row As Integer = 0 To leftAnchors.Ubound
		    
		    If leftAnchors(row) > 0 Then
		      l_shift = Max( l_shift, 1 - leftAnchors(row) )
		      
		    ElseIf leftAnchors(row) < 0 Then
		      l_shift = Max( l_shift, -strLen - leftAnchors(row) )
		      
		    End If
		    
		    If rightAnchors(row) > 0 Then
		      r_shift = Min( r_shift, strLen - rightAnchors(row) )
		      
		    ElseIf rightAnchors(row) < 0 Then
		      r_shift = Min( r_shift, -1 - rightAnchors(row) )
		      
		    End If
		    
		    o_shift = Min( o_shift, -rightNonMatchingPadding(row) )
		    
		  Next
		  
		  For row As Integer = 0 To leftAnchors.Ubound
		    
		    l_leftAnchors.Append leftAnchors(row) + l_shift
		    l_rightAnchors.Append rightAnchors(row) + l_shift
		    
		    r_leftAnchors.Append leftAnchors(row) + r_shift
		    r_rightAnchors.Append rightAnchors(row) + r_shift
		    
		    o_leftAnchors.Append leftAnchors(row) + r_shift + o_shift
		    o_rightAnchors.Append rightAnchors(row) + r_shift + o_shift
		    
		  Next
		  
		  OverlapTestWorker srcString, leftNonMatchingPadding, leftAnchors, rightAnchors, rightNonMatchingPadding, startPos, correctMatchIndex
		  
		  PushMessageStack "While running the flush-left test:"
		  OverlapTestWorker srcString, leftNonMatchingPadding, l_leftAnchors, l_rightAnchors, rightNonMatchingPadding, startPos, correctMatchIndex
		  PopMessageStack
		  
		  PushMessageStack "While running the flush-right test:"
		  OverlapTestWorker srcString, leftNonMatchingPadding, o_leftAnchors, o_rightAnchors, rightNonMatchingPadding, startPos, correctMatchIndex
		  PopMessageStack
		  
		  PushMessageStack "While running the flush-right test with the non-matching text off the end of the search string:"
		  OverlapTestWorker srcString, leftNonMatchingPadding, r_leftAnchors, r_rightAnchors, rightNonMatchingPadding, startPos, correctMatchIndex
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub OverlapTestWorker(srcString As String, leftNonMatchingPadding() As Integer, leftAnchors() As Integer, rightAnchors() As Integer, rightNonMatchingPadding() As Integer, startPos As Integer, correctMatchIndex As Integer)
		  // Created 9/10/2010 by Andrew Keller
		  
		  // Common code for testing the InStrB_BSa_KFS function.
		  
		  // First, make sure all of the given arrays are valid sizes:
		  
		  AssertEquals leftAnchors.Ubound, rightAnchors.Ubound, "The leftAnchors and rightAnchors arrays must be the same size."
		  AssertEquals leftAnchors.Ubound, leftNonMatchingPadding.Ubound, "The leftNonMatchingPadding array must be the same size as the other arrays."
		  AssertEquals leftAnchors.Ubound, rightNonMatchingPadding.Ubound, "The rightNonMatchingPadding array must be the same size as the other arrays."
		  AssertTrue correctMatchIndex <= leftAnchors.Ubound, "The supposedly correct substring index doesn't actually exist in the arrays that were provided."
		  ' Note: the arrays are allowed to be empty, because InStrB_BSa_KFS is supposed to be able to handle an empty array of substrings.
		  
		  ' Note: the start position is not checked, because InStrB_BSa_KFS is supposed to be able to handle out-of-bounds values for it.
		  
		  // Generate the substrings:
		  
		  Dim subStrings() As String
		  For row As Integer = 0 To leftAnchors.Ubound
		    
		    // Make sure the given bounds are correct:
		    
		    AssertNonZero leftAnchors(row), "Left anchor(" + str(row) + ") is zero.  Text positions are one-based.  Zero is not valid here."
		    AssertNonZero rightAnchors(row), "Right anchor(" + str(row) + ") is zero.  Text positions are one-based.  Zero is not valid here."
		    AssertNonNegative leftNonMatchingPadding(row), "Left non-matchign padding value for substring(" + str(row) + ") is negative."
		    AssertNonNegative rightNonMatchingPadding(row), "Right non-matchign padding value for substring(" + str(row) + ") is negative."
		    
		    AssertTrue Abs( leftAnchors(row) ) <= srcString.LenB, "Left anchor(" + str(row) + ") is outside the bounds of the test string."
		    AssertTrue Abs( rightAnchors(row) ) <= srcString.LenB, "Right anchor(" + str(row) + ") is outside the bounds of the test string."
		    
		    // Interpret negative anchors:
		    
		    If leftAnchors(row) < 0 Then leftAnchors(row) = leftAnchors(row) + srcString.LenB + 1
		    If rightAnchors(row) < 0 Then rightAnchors(row) = rightAnchors(row) + srcString.LenB + 1
		    
		    // Continue bounds checking:
		    
		    AssertNonNegative rightAnchors(row) - leftAnchors(row), "The left anchor of substring(" + str(row) + ") is after the right anchor."
		    AssertPositive leftAnchors(row) - leftNonMatchingPadding(row), "Applying left non-matching length for substring(" + str(row) + ") puts the start position at " + ObjectDescriptionKFS( leftAnchors(row) - leftNonMatchingPadding(row) ) + ", which is out-of-bounds."
		    ' Note: right non-matching padding is not invalid if it goes off the end of the search string, because we want to be able to test strings that go off the end of the search string.
		    
		    // Looks like everything checks out.  Build the substring.
		    
		    Dim s As String = srcString.MidB( leftAnchors(row), rightAnchors(row) - leftAnchors(row) )
		    
		    While s.LenB < rightAnchors(row) - leftAnchors(row) + leftNonMatchingPadding(row)
		      s = kUnusedCharacter + s
		    Wend
		    
		    While s.LenB < rightAnchors(row) - leftAnchors(row) + leftNonMatchingPadding(row) + rightNonMatchingPadding(row)
		      s = s + kUnusedCharacter
		    Wend
		    
		    // The substring has been created.  Add it to the list.
		    
		    subStrings.Append s
		    
		  Next
		  
		  // Convert the strings to streams:
		  
		  Dim srcStream As BinaryStream = New BinaryStream( srcString )
		  Dim subStreams() As BinaryStream
		  For row As Integer = 0 To subStrings.Ubound
		    subStreams.Append New BinaryStream( subStrings(row) )
		  Next
		  
		  // Invoke the target:
		  
		  Dim iMch As Integer = -2
		  Dim iPos As UInt64 = srcStream.InStrB_BSa_KFS( startPos, iMch, subStreams )
		  
		  // Check the results:
		  
		  AssertNotEqual -2, iMch, "InStrB_BSa_KFS did not change the substring match index parameter."
		  
		  If correctMatchIndex < 0 Then
		    
		    // No substring was supposed to match.
		    
		    If iPos <> 0 Or iMch > -1 Then
		      For row As Integer = 0 To leftAnchors.Ubound
		        AssertFalse iPos = leftAnchors(row), "InStrB_BSa_KFS may or may not have identified " + ObjectDescriptionKFS( subStrings(row) ) + " as a match instead of reporting no match found.", False
		      Next
		    End If
		    
		    AssertZero iPos, "InStrB_BSa_KFS did not return a zero position for no match."
		    AssertEquals -1, iMch, "InStrB_BSa_KFS did not return -1 for the match index."
		    
		  Else
		    
		    // One of the substrings was supposed to match.
		    
		    If iPos <> leftAnchors(correctMatchIndex) Or iMch <> correctMatchIndex Then
		      For row As Integer = 0 To leftAnchors.Ubound
		        AssertFalse iPos = leftAnchors(row), "InStrB_BSa_KFS may or may not have identified " + ObjectDescriptionKFS( subStrings(row) ) + " as a substring match instead of " + ObjectDescriptionKFS( subStrings(correctMatchIndex) ) + ".", False
		      Next
		    End If
		    
		    AssertEquals leftAnchors(correctMatchIndex), iPos, "InStrB_BSa_KFS did not return the correct match position."
		    AssertEquals correctMatchIndex, iMch, "InStrB_BSa_KFS did not return the correct match index."
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndMethod

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
		Sub TestInStrB_BSa_KFS_Basic()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is" )
		  
		  Dim iMch As Integer = 25
		  AssertEquals 6, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return the correct offset of the substring."
		  AssertEquals 0, iMch, "Did not return the correct index of the substring."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_EmptyStr()
		  // Created 9/8/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iMch As Integer
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "" )
		  
		  Try
		    iMch = 25
		    AssertEquals 0, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return a zero position after searching for an empty string."
		    AssertEquals -1, iMch, "Did not return -1 for the substring index."
		  Catch e As RuntimeException
		    If Not e IsA UnitTestExceptionKFS Then AssertFailure e, "Getting the position of an empty string should not cause an error to be raised."
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_InvalidStart()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is" )
		  
		  Dim iMch As Integer = 25
		  AssertEquals 0, src.InStrB_BSa_KFS( 100, iMch, search ), "Did not return a zero offset when starting the search off the end of the source string."
		  AssertEquals -1, iMch, "Did not return -1 for the substring index."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_LongSubStr()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "is some text.  ha ha now this is longer!" )
		  
		  Dim iMch As Integer = 25
		  AssertEquals 0, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return a zero offset when given a substring longer than the source string."
		  AssertEquals -1, iMch, "Did not return -1 for the substring index."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_MultipleClumps()
		  // Created 9/13/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iMch As Integer
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "e i" )
		  search.Append New BinaryStream( " is " )
		  search.Append New BinaryStream( "e text" )
		  search.Append New BinaryStream( "e t" )
		  search.Append New BinaryStream( " " )
		  
		  iMch = 25
		  AssertEquals 4, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return the correct offset of the first substring clump."
		  AssertEquals 0, iMch, "Did not return the correct index of the first substring clump."
		  
		  iMch = 25
		  AssertEquals 5, src.InStrB_BSa_KFS( 5, iMch, search ), "Did not return the correct offset of the latter part of the first substring clump."
		  AssertEquals 1, iMch, "Did not return the correct index of the latter part of the first substring clump."
		  
		  iMch = 25
		  AssertEquals 12, src.InStrB_BSa_KFS( 11, iMch, search ), "Did not return the correct offset of the second substring clump."
		  AssertEquals 2, iMch, "Did not return the correct index of the second substring clump."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Multiples()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iMch As Integer
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "Here" )
		  search.Append New BinaryStream( "is" )
		  search.Append New BinaryStream( "some" )
		  search.Append New BinaryStream( "text" )
		  
		  iMch = 25
		  AssertEquals 1, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return the correct offset of the first substring."
		  AssertEquals 0, iMch, "Did not return the correct substring index."
		  
		  iMch = 25
		  search.Remove 0
		  AssertEquals 6, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return the correct offset of the second substring."
		  AssertEquals 0, iMch, "Did not return the correct substring index."
		  
		  iMch = 25
		  search.Remove 0
		  AssertEquals 9, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return the correct offset of the thrid substring."
		  AssertEquals 0, iMch, "Did not return the correct substring index."
		  
		  iMch = 25
		  search.Remove 0
		  AssertEquals 14, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return the correct offset of the fourth substring."
		  AssertEquals 0, iMch, "Did not return the correct substring index."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_NoSrcStr()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "" )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "foo" )
		  
		  Dim iMch As Integer = 25
		  AssertEquals 0, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return a zero offset when given a zero source string."
		  AssertEquals -1, iMch, "Did not return -1 for the substring index."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_NoSubStr()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  
		  Dim iMch As Integer = 25
		  AssertEquals 0, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return a zero offset when given no substrings to search for."
		  AssertEquals -1, iMch, "Did not return -1 for the substring index."
		  
		  iMch = 25
		  search.Append Nil
		  AssertEquals 0, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return a zero offset when given no valid substrings to search for."
		  AssertEquals -1, iMch, "Did not return -1 for the substring index."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2s_C_L()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 4, 4 ), _
		  Array( 5, 6 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2s_C_Le()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 4, 4 ), _
		  Array( 5, 5 ), _
		  Array( 0, 1 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2s_C_R()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 4, 4 ), _
		  Array( 6, 5 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2s_C_Re()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 4, 4 ), _
		  Array( 6, 4 ), _
		  Array( 0, 1 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2s_Le_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 4, 5 ), _
		  Array( 5, 6 ), _
		  Array( 1, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2s_L_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 4, 5 ), _
		  Array( 6, 6 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2s_Re_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 5, 4 ), _
		  Array( 5, 6 ), _
		  Array( 1, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2s_R_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 5, 4 ), _
		  Array( 6, 6 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Ce_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 15, 20 ), _
		  Array( 5, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Ce_L()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 15, 20 ), _
		  Array( 2, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Ce_R()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 15, 18 ), _
		  Array( 5, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_C_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 20, 20 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_C_Ce()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 20, 15 ), _
		  Array( 0, 5 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_C_L()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 15, 20 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_C_Le()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 15, 18 ), _
		  Array( 0, 2 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_C_R()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 20, 15 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_C_Re()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 10 ), _
		  Array( 18, 15 ), _
		  Array( 2, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Le_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 14 ), _
		  Array( 16, 20 ), _
		  Array( 4, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Le_L()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 12 ), _
		  Array( 14, 20 ), _
		  Array( 2, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Le_R()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 12 ), _
		  Array( 20, 18 ), _
		  Array( 2, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_L_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 15 ), _
		  Array( 20, 20 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_L_Ce()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 15 ), _
		  Array( 20, 18 ), _
		  Array( 0, 2 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_L_L()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 15 ), _
		  Array( 18, 23 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_L_Le()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 15 ), _
		  Array( 18, 20 ), _
		  Array( 0, 3 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_L_R()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 15 ), _
		  Array( 25, 20 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_L_Re()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 10, 15 ), _
		  Array( 25, 18 ), _
		  Array( 0, 2 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Re_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 18, 20 ), _
		  Array( 2, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Re_L()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 18, 25 ), _
		  Array( 2, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_Re_R()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 22, 20 ), _
		  Array( 3, 0 ), _
		  0, _
		  1
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_R_C()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 20, 20 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_R_Ce()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 20, 18 ), _
		  Array( 0, 2 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_R_L()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 20, 25 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_R_Le()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 20, 22 ), _
		  Array( 0, 3 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_R_R()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 25, 20 ), _
		  Array( 0, 0 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_Overlap2_R_Re()
		  // Created 9/12/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  OverlapTestRouter kTestString, _
		  Array( 0, 0 ), _
		  Array( 15, 10 ), _
		  Array( 25, 18 ), _
		  Array( 0, 2 ), _
		  0, _
		  0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_SingleCharStr()
		  // Created 9/8/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  Dim iMch As Integer
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( " " )
		  
		  Try
		    iMch = 25
		    AssertEquals 5, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return the correct position."
		    AssertEquals 0, iMch, "Did not return the correct substring index."
		  Catch e As RuntimeException
		    If Not e IsA UnitTestExceptionKFS Then AssertFailure e, "Getting the position of a single character substring should not cause an error to be raised."
		  End Try
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestInStrB_BSa_KFS_StartMultiples()
		  // Created 9/6/2010 by Andrew Keller
		  
		  // Makes sure the InStrB_BSa_KFS works correctly.
		  
		  Dim src As New BinaryStream( "Here is some text." )
		  
		  Dim search() As BinaryStream
		  search.Append New BinaryStream( "Here" )
		  search.Append New BinaryStream( "is" )
		  search.Append New BinaryStream( "some" )
		  search.Append New BinaryStream( "text" )
		  
		  Dim iMch As Integer = 25
		  AssertEquals 1, src.InStrB_BSa_KFS( 0, iMch, search ), "Did not return the correct offset of the first substring."
		  AssertEquals 0, iMch, "Did not return the correct substring index."
		  
		  iMch = 25
		  AssertEquals 6, src.InStrB_BSa_KFS( 2, iMch, search ), "Did not return the correct offset of the second substring."
		  AssertEquals 1, iMch, "Did not return the correct substring index."
		  
		  iMch = 25
		  AssertEquals 9, src.InStrB_BSa_KFS( 7, iMch, search ), "Did not return the correct offset of the thrid substring."
		  AssertEquals 2, iMch, "Did not return the correct substring index."
		  
		  iMch =25
		  AssertEquals 14, src.InStrB_BSa_KFS( 10, iMch, search ), "Did not return the correct offset of the fourth substring."
		  AssertEquals 3, iMch, "Did not return the correct substring index."
		  
		  iMch =25
		  AssertEquals 0, src.InStrB_BSa_KFS( 16, iMch, search ), "Did not return 0 for no match."
		  AssertEquals -1, iMch, "Did not return -1 for the substring index."
		  
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


	#tag Constant, Name = kTestString, Type = String, Dynamic = False, Default = \"abcdefghijklmnopqrstuvwxyz", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kUnusedCharacter, Type = String, Dynamic = False, Default = \"%", Scope = Public
	#tag EndConstant


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
