#tag Class
Protected Class BaseTestBSDGlobalsKFS_DurationKFS_Constructors
Inherits UnitTests_RBCKB.BaseTestBSDGlobalsKFS_DurationKFS_Math
	#tag Method, Flags = &h0
		Sub TestConstructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Date_Date()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Double_Double()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_DurationKFS()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the clone constructor works.
		  
		  Dim orig, clone As DurationKFS
		  
		  // Make sure we can clone Nil:
		  
		  clone = Factory_ConstructFromDurationKFS( orig )
		  
		  AssertNotIsNil clone, "The clone constructor is never supposed to return Nil."
		  AssertZero clone.MicrosecondsValue, "When cloning Nil, the value should be zero."
		  
		  // Make sure we can clone a DurationKFS object:
		  
		  orig = Factory_NewWithMicroseconds(13)
		  clone = Factory_ConstructFromDurationKFS( orig )
		  
		  AssertNotIsNil clone, "The clone constructor is never supposed to return Nil."
		  AssertEquals 13, clone.MicrosecondsValue, "When cloning a real DurationKFS object, the value should be inherited."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestConstructor_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestConstructor_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromClone_DurationKFS()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromClone_Timer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestNewFromClone_WebTimer()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromDateDifference()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure the date difference constructor works.
		  
		  Worker_TestNewOrConstructFromDateDifference AddressOf Factory_NewFromDateDifference
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewFromSystemUptime()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithMaximum()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewWithMaximum constructor works.
		  
		  Dim d As DurationKFS = Factory_NewWithMaximum
		  
		  // The maximum value should be 9,223,372,036,854,775,805
		  
		  Dim m As Int64 = 9223372036854775805
		  AssertEquals m, d.MicrosecondsValue, "NewWithMaximum did not return a DurationKFS with the expected maximum value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithMicroseconds()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewWithMicroseconds constructor works.
		  
		  Dim d As DurationKFS = Factory_NewWithMicroseconds( 1194832 )
		  
		  // The MicrosecondsValue of the object should be 1194832.
		  
		  AssertEquals 1194832, d.MicrosecondsValue, "NewWithMicroseconds did not return a DurationKFS object with the expected value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithMinimum()
		  // Created 8/18/2010 by Andrew Keller
		  
		  // Make sure the NewWithMinimum constructor works.
		  
		  Dim d As DurationKFS = Factory_NewWithMinimum
		  
		  // The minimum value should be -9,223,372,036,854,775,805
		  
		  Dim m As Int64 = -9223372036854775805
		  AssertEquals m, d.MicrosecondsValue, "NewWithMinimum did not return a DurationKFS with the expected minimum value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithNegativeInfinity()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithPositiveInfinity()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithUndefined()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithValue()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestNewWithZero()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstruct(factory_method As ConstructorFactoryMethod_void)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstructFromClone_DurationKFS(factory_method As ConstructorFactoryMethod_DurationKFS)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstructFromClone_Timer(factory_method As ConstructorFactoryMethod_Timer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub Worker_TestNewOrConstructFromClone_WebTimer(factory_method As ConstructorFactoryMethod_WebTimer)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstructFromDateDifference(factory_method As ConstructorFactoryMethod_Date_Date)
		  // Created 1/22/2012 by Andrew Keller
		  
		  // Make sure the given date difference constructor works properly.
		  
		  Dim r As New Random
		  Dim dEarlier As New Date
		  Dim dLater As New Date
		  Dim result As DurationKFS
		  
		  // Generate the dates:
		  
		  Do
		    dEarlier.TotalSeconds = r.InRange( dEarlier.TotalSeconds - 1000, dEarlier.TotalSeconds + 1000 )
		    dLater.TotalSeconds = r.InRange( dLater.TotalSeconds - 1000, dLater.TotalSeconds + 1000 )
		  Loop Until dEarlier.TotalSeconds < dLater.TotalSeconds
		  
		  // Test the 'positive' scenerio:
		  
		  result = factory_method.Invoke( dLater, dEarlier )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals dLater.TotalSeconds - dEarlier.TotalSeconds, result.Value, "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // Test the 'zero' scenerio:
		  
		  result = factory_method.Invoke( dLater, New Date( dLater ) )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertZero result.MicrosecondsValue, "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // Test the 'negative' scenerio:
		  
		  result = factory_method.Invoke( dEarlier, dLater )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals dEarlier.TotalSeconds - dLater.TotalSeconds, result.Value, "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // Test the 'positive infinity' scenerios:
		  
		  result = factory_method.Invoke( Nil, dLater )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals DurationKFS.NewWithPositiveInfinity.MicrosecondsValue, result.MicrosecondsValue, _
		  "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  result = factory_method.Invoke( dEarlier, Nil )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals DurationKFS.NewWithPositiveInfinity.MicrosecondsValue, result.MicrosecondsValue, _
		  "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // (there is no 'negative infinity' scenerio)
		  
		  // Test the 'undefined' scenerio:
		  
		  result = factory_method.Invoke( Nil, Nil )
		  AssertNotIsNil result, "The NewFromDateDifference constructor should never return Nil."
		  AssertEquals DurationKFS.NewWithUndefined.MicrosecondsValue, result.MicrosecondsValue, _
		  "The shared date difference constructor did not correctly calculate the difference.", False
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestNewOrConstructWithValue(factory_method As ConstructorFactoryMethod_Double_Double)
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2012 Andrew Keller.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a list of all contributors for this library.
		
		Redistribution and use in source and binary forms, with or
		without modification, are permitted provided that the following
		conditions are met:
		
		  Redistributions of source code must retain the above copyright
		  notice, this list of conditions and the following disclaimer.
		
		  Redistributions in binary form must reproduce the above
		  copyright notice, this list of conditions and the following
		  disclaimer in the documentation and/or other materials provided
		  with the distribution.
		
		  Neither the name of Andrew Keller nor the names of other
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
