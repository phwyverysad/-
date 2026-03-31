$BravePath = "C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"
$p = "C:\temp_install"
$f = "$p\BraveBrowserSetup.exe"
$u = "https://github.com/phwyverysad/-/releases/download/%E0%B8%88%E0%B8%B9%E0%B8%99%E0%B8%84%E0%B8%AD%E0%B8%A1/BraveBrowserSetup-BRV010.exe"
$args = "/silent", "/install"

if (!(Test-Path $BravePath)) {
    Write-Host "ไม่พบ Brave Browser, กำลังเริ่มการติดตั้ง..." -ForegroundColor Yellow
    
    if(!(Test-Path $p)){ New-Item -Path $p -ItemType Directory -Force | Out-Null }
    
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        (New-Object System.Net.WebClient).DownloadFile($u, $f)
        
        if(Test-Path $f) {
            Start-Process -FilePath $f -ArgumentList $args -Wait
            Write-Host "ติดตั้ง Brave เรียบร้อยแล้ว" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "เกิดข้อผิดพลาดในการติดตั้ง: $_" -ForegroundColor Red
    }
    finally {
        if(Test-Path $f){ Remove-Item -Path $f -Force }
    }
} else {
    Write-Host "พบ Brave Browser อยู่ในเครื่องแล้ว ข้ามขั้นตอนการติดตั้ง" -ForegroundColor Cyan
}

$IconDir = "$env:USERPROFILE\Documents\My_Project\Icons"
$IconPath = Join-Path $IconDir "YouTube.ico"
if (!(Test-Path $IconDir)) { New-Item -ItemType Directory -Path $IconDir -Force }

$Url = "https://github.com/phwyverysad/-/releases/download/%E0%B8%88%E0%B8%B9%E0%B8%99%E0%B8%84%E0%B8%AD%E0%B8%A1/YouTube.icon.ico"

try {
    (New-Object System.Net.WebClient).DownloadFile($Url, $IconPath)
} catch {
    Write-Host "ไม่สามารถดาวน์โหลดไอคอนได้" -ForegroundColor Yellow
}

$DesktopPath = [Environment]::GetFolderPath('Desktop')
$ShortcutPath = Join-Path $DesktopPath "YouTube.lnk"
$Shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $BravePath
$Shortcut.Arguments = "--app=https://www.youtube.com"
$Shortcut.IconLocation = $IconPath
$Shortcut.Save()

Write-Host "สร้าง Shortcut เรียบร้อยแล้วบนหน้า Desktop!" -ForegroundColor Green

Write-Host "กำลังเปิด YouTube..." -ForegroundColor Cyan
Invoke-Item $ShortcutPath