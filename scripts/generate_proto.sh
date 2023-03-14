#!/bin/bash

# Đường dẫn đến thư mục chứa các file .proto
PROTO_DIR="protos-git-test"

# Lấy danh sách tên các file .proto
PROTO_FILES=$(find $PROTO_DIR -name "*.proto")

# Tạo file .go cho từng file
for proto_file in $PROTO_FILES; do
    echo $proto_file
    # Sử dụng lệnh protoc để tạo file .go
    protoc --go_out=protos --go-grpc_out=protos $proto_file
    # protoc --go_out="$PROTO_DIR" "$proto_file"
done