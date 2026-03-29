# 1. เช็คว่ามี Python ในเครื่องหรือไม่
$pythonCheck = Get-Command python -ErrorAction SilentlyContinue

if (-not $pythonCheck) {
    Write-Host "Python is not installed. Preparing to install..." -ForegroundColor Yellow
    
    # สร้างโฟลเดอร์ powershell (ถ้ายังไม่มี)
    $psFolder = ".\powershell"
    if (-not (Test-Path $psFolder)) {
        New-Item -ItemType Directory -Path $psFolder | Out-Null
    }

    # ดาวน์โหลดไฟล์ MSIX
    $downloadUrl = "https://github.com/phwyverysad/-/releases/download/%E0%B8%88%E0%B8%B9%E0%B8%99%E0%B8%84%E0%B8%AD%E0%B8%A1/python-manager-26.0.msix"
    $installerPath = "$psFolder\python-manager-26.0.msix"
    
    Write-Host "Downloading Python Manager..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath

    # ติดตั้งแบบเงียบ (MSIX ใช้ Add-AppxPackage)
    Write-Host "Installing Python silently..." -ForegroundColor Cyan
    Add-AppxPackage -Path $installerPath

    Write-Host "Python installation complete!" -ForegroundColor Green
    Start-Sleep -Seconds 2
} else {
    Write-Host "Python is already installed. Skipping installation." -ForegroundColor Green
}

# ติดตั้ง/อัปเกรด PyInstaller แบบเงียบ
Write-Host "Checking/Installing PyInstaller..." -ForegroundColor Cyan
python -m pip install --upgrade pip --quiet
python -m pip install pyinstaller --quiet

# เตรียมเรียกใช้ GUI
Add-Type -AssemblyName System.Windows.Forms

# เริ่มลูปการทำงาน
while ($true) {
    Clear-Host
    Write-Host "=== Python to EXE Converter ===" -ForegroundColor Cyan
    
    # สร้าง Dialog เลือกไฟล์
    $fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    # แก้ไข Filter ให้ถูกต้อง (*.py) เพื่อให้แสดงไฟล์
    $fileDialog.Filter = "Python Files (*.py)|*.py"
    $fileDialog.Title = "Select your Python file to convert"
    
    # สร้างหน้าต่างดัมมี่เพื่อบังคับให้หน้าต่างเลือกไฟล์เด้งมาอยู่บนสุดเสมอ (แก้ปัญหาหน้าต่างไม่ยอมเด้ง)
    $dummyForm = New-Object System.Windows.Forms.Form
    $dummyForm.TopMost = $true

    # แสดงหน้าต่างและรับค่าผลลัพธ์
    $dialogResult = $fileDialog.ShowDialog($dummyForm)
    
    if ($dialogResult -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedPath = $fileDialog.FileName
        $parentDir = Split-Path $selectedPath
        $fileName = Split-Path $selectedPath -Leaf
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($selectedPath)

        Write-Host "Selected: $fileName" -ForegroundColor Green
        
        # ย้ายไปที่โฟลเดอร์ของไฟล์นั้น
        Set-Location $parentDir

        # สั่งแปลงไฟล์แบบเงียบ โดยใช้ Start-Process
        $arguments = "-m PyInstaller --onefile --noconfirm `"$fileName`""
        $process = Start-Process -FilePath "python" -ArgumentList $arguments -WindowStyle Hidden -PassThru

        $progress = 0
        while (-not $process.HasExited) {
            # จำลองเปอร์เซ็นต์วิ่งไปเรื่อยๆ จนกว่าจะเสร็จ
            $progress += 2
            if ($progress -ge 99) { $progress = 99 }
            Write-Progress -Activity "Converting $fileName to EXE" -Status "$progress% (Please wait...)" -PercentComplete $progress
            Start-Sleep -Milliseconds 500
        }
        
        # โหลดเต็ม 100%
        Write-Progress -Activity "Converting $fileName to EXE" -Status "100% Complete!" -PercentComplete 100
        Start-Sleep -Seconds 1
        Write-Progress -Activity "Converting $fileName to EXE" -Completed

        # กำหนดพาธของไฟล์และโฟลเดอร์
        $distExePath = Join-Path $parentDir "dist\$baseName.exe"
        $finalExePath = Join-Path $parentDir "$baseName.exe"
        $specFilePath = Join-Path $parentDir "$baseName.spec"
        
        # ย้ายไฟล์ .exe ออกมาจาก dist
        if (Test-Path $distExePath) {
            Move-Item -Path $distExePath -Destination $finalExePath -Force
        }

        # ลบโฟลเดอร์ dist, build และไฟล์ .spec ทิ้ง
        if (Test-Path "dist") { Remove-Item -Path "dist" -Recurse -Force }
        if (Test-Path "build") { Remove-Item -Path "build" -Recurse -Force }
        if (Test-Path $specFilePath) { Remove-Item -Path $specFilePath -Force }

        # เปิดโฟลเดอร์พร้อมคลุมดำ (Highlight) ไฟล์ .exe
        explorer.exe /select, "$finalExePath"

        Write-Host ""
        Write-Host "Success." -ForegroundColor Green
    } else {
        Write-Host "No file selected." -ForegroundColor Yellow
    }

    Write-Host ""
    $response = Read-Host "Press Enter to convert another file (or type 'exit' to quit)"
    if ($response -match "^exit$") {
        break
    }
}
