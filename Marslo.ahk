﻿; =============================================================================
;       FileName: Marslo.ahk
;           Desc:
;                 How to get class of windows:
;                       WinGetClass, sClass, A
;                       MsgBox $%sClass%$
;                       if ("TTOTAL_CMD" == sClass)
;                       {
;                         Send xxxx
;                       }
;         Author: Marslo
;          Email: marslo.vida@gmail.com
;        Version: 0.0.6
;     LastChange: 2013-11-27 16:00:00
;        History:
;               0.0.2: Add the shortcut key make command line looks like shell
;               0.0.3: Add the shortcut key for Python interative shell
;               0.0.4: Add ESC to close communicator main window, Total command and onenote
;               0.0.5: Add ESC to Minimize Outlook Main window
;               0.0.6: Add Operations into Console2
;               0.0.7: Add operations for lunchy
;               0.0.8: Make format simple
; =============================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode 2

^!r::
    reload
Return

; Move the windows by Shift+Win+h/l/j/k
+#h::
  WinGetTitle, mTitle, A
  WinGetPos, xpos, ypos, Width, Height, %mTitle%
  WinMove, %mTitle%,, xpos-10, ypos
Return
+#l::
  WinGetTitle, mTitle, A
  WinGetPos, xpos, ypos, Width, Height, %mTitle%
  WinMove, %mTitle%,, xpos+10, ypos
Return
+#k::
  WinGetTitle mTitle, A
  WinGetPos, xpos, ypos, Width, Height, %mTitle%
  WinMove, %mTitle%,, xpos, ypos-10
Return
+#j::
  WinGetTitle mTitle, A
  WinGetPos, xpos, ypos, Width, Height, %mTitle%
  WinMove, %mTitle%,, xpos, ypos+10
Return

; Make quick scroll to the putty window
#IfWinActive, ahk_class PuTTY
; ControlGetFocus, control, A

F10::
    WinGetTitle pTitle
    MsgBox %pTitle%
Return
; Ctrl+k to scroll up by one line
!k::
  WinGetTitle pTitle
  SendMessage, 0x115, 0, 0, , %pTitle%
  ; SendMessage, 0x115, 0, 0, , A
Return

; Ctrl+j to scroll down by one line
!j::
  WinGetTitle pTitle
  SendMessage, 0x115, 1, 0, , %pTitle%
  ; SendMessage, 0x115, 1, 0, , A
Return
#IfWinActive

; Make quick delete to begin in Python interactive shell
#IfWinActive ahk_class TkTopLevel
^u:: Send +{Home}{Del}
^a:: Send {Home}
!b:: Send ^{Left}
!f:: Send ^{Right}
!k:: Send {Up}
!j:: Send {Down}
!h:: Send {Left}
!l:: Send {Right}
#IfWinActive

; Using VIM-KEY against Foxit Reader
#IfWinActive, ahk_class classFoxitReader
^j:: Send {Down}
^k:: Send {Up}
#IfWinActive

; Using VIM-LIKE key against chm reader (c:\Windws\hh.exe)
#IfWinActive, ahk_class HH Parent
+j:: Send {Down}
+k:: Send {Up}
/:: Send ^f
#IfWinActive

; Using VIM-LIKE key against GoldenDict
#IfWinActive, ahk_class QWidget
+j:: Send {Down}
+k:: Send {Up}
+/:: Send ^f
#IfWinActive

; Using VIM-LIKE key against Explorer.exe
#IfWinActive, ahk_class IEFrame
!j:: Send {Down}
!k:: Send {Up}
!l:: Send {Right}
!h:: Send {Left}
+/:: Send ^f
#IfWinActive

; Redefine only when the active window is a cmd
#IfWinActive ahk_class ConsoleWindowClass
^a:: Send {Home}
^e:: Send {End}
^f:: Send {Right}
^b:: Send {Left}
!b:: Send ^{Left}
!f:: Send ^{Right}

^d:: Send {Del}
^k:: Send ^{End}
^u:: Send ^{Home}
^w::
  Send ^+{Left}
  Loop, 50 {
    Send {Del}
  }
Return
!d::
  Send ^+{Right}
  Loop, 50 {
    Send {Backspace}
  }
Return

!k::
  WinGetTitle sTitle
  SendMessage, 0x115, 0, 0, , %sTitle%
Return
!j::
  WinGetTitle sTitle
  SendMessage, 0x115, 1, 0, , %sTitle%
Return

^p:: Send {Up}
^n:: Send {Down}

^v::
  StringReplace clipboard2, clipboard, \r\n, \n, All
  SendInput {Raw}%clipboard2%
Return
#IfWinActive

; Redefine only when the active window is Console2
#IfWinActive, ahk_class Console_2_Main
!k::
  ControlGetFocus, control, A
  SendMessage, 0x115, 0, 0, %control%, A
Return
!j::
  ControlGetFocus, control, A
  SendMessage, 0x115, 1, 0, %control%, A
Return

^v:: Send +{Ins}

^p:: Send {Up}
^n:: Send {Down}

^a:: send {home}
^e:: send {end}

^f:: send {right}
^b:: send {left}

!b:: send ^{left}
!f:: send ^{right}

^d:: send {del}
^k:: send ^{end}
^u:: send ^{home}
^w::
  send ^+{left}
  loop, 50 {
    send {del}
  }
Return
!d::
  send ^+{right}
  loop, 50 {
    send {backspace}
  }
Return
#IfWinActive

#IfWinActive, ahk_class VMPlayerFrame
!j:: send +{PgDn}
!k:: send +{PgUp}
#IfWinActive

; Alt + j/k for scroll up/down in Adobe Reader
#IfWinActive ahk_class AcrobatSDIWindow
!j::
  loop, 2 {
    send {Down}
  }
Return
!K::
  loop, 2{
    send {Up}
  }
Return
#IfWinActive

; Redefine only when the active window is Cygwin
#IfWinActive, ahk_class mintty
; Ctrl+up / Down to scroll command window back and forward
!k::
  WinGetTitle sTitle
  SendMessage, 0x115, 0, 0, , %sTitle%
  ; Send {WheelUp}
Return
!j::
  WinGetTitle sTitle
  SendMessage, 0x115, 1, 0, , %sTitle%
  ; Send {WheelDown}
Return
#IfWinActive

; Make Office Communicator using vim-like shortcut keys
#IfWinActive, ahk_class IMWindowClass
^+e:: Send {End}
^+a:: Send {Home}
^u:: Send +{Home}{Del}
^k:: Send +{End}{Del}
#IfWinActive

; Make <ESC> to close office communicator
#IfWinActive, ahk_class CommunicatorMainWindowClass
Esc:: Send !{F4}
#IfWinActive

; Make <ESC> to close Total command
#IfWinActive, ahk_class TTOTAL_CMD
#e:: Send !{F4}
#IfWinActive

; Make <ESC> to close OneNote
#IfWinActive, ahk_class Framework::CFrame
^w:: Send  ^{Backspace}
!d:: Send  ^{Del}
^e:: Send {End}
^a:: Send {Home}
^u:: Send +{Home}{Del}
^k:: Send +{End}{Del}
^+a:: Send ^{Home}+^{End}
ESC:: WinClose
#IfWinActive

; Close Explorer.exe (My computer) by <ESC>
#IfWinActive, ahk_class CabinetWClass
ESC:: Send !{F4}
^l:: Send !d
#IfWinActive

; Close Tencent Main window by <ESC>
#IfWinActive, ahk_class TXGuiFoundation
ESC:: Send !{F4}
#IfWinActive

; Close Skype Windows by <ESC>
#IfWinActive, Skype
ESC:: Send !{F4}
#IfWinActive

; VIM-Like and Emacs-Like shortcuts in Outlook
#IfWinActive, ahk_class rctrl_renwnd32
^w:: Send  ^{Backspace}
!d:: Send  ^{Del}
^a:: Send  {Home}
^e:: Send  {End}
!j:: Send  {Down}
!k:: Send  {Up}
#IfWinActive

; Minimize the Outlook Main Window by <ESC>
#IfWinActive, Microsoft Outlook
ESC:: Send  !{Space}n
#IfWinActive

; For lunchy
#IfWinActive, ahk_class QTool
^u:: Send +{HOME}{Del}
^k:: Send +{End}{Del}
^a:: Send {Home}
^e:: Send {End}
^w:: Send ^{Backspace}
#IfWinActive

#IfWinActive, ahk_class wcl_manager1
ESC::
{
  IfWinActive, Cisco Jabber
  {
    Send !{F4}
    ; WinMinimize
  } else {
    WinClose
  }
  Return
}
#IfWinActive

#s::
{
  IfWinExist, Cisco Jabber
  {
    WinActivate
    Return
  } else {
    Run "c:\Program Files (x86)\Cisco Systems\Cisco Jabber\CiscoJabber.exe"
  }
  Return
}

; Show Calendar
F9:: Send #b{Up}{Enter}
; Open files
!+f:: run "C:\Program Files (x86)\Foxit Software\Foxit Reader\Foxit Reader.exe"
!+l:: Run "C:\Program Files (x86)\Microsoft Office\Office14\OUTLOOK.EXE" /recycle
^!u:: run "C:\Windows\_Defined\Cygwin64.lnk"
^!p:: Run "c:\Marslo\Study\Books\CI\VCS\Perforce\P4 Command Reference - 2014.02.Dec.pdf"
; !+m:: ; Run %A_WinDir%\hh.exe c:\Marslo\Study\Scritps\MySql\MySQL.Cookbook.2nd.ed.chm
; !+r:: ; Run %A_WinDir%\hh.exe "C:\MarsloProgramFiles\Ruby193\doc\ruby19-core.chm"

!q::
  MaxTimeWait = 1000
  ClipSaved := ClipboardAll
  Clipboard =
  Sendinput ^c
  While(!Clipboard)
  {
    ClipWait,0.1,1
    If A_Index > %MaxTimeWait%
      Break
  }
  Select = %Clipboard% ; 强制转换为纯文本
  IsFile := DllCall("IsClipboardFormatAvailable","int",15)
  Clipboard := ClipSaved
  ClipSaved =
  If IsFile
  {
    Run, "C:\Marslo\MyProgramFiles\Vim\vim74\gvim.exe" "%Select%"
  }
  ; MsgBox, %ClipSaved%
Return

:://cmd:: Run cmd
; Open Windows Task Manager
:://t:: Run taskmgr.exe
; if WinExist Windows "Windows Task Manager"
; {
  ; WinActivate
; } else {
  ; Run "c:\Windows\winsxs\amd64_microsoft-windows-taskmgr_31bf3856ad364e35_6.1.7601.17514_none_7288349cbfd37b08\taskmgr.exe"
  ; Run taskmgr.exe
; }
; Return

:://cc:: Run calc.exe
; if WinExist Windows "Calculator"
; {
  ; WinActivate
; } else {
  ; Run calc.exe
; }
; Return

:://mail::Marslo_Jiao@symantec.com
::engba::engba.symantec.com
::engma::engma.symantec.com
:://vsc::
  Run "C:\Program Files (x86)\VMware\Infrastructure\Virtual Infrastructure Client\Launcher\VpxClient.exe"
  Sleep 2000
  Send Administrator{Tab}ASP@ssw0rd{Enter}
  Sleep 2000
  Send !i
Return
:://jp4::
  Send ssl:perforce.ges.symantec.com:9666{Tab}svc_appbld{Tab}$VC_@ppbld2014{Tab}{Tab}
  Send cd-jenkins-${shiftdown}[{shiftup}JOB_NAME{shiftdown}]{shiftup}
Return
