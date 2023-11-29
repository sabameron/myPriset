#!/bin/bash

# ユーザーに確認メッセージを表示し、ユーザーの入力が'y'かどうかを確認する関数
function confirm() {
  read -r -p "$1 (y/n): " response
  case "$response" in
    [yY][eE][sS]|[yY])
      true
      ;;
    *)
      false
      ;;
  esac
}

# リモートから最新の変更を取得
if confirm "リモートから最新の変更を取得しますか？"; then
  git fetch --all
else
  echo "処理を中止します。"
  exit 1
fi

# ローカルのブランチをリモートの対応するブランチと同期
if confirm "ローカルのブランチをリモートの対応するブランチと同期しますか？"; then
  git reset --hard origin/master
else
  echo "処理を中止します。"
  exit 1
fi

# ローカルの変更を取り消して、指定されたブランチの状態と一致させる
if confirm "ローカルの変更を取り消して、指定されたブランチの状態と一致させますか？"; then
  git pull origin master
else
  echo "処理を中止します。"
  exit 1
fi
