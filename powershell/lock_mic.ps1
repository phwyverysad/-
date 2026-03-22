# 1. Admin Check
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -ArgumentList $arguments -Verb RunAs
    exit
}

# กำหนดตัวแปร
$WorkDir = "C:\phwyverysad"
$ZipUrl = "https://github.com/plathx/-/releases/download/%E0%B8%88%E0%B8%99%E0%B8%84%E0%B8%AD%E0%B8%A1/lock_mic_volume.zip"

# UI Helper
function Write-Color ($text, $color) { Write-Host $text -ForegroundColor $color }

# 2. ฟังก์ชัน Install
function Install-Lock {
    Write-Color "`n[*] เริ่มต้นการติดตั้ง..." Cyan
    if (!(Test-Path $WorkDir)) { New-Item -Path $WorkDir -ItemType Directory }
    
    $zipPath = "$WorkDir\temp.zip"
    Invoke-WebRequest -Uri $ZipUrl -OutFile $zipPath
    Expand-Archive -Path $zipPath -DestinationPath $WorkDir -Force
    Remove-Item $zipPath

    Write-Color "เลือกความดังที่ต้องการล็อก:" Yellow
    Write-Host "1. 100% | 2. 75% | 3. 50% | 4. 25%"
    $choice = Read-Host "ใส่หมายเลขที่เลือก"
    $folders = @("100", "75", "50", "25")
    $selectedFolder = "$WorkDir\" + $folders[[int]$choice-1]

    Write-Color "[*] รันโปรแกรมในเบื้องหลัง..." Green
    $process = Start-Process "$selectedFolder\Run_atomatically.bat" -WindowStyle Hidden -PassThru
    
    # รอจนกว่า process จะจบ
    while (!$process.HasExited) { Start-Sleep -Seconds 5 }
    
    Remove-Item $WorkDir -Recurse -Force
    Write-Color "[!] งานเสร็จสิ้นและล้างไฟล์ชั่วคราวแล้ว" Cyan
}

# 3. ฟังก์ชัน Uninstall
function Uninstall-Lock {
    Write-Color "[*] กำลังถอนการติดตั้ง..." Yellow
    Stop-Process -Name "nircmdc" -Force -ErrorAction SilentlyContinue
    $files = @("C:\Windows\lock_mic_vol.bat", "C:\Windows\hide_cmd_window2.vbs", "C:\Windows\nircmdc.exe")
    foreach ($f in $files) { if (Test-Path $f) { Remove-Item $f -Force } }
    
    $startupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\start_lock_mic_vol.bat"
    if (Test-Path $startupPath) { Remove-Item $startupPath -Force }
    Write-Color "[!] ถอนการติดตั้งเรียบร้อย" Green
}

# Menu
Clear-Host
Write-Color "=== ระบบจัดการไมโครโฟน ===" Cyan
Write-Host "1. Install" -ForegroundColor Green
Write-Host "2. Uninstall" -ForegroundColor Yellow
$opt = Read-Host "เลือกเมนู"

if ($opt -eq "1") { Install-Lock }
elseif ($opt -eq "2") { Uninstall-Lock }

Write-Host "`nกดปุ่มใดๆ เพื่อออกจากโปรแกรม..."
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
