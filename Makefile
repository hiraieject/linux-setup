
help:


install_emacs:
	sudo apt update
	sudo apt install emacs

install_git:
	sudo apt update
	sudo apt install git

install_dev:
	sudo apt update
	sudo apt install build-essential

# ---------------------------------------------
get_dotfiles:
	(cd ~; git clone https://github.com/hiraieject/.dotfiles.git)
	(cd ~/.dotfiles; ./link.sh)
	source ~/.bashrc

# ---------------------------------------------
get_this:
	(cd ..; apt clone https://github.com/hiraieject/linuxenv.git)

get_memos:
	(cd ~; git clone https://github.com/hiraieject/memos.git)
get_tgtdev:
	(cd ~; git clone https://github.com/hiraieject/tgtdev.git)
get_pcdev:
	(cd ~; git clone https://github.com/hiraieject/pcdev.git)

# ---------------------------------------------
git_config:
	git config --global user.email "you@example.com"
	git config --global user.name "account name"
	git config --global credential.helper store
	@echo 'https://YOUR_ACCOUNT:YOUR_TOKEN@github.com' > ~/.git-credentials
	@chmod og-rwx ~/.git-credentials
	@echo Please edit ~/.git-credentials,  ~/.gitconfig
git_setproxy:
	git config --global http.proxy http://10.77.8.70:8080
	git config --global https.proxy http://10.77.8.70:8080
git_unsetproxy:
	git config --global --unset http.proxy
	git config --global --unset https.proxy
