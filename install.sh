#!/usr/bin bash
# CORE
echo 'Upgrading and installing core packages'
sudo pacman -Syu
sudo pacman -S awesome base base-devel docker docker-compose \
	git lightdm lightdm-slick-greeter neovim network-manager-applet \
	networkmanager openssh picom rofi sudo timeshift tmux xclip zsh

echo 'Configuring git..'
read -p 'Github user: ' gituser
read -p 'Github email: ' gitemail
echo 'Setting up SSH key, using github email'
ssh-keygen -t ed25519 -C "$gitemail"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
echo 'Copy and add new public key to github'
cat ~/.ssh/id_ed25519.pub
echo PRESS ANY KEY TO CONTINUE SETUP
# Give some time to setup SSH with Github
read -n 1 -s

# DOTFILES
echo 'Cloning dotfiles'
git clone git@github.com:jdearly/dotfiles.git $HOME/.dotfiles

# ZSH
echo 'Setting up ZSH'
chsh -s /bin/zsh
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh > ~/.oh-my-installer && chmod +x ~/.oh-my-installer && ~/.oh-my-installer
git clone https://github.com/zsh-users/zsh-autosuggestions.git $HOME/.oh-my-zsh/plugins/zsh-autosuggestions

# TMUX
echo 'Cloning TMUX TPM'
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
