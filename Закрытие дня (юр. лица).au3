;
;
;           Закрытие дня (юр. лица)
;
;        разработчик: Лаврененко А.Л.
;        дата создания: 20.05.2010
;        дата последнего изменения: 23.06.2016
;
;
;
#include <ScreenCapture.au3>

; считывание данных с ini-файла
$sessions = IniRead("Закінчення дня_юр.ini", "sessions", "sessions_off", "NotFound")	; признак уничтожения сесии
$abonent = 	IniRead("Закінчення дня_юр.ini", "proccess", "abonent", "NotFound") 		; название процесса абонентской
$admin = 	IniRead("Закінчення дня_юр.ini", "proccess", "admin", "NotFound")     		; название процесса администратора
$exe1 = 	IniRead("Закінчення дня_юр.ini", "exe", "admin", "NotFound")           		; полный путь к exe-файлу абонентской
$exe2 = 	IniRead("Закінчення дня_юр.ini", "exe", "abonent", "NotFound")         		; полный путь к exe-файлу администратора
$base = 	IniRead("Закінчення дня_юр.ini", "base", "base", "NotFound")           		; полный путь к базе
$pack = 	IniRead("Закінчення дня_юр.ini", "pack", "pack", "NotFound")          		; полный путь к папке с архивами
																					    ; что-бы не светить логином паролем в ini - файле вводим их в код
$user = "Лаврененко А.Л."                                                       		; пользователь
$password = ""		  			                                                		; пароль (ввести пароль при компиляции)
$date = @YEAR & "_" & @MON & "_" & @MDAY
$delay = 120	; задержка ожидание активации окна
if $sessions = 1 Then
; уничтожение всех существующих процессов абонентской и админинстратора
	RunWait(@SystemDir & "\taskkill.exe /F /IM " & $abonent, @SystemDir, @SW_HIDE)
	RunWait(@SystemDir & "\taskkill.exe /F /IM " & $admin, @SystemDir, @SW_HIDE)
EndIf
; запуск формулы ААА_0001
run($exe2 & " /D" & $base & "/N" & $user & "/P" & $password)
Sleep(5000)
If WinWaitActive('Юридичнi Особи',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('{ALT}')
send('{DOWN}')
send('{RIGHT}')
send('{RIGHT}')
send('{RIGHT}')
send('{ENTER}')
send('ААА_0001')
send('{ENTER}')
sleep(30000)
If WinWaitActive("Виконання формули обробки (ААА_0001)",'OK',$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('{ENTER}')
send('!x')
; полный контроль в администраторе
run($exe1 & " /D" & $base & "/N" & $user & "/P" & $password)
Sleep(5000)
If WinWaitActive('Юридичнi Особи',"",$delay) = 0 Then
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
If WinWaitActive('Юридичнi Особи','РЕЖИМ: Створення таблиці, якщо не існує',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('!x')
; перерасчет всей базы
run($exe2 & " /D" & $base & "/N" & $user & "/P" & $password)
Sleep(5000)
If WinWaitActive('Юридичнi Особи',"",$delay) = 0 Then
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
If WinWaitActive('Збереження даних',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
; создание архива
send($pack & $date)
send('{ENTER}')
Sleep(5000)
If WinWaitActive('Юридичнi Особи',"",$delay) = 0 Then
   ScreenShotExit($pack, $date)
EndIf
send('!x')

Func ScreenShotExit($pack, $date)
   _ScreenCapture_Capture("" & $pack & "Error_" & $date & ".jpg")
   Exit
EndFunc

