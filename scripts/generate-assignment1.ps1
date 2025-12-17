Add-Type -AssemblyName System.Drawing

$width = 1353
$height = 768

$bitmap = New-Object System.Drawing.Bitmap($width, $height)
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = 'AntiAlias'

$skyRect = New-Object System.Drawing.Rectangle(0, 0, $width, $height)
$skyBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $skyRect,
    [System.Drawing.Color]::FromArgb(255, 123, 156, 210),
    [System.Drawing.Color]::FromArgb(255, 246, 182, 142),
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$graphics.FillRectangle($skyBrush, $skyRect)

$mountainBrush1 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(160, 38, 62, 98))
$mountainBrush2 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(200, 54, 80, 122))
$mountainBrush3 = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 64, 82, 110))

$mountain1 = @(
    New-Object System.Drawing.Point(0, 520),
    New-Object System.Drawing.Point(250, 430),
    New-Object System.Drawing.Point(410, 520),
    New-Object System.Drawing.Point(0, 768)
)
$mountain2 = @(
    New-Object System.Drawing.Point(260, 520),
    New-Object System.Drawing.Point(520, 360),
    New-Object System.Drawing.Point(780, 520),
    New-Object System.Drawing.Point(260, 520)
)
$mountain3 = @(
    New-Object System.Drawing.Point(760, 520),
    New-Object System.Drawing.Point(980, 420),
    New-Object System.Drawing.Point(1353, 550),
    New-Object System.Drawing.Point(1353, 768),
    New-Object System.Drawing.Point(720, 768)
)

$graphics.FillPolygon($mountainBrush1, $mountain1)
$graphics.FillPolygon($mountainBrush2, $mountain2)
$graphics.FillPolygon($mountainBrush3, $mountain3)

$fogRect = New-Object System.Drawing.Rectangle(0, 420, $width, 348)
$fogBrush = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    $fogRect,
    [System.Drawing.Color]::FromArgb(200, 255, 255, 255),
    [System.Drawing.Color]::FromArgb(10, 255, 255, 255),
    [System.Drawing.Drawing2D.LinearGradientMode]::Vertical
)
$graphics.FillRectangle($fogBrush, $fogRect)

$panelRect = New-Object System.Drawing.Rectangle(180, 120, 980, 520)
$panelBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(120, 20, 34, 58))
$graphics.FillRectangle($panelBrush, $panelRect)

$panelPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(90, 255, 255, 255), 2)
for ($i = 1; $i -lt 7; $i++) {
    $x = [int](180 + $i * 140)
    $graphics.DrawLine($panelPen, $x, 120, $x, 640)
}
for ($j = 1; $j -lt 10; $j++) {
    $y = [int](120 + $j * 52)
    $graphics.DrawLine($panelPen, 180, $y, 1160, $y)
}

$sidebarRect = New-Object System.Drawing.Rectangle(40, 80, 260, 520)
$sidebarBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(150, 27, 47, 87))
$graphics.FillRectangle($sidebarBrush, $sidebarRect)

$titleFont = New-Object System.Drawing.Font('Segoe UI', 24, [System.Drawing.FontStyle]::Bold)
$smallFont = New-Object System.Drawing.Font('Segoe UI', 14)
$whiteBrush = [System.Drawing.Brushes]::White

$graphics.DrawString('캘린더', $titleFont, $whiteBrush, 60, 100)
$graphics.DrawString('2025년 11월 10일', $smallFont, $whiteBrush, 220, 130)

$clockRect = New-Object System.Drawing.Rectangle(60, 540, 200, 80)
$clockBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(120, 64, 104, 204))
$graphics.FillRectangle($clockBrush, $clockRect)
$graphics.DrawString('14:06:26', $titleFont, $whiteBrush, 80, 560)
$graphics.DrawString('2025년 11월 10일 월요일', $smallFont, $whiteBrush, 80, 600)

$dotBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 66, 133, 244))
$graphics.FillEllipse($dotBrush, 520, 260, 18, 18)

$panelOutline = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(120, 255, 255, 255), 2)
$graphics.DrawRectangle($panelOutline, $panelRect)

$outputPath = Join-Path $PSScriptRoot '..\\public\\assignment-1.png'
$bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

$graphics.Dispose()
$bitmap.Dispose()




