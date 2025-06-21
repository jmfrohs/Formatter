/*
 * MIT License
 *
 * Copyright (c) 2025 jmfrohs
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

@echo off
setlocal enabledelayedexpansion
set "TEMP_DIR=%TEMP%\CodeFormatter"
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"

:: ===========================================
:: UMFASSENDE FORMATTER-TOOL KONFIGURATION
:: Automatische Downloads für alle wichtigen Programmiersprachen
:: Mit integrierter Lizenz-Verwaltung
:: ===========================================

:: Basis-Verzeichnisse
set "TOOLS_DIR=%~dp0tools"
set "LICENSES_DIR=%~dp0licenses"
set "CONFIG_DIR=%~dp0config"
set "TEMP_DIR=%~dp0temp"
set "LICENSES_FILE=%LICENSES_DIR%\licenses.txt"
set "CONFIG_FILE=%CONFIG_DIR%\settings.ini"

:: Erstelle notwendige Verzeichnisse
if not exist "%TOOLS_DIR%" mkdir "%TOOLS_DIR%"
if not exist "%LICENSES_DIR%" mkdir "%LICENSES_DIR%"
if not exist "%CONFIG_DIR%" mkdir "%CONFIG_DIR%"
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"

:: ===========================================
:: LIZENZ-KONFIGURATION
:: ===========================================
call :init_license_system

:: ===========================================
:: JAVASCRIPT/TYPESCRIPT/WEB ENTWICKLUNG
:: ===========================================
set "PRETTIER_VERSION=3.1.1"
set "PRETTIER_URL=https://github.com/prettier/prettier/releases/download/%PRETTIER_VERSION%/prettier-%PRETTIER_VERSION%.tgz"
set "ESLINT_URL=https://github.com/eslint/eslint/archive/refs/heads/main.zip"
set "BEAUTIFY_JS_URL=https://github.com/beautify-web/js-beautify/archive/refs/heads/main.zip"

:: ===========================================
:: PYTHON
:: ===========================================
set "BLACK_VERSION=23.12.1"
set "BLACK_URL=https://files.pythonhosted.org/packages/source/b/black/black-%BLACK_VERSION%.tar.gz"
set "AUTOPEP8_URL=https://files.pythonhosted.org/packages/source/a/autopep8/autopep8-2.0.4.tar.gz"
set "YAPF_URL=https://github.com/google/yapf/archive/refs/heads/main.zip"
set "ISORT_URL=https://files.pythonhosted.org/packages/source/i/isort/isort-5.13.2.tar.gz"

:: ===========================================
:: JAVA
:: ===========================================
set "GOOGLE_JAVA_FORMAT_VERSION=1.19.2"
set "GOOGLE_JAVA_FORMAT_JAR=google-java-format-%GOOGLE_JAVA_FORMAT_VERSION%-all-deps.jar"
set "GOOGLE_JAVA_FORMAT_URL=https://github.com/google/google-java-format/releases/download/v%GOOGLE_JAVA_FORMAT_VERSION%/%GOOGLE_JAVA_FORMAT_JAR%"
set "ECLIPSE_JDT_URL=https://download.eclipse.org/jdtls/milestones/1.30.1/jdt-language-server-1.30.1-202311291000.tar.gz"

:: ===========================================
:: C/C++
:: ===========================================
set "CLANG_FORMAT_VERSION=17.0.6"
set "CLANG_FORMAT_URL=https://github.com/llvm/llvm-project/releases/download/llvmorg-%CLANG_FORMAT_VERSION%/clang+llvm-%CLANG_FORMAT_VERSION%-x86_64-pc-windows-msvc.tar.xz"
set "ASTYLE_VERSION=3.4.13"
set "ASTYLE_URL=https://sourceforge.net/projects/astyle/files/astyle/astyle_%ASTYLE_VERSION%/AStyle_%ASTYLE_VERSION%_windows.zip"


:: ===========================================
:: WEITERE SPRACHEN (verkürzt für Übersicht)
:: ===========================================
set "RUSTFMT_URL=https://win.rustup.rs/x86_64"
set "GOFMT_URL=https://golang.org/dl/go1.21.5.windows-amd64.zip"
set "PHP_CS_FIXER_VERSION=3.45.0"
set "PHP_CS_FIXER_URL=https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/releases/download/v%PHP_CS_FIXER_VERSION%/php-cs-fixer.phar"

:: ===========================================
:: HAUPTMENÜ
:: ===========================================
:main_menu
cls
if defined MENU_COLOR (
    color %MENU_COLOR%
) else (
    color 0B
)
echo.
echo ===========================
echo   Batch-Code-Formatter
echo         by jmfrohs
echo ===========================
echo.

echo --- FORMATTING ---
echo   1  Format and license single file
echo   2  Format and license directory
echo   3  Format only (no license)
echo.

echo --- LICENSING ---
echo   4  Add license to file
echo   5  License current directory
echo   6  Remove license from file
echo   7  License multiple files
echo   8  Advanced file selection
echo   9  License entire directory (recursive)
echo  10  Complete project setup
echo.

echo --- TOOL INSTALLATION ---
echo  11  JavaScript/TypeScript Tools
echo  12  Python Tools
echo  13  Java Tools
echo  14  C/C++ Tools
echo  15  PHP Tools
echo  16  Rust Tools
echo  17  Go Tools
echo  18  Install all tools
echo  19  Show tool status
echo.

echo --- CONFIGURATION ---
echo  20  Manage license templates
echo  21  License settings
echo  22  Show available licenses
echo  23  Clear cache
echo  24  Reset configuration
echo.

echo --- TXT AND BATCH FILES ---
echo  25  Format TXT file with language detection
echo  26  Batch format multiple TXT files
echo  27  Analyze TXT file (detection only)
echo  28  Format batch file (experimental)
echo  29  Restore last removed license
echo  30  Show last project statistics
echo  31  Settings Menu
echo.

echo   0  Exit
echo.
set /p choice=Choose an option (0-30):

:: TXT-Optionen direkt behandeln
if "%choice%"=="25" call :format_txt_file_menu & goto :main_menu
if "%choice%"=="26" call :batch_format_txt_files & goto :main_menu
if "%choice%"=="27" call :analyze_txt_file & goto :main_menu
if "%choice%"=="28" call :format_batch_file & goto :main_menu
if "%choice%"=="29" call :restore_license_from_backup & goto :main_menu
if "%choice%"=="30" call :show_last_project_stats & goto :main_menu
if "%choice%"=="31" goto :settings_menu
if "%choice%"=="0" exit /b 0

:: Alle anderen Optionen an die Prozess-Funktion übergeben
call :process_choice "%choice%"

:: Nach der Aktion zurück ins Hauptmenü
goto :main_menu

:: Die TXT-Optionen müssen auch in der choice-Verarbeitung ergänzt werden:
if "%choice%"=="25" call :format_txt_file_menu
if "%choice%"=="26" call :batch_format_txt_files
if "%choice%"=="27" call :analyze_txt_file

:: Problem: Das ursprüngliche Script hat wahrscheinlich eine unvollständige
:: Hauptmenü-Funktion, die diese Optionen nicht anzeigt oder verarbeitet.

:settings_menu
cls
echo ===========================
echo        SETTINGS MENU
echo ===========================
echo.
echo [1] Change menu color
echo [2] Toggle backup before licensing (currently: %BACKUP_BEFORE_LICENSE%)
echo [3] Change default author (currently: %DEFAULT_AUTHOR%)
echo [4] Change default year (currently: %DEFAULT_YEAR%)
echo [0] Back to main menu
echo.
set /p "settings_choice=Choose an option: "

if "%settings_choice%"=="1" (
    call :change_menu_color
    goto :settings_menu
)
if "%settings_choice%"=="2" (
    if "%BACKUP_BEFORE_LICENSE%"=="true" (
        call :update_config "BACKUP_BEFORE_LICENSE" "false"
        set "BACKUP_BEFORE_LICENSE=false"
        echo Backup before licensing is now OFF.
    ) else (
        call :update_config "BACKUP_BEFORE_LICENSE" "true"
        set "BACKUP_BEFORE_LICENSE=true"
        echo Backup before licensing is now ON.
    )
    pause
    goto :settings_menu
)
if "%settings_choice%"=="3" (
    set /p "new_author=Enter new default author: "
    call :update_config "DEFAULT_AUTHOR" "%new_author%"
    set "DEFAULT_AUTHOR=%new_author%"
    echo Default author updated!
    pause
    goto :settings_menu
)
if "%settings_choice%"=="4" (
    set /p "new_year=Enter new default year: "
    call :update_config "DEFAULT_YEAR" "%new_year%"
    set "DEFAULT_YEAR=%new_year%"
    echo Default year updated!
    pause
    goto :settings_menu
)
if "%settings_choice%"=="0" goto :main_menu

goto :settings_menu

:change_menu_color
echo.
echo === CHANGE MENU COLOR ===
echo.
echo Available colors:
echo  0 = Black   8 = Gray
echo  1 = Blue    9 = Light Blue
echo  2 = Green   A = Light Green
echo  3 = Aqua    B = Light Aqua
echo  4 = Red     C = Light Red
echo  5 = Purple  D = Light Purple
echo  6 = Yellow  E = Light Yellow
echo  7 = White   F = Bright White
echo.
set /p "color_code=Enter color code (e.g. 0A): "
color %color_code%
call :update_config "MENU_COLOR" "%color_code%"
echo Menu color changed!
pause
exit /b 0

:show_last_project_stats
cls
echo === LAST PROJECT STATISTICS ===
echo.
set "report_file=project_setup_report.txt"
if exist "%report_file%" (
    type "%report_file%"
) else (
    echo No project statistics found!
)
echo.
pause
goto :main_menu

:: Zusätzlich sollte die is_supported_extension Funktion erweitert werden:
:is_supported_extension
set "filename=%~1"
set "result_var=%~2"
set "extension=%~x1"
set "supported=false"

echo %SUPPORTED_EXTENSIONS% | findstr "%extension%" >nul 2>&1
if not errorlevel 1 set "supported=true"

:: WICHTIG: TXT-Dateien explizit unterstützen
if /i "%extension%"==".txt" set "supported=true"

set "%result_var%=%supported%"
exit /b 0

:: ===========================================
:: LIZENZ-SYSTEM INITIALISIERUNG
:: ===========================================
:init_license_system
:: Prüfe ob Lizenz-Datei existiert
if not exist "%LICENSES_FILE%" (
    call :create_default_licenses
)

:: Prüfe ob Konfigurationsdatei existiert
if not exist "%CONFIG_FILE%" (
    call :create_default_config
)

:: Lade Konfiguration
call :load_config
if defined MENU_COLOR color %MENU_COLOR%
exit /b 0

:create_default_licenses
echo Create Default-License-Templates...
(
echo [MIT]
echo /*
echo  * MIT License
echo  *
echo  * Copyright ^(c^) {YEAR} {AUTHOR}
echo  *
echo  * Permission is hereby granted, free of charge, to any person obtaining a copy
echo  * of this software and associated documentation files ^(the "Software"^), to deal
echo  * in the Software without restriction, including without limitation the rights
echo  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo  * copies of the Software, and to permit persons to whom the Software is
echo  * furnished to do so, subject to the following conditions:
echo  *
echo  * The above copyright notice and this permission notice shall be included in all
echo  * copies or substantial portions of the Software.
echo  *
echo  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo  * SOFTWARE.
echo  */
echo.
echo [Apache-2.0]
echo /*
echo  * Licensed to the Apache Software Foundation ^(ASF^) under one
echo  * or more contributor license agreements.  See the NOTICE file
echo  * distributed with this work for additional information
echo  * regarding copyright ownership.  The ASF licenses this file
echo  * to you under the Apache License, Version 2.0 ^(the
echo  * "License"^); you may not use this file except in compliance
echo  * with the License.  You may obtain a copy of the License at
echo  *
echo  *   http://www.apache.org/licenses/LICENSE-2.0
echo  *
echo  * Unless required by applicable law or agreed to in writing,
echo  * software distributed under the License is distributed on an
echo  * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
echo  * KIND, either express or implied.  See the License for the
echo  * specific language governing permissions and limitations
echo  * under the License.
echo  *
echo  * Copyright ^(c^) {YEAR} {AUTHOR}
echo  */
echo.
echo [GPL-3.0]
echo /*
echo  * This program is free software: you can redistribute it and/or modify
echo  * it under the terms of the GNU General Public License as published by
echo  * the Free Software Foundation, either version 3 of the License, or
echo  * ^(at your option^) any later version.
echo  *
echo  * This program is distributed in the hope that it will be useful,
echo  * but WITHOUT ANY WARRANTY; without even the implied warranty of
echo  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
echo  * GNU General Public License for more details.
echo  *
echo  * You should have received a copy of the GNU General Public License
echo  * along with this program.  If not, see ^<http://www.gnu.org/licenses/^>.
echo  *
echo  * Copyright ^(c^) {YEAR} {AUTHOR}
echo  */
echo.
echo [BSD-3-Clause]
echo /*
echo  * Copyright ^(c^) {YEAR}, {AUTHOR}
echo  * All rights reserved.
echo  *
echo  * Redistribution and use in source and binary forms, with or without
echo  * modification, are permitted provided that the following conditions are met:
echo  *
echo  * 1. Redistributions of source code must retain the above copyright notice,
echo  *    this list of conditions and the following disclaimer.
echo  *
echo  * 2. Redistributions in binary form must reproduce the above copyright notice,
echo  *    this list of conditions and the following disclaimer in the documentation
echo  *    and/or other materials provided with the distribution.
echo  *
echo  * 3. Neither the name of the copyright holder nor the names of its
echo  *    contributors may be used to endorse or promote products derived from
echo  *    this software without specific prior written permission.
echo  *
echo  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
echo  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
echo  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
echo  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
echo  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
echo  * DAMAGES ^(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
echo  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION^) HOWEVER
echo  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
echo  * OR TORT ^(INCLUDING NEGLIGENCE OR OTHERWISE^) ARISING IN ANY WAY OUT OF THE USE
echo  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
echo  */
echo.
echo [ISC]
echo /*
echo  * Copyright ^(c^) {YEAR}, {AUTHOR}
echo  *
echo  * Permission to use, copy, modify, and/or distribute this software for any
echo  * purpose with or without fee is hereby granted, provided that the above
echo  * copyright notice and this permission notice appear in all copies.
echo  *
echo  * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
echo  * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
echo  * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
echo  * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
echo  * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
echo  * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
echo  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
echo  */
echo.
echo [Custom]
echo /*
echo  * {CUSTOM_HEADER}
echo  *
echo  * Copyright ^(c^) {YEAR} {AUTHOR}
echo  * {CUSTOM_FOOTER}
echo  */
echo.
echo [None]
echo // Keine Lizenz - Nur Copyright
echo // Copyright ^(c^) {YEAR} {AUTHOR}
) > "%LICENSES_FILE%"
echo Standard-Lizenzen erstellt!
exit /b 0

:create_default_config
echo Creating default configuration...
(
echo [GENERAL]
echo DEFAULT_LICENSE=MIT
echo DEFAULT_AUTHOR=jmfrohs
echo DEFAULT_YEAR=2025
echo AUTO_UPDATE_YEAR=true
echo.
echo [FORMATTING]
echo ADD_LICENSE_AFTER_FORMAT=false
echo BACKUP_BEFORE_LICENSE=true
echo SKIP_BINARY_FILES=true
echo.
echo [CUSTOM]
echo CUSTOM_HEADER=Proprietary Software
echo CUSTOM_FOOTER=All rights reserved.
echo.
echo [FILE_EXTENSIONS]
echo SUPPORTED_EXTENSIONS=.js,.ts,.py,.java,.c,.cpp,.h,.hpp,.php,.rb,.go,.rs,.cs,.kt,.scala,.swift,.pl,.lua,.r,.sh,.sql,.xml,.html,.css,.scss,.sass,.less,.dart,.groovy,.ps1,.vb,.vba
) > "%CONFIG_FILE%"
echo Default configuration created!
pause
exit /b 0

:load_config
:: Lade Konfigurationswerte
for /f "usebackq tokens=1,2 delims==" %%a in ("%CONFIG_FILE%") do (
    if "%%a"=="DEFAULT_LICENSE" set "DEFAULT_LICENSE=%%b"
    if "%%a"=="DEFAULT_AUTHOR" set "DEFAULT_AUTHOR=%%b"
    if "%%a"=="DEFAULT_YEAR" set "DEFAULT_YEAR=%%b"
    if "%%a"=="AUTO_UPDATE_YEAR" set "AUTO_UPDATE_YEAR=%%b"
    if "%%a"=="ADD_LICENSE_AFTER_FORMAT" set "ADD_LICENSE_AFTER_FORMAT=%%b"
    if "%%a"=="BACKUP_BEFORE_LICENSE" set "BACKUP_BEFORE_LICENSE=%%b"
    if "%%a"=="SKIP_BINARY_FILES" set "SKIP_BINARY_FILES=%%b"
    if "%%a"=="CUSTOM_HEADER" set "CUSTOM_HEADER=%%b"
    if "%%a"=="CUSTOM_FOOTER" set "CUSTOM_FOOTER=%%b"
    if "%%a"=="SUPPORTED_EXTENSIONS" set "SUPPORTED_EXTENSIONS=%%b"
)

:: Setze Standardwerte falls nicht gesetzt
if not defined DEFAULT_LICENSE set "DEFAULT_LICENSE=MIT"
if not defined DEFAULT_AUTHOR set "DEFAULT_AUTHOR=jmfrohs"
if not defined DEFAULT_YEAR set "DEFAULT_YEAR=2025"
if not defined AUTO_UPDATE_YEAR set "AUTO_UPDATE_YEAR=true"
exit /b 0

:: ===========================================
:: CHOICE PROCESSING
:: ===========================================
:process_choice
set "choice=%~1"

:: Formatierung
if "%choice%"=="1" call :format_and_license & goto :main_menu
if "%choice%"=="2" call :format_and_license_directory & goto :main_menu
if "%choice%"=="3" call :format_only & goto :main_menu

:: Lizenzierung
if "%choice%"=="4" call :license_single_file & goto :main_menu
if "%choice%"=="5" call :license_current_directory & goto :main_menu
if "%choice%"=="6" call :remove_license_from_file & goto :main_menu
if "%choice%"=="7" call :add_license_to_files & goto :main_menu
if "%choice%"=="8" call :advanced_file_selection & goto :main_menu
if "%choice%"=="9" call :license_entire_directory & goto :main_menu
if "%choice%"=="10" call :complete_project_setup & goto :main_menu

:: Tool-Installation
if "%choice%"=="11" call :install_javascript_tools & goto :main_menu
if "%choice%"=="12" call :install_python_tools & goto :main_menu
if "%choice%"=="13" call :install_java_tools & goto :main_menu
if "%choice%"=="14" call :install_cpp_tools & goto :main_menu
if "%choice%"=="15" call :install_php_tools & goto :main_menu
if "%choice%"=="16" call :install_rust_tools & goto :main_menu
if "%choice%"=="17" call :install_go_tools & goto :main_menu
if "%choice%"=="18" call :install_all_tools & goto :main_menu
if "%choice%"=="19" call :show_all_tool_status & goto :main_menu

:: Konfiguration
if "%choice%"=="20" call :manage_license_templates & goto :main_menu
if "%choice%"=="21" call :change_default_license & goto :main_menu
if "%choice%"=="22" call :list_available_licenses & goto :main_menu
if "%choice%"=="23" call :clear_cache & goto :main_menu
if "%choice%"=="24" call :create_default_config & goto :main_menu

:: TXT- und Batch-Datei Formatierung und weitere Menüpunkte
if "%choice%"=="25" call :format_txt_file_menu & goto :main_menu
if "%choice%"=="26" call :batch_format_txt_files & goto :main_menu
if "%choice%"=="27" call :analyze_txt_file & goto :main_menu
if "%choice%"=="28" call :format_batch_file & goto :main_menu
if "%choice%"=="29" call :restore_license_from_backup & goto :main_menu
if "%choice%"=="30" call :show_last_project_stats & goto :main_menu
if "%choice%"=="31" goto :settings_menu

exit /b 0

:: ===========================================
:: LIZENZ-FUNKTIONEN
:: ===========================================
:add_license_to_file
set "file_path=%~1"
set "license_type=%~2"
set "author=%~3"
set "year=%~4"

:: Erstelle Backup falls aktiviert
if "%BACKUP_BEFORE_LICENSE%"=="true" (
    copy "%file_path%" "%file_path%.bak" >nul 2>&1
    if errorlevel 1 (
        echo Warning: Backup could not be created!
    ) else (
        echo Backup created: %file_path%.bak
    )
)

:: Prüfe ob bereits eine Lizenz vorhanden ist
findstr /C:"Copyright" "%file_path%" >nul 2>&1
if not errorlevel 1 (
    echo Warning: File already contains copyright notice!
    set /p "overwrite=Trotzdem fortfahren? (j/n): "
    if not "!overwrite!"=="j" if not "!overwrite!"=="J" exit /b 0
)

:: Temporäre Datei für Lizenz erstellen
set "temp_license=%TEMP_DIR%\temp_license.tmp"
call :create_license_content "%license_type%" "%author%" "%year%" "%temp_license%"

:: Temporäre Datei für finale Ausgabe
set "temp_file=%TEMP_DIR%\temp_licensed.tmp"

:: Lizenz am Anfang der Datei einfügen
(
    type "%temp_license%"
    echo.
    type "%file_path%"
) > "%temp_file%"

:: Originaldatei ersetzen
move "%temp_file%" "%file_path%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not update file!
    exit /b 1
)

:: Temporäre Lizenz-Datei löschen
if exist "%temp_license%" del "%temp_license%" >nul 2>&1

exit /b 0

:add_license_to_files
cls
echo === ADD LICENSE TO MULTIPLE FILES ===
echo.
echo Enter the file names (comma separated), e.g.:
echo   file1.java,file2.py,file3.cpp
echo.
set /p "file_list=Files: "

set "processed=0"
set "skipped=0"

for %%f in (%file_list%) do (
    if exist "%%f" (
        echo Adding license to: %%f
        call :add_license_to_file "%%f" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
        set /a processed+=1
    ) else (
        echo File not found: %%f
        set /a skipped+=1
    )
)

echo.
echo === SUMMARY ===
echo Files licensed: %processed%
echo Files not found: %skipped%
pause
exit /b 0

:manage_license_templates
cls
echo === MANAGE LICENSE TEMPLATES ===
echo.
echo [1] Show available license templates
echo [2] Edit a license template
echo [3] Add new license template
echo [4] Delete a license template
echo [0] Back to main menu
echo.
set /p "tmpl_choice=Choose an option: "

if "%tmpl_choice%"=="1" (
    echo.
    echo Available license templates:
    dir /b "%LICENSES_DIR%\*.txt"
    pause
    exit /b 0
)
if "%tmpl_choice%"=="2" (
    echo.
    set /p "tmpl_name=Template filename to edit: "
    if exist "%LICENSES_DIR%\%tmpl_name%" (
        notepad "%LICENSES_DIR%\%tmpl_name%"
    ) else (
        echo Template not found!
        pause
    )
    exit /b 0
)
if "%tmpl_choice%"=="3" (
    echo.
    set /p "new_tmpl=New template filename: "
    if exist "%LICENSES_DIR%\%new_tmpl%" (
        echo Template already exists!
    ) else (
        echo.>"%LICENSES_DIR%\%new_tmpl%"

        echo.
        echo Please edit the template to add your license text.
        echo The following placeholders are available:
        echo - {YEAR}: Current year
        echo - {AUTHOR}: Your name
        echo - {CUSTOM_HEADER}: Custom header text
        echo - {CUSTOM_FOOTER}: Custom footer text
        echo.
        notepad "%LICENSES_DIR%\%new_tmpl%"
    )
    pause
    exit /b 0
)
if "%tmpl_choice%"=="4" (
    echo.
    set /p "del_tmpl=Template filename to delete: "
    if exist "%LICENSES_DIR%\%del_tmpl%" (
        del "%LICENSES_DIR%\%del_tmpl%"
        echo Template deleted.
    ) else (
        echo Template not found!
    )
    pause
    exit /b 0
)
exit /b 0

@echo off

:remove_license_from_file
cls
echo === REMOVE LICENSE FROM FILE ===
echo.
set /p "file_path=Enter file path: "
set "file_path=%file_path:"=%"

if not exist "%file_path%" (
    echo ERROR: File not found!
    pause
    exit /b 1
)

:: Backup der Lizenz (nur Lizenzblock) erstellen
set "license_backup=%file_path%.license.bak"
break > "%license_backup%"
set "in_license=0"

REM --- Lizenzblock extrahieren und sichern ---
for /f "usebackq delims=" %%a in ('findstr /n "^" "%file_path%"') do (
    set "line=%%a"
    set "line=!line:*:=!"
    if "!in_license!"=="0" (
        if "!line:~0,2!"=="/*" set "in_license=1"
    )
    if "!in_license!"=="1" (
        echo(!line!>>"%license_backup%"
        if "!line:~-2!"=="*/" set "in_license=0"
    )
)

:: Backup der ursprünglichen Datei erstellen
set "backup_file=%file_path%.backup"
copy "%file_path%" "%backup_file%" >nul
if errorlevel 1 (
    echo ERROR: Could not create backup!
    pause
    exit /b 1
)

echo Removing license blocks from "%file_path%"...

:: Lizenz aus Datei entfernen - verwendet meine erste Version Logic
set "temp_file=%TEMP%\license_temp_%RANDOM%.tmp"
set "in_license_block=false"
set "found_license=false"

for /f "usebackq delims=" %%a in ("%file_path%") do (
    set "line=%%a"
    set "write_line=true"
    
    :: Prüfen ob Lizenzblock beginnt
    echo !line! | findstr /c:"/*" >nul
    if !errorlevel! equ 0 (
        set "in_license_block=true"
        set "found_license=true"
        set "write_line=false"
    )
    
    :: Prüfen ob Lizenzblock endet
    if "!in_license_block!"=="true" (
        echo !line! | findstr /c:"*/" >nul
        if !errorlevel! equ 0 (
            set "in_license_block=false"
            set "write_line=false"
        ) else (
            set "write_line=false"
        )
    )
    
    :: Zeile schreiben wenn nicht im Lizenzblock
    if "!write_line!"=="true" (
        echo !line!>>"%temp_file%"
    )
)

:: Temporäre Datei zur ursprünglichen Datei kopieren
move "%temp_file%" "%file_path%" >nul
if errorlevel 1 (
    echo ERROR: Could not update file!
    :: Backup wiederherstellen
    copy "%backup_file%" "%file_path%" >nul
    del "%backup_file%" >nul 2>&1
    pause
    exit /b 1
)

:: Temporäre Datei aufräumen falls noch vorhanden
if exist "%temp_file%" del "%temp_file%"

if "!found_license!"=="true" (
    echo License header removed successfully.
    echo Original file backup: %backup_file%
    echo License backup saved as: %license_backup%
) else (
    echo No license header found.
    :: Backup löschen wenn keine Änderungen vorgenommen wurden
    del "%backup_file%" >nul 2>&1
    del "%license_backup%" >nul 2>&1
)

pause
exit /b 0

:create_license_content
set "license_name=%~1"
set "author=%~2"
set "year=%~3"
set "output_file=%~4"
set "in_license=false"

:: Lösche Output-Datei falls vorhanden
if exist "%output_file%" del "%output_file%" >nul 2>&1

:: Lese Lizenz-Template und schreibe in Output-Datei
for /f "usebackq delims=" %%a in ("%LICENSES_FILE%") do (
    set "line=%%a"
    if "!line!"=="[%license_name%]" (
        set "in_license=true"
    ) else if "!line:~0,1!"=="[" (
        set "in_license=false"
    ) else if "!in_license!"=="true" (
        if not "!line!"=="" (
            :: Ersetze Platzhalter
            set "processed_line=!line!"
            set "processed_line=!processed_line:{YEAR}=%year%!"""
            set "processed_line=!processed_line:{AUTHOR}=%author%!"""
            if "%license_name%"=="Custom" (
                set "processed_line=!processed_line:{CUSTOM_HEADER}=%CUSTOM_HEADER%!"""
                set "processed_line=!processed_line:{CUSTOM_FOOTER}=%CUSTOM_FOOTER%!"""
            )
            echo !processed_line!>> "%output_file%"
        ) else (
            echo.>> "%output_file%"
        )
    )
)

exit /b 0

:: Entferne die alte get_license_template Funktion und ersetze sie durch diese neue Version
:get_license_template
:: Diese Funktion ist jetzt obsolet - verwende create_license_content stattdessen
echo ERROR: get_license_template is obsolete, use create_license_content
exit /b 1

:license_single_file
echo.
set /p "file_path=Enter file path: "
set "file_path=%file_path:"=%"
if not exist "%file_path%" (
    echo ERROR: File not found!
    pause
    exit /b 1
)

call :add_license_to_file "%file_path%" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
echo.
echo License successfully added to file!
pause
exit /b 0

:add_license_to_file
set "file_path=%~1"
set "license_type=%~2"
set "author=%~3"
set "year=%~4"

:: Erstelle Backup falls aktiviert
if "%BACKUP_BEFORE_LICENSE%"=="true" (
    copy "%file_path%" "%file_path%.bak" >nul 2>&1
    if errorlevel 1 (
        echo Warning: Backup could not be created!
    ) else (
        echo Backup created: %file_path%.bak
    )
)

:: Extrahiere Lizenz-Template
call :get_license_template "%license_type%" license_template

:: Ersetze Platzhalter
set "license_template=!license_template:{YEAR}=%year%!"""
set "license_template=!license_template:{AUTHOR}=%author%!"""
if "%license_type%"=="Custom" (
    set "license_template=!license_template:{CUSTOM_HEADER}=%CUSTOM_HEADER%!"""
    set "license_template=!license_template:{CUSTOM_FOOTER}=%CUSTOM_FOOTER%!"""
)

:: Prüfe ob bereits eine Lizenz vorhanden ist
findstr /C:"Copyright" "%file_path%" >nul 2>&1
if not errorlevel 1 (
    echo WARNING: File already contains copyright notice!
    set /p "overwrite=Trotzdem fortfahren? (j/n): "
    if not "!overwrite!"=="j" if not "!overwrite!"=="J" exit /b 0
)

:: Temporäre Datei erstellen
set "temp_file=%TEMP_DIR%\temp_licensed.tmp"

:: Lizenz am Anfang der Datei einfügen
(
    echo !license_template!
    echo.
    type "%file_path%"
) > "%temp_file%"

:: Originaldatei ersetzen
move "%temp_file%" "%file_path%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Could not update file!
    exit /b 1
)

exit /b 0

:get_license_template
set "license_name=%~1"
set "template_var=%~2"
set "in_license=false"
set "license_content="

for /f "usebackq delims=" %%a in ("%LICENSES_FILE%") do (
    set "line=%%a"
    if "!line!"=="[%license_name%]" (
        set "in_license=true"
    ) else if "!line:~0,1!"=="[" (
        set "in_license=false"
    ) else if "!in_license!"=="true" (
        if defined license_content (
            set "license_content=!license_content!
%%a"
        ) else (
            set "license_content=%%a"
        )
    )
)

set "%template_var%=!license_content!"
exit /b 0

:change_default_license
cls
echo === CHANGE STANDARD LICENSE ===
echo.
echo Available licenses:
call :list_available_licenses
echo.
echo Current standard license: %DEFAULT_LICENSE%
echo.
set /p "new_license=Neue Standard-Lizenz waehlen: "

:: Validiere Lizenz
call :validate_license "%new_license%" valid
if "%valid%"=="false" (
    echo ERROR: Unknown license!
    pause
    exit /b 1
)

:: Aktualisiere Konfiguration
call :update_config "DEFAULT_LICENSE" "%new_license%"
set "DEFAULT_LICENSE=%new_license%"

echo.
echo Standard license successfully changed to “%new_license%”!
pause
exit /b 0

:list_available_licenses
setlocal enabledelayedexpansion
echo.
echo Available licenses:
for /f "usebackq delims=" %%a in ("%LICENSES_FILE%") do (
    set "line=%%a"
    setlocal enabledelayedexpansion
    if "!line:~0,1!"=="[" (
        set "license_name=!line:~1!"
        for /f "delims=]" %%b in ("!license_name!") do (
            echo - %%b
        )
    )
    endlocal
)
endlocal
pause
exit /b 0

:validate_license
set "license_to_check=%~1"
set "result_var=%~2"
set "found=false"

for /f "usebackq delims=" %%a in ("%LICENSES_FILE%") do (
    set "line=%%a"
    if "!line!"=="[%license_to_check%]" (
        set "found=true"
    )
)

set "%result_var%=%found%"
exit /b 0

:update_config
set "key=%~1"
set "value=%~2"
set "temp_config=%TEMP_DIR%\temp_config.ini"

:: Erstelle neue Konfiguration
(
    for /f "usebackq tokens=1,* delims==" %%a in ("%CONFIG_FILE%") do (
        if "%%a"=="%key%" (
            echo %key%=%value%
        ) else (
            echo %%a=%%b
        )
    )
) > "%temp_config%"

:: Ersetze Original
move "%temp_config%" "%CONFIG_FILE%" >nul 2>&1
exit /b 0

:license_current_directory
echo.
echo === LICENSE CURRENT DIRECTORY ===
echo.
echo Directory: %CD%
echo Standard license: %DEFAULT_LICENSE%
echo.
echo Supported file extensions:
echo %SUPPORTED_EXTENSIONS%
echo.
set /p "confirm=Fortfahren? (j/n): "
if not "%confirm%"=="j" if not "%confirm%"=="J" exit /b 0

set "processed=0"
set "skipped=0"

:: Durchsuche alle unterstützten Dateien
for %%f in (*.*) do (
    call :is_supported_extension "%%f" supported
    if "!supported!"=="true" (
        echo Process: %%f
        call :add_license_to_file "%%f" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
        set /a processed+=1
    ) else (
        set /a skipped+=1
    )
)

echo.
echo === SUMMARY ===
echo Processed files: %processed%
echo Skipped files: %skipped%
pause
exit /b 0

:license_entire_directory
cls
echo === LICENSE THE ENTIRE DIRECTORY (RECURSIVELY) ===
echo.
set /p "target_dir=Verzeichnis (leer = aktuell): "
if "%target_dir%"=="" set "target_dir=%CD%"

if not exist "%target_dir%" (
    echo ERROR: Directory not found!
    pause
    exit /b 1
)

echo.
echo Licensing of all supported files in the directory: %target_dir%
echo Standard license: %DEFAULT_LICENSE%
echo.
set /p "confirm=Fortfahren? (j/n): "
if not "%confirm%"=="j" if not "%confirm%"=="J" exit /b 0

set "processed=0"
set "skipped=0"

for /r "%target_dir%" %%f in (*.*) do (
    call :is_supported_extension "%%f" supported
    if "!supported!"=="true" (
        echo Licensing: %%f
        call :add_license_to_file "%%f" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
        set /a processed+=1
    ) else (
        set /a skipped+=1
    )
)

echo.
echo === SUMMARY ===
echo Licensed files: %processed%
echo Skipped files: %skipped%
pause
exit /b 0

:is_supported_extension
set "filename=%~1"
set "result_var=%~2"
set "extension=%~x1"
set "supported=false"

echo %SUPPORTED_EXTENSIONS% | findstr "%extension%" >nul 2>&1
if not errorlevel 1 set "supported=true"

set "%result_var%=%supported%"
exit /b 0

:format_and_license
cls
echo === FORMAT CODE + ADD LICENSE ===
echo.
set /p "file_path=Enter file path (0 = Main Menu): "
set "file_path=%file_path:"=%"
if "%file_path%"=="0" goto :main_menu
if not exist "%file_path%" (
    echo ERROR: File not found!
    pause
    exit /b 1
)

:: Bestimme Dateityp und Formatter
call :get_formatter_for_file "%file_path%" formatter
if "%formatter%"=="" (
    echo WARNING: No formatter available for this file!
    set /p "continue_anyway=Nur Lizenz hinzufügen? (j/n): "
    if not "%continue_anyway%"=="j" if not "%continue_anyway%"=="J" exit /b 0
) else (
    echo Format file with: %formatter%
    call :format_file "%file_path%" "%formatter%"
)

echo Add license...
call :add_license_to_file "%file_path%" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"

echo.
echo File successfully formatted and licensed!
pause
exit /b 0

:format_and_license_directory
cls
echo === FORMAT AND LICENSE DIRECTORY ===
echo.
set /p "dir_path=Enter directory path (leave empty for current): "
if "%dir_path%"=="" set "dir_path=%CD%"
set "dir_path=%dir_path:"=%"
if not exist "%dir_path%" (
    echo ERROR: Directory not found!
    pause
    exit /b 1
)

echo.
echo Directory: %dir_path%
echo Standard license: %DEFAULT_LICENSE%
echo.
echo Supported file extensions:
echo %SUPPORTED_EXTENSIONS%
echo.
set /p "confirm=Proceed? (y/n): "
if /i not "%confirm%"=="y" exit /b 0

set "processed=0"
set "skipped=0"

for %%f in ("%dir_path%\*.*") do (
    call :is_supported_extension "%%f" supported
    if "!supported!"=="true" (
        echo Processing: %%f
        call :get_formatter_for_file "%%f" formatter
        if not "!formatter!"=="" (
            call :format_file "%%f" "!formatter!"
        )
        call :add_license_to_file "%%f" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
        set /a processed+=1
    ) else (
        set /a skipped+=1
    )
)

echo.
echo === SUMMARY ===
echo Processed files: %processed%
echo Skipped files: %skipped%
pause
exit /b 0

:get_formatter_for_file
set "file_path=%~1"
set "result_var=%~2"
set "extension=%~x1"
set "formatter_tool="

if /i "%extension%"==".js" set "formatter_tool=prettier"
if /i "%extension%"==".ts" set "formatter_tool=prettier"
if /i "%extension%"==".py" set "formatter_tool=black"
if /i "%extension%"==".java" set "formatter_tool=google-java-format"
if /i "%extension%"==".c" set "formatter_tool=clang-format"
if /i "%extension%"==".cpp" set "formatter_tool=clang-format"
if /i "%extension%"==".h" set "formatter_tool=clang-format"
if /i "%extension%"==".php" set "formatter_tool=php-cs-fixer"
if /i "%extension%"==".bat" set "formatter_tool=batch"
if /i "%extension%"==".cmd" set "formatter_tool=batch"

set "%result_var%=%formatter_tool%"
exit /b 0

:format_file
set "file_path=%~1"
set "formatter=%~2"

if "%formatter%"=="prettier" (
    where prettier >nul 2>&1
    if not errorlevel 1 (
        prettier --write "%file_path%"
    ) else (
        echo WARNING: Prettier not installed!
        exit /b 1
    )
)

if "%formatter%"=="black" (
    where black >nul 2>&1
    if not errorlevel 1 (
        black "%file_path%"
    ) else (
        echo WARNING: Black not installed!
        exit /b 1
    )
)

if "%formatter%"=="google-java-format" (
    if exist "%TOOLS_DIR%\%GOOGLE_JAVA_FORMAT_JAR%" (
        java -jar "%TOOLS_DIR%\%GOOGLE_JAVA_FORMAT_JAR%" --replace "%file_path%"
    ) else (
        echo WARNING: Google Java Format not installed!
    )
)

if "%formatter%"=="clang-format" (
    where clang-format >nul 2>&1
    if not errorlevel 1 (
        clang-format -i "%file_path%"
    ) else (
        echo WARNING: clang-format not installed!
    )
)

if "%formatter%"=="php-cs-fixer" (
    where php >nul 2>&1
    if not errorlevel 1 (
        if exist "%TOOLS_DIR%\php-cs-fixer.phar" (
            php "%TOOLS_DIR%\php-cs-fixer.phar" fix "%file_path%"
        ) else (
            echo WARNING: PHP-CS-Fixer not installed!
        )
    ) else (
        echo WARNING: PHP not installed!
    )
)

if "%formatter%"=="batch" (
    REM Batch-Datei formatieren: Zeilenenden vereinheitlichen, Leerzeichen am Zeilenende entfernen
    set "temp_file=%TEMP_DIR%\temp_batch_format.bat"
    powershell -Command "(Get-Content -Raw '%file_path%') -replace '\r\n', \"`n\" | Set-Content -NoNewline '%temp_file%'; (Get-Content '%temp_file%') | ForEach-Object { $_.TrimEnd() } | Set-Content '%temp_file%'"
    move /y "%temp_file%" "%file_path%" >nul 2>&1
)

exit /b 0

:: ===========================================
:: FORMATTER-INSTALLATION
:: ===========================================
:install_javascript_tools
echo.
echo === JAVASCRIPT/TYPESCRIPT TOOLS INSTALLIEREN ===
echo.
where npm >nul 2>&1
if errorlevel 1 (
    echo ERROR: npm is not installed!
    echo Please install Node.js first.
    pause
    exit /b 1
)

echo [1/3] Install Prettier...
call npm install -g prettier
echo [2/3] Install ESLint...
call npm install -g eslint
echo [3/3] Install JS-Beautify...
call npm install -g js-beautify

echo.
echo JavaScript/TypeScript tools successfully installed!
pause
exit /b 0

:install_python_tools
echo.
echo === INSTALL PYTHON TOOLS ===
echo.
where pip >nul 2>&1
if errorlevel 1 (
    echo ERROR: pip is not installed!
    pause
    exit /b 1
)

echo [1/4] Install Black...
call pip install black
echo [2/4] Install autopep8...
call pip install autopep8
echo [3/4] Install YAPF...
call pip install yapf
echo [4/4] Install isort...
call pip install isort

echo.
echo Python Tools successfully installed!
pause
exit /b 0

:install_java_tools
echo.
echo === INSTALL JAVA TOOLS ===
echo.
where java >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java is not installed!
    echo Please install Java JDK first.
    pause
    exit /b 1
)

echo [1/2] Download Google Java Format...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%GOOGLE_JAVA_FORMAT_URL%' -OutFile '%TOOLS_DIR%\%GOOGLE_JAVA_FORMAT_JAR%'}"
if errorlevel 1 (
    echo ERROR: Download failed!
    pause
    exit /b 1
)

echo [2/2] Create wrapper script...
(
echo @echo off
echo java -jar "%TOOLS_DIR%\%GOOGLE_JAVA_FORMAT_JAR%" %%*
) > "%TOOLS_DIR%\google-java-format.bat"

echo.
echo Java Tools successfully installed!
echo - Google Java Format: %GOOGLE_JAVA_FORMAT_JAR%
echo - Wrapper-Script: google-java-format.bat
pause
exit /b 0

:install_cpp_tools
echo.
echo === INSTALL C/C++ TOOLS ===
echo.

echo [1/2] Download AStyle...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%ASTYLE_URL%' -OutFile '%TEMP_DIR%\astyle.zip'}"
if errorlevel 1 (
    echo ERROR: AStyle download failed!
    pause
    exit /b 1
)

echo Extract AStyle...
powershell -Command "Expand-Archive -Path '%TEMP_DIR%\astyle.zip' -DestinationPath '%TOOLS_DIR%\astyle' -Force"

echo [2/2] Clang format installation...
echo NOTE: Clang-format is part of the LLVM toolchain.
echo Please install LLVM manually from: https://llvm.org/releases/
echo Or use chocolatey: choco install llvm
echo.
echo Alternatively, you can install Visual Studio Build Tools,
echo which contain clang-format.

echo.
echo C/C++ Tools (partially) installed!
echo - AStyle: %TOOLS_DIR%\astyle\
echo - Clang format: Manual installation required
pause
exit /b 0

:install_php_tools
echo.
echo === INSTALL PHP TOOLS ===
echo.
where php >nul 2>&1
if errorlevel 1 (
    echo ERROR: PHP is not installed!
    echo Please install PHP first.
    pause
    exit /b 1
)

echo [1/1] Download PHP-CS-Fixer...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%PHP_CS_FIXER_URL%' -OutFile '%TOOLS_DIR%\php-cs-fixer.phar'}"
if errorlevel 1 (
    echo ERROR: Download failed!
    pause
    exit /b 1
)

echo Generate Wrapper-Script...
(
echo @echo off
echo php "%TOOLS_DIR%\php-cs-fixer.phar" %%*
) > "%TOOLS_DIR%\php-cs-fixer.bat"

echo.
echo PHP Tools successfully installed!
echo - PHP-CS-Fixer: php-cs-fixer.phar
echo - Wrapper-Script: php-cs-fixer.bat
pause
exit /b 0

:install_rust_tools
echo.
echo === INSTALL RUST TOOLS ===
echo.
where rustc >nul 2>&1
if errorlevel 1 (
    echo WARNING: Rust is not installed!
    echo.
    echo [1] Install Rust via rustup
    echo [2] Install rustfmt only (if Rust already exists)
    echo [0] Cancel
    echo.
    set /p "rust_choice=Choose an Option: "

    if "!rust_choice!"=="1" (
        echo Download rustup...
        powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%RUSTFMT_URL%' -OutFile '%TEMP_DIR%\rustup-init.exe'}"
        echo.
        echo Starting rustup-init...
        "%TEMP_DIR%\rustup-init.exe"
        echo.
        echo Please restart the script after the Rust installation.
        pause
        exit /b 0
    ) else if "!rust_choice!"=="2" (
        echo Try to install rustfmt...
    ) else (
        exit /b 0
    )
)

echo [1/1] Install/update rustfmt...
where rustup >nul 2>&1
if not errorlevel 1 (
    call rustup component add rustfmt
) else (
    echo WARNING: rustup not found, rustfmt may already be available.
)

echo.
echo Rust Tools installation completed!
echo - rustfmt should now be available
pause
exit /b 0

:install_go_tools
echo.
echo === INSTALL GO TOOLS ===
echo.
where go >nul 2>&1
if errorlevel 1 (
    echo WARNING: Go is not installed!
    echo.
    echo Do you want to download and install Go?
    set /p "go_install=Start download? (y/n): "

    if "!go_install!"=="j" if "!go_install!"=="J" (
        echo Download Go...
        powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%GOFMT_URL%' -OutFile '%TEMP_DIR%\go.zip'}"
        echo.
        echo Go was downloaded to: %TEMP_DIR%\go.zip
        echo Please install Go manually and restart the script.
        pause
        exit /b 0
    ) else (
        echo Installation canceled.
        pause
        exit /b 0
    )
)

echo [1/1] Check gofmt...
where gofmt >nul 2>&1
if errorlevel 1 (
    echo ERROR: gofmt not found!
    echo gofmt should be installed automatically with Go.
) else (
    echo gofmt is already available!
)

echo.
echo Go Tools status checked!
echo - gofmt: Available (part of the Go installation)
pause
exit /b 0

:install_all_tools
echo.
echo === INSTALL ALL FORMATTER ===
echo.
echo This will install all available formatters.
echo This may take some time...
echo.
set /p "confirm_all=Continue? (y/n): "
if not "%confirm_all%"=="y" if not "%confirm_all%"=="Y" exit /b 0

echo.
echo ========================================
call :install_javascript_tools
echo ========================================
call :install_python_tools
echo ========================================
call :install_java_tools
echo ========================================
call :install_cpp_tools
echo ========================================
call :install_php_tools
echo ========================================
call :install_rust_tools
echo ========================================
call :install_go_tools
echo ========================================

echo.
echo === INSTALLATION COMPLETED ===
echo All available tools have been installed!
pause
exit /b 0

:show_all_tool_status
cls
echo === STATUS OF ALL TOOLS ===
echo.

echo JavaScript/TypeScript:
where prettier >nul 2>&1 && echo [OK] Prettier || echo [--] Prettier
where eslint >nul 2>&1 && echo [OK] ESLint || echo [--] ESLint
where js-beautify >nul 2>&1 && echo [OK] JS-Beautify || echo [--] JS-Beautify

echo.
echo Python:
where black >nul 2>&1 && echo [OK] Black || echo [--] Black
where autopep8 >nul 2>&1 && echo [OK] autopep8 || echo [--] autopep8
where yapf >nul 2>&1 && echo [OK] YAPF || echo [--] YAPF
where isort >nul 2>&1 && echo [OK] isort || echo [--] isort

echo.
echo Java:
if exist "%TOOLS_DIR%\%GOOGLE_JAVA_FORMAT_JAR%" (echo [OK] Google Java Format) else (echo [--] Google Java Format)

echo.
echo C/C++:
where clang-format >nul 2>&1 && echo [OK] clang-format || echo [--] clang-format
if exist "%TOOLS_DIR%\astyle\" (echo [OK] AStyle) else (echo [--] AStyle)

echo.
echo PHP:
if exist "%TOOLS_DIR%\php-cs-fixer.phar%" (echo [OK] PHP-CS-Fixer) else (echo [--] PHP-CS-Fixer)

echo.
echo Rust:
where rustfmt >nul 2>&1 && echo [OK] rustfmt || echo [--] rustfmt

echo.
echo Go:
where gofmt >nul 2>&1 && echo [OK] gofmt || echo [--] gofmt

echo.
echo Lizenz-System:
if exist "%LICENSES_FILE%" (echo [OK] License-Templates) else (echo [--] License-Templates)
if exist "%CONFIG_FILE%" (echo [OK] Configuration) else (echo [--] Configuration)

echo.
pause
exit /b 0

:clear_cache
echo.
echo === CLEAR CACHE ===
echo.
if exist "%TEMP_DIR%" (
    echo Delete temporary files...
    rd /s /q "%TEMP_DIR%" >nul 2>&1
    mkdir "%TEMP_DIR%"
    echo Temporary files deleted!
) else (
    echo No cache available.
)

echo.
echo Cache successfully cleared!
pause
exit /b 0

:: ===========================================
:: ERWEITERTE DATEI-ERKENNUNG FÜR TXT-DATEIEN
:: ===========================================

:detect_language_in_txt
set "file_path=%~1"
set "result_var=%~2"
set "detected_language="

echo Analyze file content from: %file_path%
echo.

:: Prüfe die ersten 50 Zeilen der Datei auf Programmiersprachen-Indikatoren
set "line_count=0"
for /f "usebackq delims=" %%a in ("%file_path%") do (
    set /a line_count+=1
    set "line=%%a"

    :: JavaScript/TypeScript Erkennung
    echo !line! | findstr /i /C:"function\|const\|let\|var\|=>\|console\.log\|require\|import.*from\|export" >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=javascript"

    :: Python Erkennung
    echo !line! | findstr /i /C:"def \|import \|from.*import\|print(\|if.*:\|elif\|:\s*$\|#.*python" >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=python"

    :: Java Erkennung
    echo !line! | findstr /i /C:"public class\|private\|protected\|public static void main\|System\.out\|package " >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=java"

    :: C/C++ Erkennung
    echo !line! | findstr /i /C:"#include\|int main\|printf\|std::\|cout\|cin\|#define" >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=cpp"

    :: PHP Erkennung
    echo !line! | findstr /i /C:"<?php\|<?=\|echo \|$.*=\|function.*{" >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=php"

    :: Rust Erkennung
    echo !line! | findstr /i /C:"fn \|let mut\|use std\|cargo\|#\[derive\]" >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=rust"

    :: Go Erkennung
    echo !line! | findstr /i /C:"package main\|func \|import \"\|fmt\.Print\|go \|defer " >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=go"

    :: SQL Erkennung
    echo !line! | findstr /i /C:"SELECT\|INSERT\|UPDATE\|DELETE\|CREATE TABLE\|DROP\|ALTER" >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=sql"

    :: HTML Erkennung
    echo !line! | findstr /i /C:"<html\|<head\|<body\|<div\|<script\|<!DOCTYPE" >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=html"

    :: CSS Erkennung
    echo !line! | findstr /i /C:"{.*}\|\..*{\|#.*{\|@media\|@import" >nul 2>&1
    if not errorlevel 1 if "%detected_language%"=="" set "detected_language=css"

    :: Begrenze die Analyse auf die ersten 50 Zeilen für Performance
    if !line_count! geq 50 goto :language_detection_done
)

:language_detection_done
set "%result_var%=%detected_language%"
exit /b 0

:advanced_file_selection
cls
echo === ADVANCED FILE SELECTION ===
echo.
echo Enter the file names (separated by commas), e.g:
echo   file1.java,file2.py,file3.cpp
echo.
set /p "file_list=Dateien: "

:: Trenne die Dateinamen und verarbeite sie einzeln
for %%f in (%file_list%) do (
    if exist "%%f" (
        echo Process: %%f
        call :add_license_to_file "%%f" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
        echo License added to %%f
    ) else (
        echo File not found: %%f
    )
)

echo.
echo Advanced file selection completed!
pause
exit /b 0

:format_only
cls
echo === FORMAT ONLY (WITHOUT LICENSE) ===
echo.
set /p "file_path=Enter file path: "
set "file_path=%file_path:"=%"
if not exist "%file_path%" (
    echo ERROR: File not found!
    pause
    exit /b 1
)

:: Vorher-Backup anlegen
set "backup_file=%file_path%.formatbak"
copy "%file_path%" "%backup_file%" >nul 2>&1

:: Bestimme Dateityp und Formatter
call :get_formatter_for_file "%file_path%" formatter
if "%formatter%"=="" (
    echo WARNING: No formatter available for this file!
    pause
    exit /b 0
) else (
    echo Format file with: %formatter%
    call :format_file "%file_path%" "%formatter%"
)

echo.
echo File formatted successfully!

:: Änderungen anzeigen
echo.
set /p "show_diff=Show all changes? (y/n): "
if /i "%show_diff%"=="y" (
    echo.
    echo Showing code changes:
    fc "%backup_file%" "%file_path%"
    echo.
    echo Press any key to continue...
    pause >nul
)
if exist "%backup_file%" del "%backup_file%" >nul 2>&1

exit /b 0

:: Bestimme Dateityp und Formatter
call :get_formatter_for_file "%file_path%" formatter
if "%formatter%"=="" (
    echo WARNING: No formatter available for this file!
    pause
    exit /b 0
) else (
    echo Format file with: %formatter%
    call :format_file "%file_path%" "%formatter%"
)

echo.
echo File formatted successfully!
pause
exit /b 0

:analyze_txt_file
cls
echo === ANALYZE TXT FILE (RECOGNITION ONLY) ===
echo.
set /p "txt_file_path=Enter the path to the TXT file: "

if not exist "%txt_file_path%" (
    echo ERROR: File not found!
    pause
    exit /b 1
)

:: Prüfe ob es wirklich eine TXT-Datei ist
if /i not "%txt_file_path:~-4%"==".txt" (
    echo WARNING: File has no .txt extension!
    set /p "continue_anyway=Continue? (y/n): "
    if /i not "!continue_anyway!"=="y" if /i not "!continue_anyway!"=="Y" exit /b 0
)

:: Sprache erkennen
call :detect_language_in_txt "%txt_file_path%" detected_lang

echo.
if "%detected_lang%"=="" (
    echo No programming language recognized.
) else (
    echo Recognized language: %detected_lang%
)
pause
exit /b 0

:batch_format_txt_files
cls
echo === BATCH FORMAT MULTIPLE TXT FILES ===
echo.
echo Enter the file names (separated by commas), e.g:
echo   file1.txt,file2.txt,file3.txt
echo.
set /p "file_list=Files: "

for %%f in (%file_list%) do (
    if exist "%%f" (
        echo.
        echo Process: %%f
        call :format_txt_file_menu_batch "%%f"
    ) else (
        echo File not found: %%f
    )
)

echo.
echo Batch formatting completed!
pause
exit /b 0

:format_batch_file
cls
echo === FORMAT BATCH FILE (EXPERIMENTAL) ===
echo.
set /p "file_path=Path to the .bat or .cmd file: "
set "file_path=%file_path:"=%"
if not exist "%file_path%" (
    echo ERROR: File not found!
    pause
    exit /b 1
)

:: PowerShell entfernt Leerzeichen am Zeilenende und vereinheitlicht Zeilenenden
set "temp_file=%TEMP_DIR%\temp_batch_format.bat"
powershell -Command "(Get-Content -Raw '%file_path%') -replace '\r\n', \"`n\" | Set-Content -NoNewline '%temp_file%'; (Get-Content '%temp_file%') | ForEach-Object { $_.TrimEnd() } | Set-Content '%temp_file%'"

move /y "%temp_file%" "%file_path%" >nul 2>&1
if errorlevel 1 (
    echo ERROR: File could not be updated!
    pause
    exit /b 1
)

echo Batch file formatted (spaces removed, line endings standardized).

:: Lizenz hinzufügen anbieten
echo.
set /p "add_license=Add license to this file? (y/n): "
if /i "%add_license%"=="y" (
    call :add_license_to_file "%file_path%" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
    echo License successfully added!
)

pause
exit /b 0

:format_txt_file_menu_batch
set "txt_file_path=%~1"

:: Prüfe ob es wirklich eine TXT-Datei ist
if /i not "%txt_file_path:~-4%"==".txt" (
    echo WARNING: %%f does not have a .txt extension! Skip.
    exit /b 0
)

:: Programmiersprache abfragen
echo.
echo Please select programming language for %%f:
echo [1] JavaScript/TypeScript
echo [2] Python
echo [3] Java
echo [4] C/C++
echo [5] PHP
echo [6] Rust
echo [7] Go
echo [8] SQL
echo [9] HTML
echo [10] CSS
echo [11] Plaintext (No formatting)
echo.
set /p "manual_choice=Select language (0 = Main Menu): "

set "detected_lang="
if "%manual_choice%"=="1" set "detected_lang=javascript"
if "%manual_choice%"=="2" set "detected_lang=python"
if "%manual_choice%"=="3" set "detected_lang=java"
if "%manual_choice%"=="4" set "detected_lang=cpp"
if "%manual_choice%"=="5" set "detected_lang=php"
if "%manual_choice%"=="6" set "detected_lang=rust"
if "%manual_choice%"=="7" set "detected_lang=go"
if "%manual_choice%"=="8" set "detected_lang=sql"
if "%manual_choice%"=="9" set "detected_lang=html"
if "%manual_choice%"=="10" set "detected_lang=css"
if "%manual_choice%"=="11" set "detected_lang=plaintext"
if "%manual_choice%"=="0" goto :main_menu

if "%detected_lang%"=="plaintext" (
    echo File is treated as plain text - no formatting possible.
    exit /b 0
)

:: Hole den passenden Formatter
call :get_formatter_for_language "%detected_lang%" formatter_tool

if "%formatter_tool%"=="" (
    echo ERROR: No formatter available for %detected_lang%!
    exit /b 1
)

:: Temporäre Datei mit korrekter Erweiterung erstellen
call :get_temp_extension "%detected_lang%" temp_ext
set "temp_file=%TEMP_DIR%\temp_format%temp_ext%"

echo Create temporary file: %temp_file%
copy "%txt_file_path%" "%temp_file%" >nul 2>&1

echo Format as %detected_lang% with %formatter_tool%...
call :format_file "%temp_file%" "%formatter_tool%"

if not errorlevel 1 (
    echo Copy formatted file back...
    copy "%temp_file%" "%txt_file_path%" >nul 2>&1
    echo Formatting successful!
) else (
    echo ERROR: Formatting failed!
)

:: Aufräumen
if exist "%temp_file%" del "%temp_file%" >nul 2>&1

:: NEU: Nach Lizenzierung fragen
echo.
set /p "add_license=Add license to this file? (y/n): "
if /i "%add_license%"=="y" (
    call :add_license_to_file "%txt_file_path%" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
    echo License successfully added!
)

exit /b 0

:format_txt_file
set "file_path=%~1"

echo.
echo === TXT FILE FORMATTING ===
echo Datei: %file_path%
echo.

:: Backup vor dem Formatieren anlegen
set "backup_file=%file_path%.formatbak"
copy "%file_path%" "%backup_file%" >nul 2>&1

:: Sprache erkennen
call :detect_language_in_txt "%file_path%" detected_lang

if "%detected_lang%"=="" (
    echo No programming language recognized.
    echo.
    echo [1] Manually select language
    echo [2] Treat as plain text
    echo [3] Skip file
    echo [0] Cancel
    echo.
    set /p "txt_choice=Choose an Option: "

    if "!txt_choice!"=="1" call :manual_language_selection detected_lang
    if "!txt_choice!"=="2" set "detected_lang=plaintext"
    if "!txt_choice!"=="3" exit /b 0
    if "!txt_choice!"=="0" exit /b 1
) else (
    echo Recognized language: %detected_lang%
    echo.
    set /p "confirm_lang=Korrekt? (j/n): "
    if "!confirm_lang!"=="n" if "!confirm_lang!"=="N" (
        call :manual_language_selection detected_lang
    )
)

if "%detected_lang%"=="plaintext" (
    echo File is treated as plain text - no formatting possible.
    if exist "%backup_file%" del "%backup_file%" >nul 2>&1
    exit /b 0
)

:: Hole den richtigen Formatter für die erkannte Sprache
call :get_formatter_for_language "%detected_lang%" formatter_tool

if "%formatter_tool%"=="" (
    echo ERROR: No formatter available for %detected_lang%!
    if exist "%backup_file%" del "%backup_file%" >nul 2>&1
    exit /b 1
)

:: Temporäre Datei mit korrekter Erweiterung erstellen
call :get_temp_extension "%detected_lang%" temp_ext
set "temp_file=%TEMP_DIR%\temp_format%temp_ext%"

echo Create temporary file: %temp_file%
copy "%file_path%" "%temp_file%" >nul 2>&1

echo Format as %detected_lang% with %formatter_tool%...
call :format_file "%temp_file%" "%formatter_tool%"

if not errorlevel 1 (
    echo Copy formatted file back...
    copy "%temp_file%" "%file_path%" >nul 2>&1
    echo Formatting successful!
) else (
    echo ERROR: Formatting failed!
)

:: Aufräumen
if exist "%temp_file%" del "%temp_file%" >nul 2>&1

:: Änderungen anzeigen
echo.
set /p "show_diff=Show all changes? (y/n): "
if /i "%show_diff%"=="y" (
    echo.
    echo Showing code changes:
    fc "%backup_file%" "%file_path%"
    echo.
    echo Press any key to continue...
    pause >nul
)
if exist "%backup_file%" del "%backup_file%" >nul 2>&1

exit /b 0

:manual_language_selection
set "result_var=%~1"

echo.
echo === MANUAL LANGUAGE SELECTION ===
echo.
echo [1]  JavaScript/TypeScript
echo [2]  Python
echo [3]  Java
echo [4]  C/C++
echo [5]  PHP
echo [6]  Rust
echo [7]  Go
echo [8]  SQL
echo [9]  HTML
echo [10] CSS
echo [11] Plaintext (No formatting)
echo [0] Cancel
echo.
set /p "manual_choice=Sprache wählen: "

if "%manual_choice%"=="1" set "%result_var%=javascript"
if "%manual_choice%"=="2" set "%result_var%=python"
if "%manual_choice%"=="3" set "%result_var%=java"
if "%manual_choice%"=="4" set "%result_var%=cpp"
if "%manual_choice%"=="5" set "%result_var%=php"
if "%manual_choice%"=="6" set "%result_var%=rust"
if "%manual_choice%"=="7" set "%result_var%=go"
if "%manual_choice%"=="8" set "%result_var%=sql"
if "%manual_choice%"=="9" set "%result_var%=html"
if "%manual_choice%"=="10" set "%result_var%=css"
if "%manual_choice%"=="11" set "%result_var%=plaintext"
if "%manual_choice%"=="0" goto :main_menu

exit /b 0

:get_temp_extension
set "language=%~1"
set "result_var=%~2"
set "extension="

if "%language%"=="javascript" set "extension=.js"
if "%language%"=="python" set "extension=.py"
if "%language%"=="java" set "extension=.java"
if "%language%"=="cpp" set "extension=.cpp"
if "%language%"=="php" set "extension=.php"
if "%language%"=="rust" set "extension=.rs"
if "%language%"=="go" set "extension=.go"
if "%language%"=="sql" set "extension=.sql"
if "%language%"=="html" set "extension=.html"
if "%language%"=="css" set "extension=.css"
if "%extension%"=="" set "extension=.txt"

set "%result_var%=%extension%"
exit /b 0

:get_formatter_for_language
set "language=%~1"
set "result_var=%~2"
set "formatter_tool="

if "%language%"=="javascript" set "formatter_tool=prettier"
if "%language%"=="python" set "formatter_tool=black"
if "%language%"=="java" set "formatter_tool=google-java-format"
if "%language%"=="cpp" set "formatter_tool=clang-format"
if "%language%"=="php" set "formatter_tool=php-cs-fixer"
if "%language%"=="rust" set "formatter_tool=rustfmt"
if "%language%"=="go" set "formatter_tool=gofmt"
if "%language%"=="sql" set "formatter_tool=sql-formatter"
if "%language%"=="html" set "formatter_tool=prettier"
if "%language%"=="css" set "formatter_tool=prettier"

set "%result_var%=%formatter_tool%"
exit /b 0

:: Erweiterte is_supported_extension Funktion
:is_supported_extension_enhanced
set "filename=%~1"
set "result_var=%~2"
set "extension=%~x1"
set "supported=false"

:: Prüfe normale unterstützte Erweiterungen
echo %SUPPORTED_EXTENSIONS% | findstr "%extension%" >nul 2>&1
if not errorlevel 1 set "supported=true"

:: Spezielle Behandlung für .txt Dateien
if /i "%extension%"==".txt" set "supported=true"

set "%result_var%=%supported%"
exit /b 0

:: Erweiterte Menü-Option hinzufügen
:add_txt_menu_option
echo.
echo === TXT FILE FORMATTING ===
echo [25] Format TXT file with language recognition
echo [26] Batch format multiple TXT files
echo [27] Analyze TXT file (recognition only)
echo.
exit /b 0

:format_txt_file_menu
setlocal enabledelayedexpansion
echo.
echo === TXT FILE FORMATTING ===
echo.
set /p "txt_file_path=Pfad zur TXT-Datei eingeben: "
set "txt_file_path=%txt_file_path:"=%"   REM <-- Anführungszeichen entfernen

:: Prüfe ob Datei existiert
if not exist "!txt_file_path!" (
    echo ERROR: File not found: !txt_file_path!
    pause
    endlocal
    exit /b 1
)
:: Prüfe ob es wirklich eine TXT-Datei ist
if /i not "!txt_file_path:~-4!"==".txt" (
    echo WARNING: File has no .txt extension!
    set /p "continue_anyway=Continue anyway? (y/n): "
    if /i not "!continue_anyway!"=="y" exit /b 0
)

:: Programmiersprache abfragen
echo.
echo Please select programming language:
echo [1] JavaScript/TypeScript
echo [2] Python
echo [3] Java
echo [4] C/C++
echo [5] PHP
echo [6] Rust
echo [7] Go
echo [8] SQL
echo [9] HTML
echo [10] CSS
echo [11] Plaintext (No formatting)
echo [0] Cancel
echo.
set /p "manual_choice=Choose language: "

set "detected_lang="
if "!manual_choice!"=="1" set "detected_lang=javascript"
if "!manual_choice!"=="2" set "detected_lang=python"
if "!manual_choice!"=="3" set "detected_lang=java"
if "!manual_choice!"=="4" set "detected_lang=cpp"
if "!manual_choice!"=="5" set "detected_lang=php"
if "!manual_choice!"=="6" set "detected_lang=rust"
if "!manual_choice!"=="7" set "detected_lang=go"
if "!manual_choice!"=="8" set "detected_lang=sql"
if "!manual_choice!"=="9" set "detected_lang=html"
if "!manual_choice!"=="10" set "detected_lang=css"
if "!manual_choice!"=="11" set "detected_lang=plaintext"
if "!manual_choice!"=="0" (
    endlocal
    goto :main_menu
)

if "!detected_lang!"=="plaintext" (
    echo File is treated as plain text - no formatting possible.
    pause
    endlocal
    exit /b 0
)

:: Hole den passenden Formatter
call :get_formatter_for_language "!detected_lang!" formatter_tool

if "!formatter_tool!"=="" (
    echo ERROR: No formatter available for !detected_lang!
    pause
    endlocal
    exit /b 1
)

:: Temporäre Datei mit korrekter Erweiterung erstellen
call :get_temp_extension "!detected_lang!" temp_ext
set "temp_file=%TEMP_DIR%\temp_format!temp_ext!"

echo Create temporary file: !temp_file!
copy "!txt_file_path!" "!temp_file!" >nul 2>&1

echo Format as !detected_lang! with !formatter_tool!...
call :format_file "!temp_file!" "!formatter_tool!"

if not errorlevel 1 (
    echo Copy formatted file back...
    copy "!temp_file!" "!txt_file_path!" >nul 2>&1
    echo Formatting successful!
) else (
    echo ERROR: Formatting failed!
)

:: Aufräumen
if exist "!temp_file!" del "!temp_file!" >nul 2>&1

:: NEU: Nach Lizenzierung fragen
echo.
set /p "add_license=Add license to this file? (y/n): "
if /i "!add_license!"=="y" (
    call :add_license_to_file "!txt_file_path!" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%"
    echo License successfully added!
)

pause
endlocal
exit /b 0

:: ===========================================
:: ERWEITERTE DATEI-AUFBEREITUNG
:: ===========================================
:complete_project_setup
cls
echo === COMPLETE PROJECT PREPARATION ===
echo.
echo This function performs the following steps:
echo 1. format all code files
echo 2. add licenses to all files
echo 3. analyze project structure
echo 4. create summary report
echo.
set /p "project_dir=Project directory (empty = current): "
if "%project_dir%"=="" set "project_dir=%CD%"

if not exist "%project_dir%" (
    echo ERROR: Directory not found!
    pause
    exit /b 1
)

echo.
echo Project directory: %project_dir%
echo default license: %DEFAULT_LICENSE%
echo.
set /p "confirm_setup=Start project preparation? (y/n): "
if not "%confirm_setup%"=="y" if not "%confirm_setup%"=="Y" exit /b 0

echo.
echo === START PROJECT PREPARATION ===
echo.

:: Statistics
set "total_files=0"
set "formatted_files=0"
set "licensed_files=0"
set "error_files=0"
set "skipped_files=0"
set "backup_files=0"
set "already_licensed=0"
set "overwritten_licenses=0"
set "plaintext_files=0"
set "start_time=%time%"

:: First count all supported files
for /r "%project_dir%" %%f in (*.*) do (
    call :is_supported_extension "%%f" supported
    if "!supported!"=="true" (
        set /a total_files+=1
    )
)

:: Now process files with progress bar
set "current_file=0"
for /r "%project_dir%" %%f in (*.*) do (
    call :is_supported_extension "%%f" supported
    if "!supported!"=="true" (
        set /a current_file+=1

        set /a percent=100*current_file/total_files
        set "bar="
        for /l %%i in (1,1,50) do (
            set /a "barpos=percent/2"
            if %%i leq !barpos! (
                set "bar=!bar!#"
            ) else (
                set "bar=!bar!."
            )
        )
        <nul set /p="Progress: [!bar!] !percent!%% (!current_file! / !total_files!)`r"

        echo.
        echo [!current_file!] Process: %%f

        :: Formatting
        call :get_formatter_for_file "%%f" formatter
        if not "!formatter!"=="" (
            call :format_file "%%f" "!formatter!"
            if not errorlevel 1 (
                set /a formatted_files+=1
                echo    └─ Formatted with !formatter!
            ) else (
                set /a error_files+=1
                echo    └─ ERROR during formatting
            )
        ) else (
            set /a plaintext_files+=1
            echo    └─ No formatter (treated as plain text)
        )

        :: Licensing
        set "license_added=0"
        set "license_overwritten=0"
        set "license_already=0"
        set "backup_created=0"
        call :add_license_to_file_stats "%%f" "%DEFAULT_LICENSE%" "%DEFAULT_AUTHOR%" "%DEFAULT_YEAR%" license_added license_overwritten license_already backup_created
        if "!license_added!"=="1" (
            set /a licensed_files+=1
            echo    └─ License added
        ) else if "!license_overwritten!"=="1" (
            set /a licensed_files+=1
            set /a overwritten_licenses+=1
            echo    └─ License overwritten
        ) else if "!license_already!"=="1" (
            set /a already_licensed+=1
            echo    └─ Already licensed (skipped)
        ) else (
            set /a error_files+=1
            echo    └─ ERROR during licensing
        )
        if "!backup_created!"=="1" set /a backup_files+=1

    ) else (
        set /a skipped_files+=1
    )
)

set "end_time=%time%"

:: Create report
set "report_file=%project_dir%\project_setup_report.txt"
(
echo === PROJECT PROCESSING REPORT ===
echo Date: %date% %time%
echo Directory: %project_dir%
echo.
echo === STATISTICS ===
echo Total files processed: %total_files%
echo Successfully formatted: %formatted_files%
echo Successfully licensed: %licensed_files%
echo Overwritten licenses: %overwritten_licenses%
echo Already licensed (skipped): %already_licensed%
echo Plain text files (no formatting): %plaintext_files%
echo Skipped files (unsupported): %skipped_files%
echo Backup files created: %backup_files%
echo Errors occurred: %error_files%
echo.
echo Start time: %start_time%
echo End time:   %end_time%
echo.
echo === SETTINGS USED ===
echo Default License: %DEFAULT_LICENSE%
echo Author: %DEFAULT_AUTHOR%
echo Year: %DEFAULT_YEAR%
echo.
echo === SUPPORTED FILE EXTENSIONS ===
echo %SUPPORTED_EXTENSIONS%
) > "%report_file%"

echo.
echo === PROJECT PROCESSING COMPLETED ===
echo.
echo Statistics:
echo - Processed files: %total_files%
echo - Formatted files: %formatted_files%
echo - Licensed files: %licensed_files%
echo - Overwritten licenses: %overwritten_licenses%
echo - Already licensed (skipped): %already_licensed%
echo - Plain text files: %plaintext_files%
echo - Skipped files: %skipped_files%
echo - Backup files: %backup_files%
echo - Errors: %error_files%
echo.
echo Report created: %report_file%
echo.
pause
exit /b 0

:: Erweiterte Lizenzfunktion für Statistik
:add_license_to_file_stats
:: %1=file, %2=license, %3=author, %4=year, %5=out_added, %6=out_overwritten, %7=out_already, %8=out_backup
setlocal enabledelayedexpansion
set "file_path=%~1"
set "license_type=%~2"
set "author=%~3"
set "year=%~4"
set "added=0"
set "overwritten=0"
set "already=0"
set "backup=0"

if "%BACKUP_BEFORE_LICENSE%"=="true" (
    copy "%file_path%" "%file_path%.bak" >nul 2>&1
    if not errorlevel 1 set "backup=1"
)

findstr /C:"Copyright" "%file_path%" >nul 2>&1
if not errorlevel 1 (
    set "already=1"
    set /p "overwrite=File already licensed. Overwrite? (y/n): "
    if /i "!overwrite!"=="y" (
        set "overwritten=1"
        set "already=0"
        call :add_license_to_file "%file_path%" "%license_type%" "%author%" "%year%"
        set "added=1"
    )
) else (
    call :add_license_to_file "%file_path%" "%license_type%" "%author%" "%year%"
    set "added=1"
)

endlocal & set "%5=%added%" & set "%6=%overwritten%" & set "%7=%already%" & set "%8=%backup%"
exit /b 0

:: Ende des Scripts
echo.
echo Script finished.
pause