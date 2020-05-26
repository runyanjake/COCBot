;AHK Settings
#NoEnv
SetBatchLines -1
SetTitleMatchMode 2
#SingleInstance Force
SetWorkingDir %A_ScriptDir%


;======================================================================
;Globals

windowName := BlueStacks
tgtWindowAhkType = HwndWrapper
id := 0
exitCondition := 1 ;signifies to stop execution of function (not the whole program)
modeText := No Mode Selected
mode := 0

ACCOUNT_SWITCHING_ENABLED := 1
TIME_BEFORE_ACCOUNT_SWITCH_MS := 108000000 ;3 hour rotations
ACC_MIN_RANGE := 1
ACC_MAX_RANGE := 4
CUR_ACCT := ACC_MIN_RANGE

;======================================================================
;Shortcuts

Hotkey  !^w,    SelectWindow		; ctrl+alt+w to select window to control
Hotkey	!^q,	Stop				; ctrl+alt+q to stop currently running function
Hotkey	!^a,	CocBotHandler 		; ctrl+alt+a to start CocBot	
Hotkey	!^s,	TrainBarchHandler 	; ctrl+alt+a to start training barch	
Hotkey	!^d,	ClearCampsHandler 	; ctrl+alt+a to start clearing camps
Hotkey	!^f,	FlushBarchHandler 	; ctrl+alt+f to deploy barch in battle

;======================================================================
;Main Menu
;======================================================================

Menu, FileMenu, Add, Jump to CocBotLoop, MenuCocBot
Menu, FileMenu, Add, Exit, MenuExit
Menu, HelpMenu, Add, How to Use, MenuHandler
Menu, ModeSelectionMenu, Add, CocBotLoop, MenuCocBot
Menu, ModeSelectionMenu, Add, Train Barch, MenuTrainBarch
Menu, ModeSelectionMenu, Add, ClearCamps, MenuClearCamps
Menu, ModeSelectionMenu, Add, FlushBarch, MenuFlushBarch
Menu, ModeSelectionMenu, Add, Coming Soon, MenuComingSoon ;todo emptycomingsoon method
Menu, BotMenu, Add, File, :FileMenu
Menu, BotMenu, Add, Help, :HelpMenu
Menu, BotMenu, Add, Options, :ModeSelectionMenu


;======================================================================
;Menu Main Screen
;======================================================================

Gui, Destroy
Gui, Show, w400 h230, Shortcuts
Gui, Add, Pic, w380 h215 vpic_get, gcLogo.jpg
Gui, Show,, CocBot v1.0 by pZ_aeriaL
return

;======================================================================
;Menu Handling Methods
;======================================================================

;----------------------------------------------------------------
MenuHandler:
{
	return
}


;======================================================================
;Menu Window Code
;======================================================================

;----------------------------------------------------------------
MenuCocBot:
{
	;stop any active process
	exitCondition := 1

	;set program info
	modeText := CocBot
	mode := 1

	;update gui
	Gui, Destroy
	Gui, Show, w500 h500, Temp
	Gui, Menu, BotMenu
	Gui, Add, Text,, Target Window Title : %thisWindowName%
	Gui, Add, Text,, Windows HWIND is : %id%
	Gui, Add, Text,, CURRENT AVALIBLE OPTIONS: 
	Gui, Add, Text,, ctrl+alt+a to start CocBot
	Gui, Add, Text,, ctrl+alt+w to regrab window and return to main menu
	Gui, Show,, CocBot v1.0 by pZ_aeriaL
	return
}

;----------------------------------------------------------------
MenuTrainBarch:
{
	;stop any active process
	exitCondition := 1

	;set program info
	modeText := TrainBarch
	mode := 2

	;update gui
	Gui, Destroy
	Gui, Show, w500 h500, Temp
	Gui, Menu, BotMenu
	Gui, Add, Text,, Target Window Title : %thisWindowName%
	Gui, Add, Text,, Windows HWIND is : %id%
	Gui, Add, Text,, CURRENT AVALIBLE OPTIONS: 
	Gui, Add, Text,, ctrl+alt+s to train a round of Barch
	Gui, Add, Text,, ctrl+alt+w to regrab window and return to main menu
	Gui, Show,, CocBot v1.0 by pZ_aeriaL
	return
}

;----------------------------------------------------------------
MenuClearCamps:
{
	;stop any active process
	exitCondition := 1

	;set program info
	modeText := ClearCamps
	mode := 3

	;update gui
	Gui, Destroy
	Gui, Show, w500 h500, Temp
	Gui, Menu, BotMenu
	Gui, Add, Text,, Target Window Title : %thisWindowName%
	Gui, Add, Text,, Windows HWIND is : %id%
	Gui, Add, Text,, CURRENT AVALIBLE OPTIONS: 
	Gui, Add, Text,, ctrl+alt+d to clear camps
	Gui, Add, Text,, ctrl+alt+w to regrab window and return to main menu
	Gui, Show,, CocBot v1.0 by pZ_aeriaL
	return
}

;----------------------------------------------------------------
MenuFlushBarch:
{
	;stop any active process
	exitCondition := 1

	;set program info
	modeText := FlushBarch
	mode := 4

	;update gui
	Gui, Destroy
	Gui, Show, w500 h500, Temp
	Gui, Menu, BotMenu
	Gui, Add, Text,, Target Window Title : %thisWindowName%
	Gui, Add, Text,, Windows HWIND is : %id%
	Gui, Add, Text,, CURRENT AVALIBLE OPTIONS: 
	Gui, Add, Text,, ctrl+alt+f to deploy barch while in battle
	Gui, Add, Text,, ctrl+alt+w to regrab window and return to main menu
	Gui, Show,, CocBot v1.0 by pZ_aeriaL
	return
}

;----------------------------------------------------------------
MenuComingSoon:
{
	return ;do nothing till implemented
}


;======================================================================
;COC functionality
;======================================================================

;----------------------------------------------------------------
CocBotHandler:
{
	exitCondition := 0
	Gosub, CocBot
	exitCondition := 1
	return
}
CocBot:
{
	campSize := 200
	startTime := A_TickCount

	while (exitCondition != 1) {
		CustomSleep(2000)
		Gosub, TrainBarch
		CustomSleep(2000)
		Gosub, SearchForBattle
		CustomSleep(5000)
		Gosub, ZoomOutTopRight
		CustomSleep(2000)
		Gosub, BarchDeploy
		CustomSleep(180000) ;3min battle timer
		Gosub, LeaveBattle
		CustomSleep(5000)
		Gosub, ZoomOutTopRight
		CustomSleep(2000)
		Gosub, GoToBuilderBase
		CustomSleep(2000)
		Gosub, BuilderBaseCollectResources
		CustomSleep(2000)
		Gosub, LeaveBuilderBase
		CustomSleep(5000)
		Gosub, ZoomOutTopRight
		CustomSleep(2000)
		Gosub, TrainBarch
		CustomSleep(360000) ;6min for training

		currentTime := A_TickCount
		if ((ACCOUNT_SWITCHING_ENABLED = 1) and ((currentTime - startTime) > TIME_BEFORE_ACCOUNT_SWITCH_MS))
		{
			startTime := currentTime
			CUR_ACCT := CUR_ACCT + 1
			if(curAcct > ACC_HIGH_RANGE)
			{
				curAcct := ACC_MIN_RANGE
			}
			CustomSleep(2000)
			Gosub, ChangeToAccount
		}
	}
	return
}

;----------------------------------------------------------------
TrainBarchHandler:
{
	exitCondition := 0
	Gosub, TrainBarch
	exitCondition := 1
	return
}
TrainBarch:
{
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(2000)

	ControlClick, X90 Y750, ahk_id %id%, , , , NA
	MouseClick, left, 90, 750
	CustomSleep(500)
	ControlClick, X600 Y90, ahk_id %id%, , , , NA
	CustomSleep(500)

	itor := 0
	cap := 200
	while (itor < cap ) and (exitCondition != 1) {
		if(Mod(itor, 2) == 1){
			ControlClick, X200 Y700, ahk_id %id%, , , , NA
		}else{
			ControlClick, X200 Y900, ahk_id %id%, , , , NA
		}
		itor := itor + 1
	}
	ControlClick, X1800 Y80, ahk_id %id%, , , , NA

	return
}

;----------------------------------------------------------------
ClearCampsHandler:
{
	exitCondition := 0
	Gosub, ClearCamps
	exitCondition := 1
	return
}
ClearCamps:
{
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(2000)

	ControlClick, X90 Y750, ahk_id %id%, , , , NA
	CustomSleep(500)
	ControlClick, X600 Y90, ahk_id %id%, , , , NA
	CustomSleep(500)

	itor := 0
	cap := 200
	while (itor < cap ) and (exitCondition != 1) {
		ControlClick, X1810 Y200, ahk_id %id%, , , , NA
		itor := itor + 1
		sleep, 45
	}
	ControlClick, X1800 Y80, ahk_id %id%, , , , NA

	return
}

;----------------------------------------------------------------
ZoomOutTopRight:
{
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(1000)
	ControlSend, , {Down down}, ahk_id %id%
	CustomSleep(1000)
	ControlSend, , {Down up}, ahk_id %id%

	CustomSleep(750)
	MouseClickDrag, left, 949, 400, 302, 789
	CustomSleep(750)
	MouseClickDrag, left, 749, 430, 245, 699
	CustomSleep(50)

	return
}


;----------------------------------------------------------------
SearchForBattle:
{
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(1000)
	ControlClick, X200 Y1000, ahk_id %id%, , , , NA
	CustomSleep(100)
	ControlClick, X1400 Y750, ahk_id %id%, , , , NA
	CustomSleep(5000)
	return
}

;----------------------------------------------------------------
LeaveBattle:
{	
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(1000)
	ControlClick, X90 Y810, ahk_id %id%, , , , NA
	CustomSleep(150)
	ControlClick, X1115 Y680, ahk_id %id%, , , , NA
	CustomSleep(150)
	ControlClick, X900 Y1000, ahk_id %id%, , , , NA
	CustomSleep(2500)
	return
}

;----------------------------------------------------------------
FlushBarchHandler:
{
	exitCondition := 0
	Gosub, ZoomOutTopRight
	Gosub, BarchDeploy
	exitCondition := 1
	return
}
BarchDeploy:
{
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(1000)

	campSize := 200
	startLHSx := 850
	startLHSy := 100
	endLHSx := 150
	endLHSy := 680
	startRHSx := 850
	startRHSy := 100
	endRHSx := 1700
	endRHSy := 680
	rangeLHSx := endLHSx - startLHSx
	rangeLHSy := endLHSy - startLHSy
	rangeRHSx := endRHSx - startRHSx
	rangeRHSy := endRHSy - startRHSy
	clickCount := 0
	itor := 0
	cap := (campSize / 4) + 10

	while itor < cap {
		CustomSleep(50)
		if (Mod(itor, 2) == 1) {
			ControlClick, X300 Y1000, ahk_id %id%, , , , NA
		}else{
			ControlClick, X430 Y1000, ahk_id %id%, , , , NA
		}
		Random, rand, 0, 80
		xLHS := startLHSx + (rangeLHSx * (rand / 100))
		yLHS := startLHSy + (rangeLHSy * (rand / 100))
		xRHS := startRHSx + (rangeRHSx * (rand / 100))
		yRHS := startRHSy + (rangeRHSy * (rand / 100))
		xLHSdelt := (rangeLHSx * 0.05)
		yLHSdelt := (rangeLHSy * 0.05)
		xRHSdelt := (rangeRHSx * 0.05)
		yRHSdelt := (rangeRHSy * 0.05)
		itor2 := 0
		while itor2 < 4 {
			ControlClick, X%xLHS% Y%yLHS%, ahk_id %id%, , , , NA
			ControlClick, X%xRHS% Y%yRHS%, ahk_id %id%, , , , NA
			xLHS := xLHS + xLHSdelt
			yLHS := yLHS + yLHSdelt
			xRHS := xRHS + xRHSdelt
			yRHS := yRHS + yRHSdelt
			itor2 := itor2 + 1
		}
		itor := itor + 1
	}
	return
}

;----------------------------------------------------------------
GoToBuilderBase:
{
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(1000)
	ControlClick, X360 Y1070, ahk_id %id%, , , , NA
	CustomSleep(5)
	ControlClick, X370 Y1070, ahk_id %id%, , , , NA
	CustomSleep(5)
	ControlClick, X380 Y1070, ahk_id %id%, , , , NA
	CustomSleep(5)
	ControlClick, X390 Y1070, ahk_id %id%, , , , NA
	CustomSleep(5)
	ControlClick, X400 Y1070, ahk_id %id%, , , , NA
	CustomSleep(2000)
	return
}

;----------------------------------------------------------------
BuilderBaseCollectResources:
{
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	sleep 1000
	ControlClick, X810 Y520, ahk_id %id%, , , , NA
	CustomSleep(150)
	ControlClick, X830 Y505, ahk_id %id%, , , , NA
	CustomSleep(150)
	ControlClick, X850 Y490, ahk_id %id%, , , , NA
	CustomSleep(150)
	ControlClick, X870 Y470, ahk_id %id%, , , , NA
	CustomSleep(150)
	ControlClick, X890 Y460, ahk_id %id%, , , , NA
	CustomSleep(150)
	ControlClick, X910 Y450, ahk_id %id%, , , , NA
	CustomSleep(150)
	ControlClick, X925 Y440, ahk_id %id%, , , , NA
	return
}

;----------------------------------------------------------------
LeaveBuilderBase:
{	
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(1000)
	ControlClick, X1260 Y420, ahk_id %id%, , , , NA
	CustomSleep(2500)
	return
}

;----------------------------------------------------------------
ChangeToAccount:
{	
	;short-circuit for shutoff
	if (exitCondition = 1)
	{
		return
	}

	CustomSleep(1000)
	ControlClick, X1815 Y750, ahk_id %id%, , , , NA
	CustomSleep(1500)
	ControlClick, X1245 Y200, ahk_id %id%, , , , NA
	CustomSleep(3000)

	baseX := 1440
	baseY := 560
	deltY := 115
	actualX := baseX
	actualY := baseY + (deltY * (CUR_ACCT - 1)) 
	ControlClick, X%actualX% Y%actualY%, ahk_id %id%, , , , NA

	CustomSleep(10000)
	ControlClick, X960 Y990, ahk_id %id%, , , , NA
	MouseClick, left, 960, 990
	CustomSleep(1000)
	
	return
}


;======================================================================
;Utility Functions
;======================================================================

;----------------------------------------------------------------
CustomSleep(ms)
{
	sleep, %ms%
}

;----------------------------------------------------------------
SelectWindow:
{
	;stop any active process
	exitCondition := 1
	;set program info
	modeText := No Mode Selected
	mode := 0

	;Get mouse pos on screen and grab details of program
	MouseGetPos, , , id, control
	WinGetTitle, thisWindowName, ahk_id %id%
	WinGetClass, thisWindowClass, ahk_id %id%
	;MsgBox, ahk_id %id%`nahk_class %thisWindowClass%`n%thisWindowName%`nControl:  %control% ;(debug)
	
	;Match Window type
	if InStr(thisWindowClass, tgtWindowAhkType)
	{
		;msgBox, %thisWindowClass% has %tgtWindowAhkType% in it. ;(debug)
		;Target window found, continue to next screen
		Gui, Destroy
		Gui, Show, w500 h500, Temp
		Gui, Menu, BotMenu
		Gui, Add, Text,, Target Window Title : %thisWindowName%
		Gui, Add, Text,, Windows HWIND is : %id%
		Gui, Add, Text,, To change mode of opperation please select from Option menu.
		Gui, Add, Text,, MODE:  
		Gui, Add, Text, vMode w30, None
		Gui, Show,, CocBot v1.0 by pZ_aeriaL
		;clear mouse clicks to target by sending UP to the keys
		ControlClick, , ahk_id %id%, ,Right, , NAU
		ControlClick, , ahk_id %id%, ,Left, ,NAU
		sleep 500
	}
	Else
	{
		;Program class is not correct
		MsgBox, Selected window is not a Bluestacks window. Please check before you continue.
	}
	return
}

;----------------------------------------------------------------
Stop:
{
	exitCondition := 1
	ControlClick, , ahk_id %id%, ,Right, , NAU
	ControlClick, , ahk_id %id%, ,Left, ,NAU
	;todo create unclicks for down/up arrow buttons
	sleep 500
	return
}

;----------------------------------------------------------------
MenuExit:
{
	ExitApp
}


;======================================================================
;Closing Actions
;======================================================================
ESC:
GuiClose:
GuiEscape:
ExitApp