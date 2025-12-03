#!/bin/bash

# 1. Tự động lấy tên card mạng (eth0, ens5,...)
ETH_NAME=$(ip -o -4 route show to default | awk '{print $5}')

# 2. Cài đặt Dante Server
apt install dante-server -y

# 3. Tạo file cấu hình Dante (Tự động điền card mạng vào external)
bash -c "cat > /etc/danted.conf <<EOF
logoutput: syslog
user.privileged: root
user.unprivileged: nobody

# Port chạy proxy
internal: 0.0.0.0 port = 1080

# Card mạng đi ra Internet (quan trọng)
external: $ETH_NAME

# Xác thực bằng user/pass hệ thống
socksmethod: username

# Rule cho phép kết nối
client pass { from: 0.0.0.0/0 to: 0.0.0.0/0 }
socks pass { from: 0.0.0.0/0 to: 0.0.0.0/0 }
EOF"

# 4. Tạo User cho Proxy (User: manh / Pass: manh)
# Nếu muốn đổi pass proxy, sửa chữ 'manh' thứ 2 trong dòng dưới
useradd -r -s /bin/false manh
echo "manh:manh" | chpasswd

# 5. Khởi động Proxy
systemctl restart danted
systemctl enable danted

# =================================================================
# KẾT THÚC
# =================================================================
echo "Hoan tat cai dat SSH va Proxy!"
