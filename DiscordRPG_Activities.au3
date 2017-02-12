; Script by MyGoodFriend
; https://github.com/MyGoodFriend

#include <Array.au3>

; Hotkeys
HotKeySet("{HOME}","main")
HotKeySet("{END}","end")

; Global Variables
Global $n = 0 ; # of activities
Global $h = 0 ; # of healing
Global $prefix = "{#}{!}" ; split into {}{} because autoit doen't like #! together
Global $commands[5] = ['mine','chop','forage','fish','adv'] ; Array of commands
Global $win = "#rpg - Discord" ; name or hWnd of discord window

; Ends the script
Func end()
	; Print total number of activities performed
	ConsoleWrite("Total Activities: " & $n & @CRLF)
	; Print total number of heals performed
	ConsoleWrite("Total Heals: " & 	$h & @CRLF)
	Exit
EndFunc

; Waits for user input(Hotkeys) after starting
While 1
	Sleep(1000)
WEnd

; Main
Func main()

	While 1
		Activities()
		heal()
	WEnd

EndFunc

; Handles the activities
; Moves on to heal() after 7 runs of activities
Func Activities()
	For $i0 = 0 to 6 ; 7 times,
					 ; 7 runs is about how long it takes to require 1 health potion(50 HP)
		If WinExists($win) Then
			WinActivate($win)
		EndIf

		If WinActive($win) Then
			For $i = 0 To 4
				Send($prefix & $commands[$i])
				Sleep(500)
				Send("{ENTER}")
				Sleep(500)
			Next
		EndIf

		$n = $n + 1 ; Count number of Activities
		ConsoleWrite("Activity#: " & $n & @CRLF)
		Sleep(300000) ; 300sec = 5min
	Next

EndFunc

; Handles Healing
Func heal()
	If WinExists($win) Then
		WinActivate($win)
	EndIf

	Send("{#}{!}heal")
	Sleep(500)
	Send("{ENTER}")
	Sleep(500)
	$h = $h + 1
	ConsoleWrite("Healed! " & $h & @CRLF)
EndFunc

