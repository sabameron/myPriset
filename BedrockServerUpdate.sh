#!/bin/bash

# サーバー閉じたかどうかの入力を取得
read -p "サーバーを閉じましたか？ (y/n): " input
if [[ $input == "y" || $input == "Y" ]]; then
    echo "サーバーを閉じましたね！"
elif [[ $input == "n" || $input == "N" ]]; then
    echo "サーバーを閉じるまでスクリプトを終了します。"
    exit 1
else
    echo "無効な入力です。スクリプトを終了します。"
    exit 1
fi

# URLの入力を取得
read -p "MinecraftサーバーのダウンロードURLを入力してください: " URL

beforeBCFolder=$(cat 00_beforeBcName.txt)
echo 一つ前のバージョンは$beforeBCFolder
# URLからファイル名を抽出してNEWFに設定
NEWF=$(basename $URL)
NEWF=${NEWF%.zip}

# bedrock-server- で始まるフォルダを取得
folders=($(ls -d bedrock-server-*))
num_folders=${#folders[@]}

if [[ $num_folders -gt 1 ]]; then
    echo "サーバーフォルダが複数存在します。スクリプトを終了します。"
    exit 1
elif [[ $num_folders -eq 1 ]]; then
    OLDF=${folders[0]}
else
    echo "サーバーフォルダが存在しません。スクリプトを終了します。"
    exit 1
fi

# ダウンロードしたファイルを取得
wget $URL --no-check-certificate

mkdir $NEWF
mv $NEWF.zip $NEWF/
cd $NEWF

unzip $NEWF.zip

cd ..

cp $OLDF/allowlist.json $NEWF
cp $OLDF/permissions.json $NEWF
cp $OLDF/server.properties $NEWF
cp $OLDF/up.sh $NEWF
cp $OLDF/これがあればコピー成功.txt $NEWF
cp -r $OLDF/worlds $NEWF
cp -r $OLDF/applogs $NEWF

echo "コピー終わりましたので、zip化します。"

zip -r BC_$OLDF.zip $OLDF
mv $OLDF bc_$OLDF

# ふたつ前のバックアップフォルダを削除
ls -al
rm -r $beforeBCFolder
ls -al
echo bc_$OLDF > 00_beforeBcName.txt


echo "完了しました！古いデータが削除されていることを確認してサーバーを起動してください。"
