# 1. Check for Administrator privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Elevating privileges..." -ForegroundColor Yellow
    try {
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -ErrorAction Stop
    } catch {
        Write-Host "Failed: Please run as Administrator." -ForegroundColor Red
        Pause
    }
    exit
}

function Show-Menu {
    Clear-Host
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "      MIC VOLUME LOCKER - MANAGER         " -ForegroundColor Cyan
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host " 1. Install (Set & Lock Volume)" -ForegroundColor Green
    Write-Host " 2. Uninstall (Remove Locks)" -ForegroundColor Yellow
    Write-Host " 3. Exit" -ForegroundColor Red
    Write-Host "==========================================" -ForegroundColor Cyan
}

function Invoke-Install {
    $tempDir = "C:\phwyverysad"
    $zipUrl = "https://github.com/plathx/-/releases/download/%E0%B8%88%E0%B8%B9%E0%B8%99%E0%B8%84%E0%B8%AD%E0%B8%A1/lock_mic_volume.zip"
    $zipPath = Join-Path $tempDir "package.zip"

    if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue }
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null

    Write-Host "[*] Downloading components..." -ForegroundColor Cyan
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath -ErrorAction Stop
    } catch {
        Write-Host "[!] Download failed: $_" -ForegroundColor Red
        return
    }

    Write-Host "[*] Extracting files..." -ForegroundColor Cyan
    Expand-Archive -Path $zipPath -DestinationPath $tempDir -Force
    
    Write-Host "`nSelect Microphone Volume Level:" -ForegroundColor Cyan
    Write-Host "1. 100%"
    Write-Host "2. 75%"
    Write-Host "3. 50%"
    Write-Host "4. 25%"
    $volChoice = Read-Host "Choice (1-4)"

    $folderMap = @{ "1" = "100"; "2" = "75"; "3" = "50"; "4" = "25" }
    $selectedNum = $folderMap[$volChoice]

    if ($null -eq $selectedNum) {
        Write-Host "[!] Invalid selection." -ForegroundColor Red
        return
    }

    # Find folder starting with number (Fixes Thai character encoding issue)
    $matchedFolder = Get-ChildItem -Path $tempDir -Directory | Where-Object { $_.Name -like "$selectedNum*" } | Select-Object -First 1

    if ($null -eq $matchedFolder) {
        Write-Host "[!] Folder for $selectedNum% not found." -ForegroundColor Red
        return
    }

    $targetBatchDir = $matchedFolder.FullName
    $batchFile = Join-Path $targetBatchDir "Run_atomatically.bat"

    if (Test-Path $batchFile) {
        Write-Host "[*] Executing setup..." -ForegroundColor Green
        $process = Start-Process -FilePath $batchFile -WorkingDirectory $targetBatchDir -WindowStyle Hidden -PassThru
        
        Write-Host "[*] Waiting for process to finish..." -ForegroundColor Yellow
        while (!$process.HasExited) {
            Start-Sleep -Seconds 2
            if (!(Get-Process -Id $process.Id -ErrorAction SilentlyContinue)) { break }
        }

        Set-Location "C:\"
        Remove-Item $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "[+] Installation Complete!" -ForegroundColor Green
    } else {
        Write-Host "[!] Could not find $batchFile" -ForegroundColor Red
    }
}

function Invoke-Uninstall {
    Write-Host "[*] Stopping lock process..." -ForegroundColor Yellow
    Stop-Process -Name "nircmdc" -Force -ErrorAction SilentlyContinue

    $systemFiles = @(
        "C:\Windows\lock_mic_vol.bat",
        "C:\Windows\hide_cmd_window2.vbs",
        "C:\Windows\nircmdc.exe"
    )

    $startupShortcut = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\start_lock_mic_vol.bat"

    Write-Host "[*] Removing files..." -ForegroundColor Cyan
    foreach ($file in $systemFiles) {
        if (Test-Path $file) {
            Remove-Item $file -Force -ErrorAction SilentlyContinue
            Write-Host "[-] Deleted: $file" -ForegroundColor Gray
        }
    }

    if (Test-Path $startupShortcut) {
        Remove-Item $startupShortcut -Force -ErrorAction SilentlyContinue
        Write-Host "[-] Deleted: Startup Shortcut" -ForegroundColor Gray
    }

    Write-Host "[+] Uninstallation Successful!" -ForegroundColor Green
}

do {
    Show-Menu
    $choice = Read-Host "Select an option"
    switch ($choice) {
        "1" { Invoke-Install }
        "2" { Invoke-Uninstall }
        "3" { exit }
        default { Write-Host "Invalid option." -ForegroundColor Red; Start-Sleep -Seconds 1 }
    }
    Write-Host "`nPress any key to continue..." -ForegroundColor Cyan
    $null = [Console]::ReadKey($true)
} while ($true)
