;
;
;           �������� ��� (��. ����)
;
;        �����������: ���������� �.�.
;        ���� ��������: 20.05.2010
;        ���� ���������� ���������: 23.06.2016
;
;
;
#include <ScreenCapture.au3>

; ���������� ������ � ini-�����
$sessions = IniRead("��������� ���_��.ini", "sessions", "sessions_off", "NotFound")	; ������� ����������� �����
$abonent = 	IniRead("��������� ���_��.ini", "proccess", "abonent", "NotFound") 		; �������� �������� �����������
$admin = 	IniRead("��������� ���_��.ini", "proccess", "admin", "NotFound")     		; �������� �������� ��������������
$exe1 = 	IniRead("��������� ���_��.ini", "exe", "admin", "NotFound")           		; ������ ���� � exe-����� �����������
$exe2 = 	IniRead("��������� ���_��.ini", "exe", "abonent", "NotFound")         		; ������ ���� � exe-����� ��������������
$base = 	IniRead("��������� ���_��.ini", "base", "base", "NotFound")           		; ������ ���� � ����
$pack = 	IniRead("��������� ���_��.ini", "pack", "pack", "NotFound")          		; ������ ���� � ����� � ��������
																					    ; ���-�� �� ������� ������� ������� � ini - ����� ������ �� � ���
$user = "���������� �.�."                                                       		; ������������
$password = ""		  			                                                		; ������ (������ ������ ��� ����������)
$date = @YEAR & "_" & @MON & "_" & @MDAY
$delay = 120	; �������� �������� ��������� ����
if $sessions = 1 Then
; ����������� ���� ������������ ��������� ����������� � ���������������
	RunWait(@SystemDir & "\taskkill.exe /F /IM " & $abonent, @SystemDir, @SW_HIDE)
	RunWait(@SystemDir & "\taskkill.exe /F /IM " & $admin, @SystemDir, @SW_HIDE)
EndIf
; ������ ������� ���_0001
run($exe2 & " /D" & $base & "/N" & $user & "/P" & $password)
Sleep(5000)
If WinWaitActive('�������i �����',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('{ALT}')
send('{DOWN}')
send('{RIGHT}')
send('{RIGHT}')
send('{RIGHT}')
send('{ENTER}')
send('���_0001')
send('{ENTER}')
sleep(30000)
If WinWaitActive("��������� ������� ������� (���_0001)",'OK',$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('{ENTER}')
send('!x')
; ������ �������� � ��������������
run($exe1 & " /D" & $base & "/N" & $user & "/P" & $password)
Sleep(5000)
If WinWaitActive('�������i �����',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('{ALT}')
send('{DOWN}')
send('{RIGHT}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{ENTER}')
send('{ENTER}')
If WinWaitActive('�������i �����','�����: ��������� �������, ���� �� ����',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('!x')
; ���������� ���� ����
run($exe2 & " /D" & $base & "/N" & $user & "/P" & $password)
Sleep(5000)
If WinWaitActive('�������i �����',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('{ALT}')
send('{RIGHT}')
send('{RIGHT}')
send('{RIGHT}')
send('{RIGHT}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{DOWN}')
send('{ENTER}')
If WinWaitActive('���������� �����',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
; �������� ������
send($pack & $date)
send('{ENTER}')
Sleep(5000)
If WinWaitActive('�������i �����',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('!x')

Func ScreenShotExit($pack, $date)
   _ScreenCapture_Capture("" & $pack & "Error_" & $date & ".jpg")
   Exit
EndFunc

