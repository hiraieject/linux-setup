
# linux 個人的環境設定

## ■■■ インストール直後の設定(rootでGUIログインして作業)
### ・IPアドレス、ホストネームをGUIで設定する
### ・プロクシの設定が必要な場合のみ、GUIで設定する
### ・通常使用するユーザーの追加
> adduser <username>
### ・追加したユーザーをwheelグループに登録する
> vi /etc/group

## ■■■ 通常ユーザーでの作業(上で追加したユーザーでGUIログインして作業)

### ・aptのプロクシ設定（プロクシが必要な環境のみ）

> sudo vi /etc/apt/apt.conf.d/01proxy

以下を追加<br>
Acquire::http::Proxy "http"//192.168.0.86:8080/";

### ・git インストール（必須）

> sudo apt update
> sudo apt install git make

### ・gitのプロクシ設定（プロクシが必要な環境のみ）

> git config --global http.proxy http://192.168.0.86:8080
> git config --global https.proxy http://192.168.0.86:8080

### ・linuxenv(このフォルダ)を取得

> git clone https://github.com/hiraieject/linuxenv.git

## ■■■ linuxenv(このフォルダ)をつかった環境設定
各処理はMakefileのターゲットとして記述されているので、基本的には以下のコマンドラインで使用する
> cd ~/linuxenv
> make なんとか

### ・sudoでパスワードを溶融しない設定
> make sudo_nopass


