#tag Class
Protected Class BaseTestBSDGlobalsKFS_DurationKFS
Inherits UnitTestBaseClassKFS
	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_Date_Date(dLater As Date, dEarlier As Date) As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_Double_Double(newValue As Double, powerOfTen As Double = DurationKFS . kSeconds) As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_DurationKFS(other As DurationKFS) As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_Timer(other As Timer) As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0
		Delegate Function ConstructorFactoryMethod_void() As DurationKFS
	#tag EndDelegateDeclaration

	#tag DelegateDeclaration, Flags = &h0, CompatibilityFlags = TargetWeb
		Delegate Function ConstructorFactoryMethod_WebTimer(other As WebTimer) As DurationKFS
	#tag EndDelegateDeclaration

	#tag Method, Flags = &h0
		Function Factory_Construct() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromDurationKFS(other As DurationKFS) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromTimer(other As Timer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_ConstructFromValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_ConstructFromWebTimer(other As WebTimer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_DurationKFS(d As DurationKFS) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromClone_Timer(t As Timer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Function Factory_NewFromClone_WebTimer(t As WebTimer) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromDateDifference(dLater As Date, dEarlier As Date) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewFromSystemUptime() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMaximum() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMicroseconds(newValue As Int64) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithMinimum() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithNegativeInfinity() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithNegativeOverflow() As DurationKFS
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithPositiveInfinity() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithPositiveOverflow() As DurationKFS
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithUndefined() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithValue(newValue As Double, powerOfTen As Double = DurationKFS.kSeconds) As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Factory_NewWithZero() As DurationKFS
		  // Created 1/21/2012 by Andrew Keller
		  
		  // Wraps the Constructor equivalent to this signature for the
		  // DurationKFS class so that it can be overridden in a subclass.
		  
		  // This class is not allowed to acutally use this method - it
		  // exists only to allow access to it when a subclass overrides it.
		  
		  Raise New RuntimeException
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateObjectFromScenario(className As String, dataScenario As String, previousObject As Variant = Nil) As Variant
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Generates a DurationKFS object for the given scenario.
		  
		  If dataScenario = "Nil" Then Return Nil
		  
		  If className = "DurationKFS" Then
		    If dataScenario = "undefined" Then
		      Return DurationKFS.NewWithUndefined
		      
		    ElseIf dataScenario = "neginf" Then
		      Return DurationKFS.NewWithNegativeInfinity
		      
		    ElseIf dataScenario = "posinf" Then
		      Return DurationKFS.NewWithPositiveInfinity
		      
		    ElseIf dataScenario = "negovr" Then
		      Return DurationKFS.NewWithNegativeOverflow
		      
		    ElseIf dataScenario = "posovr" Then
		      Return DurationKFS.NewWithPositiveOverflow
		      
		    ElseIf dataScenario = "negreal" Then
		      Return DurationKFS.NewWithMicroseconds(-13)
		      
		    ElseIf dataScenario = "posreal" Then
		      Return DurationKFS.NewWithMicroseconds(42)
		      
		    ElseIf dataScenario = "zero" Then
		      Return DurationKFS.NewWithZero
		      
		    ElseIf dataScenario = "sameobject" Then
		      Return previousObject
		      
		    End If
		  ElseIf className = "Date" Then
		    If dataScenario = "negreal" Then
		      Dim d As New Date
		      d.TotalSeconds = -30
		      Return d
		      
		    ElseIf dataScenario = "posreal" Then
		      Dim d As New Date
		      d.TotalSeconds = 42
		      Return d
		      
		    ElseIf dataScenario = "zero" Then
		      Dim d As New Date
		      d.TotalSeconds = 0
		      Return d
		      
		    End If
		  ElseIf className = "Timer" Then
		    If dataScenario = "posreal" Then
		      Dim t As New Timer
		      t.Period = 42
		      Return t
		      
		    ElseIf dataScenario = "zero" Then
		      Dim t As New Timer
		      t.Period = 0
		      Return t
		      
		    End If
		  ElseIf className = "WebTimer" Then
		    #if TargetWeb Then
		      If dataScenario = "posreal" Then
		        Dim t As New WebTimer
		        t.Period = 42
		        Return t
		        
		      ElseIf dataScenario = "zero" Then
		        Dim t As New WebTimer
		        t.Period = 0
		        Return t
		        
		      End If
		    #endif
		  ElseIf className = "Double" Then
		    If dataScenario = "negreal" Then
		      Return -30
		      
		    ElseIf dataScenario = "posreal" Then
		      Return 42
		      
		    ElseIf dataScenario = "zero" Then
		      Return 0
		      
		    End If
		  End If
		  
		  AssertFailure "Unknown scenerio: " + dataScenario + " " + className + "."
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsUnitValid(unit As Double) As Boolean
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Returns whether or not the given unit is valid.
		  
		  Return ListUnits.IndexOf( unit ) > -1
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListDataScenariosForClass(tuneForClass As String, includeTheSameObjectScenario As Boolean) As String()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Returns a list of all the data scenarios that need to be tested.
		  
		  Dim result() As String
		  
		  If tuneForClass = "DurationKFS" Then
		    
		    result = Array( _
		    "Nil", _
		    "undefined", _
		    "neginf", _
		    "posinf", _
		    "negovr", _
		    "posovr", _
		    "negreal", _
		    "posreal", _
		    "zero" )
		    
		  ElseIf tuneForClass = "StopwatchKFS" Then
		    
		    result = Array( _
		    "Nil", _
		    "undefined", _
		    "neginf", _
		    "posinf", _
		    "negovr", _
		    "posovr", _
		    "negreal", _
		    "posreal", _
		    "zero" )
		    
		  ElseIf tuneForClass = "Date" Then
		    
		    result = Array( _
		    "Nil", _
		    "negreal", _
		    "posreal", _
		    "zero" )
		    
		  ElseIf tuneForClass = "Timer" Or tuneForClass = "WebTimer" Then
		    
		    result = Array( _
		    "Nil", _
		    "posreal", _
		    "zero" )
		    
		  ElseIf tuneForClass = "Double" Then
		    
		    result = Array( _
		    "negreal", _
		    "posreal", _
		    "zero" )
		    
		  Else
		    
		    AssertFailure "Unknown class for which to generate data scenarios: '" + tuneForClass + "'."
		    
		  End If
		  
		  If includeTheSameObjectScenario Then
		    If tuneForClass <> "Double" Then
		      result.Append "sameobject"
		    End If
		  End If
		  
		  Return result
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListDurationClassesToTest() As String()
		  // Created 1/29/2012 by Andrew Keller
		  
		  // Returns a list of classes that need to be tested in this class.
		  
		  Return Array( "DurationKFS", "StopwatchKFS" )
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListThisDurationClass() As String()
		  // Created 1/29/2012 by Andrew Keller
		  
		  // Returns a list of classes that... includes only this class.
		  
		  Dim s(-1) As String
		  Return s
		  
		  // done.
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ListUnits(includeInvalids As Boolean = False) As Double()
		  // Created 2/9/2012 by Andrew Keller
		  
		  // Returns a list of all units.
		  
		  If includeInvalids Then
		    
		    Return Array( _
		    -6.25, _
		    DurationKFS.kMicroseconds, _
		    DurationKFS.kMilliseconds, _
		    DurationKFS.kSeconds, _
		    1, _
		    DurationKFS.kMinutes, _
		    DurationKFS.kHours, _
		    DurationKFS.kDays, _
		    DurationKFS.kWeeks, _
		    DurationKFS.kMonths, _
		    DurationKFS.kYears, _
		    DurationKFS.kDecades, _
		    DurationKFS.kCenturies, _
		    10 )
		    
		  Else
		    
		    Return Array( _
		    DurationKFS.kMicroseconds, _
		    DurationKFS.kMilliseconds, _
		    DurationKFS.kSeconds, _
		    DurationKFS.kMinutes, _
		    DurationKFS.kHours, _
		    DurationKFS.kDays, _
		    DurationKFS.kWeeks, _
		    DurationKFS.kMonths, _
		    DurationKFS.kYears, _
		    DurationKFS.kDecades, _
		    DurationKFS.kCenturies )
		    
		  End If
		  
		  // done.
		  
		End Function
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
