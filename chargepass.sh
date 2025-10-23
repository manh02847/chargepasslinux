#!/bin/bash

# Cập nhật danh sách gói
apt update -y

# Gỡ cài đặt OpenSSH Server
apt purge openssh-server -y

# Xóa thư mục cấu hình SSH
rm -rf /etc/ssh
rm -rf ~/.ssh

# Cài đặt lại OpenSSH Server
apt install openssh-server -y

# Thay đổi mật khẩu root
echo "root:Manhvip1@" | chpasswd

# Cấu hình SSH để cho phép đăng nhập root bằng mật khẩu
SSHD_CONFIG="/etc/ssh/sshd_config"

# Sao lưu tệp cấu hình hiện tại
cp $SSHD_CONFIG ${SSHD_CONFIG}.bak

# Chỉnh sửa tệp cấu hình để cho phép đăng nhập root và xác thực bằng mật khẩu
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' $SSHD_CONFIG
sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' $SSHD_CONFIG
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' $SSHD_CONFIG
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' $SSHD_CONFIG

# Khởi động lại dịch vụ SSH
systemctl restart ssh

# Kiểm tra trạng thái dịch vụ SSH
systemctl status ssh

echo "Mật khẩu root đã được thay đổi và SSH đã được cấu hình lại thành công thành: "Manhvip1@"
