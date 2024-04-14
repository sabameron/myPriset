#!/bin/bash

# ユーザーにIPアドレスを入力してもらう
echo "IPを入力してください:"
read ip_address

# UFWでポート19138と19139への通信を許可
sudo ufw allow from $ip_address to any port 19138 proto udp
sudo ufw allow from $ip_address to any port 19139 proto udp

sudo ufw reload
# 設定が正しく行われたことを確認
echo "$ip_address を設定しました"
sudo ufw status
