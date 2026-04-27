# Obsidian 图片自动上传脚本
# 1. 把剪贴板图片保存到 hexo-blog/source/images/
# 2. 生成 jsDelivr CDN 链接到剪贴板
# 3. 在 Obsidian 中直接 Ctrl+V 粘贴

$ErrorActionPreference = "Stop"

# 路径配置
$blogRoot = "D:\project\sever\hexo-blog"
$imagesDir = "$blogRoot\source\images"
$cdnBase = "https://cdn.jsdelivr.net/gh/zitont/hexo-blog@main/images"

# 确保目录存在
if (!(Test-Path $imagesDir)) {
    New-Item -ItemType Directory -Path $imagesDir -Force | Out-Null
}

# 从剪贴板获取图片
Add-Type -AssemblyName System.Windows.Forms
$clipboard = [System.Windows.Forms.Clipboard]::GetImage()

if ($null -eq $clipboard) {
    Write-Error "剪贴板中没有图片"
    exit 1
}

# 生成文件名（时间戳 + 随机数）
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$random = (Get-Random -Maximum 9999 -Minimum 1000)
$filename = "img_${timestamp}_${random}.png"
$filepath = Join-Path $imagesDir $filename

# 保存图片
$clipboard.Save($filepath, [System.Drawing.Imaging.ImageFormat]::Png)

# 生成 jsDelivr CDN 链接
$cdnUrl = "$cdnBase/$filename"

# 复制链接到剪贴板
$markdown = "![$filename]($cdnUrl)"
[System.Windows.Forms.Clipboard]::SetText($markdown)

Write-Output "已上传: $filename"
Write-Output "链接已复制到剪贴板: $markdown"