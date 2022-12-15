
help:
## first step
##	sudo apt update
##	sudo apt install git build-essential
##	(cd ..; apt clone https://github.com/hiraieject/linuxenv.git)

## second step
##	cd linuxenv
##	make install_basic
##	make install_mozc

## git
##	make config_git
##	emacs ~/.git-credentials

	@echo 'make install_emacs'
	@echo 'make install_git'
	@echo 'make install_dev'
	@echo 'make get_dotfiles'
	@echo 'make get_this'
	@echo 'make get_memos'
	@echo 'make get_tgtdev'
	@echo 'make get_pcdev'
	@echo 'make git_config'
	@echo 'make git_setproxy'
	@echo 'make git_unsetproxy'

gcommit:
	git commit . -m "update"
	git push
gpush:
	git push
gpull:
	git pull

# ------------------------------------------------ sudo nopassword
sudo_nopass:
	echo  > /tmp/add_sudoers
	echo `whoami` "ALL=NOPASSWD: ALL" >> /tmp/add_sudoers
	sudo make _sudo_nopass
_sudo_nopass:
	cat /tmp/add_sudoers >> /etc/sudoers

# ------------------------------------------------ hostname
hostname:
	@if [ AA${NAME} = 'AA' ] ; then \
		echo 'Please enter as below'; \
		echo '  make NAME=<hosrname> hostname'; \
	else \
		sudo hostnamectl set-hostname ${NAME}; \
	fi

# ------------------------------------------------ first install
install_ubuntu_basic:
	make install_dev
	make install_basic
	make install_xterm
	make install_mozc
	make install_cmake
	make install_doxygen
	make install_samba

install_git:
	sudo apt update
	sudo apt install git

install_dev:
	sudo apt update
	sudo apt install build-essential

install_basic:
	sudo apt update
	sudo apt install emacs net-tools global

install_xterm:
	sudo apt update
	sudo apt install xterm

# --------------------------------------------- OpenCV
install_opencvdev:
	sudo apt update
	sudo apt install libopencv-dev

# --------------------------------------------- googletest
install_googletest:
	sudo apt update
	sudo apt install libgoogle-glog-dev
	dpkg -L libgoogle-glog-dev

	sudo apt install libgtest-dev
	dpkg -L libgtest-dev

# ------------------------------------------------ samba
## Sambaサーバーの設定手順(Ubuntu18.04)とWindowsからのアクセス方法
## https://aquarius-train.hatenablog.com/entry/Samba%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%81%AE%E8%A8%AD%E5%AE%9A%E6%89%8B%E9%A0%86%E3%81%A8Windows%E3%81%8B%E3%82%89%E3%81%AE%E3%82%A2%E3%82%AF%E3%82%BB%E3%82%B9%E6%96%B9%E6%B3%95
##
install_samba:
	sudo -E apt update
	sudo -E apt install samba
	sudo systemctl enable smbd
	sudo systemctl enable nmbd
	sudo pdbedit -a hirai
edit_samba_conf:
	sudo vi /etc/samba/smb.conf
restart_samba:
	sudo service smbd restart
	sudo service nmbd restart

# --------------------------------------------- My dotfiles
install_dotfiles:
	(cd ~; git clone https://github.com/hiraieject/.dotfiles.git)
	(cd ~/.dotfiles; ./link.sh)
	source ~/.bashrc

# --------------------------------------------- My folders
clone_linuxenv:
	(cd ~; git clone https://github.com/hiraieject/linuxenv.git)

clone_memos:
	(cd ~; git clone https://github.com/hiraieject/memos.git)
clone_tgtdev:
	(cd ~; git clone https://github.com/hiraieject/tgtdev.git)
clone_pcdev:
	(cd ~; git clone https://github.com/hiraieject/pcdev.git)
clone_pavctdev:
	(cd ~; git clone https://github.com/hiraieject/pavctdev.git)

# --------------------------------------------- git
config_git:
	git config --global user.email "you@example.com"
	git config --global user.name "account name"
	git config --global credential.helper store
	git config pull.rebase false
	@echo 'https://YOUR_ACCOUNT:YOUR_TOKEN@github.com' > ~/.git-credentials
	@chmod og-rwx ~/.git-credentials
	@echo Please edit ~/.git-credentials,  ~/.gitconfig

config_git_setproxy:
	git config --global http.proxy http://10.77.8.70:8080
	git config --global https.proxy http://10.77.8.70:8080

config_git_setproxy86:
	git config --global http.proxy http://192.168.0.86:8080
	git config --global https.proxy http://192.168.0.86:8080

config_git_unsetproxy:
	git config --global --unset http.proxy
	git config --global --unset https.proxy

##  "server certificate verification failed. CAfile: /home/<user>/.ssl/trusted.pem CRLfile: none" エラー対策
config_git_sslvrify:
	git config --global http.sslverify false

##  "fatal: unable to access 'https://XXXXX': server certificate verification failed. CAfile: none CRLfile: none" エラー対策
config_git_fix_certerr:
	sudo apt update
	sudo apt install --reinstall ca-certificates


config_git2:
	rm ~/.gitconfig
	git config --global user.email "hirai.yoshikazu@persol-avct.co.jp"
	git config --global user.name "hirai.yoshikazu"
	cp ~/.gitconfig ~/.gitconfig.pavctgitlab

	rm ~/.gitconfig
	git config --global user.email "you@example.com"
	git config --global user.name "account name"
	git config --global credential.helper store
##	git config --global user.useConfigOnly "true"

	git config --global includeIf."gitdir:nuvoton2210".path ".gitconfig.pavctgitlab"

# --------------------------------------------- mozc
install_mozc:
	sudo apt update
	sudo apt install emacs-mozc-bin
#	(mkdir -p ~/.emacs.d/lisp; cd ~/.emacs.d/lisp; \
#	 wget https://raw.githubusercontent.com/google/mozc/master/src/unix/emacs/mozc.el)

# google jpanese input
# (setq default-input-method "japanese-mozc")
# (require 'mozc)

# --------------------------------------------- cmake
install_cmake:
	sudo apt update
	sudo apt install cmake

# --------------------------------------------- doxygen
install_doxygen:
	sudo apt update
	sudo apt install doxygen graphviz
	sudo apt install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
uninstall_doxygen:
	sudo apt remove doxygen graphviz
	sudo apt remove texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra

# --------------------------------------------- LXC
## https://www.kkaneko.jp/tools/container/lxc.html
## https://ubuntu.com/server/docs/containers-lxc
## https://linuxcontainers.org/ja/lxc/introduction/#LXC

LXCCON=test1

lxc_install:
	sudo apt update
	sudo apt -y install debootstrap lxc lxctl lxc-templates curl
##	lxc-checkconfig

lxc_templates:
	ls -l /usr/share/lxc/templates
lxc_list:
	sudo lxc-ls 

lxc_create:
	sudo lxc-create -t /usr/share/lxc/templates/lxc-ubuntu -n $(LXCCON)
lxc_destroy:
	sudo lxc-destroy -n $(LXCCON)
lxc_start:
	sudo lxc-start -n $(LXCCON)
lxc_stop:
	sudo lxc-stop -n $(LXCCON)
lxc_attach:
	sudo lxc-attach -n $(LXCCON)
lxc_editconf:
	sudo vi /var/lib/lxc/test1/config
