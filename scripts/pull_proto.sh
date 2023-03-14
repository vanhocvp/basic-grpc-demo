#!/bin/bash

# Khai báo biến repo_url chứa đường dẫn đến repo trên server
repo_url=https://github.com/vanhocvp/proto-management-struct.git

# Khai báo biến repo_name chứa tên của repo đã được clone về trước đó
repo_name=protos-git-test

# Cấu hình sparse checkout và chỉ định các thư mục cần pull
rm -rf $repo_name
mkdir -p $repo_name
cd $repo_name
git init
git remote add -f origin $repo_url
git config core.sparseCheckout true

# Thêm các đường dẫn mới vào sparse checkout
echo "proto/calculator" >> .git/info/sparse-checkout

# git read-tree -mu HEAD
# Pull repo
git pull origin master

rm -rf .git
