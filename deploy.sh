#!/bin/bash
# Hexo 博客一键部署脚本
# 用法: ./deploy.sh "提交消息"

set -e

MSG="${1:-chore: update blog}"

cd "$(dirname "$0")"

echo ">>> 生成静态文件..."
hexo clean
hexo generate

echo ">>> 提交并推送..."
git add .
git commit -m "$MSG"
git push origin main

echo ">>> 部署完成!"
