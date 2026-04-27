# Image Upload Script for Hexo Blog
# 使用方法：
# 1. 截图后运行此脚本
# 2. 图片自动保存到 source/images/
# 3. jsDelivr CDN 链接已复制到剪贴板
# 4. 在 Obsidian 中直接 Ctrl+V 粘贴

$ErrorActionPreference = "Stop"

$blogRoot = "D:\project\sever\hexo-blog"
$imagesDir = "$blogRoot\source\images"
$cdnBase = "https://cdn.jsdelivr.net/gh/zitont/hexo-blog@main/images"

# 创建图片目录
if (!(Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir -Force | Out-Null
}

# 获取剪贴板图片
Add-Type -AssemblyName System.Windows.Forms
$clipboard = [System.Windows.Forms.Clipboard]::GetImage()

if ($null -eq $clipboard) {
    Write-Error "剪贴板中没有图片，请先截图"
    exit 1
}

# 生成文件名（时间戳）
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$filename = "img_$timestamp.png"
$filepath = Join-Path $imagesDir $filename

# 保存图片
$clipboard.Save($filepath, [System.Drawing.Imaging.ImageFormat]::Png)

# 生成 CDN 链接
$cdnUrl = "$cdnBase/$filename"

# 复制链接到剪贴板
$markdown = "![]($cdnUrl)"
[System.Windows.Forms.Clipboard]::SetText($markdown)

Write-Host "图片已保存: $filename"
Write-Host "CDN链接已复制到剪贴板"
Write-Host $markdown