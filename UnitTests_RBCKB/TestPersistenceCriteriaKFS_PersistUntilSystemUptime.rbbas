#tag Class
Protected Class TestPersistenceCriteriaKFS_PersistUntilSystemUptime
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestIsStillCurrent()
		  // Created 3/11/2012 by Andrew Keller
		  
		  // Makes sure the IsStillCurrent returns the correct values.
		  
		  Dim pc As PersistenceCriteriaKFS = New PersistenceCriteriaKFS_PersistUntilSystemUptime( -40 )
		  AssertFalse pc.IsStillCurrent, "The IsStillCurrent method is supposed to return False when the target time is negative.", False
		  
		  pc = New PersistenceCriteriaKFS_PersistUntilSystemUptime( 0 )
		  AssertFalse pc.IsStillCurrent, "The IsStillCurrent method is supposed to return False when the target time is zero.", False
		  
		  pc = New PersistenceCriteriaKFS_PersistUntilSystemUptime( Microseconds )
		  AssertFalse pc.IsStillCurrent, "The IsStillCurrent method is supposed to return False when the target time has passed.", False
		  
		  Dim expireTime As Int64 = Microseconds + 100000
		  pc = New PersistenceCriteriaKFS_PersistUntilSystemUptime( expireTime )
		  
		  Dim expireTimeStillInFuture As Boolean
		  Do
		    expireTimeStillInFuture = Microseconds < expireTime
		    
		    If Not expireTimeStillInFuture Then
		      AssertFalse pc.IsStillCurrent
		    End If
		    
		    If pc.IsStillCurrent Then
		      AssertTrue expireTimeStillInFuture
		    Else
		      AssertFalse Microseconds < expireTime
		    End If
		    
		  Loop Until Not expireTimeStillInFuture
		  
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
