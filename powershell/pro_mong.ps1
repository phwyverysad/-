# ตรวจสอบสิทธิ์ Administrator (จำเป็นสำหรับการเขียนไฟล์ลง C:\Program Files)
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "กรุณาเปิด PowerShell ในฐานะ Administrator (Run as Administrator)" -ForegroundColor Red
    Write-Host "กดปุ่มอะไรก็ได้เพื่อปิดหน้าต่างนี้..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit
}

# บังคับใช้ TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# เมนูหลัก
Write-Host "กรุณาเลือกคำสั่ง:" -ForegroundColor Cyan
Write-Host "1. Install"
Write-Host "2. Remove"
$mainChoice = Read-Host "ใส่ตัวเลข 1 หรือ 2"

if ($mainChoice -notin @('1','2')) {
    Write-Host "เลือกไม่ถูกต้อง ออกจากโปรแกรม..." -ForegroundColor Red
    exit
}

# เมนูย่อย
Write-Host "`nกรุณาเลือก Emulator:" -ForegroundColor Cyan
Write-Host "1. BlueStacks App Player"
Write-Host "2. MSI App Player x BlueStacks"
$emuChoice = Read-Host "ใส่ตัวเลข 1 หรือ 2"

if ($emuChoice -notin @('1','2')) {
    Write-Host "เลือกไม่ถูกต้อง ออกจากโปรแกรม..." -ForegroundColor Red
    exit
}

# กำหนดเส้นทางตามที่เลือก
if ($emuChoice -eq '1') {
    $targetFolder = "C:\Program Files\BlueStacks_nxt"
} else {
    $targetFolder = "C:\Program Files\BlueStacks_msi5"
}

$targetFile = "$targetFolder\opengl32.dll"
$downloadUrl = "https://github.com/plathx/-/releases/download/%E0%B8%88%E0%B8%B9%E0%B8%99%E0%B8%84%E0%B8%AD%E0%B8%A1/opengl32.dll"

# ----------------- INSTALL -----------------
if ($mainChoice -eq '1') {
    Write-Host "`nกำลังดำเนินการติดตั้ง..." -ForegroundColor Yellow

    # สร้างโฟลเดอร์หากไม่มีอยู่
    if (!(Test-Path -Path $targetFolder)) {
        New-Item -ItemType Directory -Force -Path $targetFolder | Out-Null
    }

    try {
        # ปิด Progress Bar ชั่วคราว ลดการใช้ทรัพยากร UI
        $ProgressPreference = 'SilentlyContinue'

        # ใช้ .NET WebClient ดาวน์โหลดไฟล์แบบ Synchronous ตรงๆ
        $webClient = New-Object System.Net.WebClient
        $webClient.DownloadFile($downloadUrl, $targetFile)
        
        Write-Host "ดาวน์โหลดและติดตั้งไฟล์เสร็จสิ้น" -ForegroundColor Green

        # ตรวจสอบว่าเปิด HD-Player.exe อยู่หรือไม่
        $isRunning = Get-Process -Name "HD-Player" -ErrorAction SilentlyContinue

        if ($isRunning) {
            Write-Host "โปรแกรมกำลังเปิดอยู่" -ForegroundColor Yellow
            $null = Read-Host "กดปุ่ม เอ็นเทอร์เพื่อ รีสตาร์ส"
            Write-Host "กดปุ่ม ins เพื่อเปิด เมนูมอง" -ForegroundColor Cyan
        } else {
            Write-Host "กดปุ่ม ins เพื่อเปิด เมนูมอง" -ForegroundColor Cyan
        }

    } catch {
        Write-Host "เกิดข้อผิดพลาดในการดาวน์โหลด: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# ----------------- REMOVE -----------------
elseif ($mainChoice -eq '2') {
    Write-Host "`nกำลังดำเนินการลบไฟล์..." -ForegroundColor Yellow
    
    if (Test-Path $targetFile) {
        try {
            Remove-Item -Path $targetFile -Force
            Write-Host "ลบสำเร็จแล้ว" -ForegroundColor Green
            $null = Read-Host "กดปุ่ม เอ็นเทอร์เพื่อ รีสตาร์ส"
        } catch {
            Write-Host "เกิดข้อผิดพลาดในการลบไฟล์ (โปรแกรมอาจจะเปิดใช้งานอยู่): $($_.Exception.Message)" -ForegroundColor Red
        }
    } else {
        Write-Host "ไม่พบไฟล์เป้าหมาย (อาจถูกลบไปแล้ว)" -ForegroundColor Yellow
    }
}

# คำสั่งปิดท้าย (รอกดปุ่มใดๆ เพื่อปิด)
Write-Host "`nกดปุ่มอะไรก็ได้เพื่อปิดหน้าต่างนี้..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
