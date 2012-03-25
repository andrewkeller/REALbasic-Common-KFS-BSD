#tag Class
Protected Class BaseTestBSDGlobalsKFS_DurationKFS_Math
Inherits UnitTests_RBCKB.BaseTestBSDGlobalsKFS_DurationKFS
	#tag Method, Flags = &h0
		Function GetMethodInfoForMethodByName(targetClass As Object, targetMethodName As String) As Introspection.MethodInfo
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Returns the MethodInfo object for the method with the given name in the given class.
		  
		  Dim results(-1) As Introspection.MethodInfo
		  
		  For Each mi As Introspection.MethodInfo In Introspection.GetType( targetClass ).GetMethods
		    
		    If mi.Name = targetMethodName Then results.Append mi
		    
		  Next
		  
		  If UBound( results ) = 0 Then
		    
		    Return results(0)
		    
		  Else
		    
		    // Uh oh, if you get here that means that the target method name exists
		    // either zero or more than one times.  See the results() variable in this method.
		    
		    Raise New RuntimeException
		    
		  End If
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_DoubleToMicroseconds()
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Makes sure the DoubleToMicroseconds converter works.
		  
		  For Each u As Double In ListUnits( True )
		    TestMath_DoubleToMicroseconds IsUnitValid(u), 0, u, 0
		  Next
		  
		  TestMath_DoubleToMicroseconds False, 1, -6.25, 0
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kMicroseconds, 1
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kMilliseconds, 1 * 1000
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kSeconds, 1 * 1000 * 1000
		  TestMath_DoubleToMicroseconds False, 1, 1, 0
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kMinutes, 1 * 1000 * 1000 * 60
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kHours, 1 * 1000 * 1000 * 60 * 60
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kDays, 1 * 1000 * 1000 * 60 * 60 * 24
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kWeeks, 1 * 1000 * 1000 * 60 * 60 * 24 * 7
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kMonths, 1 * 1000 * 1000 * 60 * 60 * 24 * 365.75 / 12
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kYears, 1 * 1000 * 1000 * 60 * 60 * 24 * 365.75
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kDecades, 1 * 1000 * 1000 * 60 * 60 * 24 * 365.75 * 10
		  TestMath_DoubleToMicroseconds True, 1, DurationKFS.kCenturies, 1 * 1000 * 1000 * 60 * 60 * 24 * 365.75 * 10 * 10
		  TestMath_DoubleToMicroseconds False, 1, 10, 0
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_DoubleToMicroseconds(shouldWork As Boolean, inputValue As Double, unit As Double, expectedOutput As Int64)
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Makes sure the DoubleToMicroseconds converter works.
		  
		  // This method is protected - we need to dig for it.
		  
		  Dim d As DurationKFS = Factory_NewWithZero
		  Dim m As Introspection.MethodInfo = GetMethodInfoForMethodByName( d, "Math_DoubleToMicroseconds" )
		  
		  PushMessageStack "Testing Math_DoubleToMicroseconds( " + Str(inputValue) + ", " + Str(unit) + " ): "
		  
		  Dim args(1) As Variant
		  args(0) = 0
		  args(1) = unit
		  
		  Dim caughtException As RuntimeException = Nil
		  Dim result As Int64 = 0
		  
		  Try
		    #pragma BreakOnExceptions Off
		    result = m.Invoke( d, args )
		  Catch err As RuntimeException
		    ReRaiseRBFrameworkExceptionsKFS err
		    caughtException = err
		  End Try
		  
		  If shouldWork Then
		    
		    If PresumeIsNil( caughtException, "Passing zero in any valid unit should not raise an exception." ) Then
		      AssertEquals expectedOutput, result, "Passing zero in any valid unit should result in zero.", False
		    End If
		    
		  Else
		    
		    AssertNotIsNil caughtException, "Passing zero in an invalid unit should raise an exception.", False
		    
		  End If
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_Int64ToMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsDividedByMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsDividedByScalar()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsMinusMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsModMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsPlusMicroseconds()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsTimesScalar()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsToDouble()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestMath_MicrosecondsToInt64()
		  
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
