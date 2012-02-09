#tag Class
Protected Class BaseTestBSDGlobalsKFS_DurationKFS_Operators
Inherits UnitTests_RBCKB.BaseTestBSDGlobalsKFS_DurationKFS_Constructors
	#tag Method, Flags = &h0
		Sub TestOperator_AddRight_Date()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Date + DurationKFS => Date ) works.
		  
		  For Each ltype As String In Array("Date")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_AddRight_Timer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( Timer + DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_AddRight_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Make sure that ( WebTimer + DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_Date()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( DurationKFS + Date => Date ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Date")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_DurationKFS()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Make sure that ( DurationKFS + DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Add_Timer()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure that ( DurationKFS + Timer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Add_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Make sure that ( DurationKFS + WebTimer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "add", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Compare_DurationKFS()
		  // Created 8/17/2010 by Andrew Keller
		  
		  // Make sure a DurationKFS object can be compared to another DurationKFS object.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "compare", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Compare_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Make sure a DurationKFS object can be compared to a Timer object.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "compare", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Compare_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Make sure a DurationKFS object can be compared to a WebTimer object.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "compare", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_DivideRight_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( Timer / DurationKFS => Double ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_DivideRight_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( WebTimer / DurationKFS => Double ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_Double()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS / Double => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Double")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS / DurationKFS => Double ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Divide_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS / Timer => Double ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Divide_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS / WebTimer => Double ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "divide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_IntegerDivideRight_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( Timer \ DurationKFS => Int64 ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_IntegerDivideRight_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( WebTimer \ DurationKFS => Int64 ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_IntegerDivide_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS \ DurationKFS => Int64 ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_IntegerDivide_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS \ Timer => Int64 ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_IntegerDivide_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS \ WebTimer => Int64 ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "integerdivide", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_ModuloRight_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( Timer Mod DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_ModuloRight_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( WebTimer Mod DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Modulo_DurationKFS()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS Mod DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Modulo_Timer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS Mod Timer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Modulo_WebTimer()
		  // Created 1/31/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS Mod WebTimer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "modulo", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_MultiplyRight_Double()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( Double * DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("Double")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "multiply", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Multiply_Double()
		  // Created 8/20/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS * Double => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Double")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "multiply", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Negate()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Makes sure ( -DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      
		      Worker_TestSimpleOperation "negate", lsen, ltype
		      
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_SubtractRight_Date()
		  // Created 8/19/2010 by Andrew Keller
		  
		  // Makes sure ( Date - DurationKFS => Date ) works.
		  
		  For Each ltype As String In Array("Date")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_SubtractRight_Timer()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Makes sure ( Timer - DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("Timer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_SubtractRight_WebTimer()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Makes sure ( WebTimer - DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In Array("WebTimer")
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Subtract_DurationKFS()
		  // Created 8/7/2010 by Andrew Keller
		  
		  // Makes sure ( DurationKFS - DurationKFS => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In ListDurationClassesToTest
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestOperator_Subtract_Timer()
		  // Created 1/30/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS - Timer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("Timer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = TargetWeb
		Sub TestOperator_Subtract_WebTimer()
		  // Created 1/29/2012 by Andrew Keller
		  
		  // Makes sure ( DurationKFS - WebTimer => DurationKFS ) works.
		  
		  For Each ltype As String In ListDurationClassesToTest
		    For Each lsen As String In ListDataScenariosForClass(ltype, False)
		      For Each rtype As String In Array("WebTimer")
		        For Each rsen As String In ListDataScenariosForClass(rtype, True)
		          
		          Worker_TestSimpleOperation "subtract", lsen, ltype, rsen, rtype
		          
		        Next
		      Next
		    Next
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestSimpleOperation(operationCode As String, arg1Code As String, arg1Type As String)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Worker_TestSimpleOperation(operationCode As String, arg1Code As String, arg1Type As String, arg2Code As String, arg2Type As String)
		  
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
