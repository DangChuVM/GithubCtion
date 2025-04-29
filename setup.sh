#!/bin/bash
# Tự động pull, track file >50MB bằng Git LFS, add, commit, và push
clear
# Bước 1: Pull bản mới nhất
git pull

# Bước 2: Tìm file >50MB và track bằng Git LFS
echo "Đang tìm file >50MB để track bằng Git LFS..."
find . -type f -size +50M ! -path "./.git/*" | while read -r file; do
    ext="${file##*.}"
    pattern="*.${ext}"
    # Chỉ track nếu chưa có trong .gitattributes
    if ! grep -q "$pattern" .gitattributes 2>/dev/null; then
        git lfs track "$pattern"
        echo "Đã track $pattern bằng Git LFS"
    fi
done

# Bước 3: Thêm tất cả thay đổi
git add .

# Bước 4: Commit
git commit -m "Tự động cập nhật, track file >50MB bằng Git LFS và push"

# Bước 5: Push
git push
