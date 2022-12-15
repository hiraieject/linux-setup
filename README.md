
# linux 個人的環境設定(主にvmware上のubuntu仮想マシンで検証)

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

> sudo apt update<br>
> sudo apt install git make

### ・gitのプロクシ設定（プロクシが必要な環境のみ）

> git config --global http.proxy http://192.168.0.86:8080<br>
> git config --global https.proxy http://192.168.0.86:8080

### ・linuxenv(このフォルダ)を取得

> git clone https://github.com/hiraieject/linuxenv.git

## ■■■ linuxenv(このフォルダ)をつかった環境設定
各処理はMakefileのターゲットとして記述されているので、基本的には以下のコマンドラインで使用する
> cd ~/linuxenv
> make なんとか

### ・sudoでパスワードを要求しない
> make sudo_nopass

### ・基本ツールの一気インストール
> make install_ubuntu_basic

### ・個人設定ファイルのインストール(bash,emacsなどの設定)
> make install_dotfiles

~/.dotfiles/.bashrc_local を編集
> vi ~/.dotfiles/.bashrc_local

作業後、ログインし直す<br>
必要ならrootユーザーで同じ作業をしても良い

### ・gitの詳細設定

> make config_git

設定ファイルを手動で変更（user.emailとuser.name）
> emacs ~/.gitconfig

認証情報を変更（accoutと個人アクセストークン）
> emacs ~/.git-credentials

個人アクセストークンの新規作成は以下を参照
>https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

proxyの設定・設定消去、makeで設定後emacsでアドレス変更<br>
> make config_git_setproxy<br>
> emacs ~/.gitconfig

> make config_git_unsetproxy<br>

### ・sambaの設定

> make edit_samba_conf

以下を書き換え、セミコロンを消して行を有効にする<br>
> [homes]<br>
>   comment = Home Directories
>   browseable = yes<br>
>   read only = no
>   valid users = <username>

sambaサーバーを再起動して、設定を反映
> make restart_samba

参考
> https://aquarius-train.hatenablog.com/entry/Samba%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%89%8B%E9%A0%86%E3%81%A8Windows%E3%81%8B%E3%82%89%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E6%96%B9%E6%B3%95

### ・vscode のインストール

以下から deb 64bit版をダウンロード
>https://code.visualstudio.com/download

コマンドラインからインストール
> sudo apt install ./code_1.62.3-1637137107_amd64.deb

コマンドラインからの起動（&はつけなくてよい）
> code