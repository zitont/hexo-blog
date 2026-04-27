#!/bin/bash
# Hexo 图片上传脚本
# 用法：在 Obsidian Shell Commands 中调用

BLOG_ROOT="D:/project/sever/hexo-blog"
IMAGES_DIR="$BLOG_ROOT/source/images"
CDN_BASE="https://cdn.jsdelivr.net/gh/zitont/hexo-blog@main/images"

# 创建目录
mkdir -p "$IMAGES_DIR"

# 生成文件名
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RANDOM_NUM=$((RANDOM % 9000 + 1000))
FILENAME="img_${TIMESTAMP}_${RANDOM_NUM}.png"
FILEPATH="$IMAGES_DIR/$FILENAME"

# 从命令行参数获取图片路径（如果通过命令行传递）
if [ -n "$1" ]; then
    cp "$1" "$FILEPATH"
    CDN_URL="$CDN_BASE/$FILENAME"
    echo "[$FILENAME]($CDN_URL)"
else
    echo "请使用截图后调用，或传入图片路径"
fi