# ==============================================================================
# 1. Admin Privilege Check (ขอสิทธิ์ผู้ดูแลระบบ)
# ==============================================================================
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# ==============================================================================
# 2. Environment Setup (ตั้งค่าสภาพแวดล้อมภาษาไทยและเครือข่าย)
# ==============================================================================
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding  = [System.Text.Encoding]::UTF8
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# ==============================================================================
# 3. Global Variables (ตัวแปรส่วนกลาง)
# ==============================================================================
$URL      = "https://github.com/plathx/-/releases/download/%E0%B8%88%E0%B8%B9%E0%B8%99%E0%B8%84%E0%B8%AD%E0%B8%A1/opengl32.dll"
$PATH_NXT = "C:\Program Files\BlueStacks_nxt"
$PATH_MSI = "C:\Program Files\BlueStacks_msi5"

# ==============================================================================
# 4. Helper Functions (ฟังก์ชันช่วยเหลือ)
# ==============================================================================

# ฟังก์ชันปิดและเปิด HD-Player ใหม่
function Restart-Player ($folderPath) {
    $exe = Join-Path $folderPath "HD-Player.exe"
    $proc = Get-Process -Name "HD-Player" -ErrorAction SilentlyContinue | Where-Object { $_.Path -eq $exe }
    
    if ($proc) {
        Write-Host "`n[!] ตรวจพบ HD-Player กำลังทำงานอยู่" -ForegroundColor Cyan
        Read-Host "กด Enter เพื่อ Restart (ปิดและเปิดใหม่)"
        Stop-Process -Id $proc.Id -Force
        Start-Sleep -Seconds 1
        if (Test-Path $exe) { Start-Process -FilePath $exe }
        Write-Host "[+] กดปุ่ม INS เพื่อเปิดเมนูมอง" -ForegroundColor Green
    } else {
        Write-Host "`n[+] กดปุ่ม INS เพื่อเปิดเมนูมอง" -ForegroundColor Green
    }
}

# ฟังก์ชันปิดโปรแกรมแบบสมบูรณ์
function Exit-Terminal {
    Write-Host "`n[!] กดปุ่มอะไรก็ได้เพื่อปิดหน้าต่างนี้..." -ForegroundColor Yellow
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Stop-Process -Id $PID -Force
}

# ==============================================================================
# 5. Main Menu (เมนูหลัก)
# ==============================================================================
Clear-Host
Write-Host "================================" -ForegroundColor Magenta
Write-Host "      MOD MANAGER (CLEAN)       "
Write-Host "================================" -ForegroundColor Magenta
Write-Host "1. Install (ติดตั้ง)"
Write-Host "2. Remove (ถอนการติดตั้ง)"
$choice = Read-Host "`nเลือกรายการ (1-2)"

# --- การตรวจสอบเส้นทางเป้าหมาย ---
if ($choice -match '1|2') {
    Clear-Host
    Write-Host "--- เลือกโปรแกรมจำลอง ---" -ForegroundColor Cyan
    Write-Host "1. BlueStacks App Player"
    Write-Host "2. MSI App Player x BlueStacks"
    $appChoice = Read-Host "เลือกรายการ (1-2)"
    
    $targetDir = if ($appChoice -eq '1') { $PATH_NXT } else { $PATH_MSI }
    $targetFile = Join-Path $targetDir "opengl32.dll"
    $exePath = Join-Path $targetDir "HD-Player.exe"
}

# ==============================================================================
# 6. Action Logic (การทำงานตามที่เลือก)
# ==============================================================================

# --- INSTALL ---
if ($choice -eq '1') {
    if (!(Test-Path $targetDir)) { New-Item -ItemType Directory -Path $targetDir -Force | Out-Null }
    
    Write-Host "`n[*] กำลังดาวน์โหลดไฟล์ด้วย WebClient (TLS 1.2)..." -ForegroundColor Yellow
    try {
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($URL, $targetFile)
        $wc.Dispose()
        Write-Host "[OK] ดาวน์โหลดสำเร็จ!" -ForegroundColor Green
        Restart-Player $targetDir
    } catch {
        Write-Host "[ERR] ไม่สามารถดาวน์โหลดได้: $($_.Exception.Message)" -ForegroundColor Red
    }
    Exit-Terminal
}

# --- REMOVE ---
elseif ($choice -eq '2') {
    Write-Host "`n[*] กำลังดำเนินการลบไฟล์..." -ForegroundColor Yellow
    
    # บังคับปิดก่อนลบ
    $proc = Get-Process -Name "HD-Player" -ErrorAction SilentlyContinue | Where-Object { $_.Path -eq $exePath }
    if ($proc) { Stop-Process -Id $proc.Id -Force; Start-Sleep -Seconds 1 }

    if (Test-Path $targetFile) {
        Remove-Item -Path $targetFile -Force
        Write-Host "[OK] ลบไฟล์สำเร็จแล้ว!" -ForegroundColor Green
        Read-Host "กด Enter เพื่อ Restart HD-Player"
        if (Test-Path $exePath) { Start-Process -FilePath $exePath }
    } else {
        Write-Host "[!] ไม่พบไฟล์ในระบบ" -ForegroundColor Red
    }
    Exit-Terminal
}

else {
    Write-Host "เลือกไม่ถูกต้อง" -ForegroundColor Red
    Exit-Terminal
}
