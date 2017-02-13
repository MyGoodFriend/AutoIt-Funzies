; Script by MyGoodFriend
; https://github.com/MyGoodFriend

#include <Array.au3>

; Hotkeys
HotKeySet("{HOME}","main")
HotKeySet("{END}","end")

; Global Variables
Global $n = 0  ; Activities counter
Global $h = 0  ; Healing counter
Global $an = 0 ; Adventure counter

; $a = 15, $nPotions = 3 are safe amounts
Global $a = 15  ; # of Adventures to go on
; 5-7 runs is about how long it takes to require 1 health potion(50 HP)
; Can't go on more than 16 adventures because that's how many you
; can fit within the 300,000ms activity cooldown.
Global $nPotions = 3 ; # of Potions to use

Global $prefix = "{#}{!}" ; split into {}{} because autoit doen't like #! together
Global $commands[5] = ['mine','chop','forage','fish','adv'] ; Array of commands
Global $win = "#rpg - Discord" ; name or hWnd of discord window

; Ends the script
Func end()
	; Print total number of activities performed
	ConsoleWrite("  Total Activities: " & $n & @CRLF)
	; Print total number of adventures performed
	ConsoleWrite("  Total Adventures: " & $an & @CRLF)
	; Print total number of heals performed
	ConsoleWrite("  Total Heals: " & $h & @CRLF)
	Exit
EndFunc

; Waits for user input(Hotkeys) after starting
While 1
	Sleep(1000)
WEnd

; Main
Func main()

	While 1

		Activities() ; includes Adventures()
		; If Adventure is > 0
		If $a > 0 Then
			; Go on an adventure $a-1 times
			For $i = 0 to $a-1 ; -1 because it assumes user input
				Adventure()
			Next
			; Heal after $a-1 adventures
			Heal()
		EndIf
		; Calculate how long to sleep for
		; 300,000ms = 300sec = 5min
		; 300,000 - (# of activities * the wait time between each activitity) - tested margin of error.
		Local $sleepFor = 300000 - ($a*16000) - 25000
		Sleep($sleepFor)
	WEnd

EndFunc

; Handles the activities
Func Activities()
		ActivateWindow()

		If WinActive($win) Then
			For $i = 0 To 3
				Send($prefix & $commands[$i])
				Sleep(500)
				Send("{ENTER}")
				Sleep(500)
			Next
		EndIf
		$n = $n + 1 ; Count number of Activities
		ConsoleWrite("Activity#: " & $n & @CRLF)
EndFunc

; Handles Healing
Func Heal()
	ActivateWindow()

	;Send("{#}{!}heal " & $nPotions)
	Send("{#}{!}heal auto")
	Sleep(500)
	Send("{ENTER}")
	Sleep(500)
	$h = $h + 1 ; counter count # of heals
	ConsoleWrite("Healed! " & $h & @CRLF)
EndFunc

; 1 Adventure
Func Adventure()
		ActivateWindow()

		If WinActive($win) Then
			Send($prefix & $commands[4]) ; command 4 is 'adv' (Adventure)
			Sleep(500)
			Send("{ENTER}")
			Sleep(500)
		EndIf

		$an = $an + 1 ; Count number of Adventures
		ConsoleWrite("Adventure#: " & $an & @CRLF)
		Sleep(16000) ; 16sec

EndFunc

; Check if window exists & make it active
Func ActivateWindow()
	If WinExists($win) Then
		WinActivate($win)
	EndIf
EndFunc