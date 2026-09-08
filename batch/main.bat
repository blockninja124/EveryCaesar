@echo off
setlocal enabledelayedexpansion

set "ALPH=ABCDEFGHIJKLMNOPQRSTUVWXYZ"

set /p "mode=Enter e/d for encrypt/decrypt: "

if /i "%mode%"=="e" (
    set /p "plaintext=Enter plaintext: "
    set /p "key=Enter key: "
    call :encrypt result "!plaintext!" "!key!"
    echo !result!
)

if /i "%mode%"=="d" (
    set /p "ciphertext=Enter ciphertext: "
    set /p "key=Enter key: "
    call :decrypt result "!ciphertext!" "!key!"
    echo !result!
)

endlocal
exit /b 0

:encrypt
setlocal enabledelayedexpansion
set "text=%~2"
set /a "key=%~3"

set "result="
set "i=0"

:encrypt_loop
:: Eww
set "char=!text:~%i%,1!"
if "!char!"=="" goto encrypt_done

call :indexof idx "!char!"
if !idx! equ -1 (
    :: Non-ALPH character so we add it directly
    set "result=!result!!char!"
) else (
    :: double % otherwise it tries to expand
    set /a "idx=(idx+key)%%26"
    call :charat newchar "%ALPH%" !idx!
    set "result=!result!!newchar!"
)

set /a "i+=1"
goto encrypt_loop

:encrypt_done
endlocal & set "%~1=%result%"
exit /b 0

:decrypt
setlocal enabledelayedexpansion
set "text=%~2"
set /a "key=%~3"

set "result="
set "i=0"

:decrypt_loop
:: Ew
set "char=!text:~%i%,1!"
if "!char!"=="" goto decrypt_done

call :indexof idx "!char!"
if !idx! equ -1 (
    set "result=!result!!char!"
) else (
    :: Yeah this is really ugly
    set /a "idx=(idx-key%%26+26)%%26"
    call :charat newchar "%ALPH%" !idx!
    set "result=!result!!newchar!"
)

set /a "i+=1"
goto decrypt_loop

:decrypt_done
endlocal & set "%~1=%result%"
exit /b 0

:: Bash doesn't have indexOf, so we have to do it ourselves :(
:indexof
setlocal enabledelayedexpansion
set "c=%~2"
set "n=-1"
set "k=0"
:indexof_loop
if %k% geq 26 goto indexof_done
set "letter=!ALPH:~%k%,1!"
if /i "!c!"=="!letter!" (
    set "n=%k%"
    goto indexof_done
)
set /a "k+=1"
goto indexof_loop
:indexof_done
endlocal & set "%~1=%n%"
exit /b 0

:: Bash doesn't even have string indexing. Who the heck made this language?
:: Oh right, Microsoft.
:charat
setlocal enabledelayedexpansion
set "s=%~2"
set "pos=%~3"
set "ch=!s:~%pos%,1!"
endlocal & set "%~1=%ch%"
exit /b 0