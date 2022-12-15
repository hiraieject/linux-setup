
# linux 個人的環境設定

## linuxenv(このフォルダ)のスクリプトが使えるようになるまで、最低限の手動作業を行う

### aptのプロクシ設定（プロクシが必要な環境のみ）

sudo vi /etc/apt/apt.conf.d/01proxy
------------- 以下を追加
Acquire::http::Proxy "http"//192.168.0.86:8080/";
-------------

### git インストール（必須）

> sudo apt update
> sudo apt install git make

### gitのプロクシ設定（プロクシが必要な環境のみ）

> git config --global http.proxy http://192.168.0.86:8080
> git config --global https.proxy http://192.168.0.86:8080

### linuxenv(このフォルダ)を取得

> git clone https://github.com/hiraieject/linuxenv.git

## linuxenv(このフォルダ)をつかった環境設定

