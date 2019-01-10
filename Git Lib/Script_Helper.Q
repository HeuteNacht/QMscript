[General]
SyntaxVersion=2
BeginHotkey=121
BeginHotkeyMod=0
PauseHotkey=0
PauseHotkeyMod=0
StopHotkey=123
StopHotkeyMod=0
RunOnce=1
EnableWindow=
MacroID=365e70b3-4aaa-4d36-9848-2baae762d9bd
Description=Script_Helper
Enable=0
AutoRun=0
[Repeat]
Type=0
Number=1
[SetupUI]
Type=2
QUI=
[Relative]
SetupOCXFile=
[Comment]

[Script]
Root_URL = "D:\HeuteNacht\anjian\"

Dim Script_Dict                   '创建：属性字典
Set Script_Dict = CreateObject("Scripting.Dictionary")
Script_Dict.Add "choice_wide", "50"    '添加键和项目



//just for test
//Call What_Key_Press()

Call Help2Script(Root_URL & "Open_Shadowverse.txt")
//Msgbox "Complete!" & Cstr(array1(0))

Function Help2Script(URL)
	Dim label,click
	Dim time_start
	Dim time_end
	Dim time_delay
	Dim Text
	Dim sTime1,sTime2
	label=0
	//Msgbox "Press Any Key!"
	Call Plugin.Msg.ShowScrTXT(0, 0, 1024, 768, "Press Any Key...", "0000FF")
/*
//test codes
If Now_KeyPress Then 
GetCursorPos x, y
Msgbox "Your Mouse is in " & x&","&y
Msgbox "You have pressed " & chr(Now_KeyPress)
Call Plugin.Msg.ShowScrTXT(0, 0, 1024, 768, "Next..click..please..", "0000FF")
Msgbox "Complete!" 
End If
*/
	Not_End = 1	//label not end
	Text=""	//try to record the press and mouse position.
	While Not_End
		time_start = Plugin.Sys.GetDateTime()//system data time
		Call Plugin.Msg.ShowScrTXT(0, 0, 1024, 768,chr(Now_KeyPress) & "press in:"&time_start, "0000FF")
		Now_KeyPress = WaitKey()
		sTime1 = Plugin.Sys.GetTime()		//you press "key" then wait for mouse "click",for caculate Delay
		time_end = Plugin.Sys.GetDateTime()
		
		Select Case Now_KeyPress
			Case 80, P, 67, C, 68, D, 82, R
				click = WaitClick()			//wait for click
				GetCursorPos x, y			//get the mouse position
				sTime2 = Plugin.Sys.GetTime()
				time_delay = sTime2 - sTime1
				Text = Text &Cstr(x) &"," &Cstr(y) &"," &chr(Now_KeyPress) &"," &Cstr(time_delay) &chr(13)&chr(10)
				
				//Msgbox "Updata!" & chr(13) & chr(10) & "Text=" & chr(13) & chr(10) & Text
				Call Plugin.Msg.ShowScrTXT(0, 0, 1024, 768, " ?"&Now_KeyPress&" time="&time_end, "0000FF")
			Case 83, S
				label = myFile_Out(URL, Text)
				If label Then 
					Msgbox "Save Success!Go end!"
				Else 
					Msgbox "Failed to Save!"
				End If
				Not_End = 0 //save and end.
			Case 69, E	//If you press "E",and end the loop.
				Not_End = 0
				Msgbox "Script Ending!"
			Case Else
				Msgbox "Useless Key!"&chr(13)&chr(10)&"Press C for click button"&chr(13)&chr(10)&"Press P for Post"&chr(13)&chr(10)&"Press E to end."
				//Msgbox "You have pressed  " & chr(Now_KeyPress)&Now_KeyPress
		End Select
	Wend

End Function

Function What_Key_Press()
Msgbox "Press Any Key!"&chr(13)&chr(10)&"回车实例"
Now_KeyPress = WaitKey()
If Now_KeyPress Then 
Msgbox "You have pressed " & Now_KeyPress & chr(Now_KeyPress)//chr()ACSII转义函数
End If
End Function

//获取目录下：文件名 complete
Function myFile_Out(URL, String_Data)
	Dim label
	label=0	//when write failed return 0,else return 1
	//Msgbox "start open.."&URL
	FileExist = Plugin.File.IsFileExist(URL)
	If FileExist Then
		f = Plugin.File.OpenFile(URL)
		Call Plugin.File.WriteFile(f,String_Data)
		Plugin.File.CloseFile f
		label = 1//successful
	Else 
		Msgbox "No Such File" & chr(13) & chr(10) & "Create?yes?"
		f = Plugin.File.OpenFile(URL)
		Call Plugin.File.WriteFile(f,String_Data)
		Plugin.File.CloseFile f
		label = 2//creat one and successful.
	End If
myFile_Out = label
//Msgbox "Complete!"
End Function
