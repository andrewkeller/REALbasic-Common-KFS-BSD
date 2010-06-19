#tag Class
Protected Class DelegateTimerKFS
Inherits Timer
	#tag Event
		Sub Action()
		  // Created 6/19/2010 by Andrew Keller
		  
		  // Invoke the delegate.
		  
		  If ActionMethod <> Nil Then
		    
		    ActionMethod.Invoke
		    
		  End If
		  
		  // done.
		  
		End Sub
	#tag EndEvent


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

	#tag Note, Name = Usage
		This class is a Timer where the Action event can be configured at runtime.
		
		The Action event invokes a delegate.  The currently used delegate has no
		arguments and no parameters.  To configure the Action event of this timer
		at runtime, set the ActionMethod property to a valid method.
		
		This class does not interpret the ActionMethod at all.  If the ActionMethod
		property is Nil when the timer fires, then nothing will happen.  The timer
		would continue to operate like a normal timer operates, except that the
		Action event would seem to do nothing.
		
		Everything about this timer except the Action event is unchanged from a
		normal Timer object.
		
	#tag EndNote


	#tag Property, Flags = &h0
		ActionMethod As PlainMethodKFS
	#tag EndProperty


End Class
#tag EndClass
