#tag Class
Protected Class TestPropertyListKFS_APList
Inherits UnitTestBaseClassKFS
	#tag Method, Flags = &h0
		Sub TestDeserialize_ApplePList_ApplePList()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure an Apple PropertyListKFS can be parsed correctly.
		  
		  VerifySampleApplePList1_ApplePList New PropertyListKFS( kSampleApplePList1, PropertyListKFS.SerialFormats.ApplePList )
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDeserialize_ApplePList_Automatic()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDeserialize_Undefined_ApplePList()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestDeserialize_Undefined_Automatic()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGuessSerializedFormat_ApplePList()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure the GuessSerializedPListFormat function can identify Apple Property Lists.
		  
		  PushMessageStack "Did not recognize some data formatted as an Apple Property List."
		  
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList1 ), "(sample 1)"
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList2 ), "(sample 2)"
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList3 ), "(sample 3)"
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList4 ), "(sample 4)"
		  AssertEquals PropertyListKFS.SerialFormats.ApplePList, PropertyListKFS.GuessSerializedPListFormat( kSampleApplePList5 ), "(sample 5)"
		  
		  PopMessageStack
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestGuessSerializedFormat_Undefined()
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure the GuessSerializedPListFormat function can identify undefined plist formats.
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( Nil ), "Did not return Undefined for a Nil string."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "" ), "Did not return Undefined for an empty string."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( " " ), "Did not return Undefined for a single space."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "          " ), "Did not return Undefined for 10 spaces."
		  
		  AssertEquals PropertyListKFS.SerialFormats.Undefined, PropertyListKFS.GuessSerializedPListFormat( "  blah  foobar  " ), "Did not return Undefined for arbitrary text."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSerialize_ApplePList()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TestSerialize_Undefined()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifyDirTerminal(dir As Dictionary, expectedKey As Variant, expectedValType As Integer, expectedValue As Variant)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Verifies that the given directory has the given key / value pair.
		  
		  Dim v As Variant
		  
		  AssertTrue dir.HasKey( expectedKey ), "The "+expectedKey+" key does not exist."
		  v = dir.Value( expectedKey )
		  AssertEquals expectedValType, v.Type, "The "+expectedKey+" key should be a string."
		  AssertEquals expectedValue, v, "The "+expectedKey+" key did not have the correct value."
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifyDirTerminals(dir As Dictionary, expectedKeys() As Variant, expectedValTypes() As Integer, expectedValues() As Variant)
		  // Created 1/7/2010 by Andrew Keller
		  
		  // Verifies that the given directory has the given keys and values.
		  
		  Dim v As Variant
		  
		  For item As Integer = 0 To UBound( expectedKeys )
		    
		    VerifyDirTerminal dir, expectedKeys(item), expectedValTypes(item), expectedValues(item)
		    
		  Next
		  
		  // done.
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub VerifySampleApplePList1_ApplePList(p As PropertyListKFS)
		  // Created 12/7/2010 by Andrew Keller
		  
		  // Makes sure the given property list matches kkSampleApplePList1.
		  
		  Dim d As Dictionary
		  Dim t As Date
		  Dim keys() As Variant
		  Dim types() As Integer
		  Dim values() As Variant
		  
		  AssertNotIsNil p, "Cannot test a PropertyListKFS object that is Nil."
		  
		  AssertFalse p.TreatAsArray, "The TreatAsArray property of the root of kSampleApplePList1 should be False."
		  
		  d = p
		  AssertNotIsNil d, "The outgoing Dictionary convert constructor is never supposed to return Nil."
		  
		  keys.Append "AB21vCardEncoding"
		  types.Append Variant.TypeString
		  values.Append "MACINTOSH"
		  
		  keys.Append "AB21vCardEncoding-localized"
		  types.Append Variant.TypeString
		  values.Append "MACINTOSH"
		  
		  keys.Append "ABDefaultAddressCountryCode"
		  types.Append Variant.TypeString
		  values.Append "us"
		  
		  keys.Append "ABDefaultSelectedMember"
		  types.Append Variant.TypeString
		  values.Append "3C2C8E62-2CD7-4792-BDD2-66181478E252:ABPerson"
		  
		  keys.Append "ABImportTipCards"
		  types.Append Variant.TypeBoolean
		  values.Append True
		  
		  keys.Append "ABMainWindowViewMode"
		  types.Append Variant.TypeInteger
		  values.Append 0
		  
		  keys.Append "ABMainWindowViewMode-cardCol"
		  types.Append Variant.TypeInteger
		  values.Append 353
		  
		  keys.Append "ABMainWindowViewMode-contactCol"
		  types.Append Variant.TypeInteger
		  values.Append 187
		  
		  keys.Append "ABMainWindowViewMode-sourceCol"
		  types.Append Variant.TypeInteger
		  values.Append 159
		  
		  keys.Append "ABMetaDataChangeCount"
		  types.Append Variant.TypeInteger
		  values.Append 881
		  
		  keys.Append "ABMetadataLastOilChange"
		  types.Append Variant.TypeDate
		  t = New Date
		  t.Year = 2010
		  t.Month = 12
		  t.Day = 7
		  t.Hour = 0
		  t.Minute = 45
		  t.Second = 53
		  values.Append t
		  
		  keys.Append "ABNameDisplay"
		  types.Append Variant.TypeInteger
		  values.Append 0
		  
		  keys.Append "ABNameSorting"
		  types.Append Variant.TypeInteger
		  values.Append 1
		  
		  keys.Append "ABPhoneFormat-Edited"
		  types.Append Variant.TypeBoolean
		  values.Append False
		  
		  keys.Append "ABPhoneFormat-Enabled"
		  types.Append Variant.TypeBoolean
		  values.Append True
		  
		  keys.Append "NSWindow Frame AB Main Window"
		  types.Append Variant.TypeString
		  values.Append "402 249 701 564 0 0 1440 878 "
		  
		  VerifyDirTerminals d, keys, types, values
		  
		End Sub
	#tag EndMethod


	#tag Note, Name = License
		This class is licensed as BSD.
		
		Copyright (c) 2010, Andrew Keller, et al.
		All rights reserved.
		
		See CONTRIBUTORS.txt for a full list of all contributors.
		
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


	#tag Constant, Name = kSampleApplePList1, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>AB21vCardEncoding</key>\r\t<string>MACINTOSH</string>\r\t<key>AB21vCardEncoding-localized</key>\r\t<string>MACINTOSH</string>\r\t<key>ABDefaultAddressCountryCode</key>\r\t<string>us</string>\r\t<key>ABDefaultSelectedMember</key>\r\t<string>3C2C8E62-2CD7-4792-BDD2-66181478E252:ABPerson</string>\r\t<key>ABImportTipCards</key>\r\t<true/>\r\t<key>ABMainWindowViewMode</key>\r\t<integer>0</integer>\r\t<key>ABMainWindowViewMode-cardCol</key>\r\t<real>353</real>\r\t<key>ABMainWindowViewMode-contactCol</key>\r\t<real>187</real>\r\t<key>ABMainWindowViewMode-sourceCol</key>\r\t<real>159</real>\r\t<key>ABMetaDataChangeCount</key>\r\t<integer>881</integer>\r\t<key>ABMetadataLastOilChange</key>\r\t<date>2010-12-07T17:45:53Z</date>\r\t<key>ABNameDisplay</key>\r\t<integer>0</integer>\r\t<key>ABNameSorting</key>\r\t<integer>1</integer>\r\t<key>ABPhoneFormat-Edited</key>\r\t<false/>\r\t<key>ABPhoneFormat-Enabled</key>\r\t<true/>\r\t<key>ABPhoneFormat-PhoneFormatter</key>\r\t<array>\r\t\t<string>+1-###-###-####</string>\r\t\t<string>1-###-###-####</string>\r\t\t<string>###-###-####</string>\r\t\t<string>###-####</string>\r\t</array>\r\t<key>NSSplitView Subview Frames main split view</key>\r\t<array>\r\t\t<string>0.000000\x2C 0.000000\x2C 159.000000\x2C 519.000000\x2C NO</string>\r\t\t<string>160.000000\x2C 0.000000\x2C 187.000000\x2C 519.000000\x2C NO</string>\r\t\t<string>348.000000\x2C 0.000000\x2C 353.000000\x2C 519.000000\x2C NO</string>\r\t</array>\r\t<key>NSWindow Frame AB Main Window</key>\r\t<string>402 249 701 564 0 0 1440 878 </string>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSampleApplePList2, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>NSFontPanelAttributes</key>\r\t<string>1\x2C 4</string>\r\t<key>NSNavBrowserPreferedColumnContentWidth</key>\r\t<real>186</real>\r\t<key>NSNavPanelExpandedSizeForSaveMode</key>\r\t<string>{537\x2C 504}</string>\r\t<key>NSNavPanelExpandedStateForSaveMode</key>\r\t<true/>\r\t<key>NSWindow Frame PVInspectorPanel</key>\r\t<string>1116 499 320 375 0 0 1440 878 </string>\r\t<key>NSWindow Frame PVPreferences</key>\r\t<string>390 393 500 168 0 0 1280 778 </string>\r\t<key>PMPrintingExpandedStateForPrint</key>\r\t<true/>\r\t<key>PVAnnotationArrowStyle_1</key>\r\t<integer>2</integer>\r\t<key>PVAnnotationColor_1</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/j3dz+DlZSUPoP5+Hg+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_2</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/j3dz+DlZSUPoP5+Hg+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_3</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/j3dz+DlZSUPoP5+Hg+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_4</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/HwcD+D3dxcP4OtrCw+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_5</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMDhAJm\r\tZgABhg\x3D\x3D\r\t</data>\r\t<key>PVAnnotationColor_7</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/z7ez+D7u1tP4Pn5uY+AYY\x3D\r\t</data>\r\t<key>PVAnnotationColor_8</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMBhARm\r\tZmZmg/j3dz+DlZSUPoP5+Hg+AYY\x3D\r\t</data>\r\t<key>PVAnnotationFontName_5</key>\r\t<string>Monaco</string>\r\t<key>PVAnnotationFontSize_5</key>\r\t<real>6</real>\r\t<key>PVAnnotationInteriorColor_1</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMDhAJm\r\tZgAAhg\x3D\x3D\r\t</data>\r\t<key>PVAnnotationInteriorColor_2</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMDhAJm\r\tZgAAhg\x3D\x3D\r\t</data>\r\t<key>PVAnnotationInteriorColor_5</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAdOU0NvbG9yAISECE5TT2JqZWN0AIWEAWMDhAJm\r\tZgEBhg\x3D\x3D\r\t</data>\r\t<key>PVAnnotationLineWidth_1</key>\r\t<real>3</real>\r\t<key>PVAnnotationLineWidth_2</key>\r\t<real>3</real>\r\t<key>PVAnnotationLineWidth_5</key>\r\t<real>3</real>\r\t<key>PVGeneralSelectedPane</key>\r\t<integer>0</integer>\r\t<key>PVInspectorPanelForDoctype_NoDocument</key>\r\t<string>PVInspectorNoDocument</string>\r\t<key>PVInspectorPanelForDoctype_PDFDocument</key>\r\t<string>PVInspectorPDFAnnotations</string>\r\t<key>PVInspectorWindowOpenOnStart</key>\r\t<false/>\r\t<key>PVPDFDisplayBox</key>\r\t<integer>1</integer>\r\t<key>PVPDFDisplayMode</key>\r\t<integer>1</integer>\r\t<key>PVPDFLastSidebarWidthForOutline</key>\r\t<real>196</real>\r\t<key>PVPDFLastSidebarWidthForThumbnails</key>\r\t<real>164</real>\r\t<key>PVSidebarThumbnailColumns</key>\r\t<integer>1</integer>\r\t<key>kPVInspectorPDFMetricsUnit</key>\r\t<integer>4</integer>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSampleApplePList3, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>Default Window Settings</key>\r\t<string>Homebrew</string>\r\t<key>HasMigratedDefaults</key>\r\t<true/>\r\t<key>NSFontPanelAttributes</key>\r\t<string>1\x2C 4</string>\r\t<key>NSNavBrowserPreferedColumnContentWidth</key>\r\t<real>186</real>\r\t<key>NSNavLastRootDirectory</key>\r\t<string>~</string>\r\t<key>NSWindow Frame NSColorPanel</key>\r\t<string>867 413 201 309 0 0 1440 878 </string>\r\t<key>NSWindow Frame NSFontPanel</key>\r\t<string>296 71 445 270 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTAppPreferences</key>\r\t<string>696 272 590 399 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTFindPanel</key>\r\t<string>863 324 483 144 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow</key>\r\t<string>493 427 524 349 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Basic</key>\r\t<string>390 109 505 366 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Grass</key>\r\t<string>693 235 505 366 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Homebrew</key>\r\t<string>253 150 955 388 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Novel</key>\r\t<string>855 329 585 390 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Ocean</key>\r\t<string>833 433 585 390 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Pro</key>\r\t<string>114 449 505 366 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow Red Sands</key>\r\t<string>805 109 585 366 0 0 1440 878 </string>\r\t<key>NSWindow Frame TTWindow emunix</key>\r\t<string>73 415 955 388 0 0 1440 878 </string>\r\t<key>ProfileCurrentVersion</key>\r\t<real>2.0099999999999998</real>\r\t<key>SecureKeyboardEntry</key>\r\t<false/>\r\t<key>Shell</key>\r\t<string></string>\r\t<key>ShowTabBar</key>\r\t<true/>\r\t<key>Startup Window Settings</key>\r\t<string>Homebrew</string>\r\t<key>TTAppPreferences Selected Tab</key>\r\t<integer>1</integer>\r\t<key>TTInspector Selected Pane</key>\r\t<string>Settings</string>\r\t<key>Window Settings</key>\r\t<dict>\r\t\t<key>Basic</key>\r\t\t<dict>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>FontWidthSpacing</key>\r\t\t\t<real>1.004032258064516</real>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Basic</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Grass</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAgMC4wNzQ1MDk4MDcg\r\t\t\tMC40NjY2NjY3IDAuMjM5MjE1NwDSEBESE1okY2xhc3NuYW1lWCRj\r\t\t\tbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJj\r\t\t\taGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cYmRmiY6ZoqqttsjL\r\t\t\t0AAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAADS\r\t\t\t</data>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAYMC41NTY4NjI3NyAw\r\t\t\tLjE1Njg2Mjc1IDAA0hAREhNaJGNsYXNzbmFtZVgkY2xhc3Nlc1dO\r\t\t\tU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RcY\r\t\t\tVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoGGkZqipa7Aw8gAAAAAAAAB\r\t\t\tAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAAyg\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>CursorType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAhMC43MTM3MjU1MSAw\r\t\t\tLjI4NjI3NDUyIDAuMTQ5MDE5NjEA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAXMSAwLjY5MDE5NjEg\r\t\t\tMC4yMzEzNzI1NwDSEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05T\r\t\t\tQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhU\r\t\t\tcm9vdIABCBEaIy0yNztBSE9cYmRmgIWQmaGkrb/CxwAAAAAAAAEB\r\t\t\tAAAAAAAAABkAAAAAAAAAAAAAAAAAAADJ\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAYMSAwLjk0MTE3NjUz\r\t\t\tIDAuNjQ3MDU4ODQA0hAREhNaJGNsYXNzbmFtZVgkY2xhc3Nlc1dO\r\t\t\tU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RcY\r\t\t\tVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoGGkZqipa7Aw8gAAAAAAAAB\r\t\t\tAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAAyg\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Grass</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Homebrew</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANGMCAwLjgA0hAREhNa\r\t\t\tJGNsYXNzbmFtZVgkY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0\r\t\t\tXxAPTlNLZXllZEFyY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhP\r\t\t\tXGRmaG90f4iQk5yusbYAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAA\r\t\t\tAAAAAAAAuA\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>CursorBlink</key>\r\t\t\t<false/>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAhMC4yMTk2MDc4NiAw\r\t\t\tLjk5NjA3ODQ5IDAuMTUyOTQxMTgA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>CursorType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>Linewrap</key>\r\t\t\t<true/>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>ScrollbackLines</key>\r\t\t\t<real>10000</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAeMC4wMzQ1NzgzOTUg\r\t\t\tMCAwLjkxMzI2NTMxIDAuNjUA0hAREhNaJGNsYXNzbmFtZVgkY2xh\r\t\t\tc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hp\r\t\t\tdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoeMl6Coq7TGyc4A\r\t\t\tAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0A\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>ShouldLimitScrollback</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABRjAgMSAwANIQERITWiRj\r\t\t\tbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xvcqISFFhOU09iamVjdF8Q\r\t\t\tD05TS2V5ZWRBcmNoaXZlctEXGFRyb290gAEIERojLTI3O0FIT1xi\r\t\t\tZGZtcn2GjpGarK+0AAAAAAAAAQEAAAAAAAAAGQAAAAAAAAAAAAAA\r\t\t\tAAAAALY\x3D\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAiMC4xNTY4NjI3NSAw\r\t\t\tLjk5NjA3ODQ5IDAuMDc4NDMxMzc1ANIQERITWiRjbGFzc25hbWVY\r\t\t\tJGNsYXNzZXNXTlNDb2xvcqISFFhOU09iamVjdF8QD05TS2V5ZWRB\r\t\t\tcmNoaXZlctEXGFRyb290gAEIERojLTI3O0FIT1xiZGaLkJukrK+4\r\t\t\tys3SAAAAAAAAAQEAAAAAAAAAGQAAAAAAAAAAAAAAAAAAANQ\x3D\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Homebrew</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Novel</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAaMC44NzUgMC44NTc5\r\t\t\tODM2NSAwLjc2NTYyNQDSEBESE1okY2xhc3NuYW1lWCRjbGFzc2Vz\r\t\t\tV05TQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLR\r\t\t\tFxhUcm9vdIABCBEaIy0yNztBSE9cYmRmg4iTnKSnsMLFygAAAAAA\r\t\t\tAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAADM\r\t\t\t</data>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAqMC4yMjc0NTEgMC4x\r\t\t\tMzcyNTQ5MSAwLjEzMzMzMzM0IDAuNjQ5OTk5OTgA0hAREhNaJGNs\r\t\t\tYXNzbmFtZVgkY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAP\r\t\t\tTlNLZXllZEFyY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJk\r\t\t\tZpOYo6y0t8DS1doAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAA\r\t\t\tAAAA3A\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAsMC40NTQwODE2NSAw\r\t\t\tLjQ1MTAwNDg5IDAuMzE1MTQzOTEgMC43NTk5OTk5OQDSEBESE1ok\r\t\t\tY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3Rf\r\t\t\tEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9c\r\t\t\tYmRmlZqlrra5wtTX3AAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAA\r\t\t\tAAAAAADe\r\t\t\t</data>\r\t\t\t<key>ShowWindowSettingsNameInTitle</key>\r\t\t\t<false/>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAbMC41IDAuMTY0MzAw\r\t\t\tNTUgMC4wOTkxNDU0NzIA0hAREhNaJGNsYXNzbmFtZVgkY2xhc3Nl\r\t\t\tc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy\r\t\t\t0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoSJlJ2lqLHDxssAAAAA\r\t\t\tAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAAzQ\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAhMC4yMzMxNzMxMiAw\r\t\t\tLjEzNTQwODU3IDAuMTMyOTA2MDgA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Novel</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Ocean</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAhMC4xMzIwNTYyNCAw\r\t\t\tLjMwODQ3ODU2IDAuNzM5MTMwNDQA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>FontWidthSpacing</key>\r\t\t\t<real>0.99596774193548387</real>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAXMC4xMzA3MzkzIDAu\r\t\t\tNDI4NDU4MDYgMQDSEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05T\r\t\t\tQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhU\r\t\t\tcm9vdIABCBEaIy0yNztBSE9cYmRmgIWQmaGkrb/CxwAAAAAAAAEB\r\t\t\tAAAAAAAAABkAAAAAAAAAAAAAAAAAAADJ\r\t\t\t</data>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANCMQDSEBESE1okY2xh\r\t\t\tc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9O\r\t\t\tU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cZGZo\r\t\t\ta3B7hIyPmKqtsgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAA\r\t\t\tAAC0\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANCMQDSEBESE1okY2xh\r\t\t\tc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9O\r\t\t\tU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cZGZo\r\t\t\ta3B7hIyPmKqtsgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAA\r\t\t\tAAC0\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>fontAllowsDisableAntialias</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Ocean</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Pro</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANNMCAwLjg1MDAwMDAy\r\t\t\tANIQERITWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xvcqISFFhO\r\t\t\tU09iamVjdF8QD05TS2V5ZWRBcmNoaXZlctEXGFRyb290gAEIERoj\r\t\t\tLTI3O0FIT1xkZmh2e4aPl5qjtbi9AAAAAAAAAQEAAAAAAAAAGQAA\r\t\t\tAAAAAAAAAAAAAAAAAL8\x3D\r\t\t\t</data>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANLMC4zMDI0MTkzNgDS\r\t\t\tEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNP\r\t\t\tYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0y\r\t\t\tNztBSE9cZGZodHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAA\r\t\t\tAAAAAAAAAAAAAAC9\r\t\t\t</data>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>FontWidthSpacing</key>\r\t\t\t<real>0.99596774193548387</real>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANLMC4yNTQwMzIyNQDS\r\t\t\tEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNP\r\t\t\tYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0y\r\t\t\tNztBSE9cZGZodHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAA\r\t\t\tAAAAAAAAAAAAAAC9\r\t\t\t</data>\r\t\t\t<key>ShowWindowSettingsNameInTitle</key>\r\t\t\t<false/>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANCMQDSEBESE1okY2xh\r\t\t\tc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9O\r\t\t\tU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cZGZo\r\t\t\ta3B7hIyPmKqtsgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAA\r\t\t\tAAC0\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANLMC45NDc1ODA2NADS\r\t\t\tEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNP\r\t\t\tYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0y\r\t\t\tNztBSE9cZGZodHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAA\r\t\t\tAAAAAAAAAAAAAAC9\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Pro</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>shellExitAction</key>\r\t\t\t<integer>2</integer>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t\t<key>Red Sands</key>\r\t\t<dict>\r\t\t\t<key>BackgroundColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAsMC40NzgyNjA4NyAw\r\t\t\tLjE0NTEwNDM2IDAuMTE2ODgxMjEgMC44NTAwMDAwMgDSEBESE1ok\r\t\t\tY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3Rf\r\t\t\tEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9c\r\t\t\tYmRmlZqlrra5wtTX3AAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAA\r\t\t\tAAAAAADe\r\t\t\t</data>\r\t\t\t<key>CursorColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VXTlNXaGl0ZYACEANCMQDSEBESE1okY2xh\r\t\t\tc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9O\r\t\t\tU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cZGZo\r\t\t\ta3B7hIyPmKqtsgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAA\r\t\t\tAAC0\r\t\t\t</data>\r\t\t\t<key>CursorType</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>Font</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKQHCBESVSRudWxs1AkKCwwNDg8QViRj\r\t\t\tbGFzc1ZOU05hbWVWTlNTaXplWE5TZkZsYWdzgAOAAiNAJAAAAAAA\r\t\t\tABAQVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNWTlNG\r\t\t\tb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJv\r\t\t\tb3SAAQgRGiMtMjc8QktSWWBpa212eH+Ej5ifoqu9wMUAAAAAAAAB\r\t\t\tAQAAAAAAAAAcAAAAAAAAAAAAAAAAAAAAxw\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>FontAntialias</key>\r\t\t\t<false/>\r\t\t\t<key>FontWidthSpacing</key>\r\t\t\t<real>1.004032258064516</real>\r\t\t\t<key>ProfileCurrentVersion</key>\r\t\t\t<real>2.0099999999999998</real>\r\t\t\t<key>SelectionColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAjMC4yMzc5MDMyMSAw\r\t\t\tLjA5NzYwMTMzOSAwLjA4NzQzNDUyMwDSEBESE1okY2xhc3NuYW1l\r\t\t\tWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVk\r\t\t\tQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSE9cYmRmjJGcpa2w\r\t\t\tucvO0wAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAADV\r\t\t\t</data>\r\t\t\t<key>TextBoldColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhABTxAcMC44NzUgMC43NDAz\r\t\t\tODg0NSAwLjEzMjEzODczANIQERITWiRjbGFzc25hbWVYJGNsYXNz\r\t\t\tZXNXTlNDb2xvcqISFFhOU09iamVjdF8QD05TS2V5ZWRBcmNoaXZl\r\t\t\tctEXGFRyb290gAEIERojLTI3O0FIT1xiZGaFipWepqmyxMfMAAAA\r\t\t\tAAAAAQEAAAAAAAAAGQAAAAAAAAAAAAAAAAAAAM4\x3D\r\t\t\t</data>\r\t\t\t<key>TextColor</key>\r\t\t\t<data>\r\t\t\tYnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFy\r\t\t\tY2hpdmVyVCR0b3ASAAGGoKMHCA9VJG51bGzTCQoLDA0OViRjbGFz\r\t\t\tc1xOU0NvbG9yU3BhY2VVTlNSR0KAAhACTxAhMC44NDMxMzczMiAw\r\t\t\tLjc4ODIzNTM3IDAuNjU0OTAxOTgA0hAREhNaJGNsYXNzbmFtZVgk\r\t\t\tY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFy\r\t\t\tY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhPXGJkZoqPmqOrrrfJ\r\t\t\tzNEAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAA0w\x3D\x3D\r\t\t\t</data>\r\t\t\t<key>columnCount</key>\r\t\t\t<integer>155</integer>\r\t\t\t<key>fontAllowsDisableAntialias</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>name</key>\r\t\t\t<string>Red Sands</string>\r\t\t\t<key>noWarnProcesses</key>\r\t\t\t<array>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>rlogin</string>\r\t\t\t\t</dict>\r\t\t\t\t<dict>\r\t\t\t\t\t<key>ProcessName</key>\r\t\t\t\t\t<string>slogin</string>\r\t\t\t\t</dict>\r\t\t\t</array>\r\t\t\t<key>type</key>\r\t\t\t<string>Window Settings</string>\r\t\t</dict>\r\t</dict>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSampleApplePList4, Type = String, Dynamic = False, Default = \"<\?xml version\x3D\"1.0\" encoding\x3D\"UTF-8\"\?>\r\r<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\r<plist version\x3D\"1.0\">\r<dict>\r\t<key>IgnoreHTML</key>\r\t<true/>\r\t<key>NSNavBrowserPreferedColumnContentWidth</key>\r\t<real>186</real>\r\t<key>NSNavLastCurrentDirectory</key>\r\t<string>~/School/COSC 444-0</string>\r\t<key>NSNavLastRootDirectory</key>\r\t<string>~/School</string>\r\t<key>NSNavPanelExpandedSizeForOpenMode</key>\r\t<string>{537\x2C 400}</string>\r\t<key>NSNavPanelExpandedSizeForSaveMode</key>\r\t<string>{537\x2C 422}</string>\r\t<key>NSNavPanelExpandedStateForSaveMode</key>\r\t<true/>\r\t<key>NSWindow Frame NSFontPanel</key>\r\t<string>993 97 445 270 0 0 1440 878 </string>\r\t<key>NSWindow Frame NSNavGotoPanel</key>\r\t<string>956 744 432 134 0 0 1440 878 </string>\r\t<key>PMPrintingExpandedStateForPrint</key>\r\t<false/>\r\t<key>RichText</key>\r\t<integer>0</integer>\r\t<key>TextReplacement</key>\r\t<false/>\r</dict>\r</plist>\r", Scope = Public
	#tag EndConstant

	#tag Constant, Name = kSampleApplePList5, Type = String, Dynamic = False, Default = \"<\?xml  version\x3D\"1.0\"    encoding\x3D\"UTF-8\"\?>\r\r<!DOCTYPE   plist     PUBLIC     \"-//Apple//DTD PLIST 1.0//EN\"     \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"        >\r\r\r<plist     version\x3D\"1.0\"    >\r\r\r\r<dict>\r\t<key>ActivityViewerWindowFrame</key>\r\t<string>50 105 400 200 0 0 1440 878 </string>\r\t<key>ColorIndexedSymbols</key>\r\t<true/>\r\t<key>ColorTheme</key>\r\t<string>Xcode Default (Monaco)</string>\r\t<key>ColorThemesUpgraded</key>\r\t<true/>\r\t<key>CopySourceCodeAsRichText</key>\r\t<true/>\r\t<key>DSAPreferenceRefreshInterval</key>\r\t<real>86400</real>\r\t<key>DSAPreferenceSubscriptions</key>\r\t<dict>\r\t\t<key>http://developer.apple.com/rss/adcdocsets.atom</key>\r\t\t<string>5826CA10-BCA8-4F00-8694-F2E16CCB0E1C</string>\r\t\t<key>http://developer.apple.com/rss/com.apple.adc.documentation.AppleSnowLeopard.atom</key>\r\t\t<string>57B16CE1-8F87-4684-B5F3-8ED1850DF19A</string>\r\t\t<key>http://developer.apple.com/rss/com.apple.adc.documentation.AppleXcode3_2.atom</key>\r\t\t<string>52260324-7AE6-497E-8972-25DC39934D5B</string>\r\t</dict>\r\t<key>DSMEnabledDocSetsForSearching</key>\r\t<dict>\r\t\t<key>C</key>\r\t\t<false/>\r\t\t<key>C++</key>\r\t\t<false/>\r\t\t<key>Java</key>\r\t\t<true/>\r\t\t<key>JavaScript</key>\r\t\t<false/>\r\t\t<key>Objective-C</key>\r\t\t<false/>\r\t</dict>\r\t<key>IndentWidth</key>\r\t<integer>4</integer>\r\t<key>NSFontPanelAttributes</key>\r\t<string>1\x2C 4</string>\r\t<key>NSNavBrowserPreferedColumnContentWidth</key>\r\t<real>186</real>\r\t<key>NSNavLastRootDirectory</key>\r\t<string>~/Downloads/bbt</string>\r\t<key>NSNavPanelExpandedSizeForOpenMode</key>\r\t<string>{537\x2C 400}</string>\r\t<key>NSNavPanelExpandedSizeForSaveMode</key>\r\t<string>{537\x2C 400}</string>\r\t<key>NSNavPanelExpandedStateForSaveMode</key>\r\t<true/>\r\t<key>NSSplitView Sizes XCDistributedBuildsSplitView</key>\r\t<array>\r\t\t<string>{135\x2C 179}</string>\r\t\t<string>{455\x2C 179}</string>\r\t</array>\r\t<key>NSSplitView Subview Frames PBXTargetInspectorPaneSplit</key>\r\t<array>\r\t\t<string>0.000000\x2C 0.000000\x2C 438.000000\x2C 213.000000\x2C NO</string>\r\t\t<string>0.000000\x2C 222.000000\x2C 438.000000\x2C 284.000000\x2C NO</string>\r\t</array>\r\t<key>NSSplitView Subview Frames WebAndSearchResultsSplitView</key>\r\t<array>\r\t\t<string>0.000000\x2C 0.000000\x2C 0.000000\x2C 643.000000\x2C NO</string>\r\t\t<string>0.000000\x2C 0.000000\x2C 1049.000000\x2C 643.000000\x2C NO</string>\r\t</array>\r\t<key>NSSplitView Subview Frames XCBuildPropertiesInspectorSplitView</key>\r\t<array>\r\t\t<string>0.000000\x2C 0.000000\x2C 417.000000\x2C 363.000000\x2C NO</string>\r\t\t<string>0.000000\x2C 373.000000\x2C 417.000000\x2C 97.000000\x2C NO</string>\r\t</array>\r\t<key>NSTableView Columns XCDistributedBuildsComputersTable</key>\r\t<array>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErFENvbXB1dGVyU3RyaW5nQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<string>114</string>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErEENvbXB1dGVyT1NDb2x1bW6G\r\t\t</data>\r\t\t<string>103</string>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErF0NvbXB1dGVyQ29tcGlsZXJzQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<string>152</string>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErFENvbXB1dGVyU3RhdHVzQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<string>77</string>\r\t</array>\r\t<key>NSTableView Hidden Columns XCDistributedBuildsComputersTable</key>\r\t<array/>\r\t<key>NSTableView Sort Ordering XCDistributedBuildsComputersTable</key>\r\t<array>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErFENvbXB1dGVyU3RhdHVzQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<true/>\r\t\t<data>\r\t\tBAtzdHJlYW10eXBlZIHoA4QBQISEhAhOU1N0cmluZwGEhAhOU09iamVjdACF\r\t\thAErFENvbXB1dGVyU3RyaW5nQ29sdW1uhg\x3D\x3D\r\t\t</data>\r\t\t<true/>\r\t</array>\r\t<key>NSToolbar Configuration PBXModule.PBXNavigatorGroup</key>\r\t<dict>\r\t\t<key>TB Display Mode</key>\r\t\t<integer>1</integer>\r\t\t<key>TB Icon Size Mode</key>\r\t\t<integer>1</integer>\r\t\t<key>TB Is Shown</key>\r\t\t<integer>0</integer>\r\t\t<key>TB Item Identifiers</key>\r\t\t<array>\r\t\t\t<string>active-combo-popup</string>\r\t\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t\t<string>debugger-enable-breakpoints</string>\r\t\t\t<string>build-and-go</string>\r\t\t\t<string>com.apple.ide.PBXToolbarStopButton</string>\r\t\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t\t<string>toggle-editor-pin</string>\r\t\t\t<string>servicesModuleproject</string>\r\t\t</array>\r\t\t<key>TB Size Mode</key>\r\t\t<integer>1</integer>\r\t\t<key>TB Visibility Priority Values</key>\r\t\t<dict>\r\t\t\t<key>active-combo-popup</key>\r\t\t\t<array>\r\t\t\t\t<integer>1400</integer>\r\t\t\t</array>\r\t\t\t<key>build-and-go</key>\r\t\t\t<array>\r\t\t\t\t<integer>1600</integer>\r\t\t\t</array>\r\t\t\t<key>com.apple.ide.PBXToolbarStopButton</key>\r\t\t\t<array>\r\t\t\t\t<integer>1600</integer>\r\t\t\t</array>\r\t\t</dict>\r\t</dict>\r\t<key>NSWindow Frame DocResultsWindow</key>\r\t<string>208 178 1049 687 0 0 1440 878 </string>\r\t<key>NSWindow Frame HUDModule</key>\r\t<string>0 479 496 345 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXAddFilesOptionsPanel</key>\r\t<string>631 228 400 396 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXSaveMultiplePanel</key>\r\t<string>500 411 440 348 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXSimpleFinder</key>\r\t<string>50 850 642 181 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXTextFieldEntryModule</key>\r\t<string>527 680 386 143 0 0 1440 878 </string>\r\t<key>NSWindow Frame PBXWizardPanel</key>\r\t<string>353 225 733 596 0 0 1440 878 </string>\r\t<key>NSWindow Frame XCBinderWindowFrameKey</key>\r\t<string>50 541 949 637 0 0 1920 1178 </string>\r\t<key>NSWindow Frame XCStringEditorModule</key>\r\t<string>485 520 476 280 0 0 1440 878 </string>\r\t<key>NSWindow Frame XCStringListEditorModule</key>\r\t<string>42 520 476 280 0 0 1440 878 </string>\r\t<key>PBXActiveKeyBindings</key>\r\t<string>Xcode Default</string>\r\t<key>PBXApplicationwideBuildSettings</key>\r\t<dict/>\r\t<key>PBXAutoIndentCharacters</key>\r\t<string>{};:#\r\r</string>\r\t<key>PBXAutoInsertsCloseBrace</key>\r\t<string>NO</string>\r\t<key>PBXBuildLogShowAllResultsDefaultKey</key>\r\t<false/>\r\t<key>PBXBuildLogShowByStepViewDefaultKey</key>\r\t<false/>\r\t<key>PBXBuildLogShowsAllBuildSteps</key>\r\t<true/>\r\t<key>PBXBuildLogShowsAnalyzerResults</key>\r\t<true/>\r\t<key>PBXBuildLogShowsErrors</key>\r\t<true/>\r\t<key>PBXBuildLogShowsWarnings</key>\r\t<true/>\r\t<key>PBXCounterpartStaysInSameEditor</key>\r\t<string>YES</string>\r\t<key>PBXDebugger.ImageSymbolsv2.sys.level</key>\r\t<integer>2</integer>\r\t<key>PBXDebugger.ImageSymbolsv2.user.level</key>\r\t<integer>2</integer>\r\t<key>PBXDebugger.LazySymbolLoading</key>\r\t<true/>\r\t<key>PBXDebuggerOldLayout</key>\r\t<false/>\r\t<key>PBXDefaultTextLineEnding</key>\r\t<string>LF</string>\r\t<key>PBXDefaultTextLineEndingForSave</key>\r\t<string>LF</string>\r\t<key>PBXFileTypesToDocumentTypes</key>\r\t<dict>\r\t\t<key>file.xib</key>\r\t\t<string>Interface/Builder</string>\r\t\t<key>wrapper.nib</key>\r\t\t<string>Interface/Builder</string>\r\t</dict>\r\t<key>PBXFindIgnoreCase</key>\r\t<true/>\r\t<key>PBXFindMatchStyle</key>\r\t<string>Contains</string>\r\t<key>PBXFindType</key>\r\t<integer>0</integer>\r\t<key>PBXGlobalFindOptionsSets</key>\r\t<array>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In Project</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In Project and Frameworks</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In All Open Projects</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>2</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In Selected Project Items</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<true/>\r\t\t\t<key>name</key>\r\t\t\t<string>In Frameworks</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>2</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>1</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>fileFilterType</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInFilesAndFolders</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>findInIncludedFiles</key>\r\t\t\t<false/>\r\t\t\t<key>findInOpenFiles</key>\r\t\t\t<true/>\r\t\t\t<key>findInOpenProjects</key>\r\t\t\t<false/>\r\t\t\t<key>name</key>\r\t\t\t<string>In All Open Files</string>\r\t\t\t<key>negativeNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>positiveNamePatterns</key>\r\t\t\t<array/>\r\t\t\t<key>projectFindCandidates</key>\r\t\t\t<integer>0</integer>\r\t\t\t<key>projectFindScope</key>\r\t\t\t<integer>2</integer>\r\t\t\t<key>searchFiles</key>\r\t\t\t<array/>\r\t\t</dict>\r\t</array>\r\t<key>PBXIndentWrappedLines</key>\r\t<string>YES</string>\r\t<key>PBXInspectorPanel Configuration</key>\r\t<dict>\r\t\t<key>PBXConfiguration.PBXModule.PBXInfoInspectorPanel.Contents</key>\r\t\t<dict>\r\t\t\t<key>inspectorPanes</key>\r\t\t\t<dict>\r\t\t\t\t<key>PBXConfiguration.PBXModule.XCCommentsInspectorPane</key>\r\t\t\t\t<dict/>\r\t\t\t\t<key>PBXConfiguration.PBXModule.XCExecutableArgumentsInspectorPane</key>\r\t\t\t\t<dict/>\r\t\t\t\t<key>PBXConfiguration.PBXModule.XCExecutableDebugSettingsInspectorPane</key>\r\t\t\t\t<dict/>\r\t\t\t\t<key>PBXConfiguration.PBXModule.XCExecutableInspectorPane</key>\r\t\t\t\t<dict/>\r\t\t\t</dict>\r\t\t\t<key>selectedTab</key>\r\t\t\t<string>Arguments</string>\r\t\t</dict>\r\t\t<key>PBXConfiguration.PBXModule.PBXInfoInspectorPanel.Geometry</key>\r\t\t<dict>\r\t\t\t<key>Frame</key>\r\t\t\t<string>{{0\x2C -1}\x2C {390\x2C 573}}</string>\r\t\t\t<key>RubberWindowFrame</key>\r\t\t\t<string>653 195 390 593 0 0 1440 878 </string>\r\t\t</dict>\r\t\t<key>PBXConfiguration.PBXModule.PBXInspectorPanel.Contents</key>\r\t\t<dict>\r\t\t\t<key>inspectorPanes</key>\r\t\t\t<dict/>\r\t\t</dict>\r\t\t<key>PBXConfiguration.PBXModule.PBXInspectorPanel.Geometry</key>\r\t\t<dict>\r\t\t\t<key>Frame</key>\r\t\t\t<string>{{0\x2C 0}\x2C {390\x2C 571}}</string>\r\t\t\t<key>RubberWindowFrame</key>\r\t\t\t<string>50 291 390 587 0 0 1440 878 </string>\r\t\t</dict>\r\t</dict>\r\t<key>PBXNavigatorGroupDefaultFrame</key>\r\t<string>{{84\x2C 117}\x2C {715\x2C 693}}</string>\r\t<key>PBXPreferencesContentSize</key>\r\t<string>{628\x2C 342}</string>\r\t<key>PBXPreferencesSelectedIndex</key>\r\t<integer>0</integer>\r\t<key>PBXSelectToInsideMatchingBraces</key>\r\t<string>NO</string>\r\t<key>PBXSelectToMatchingBrace</key>\r\t<string>YES</string>\r\t<key>PBXSelectedGlobalFindOptionsSet</key>\r\t<string>In Project</string>\r\t<key>PBXShowColumnPositionInLineBrowser</key>\r\t<true/>\r\t<key>PBXShowLineNumbers</key>\r\t<true/>\r\t<key>PBXShowPageGuide</key>\r\t<true/>\r\t<key>PBXShowsTextColorsWhenPrinting</key>\r\t<false/>\r\t<key>PBXSimpleFindMatchStyle</key>\r\t<string>Contains</string>\r\t<key>PBXSoloBraceIndentWidth</key>\r\t<integer>0</integer>\r\t<key>PBXSyntaxColoringEnabled</key>\r\t<true/>\r\t<key>PBXSyntaxColoringUseSeparateFonts</key>\r\t<string>NO</string>\r\t<key>PBXTabKeyIndentBehavior</key>\r\t<string>InLeadingWhitespace</string>\r\t<key>PBXTextEditorWrapsLines</key>\r\t<string>NO</string>\r\t<key>PBXTurnOffWindowConfigurations</key>\r\t<false/>\r\t<key>PBXUsesSyntaxAwareIndenting</key>\r\t<string>YES</string>\r\t<key>PBXUsesTabs</key>\r\t<string>YES</string>\r\t<key>PBXWrappedLineIndentWidth</key>\r\t<integer>4</integer>\r\t<key>PBX_autoOpenProjectEditor</key>\r\t<true/>\r\t<key>PMPrintingExpandedStateForPrint</key>\r\t<false/>\r\t<key>PerspectivesToolbar.com.apple.perspectives.project.defaultV3_2.PBXModule.XCPerspectiveModule.Project</key>\r\t<array>\r\t\t<string>XCToolbarPerspectiveControl</string>\r\t\t<string>NSToolbarSeparatorItem</string>\r\t\t<string>active-combo-popup</string>\r\t\t<string>action</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>debugger-enable-breakpoints</string>\r\t\t<string>build-and-go</string>\r\t\t<string>com.apple.ide.PBXToolbarStopButton</string>\r\t\t<string>get-info</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>com.apple.pbx.toolbar.searchfield</string>\r\t</array>\r\t<key>PerspectivesToolbar.com.apple.perspectives.project.mode1v3_2.PBXModule.XCPerspectiveModule.Project</key>\r\t<array>\r\t\t<string>active-combo-popup</string>\r\t\t<string>action</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>debugger-enable-breakpoints</string>\r\t\t<string>build-and-go</string>\r\t\t<string>com.apple.ide.PBXToolbarStopButton</string>\r\t\t<string>get-info</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>com.apple.pbx.toolbar.searchfield</string>\r\t</array>\r\t<key>PerspectivesToolbar.com.apple.perspectives.project.mode2v3_2.PBXModule.XCPerspectiveModule.Project</key>\r\t<array>\r\t\t<string>active-combo-popup</string>\r\t\t<string>debugger-enable-breakpoints</string>\r\t\t<string>build-and-go</string>\r\t\t<string>com.apple.ide.PBXToolbarStopButton</string>\r\t\t<string>NSToolbarFlexibleSpaceItem</string>\r\t\t<string>get-info</string>\r\t</array>\r\t<key>ShowsFoldingSidebar</key>\r\t<true/>\r\t<key>SyntaxColoringEnabled</key>\r\t<true/>\r\t<key>TSDefaultCStringEncoding</key>\r\t<string>4</string>\r\t<key>TabWidth</key>\r\t<integer>4</integer>\r\t<key>XCActivityViewerOpenKey</key>\r\t<false/>\r\t<key>XCAlignConsecutiveSlashSlashComments</key>\r\t<true/>\r\t<key>XCAssistantSelections</key>\r\t<dict>\r\t\t<key>PBXFileWizardChooserWizard</key>\r\t\t<string>macosx.platform/C and C++/C File</string>\r\t\t<key>PBXProjectWizardChooserWizard</key>\r\t\t<string>macosx.platform/Application/Command Line Tool</string>\r\t\t<key>PBXTargetWizardChooserWizard</key>\r\t\t<string>macosx.platform/BSD/Shell Tool</string>\r\t</dict>\r\t<key>XCBinderSideBarWidthKey</key>\r\t<real>212</real>\r\t<key>XCExternalEditorList</key>\r\t<dict>\r\t\t<key>Interface/Builder</key>\r\t\t<string>com.apple.Xcode.ExternalEditor.nib!@/Developer/Applications/Interface Builder.app</string>\r\t\t<key>emacs</key>\r\t\t<string>com.apple.Xcode.ExternalEditor.\?\?\?\?@/Applications/Utilities/Terminal.app</string>\r\t</dict>\r\t<key>XCHudWindowLocationRectString</key>\r\t<string>{{0\x2C 759}\x2C {144\x2C 65}}</string>\r\t<key>XCIndentSlashSlashComments</key>\r\t<false/>\r\t<key>XCLastBuildConfigurationInspected</key>\r\t<string>Debug</string>\r\t<key>XCLastFilterSelected</key>\r\t<integer>0</integer>\r\t<key>XCMultiWizardProxymacosx.platform/Application/Command Line Tool</key>\r\t<string>Standard</string>\r\t<key>XCProjectWindowToolbarDisplayMode</key>\r\t<integer>1</integer>\r\t<key>XCProjectWindowToolbarSizeMode</key>\r\t<integer>1</integer>\r\t<key>XCReopenProjects</key>\r\t<false/>\r\t<key>XCShowSplashScreen</key>\r\t<false/>\r\t<key>XCSmartClosingBrackets</key>\r\t<true/>\r\t<key>XCUseBonjourDistributedBuildServers</key>\r\t<true/>\r\t<key>XCUserBreakpoints</key>\r\t<data>\r\tLy8gISQqVVRGOCokIQp7CglhcmNoaXZlVmVyc2lvbiA9IDE7CgljbGFzc2VzID0gewoJ\r\tfTsKCW9iamVjdHMgPSB7CgovKiBCZWdpbiBYQ0JyZWFrcG9pbnRzQnVja2V0IHNlY3Rp\r\tb24gKi8KCQk0OUQ2MTg2QTEwNkU5REQzMDBGNTIzQUEgLyogWENCcmVha3BvaW50c0J1\r\tY2tldCAqLyA9IHsKCQkJaXNhID0gWENCcmVha3BvaW50c0J1Y2tldDsKCQkJbmFtZSA9\r\tICJHbG9iYWwgQnJlYWtwb2ludHMiOwoJCQlvYmplY3RzID0gKAoJCQkpOwoJCX07Ci8q\r\tIEVuZCBYQ0JyZWFrcG9pbnRzQnVja2V0IHNlY3Rpb24gKi8KCX07Cglyb290T2JqZWN0\r\tID0gNDlENjE4NkExMDZFOUREMzAwRjUyM0FBIC8qIFhDQnJlYWtwb2ludHNCdWNrZXQg\r\tKi87Cn0K\r\t</data>\r\t<key>XC_PerspectiveExtension_ver3</key>\r\t<string>mode1v3</string>\r\t<key>XC_PerspectiveIdentifier_ver3</key>\r\t<string>com.apple.perspectives.project.mode1v3</string>\r\t<key>XcodeDefaultsVersion</key>\r\t<integer>20</integer>\r\t<key>com.apple.ide.smrt.PBXUserSmartGroupsKey.Rev10</key>\r\t<data>\r\tBAtzdHJlYW10eXBlZIHoA4QBQISEhA5OU011dGFibGVBcnJheQCEhAdOU0FycmF5AISE\r\tCE5TT2JqZWN0AIWEAWkCkoSEhBNOU011dGFibGVEaWN0aW9uYXJ5AISEDE5TRGljdGlv\r\tbmFyeQCVlgeShISECE5TU3RyaW5nAZWEASsZUEJYVHJhbnNpZW50TG9jYXRpb25BdFRv\r\tcIaShJqaBmJvdHRvbYaShJqaA2NseoaShJqaFVBCWEZpbGVuYW1lU21hcnRHcm91cIaS\r\thJqaC3ByZWZlcmVuY2VzhpKEl5YHkoSamgZpc0xlYWaGkoSEhAhOU051bWJlcgCEhAdO\r\tU1ZhbHVlAJWEASqElpYAhpKEmpoJcmVjdXJzaXZlhpKEop2klgGGkoSamgRyb290hpKE\r\tmpoJPFBST0pFQ1Q+hpKEmpoFaW1hZ2WGkoSamgtTbWFydEZvbGRlcoaShJqaB2NhblNh\r\tdmWGkqaShJqaBXJlZ2V4hpKEmpooXC4oY3xjcHxjcHB8Q3xDUHxDUFB8bXxtbXxqYXZh\r\tfHNofHNjcHQpJIaShJqaB2ZubWF0Y2iGkoSamgCGhpKEmpoUYWJzb2x1dGVQYXRoVG9C\r\tdW5kbGWGkq+ShJqaC2Rlc2NyaXB0aW9uhpKEmpoQPG5vIGRlc2NyaXB0aW9uPoaShJqa\r\tBG5hbWWGkoSamhRJbXBsZW1lbnRhdGlvbiBGaWxlc4aShJqaCGdsb2JhbElEhpKEmpoY\r\tMUNDMEVBNDAwNDM1MEVGOTAwNDQ0MTBChoaShJeWB5KEmpoEbmFtZYaShJqaF0ludGVy\r\tZmFjZSBCdWlsZGVyIEZpbGVzhpKEmpoZUEJYVHJhbnNpZW50TG9jYXRpb25BdFRvcIaS\r\thJqaBmJvdHRvbYaShJqaC3ByZWZlcmVuY2VzhpKEl5YHkoSamgZpc0xlYWaGkqGShJqa\r\tCXJlY3Vyc2l2ZYaSppKEmpoEcm9vdIaShJqaCTxQUk9KRUNUPoaShJqaBWltYWdlhpKE\r\tmpoLU21hcnRGb2xkZXKGkoSamgdjYW5TYXZlhpKmkoSamgVyZWdleIaSr5KEmpoHZm5t\r\tYXRjaIaShJqaCCouW254XWlihoaShJqaFGFic29sdXRlUGF0aFRvQnVuZGxlhpKEmpoA\r\thpKEmpoLZGVzY3JpcHRpb26GkoSamhA8bm8gZGVzY3JpcHRpb24+hpKEmpoIZ2xvYmFs\r\tSUSGkoSamhgxQ0MwRUE0MDA0MzUwRUY5MDA0MTExMEKGkoSamgNjbHqGkoSamhVQQlhG\r\taWxlbmFtZVNtYXJ0R3JvdXCGhoY\x3D\r\t</data>\r\t<key>kDSMBookmarkManagerAllBookmarksUserDefaultsKey</key>\r\t<array>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleSnowLeopard.JavaReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>Map (Java Platform SE 6)</string>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleSnowLeopard.JavaReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>ArrayList (Java Platform SE 6)</string>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleLegacy.CoreReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>Java 2 Platform SE v1.3.1: Class String</string>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleSnowLeopard.JavaReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>Queue (Java 2 Platform SE 5.0_19)</string>\r\t\t</dict>\r\t\t<dict>\r\t\t\t<key>kDSMBookmarkDocSetIdentifierDictionaryKey</key>\r\t\t\t<string>com.apple.adc.documentation.AppleSnowLeopard.JavaReference</string>\r\t\t\t<key>kDSMBookmarkNameDictionaryKey</key>\r\t\t\t<string>String (Java Platform SE 6)</string>\r\t\t</dict>\r\t</array>\r\t<key>kSearchResultsSubviewWidthAsString</key>\r\t<real>200</real>\r\t<key>kXCDocCheckAndInstallUpdatesAutomatically</key>\r\t<string>1</string>\r\t<key>searchMatchType</key>\r\t<integer>1</integer>\r</dict>\r</plist>\r", Scope = Public
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
