#tag Class
Protected Class TestDurationKFS
Inherits UnitTests_RBCKB.BaseTestBSDGlobalsKFS_DurationKFS_TheRest
	#tag Method, Flags = &h0
		Function Factory_Construct() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( dLater, dEarlier )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDurationKFS(other As DurationKFS) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromTimer(other As Timer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( newValue, powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_ConstructFromWebTimer(other As WebTimer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return New DurationKFS( other )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_DurationKFS(d As DurationKFS) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromClone( d )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_Timer(t As Timer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromClone( t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_NewFromClone_WebTimer(t As WebTimer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromClone( t )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromDateDifference( dLater, dEarlier )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromSystemUptime() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewFromSystemUptime
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMaximum() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithMaximum
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMicroseconds(newValue As Int64) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithMicroseconds( newValue )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMinimum() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithMinimum
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithNegativeInfinity() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithNegativeInfinity
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithNegativeOverflow() As DurationKFS
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithNegativeOverflow
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithPositiveInfinity() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithPositiveInfinity
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithPositiveOverflow() As DurationKFS
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithPositiveOverflow
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithUndefined() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithUndefined
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithValue( newValue, powerOfTen )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithZero() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  Return DurationKFS.NewWithZero
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListThisDurationClass() As String()
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Returns a list of classes that... includes only this class.
		  
		  Return Array( "DurationKFS" )
		  
		  // done.
		  
		End Function
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010 - 2012 Andrew Keller.
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
