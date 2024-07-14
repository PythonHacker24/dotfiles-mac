autoload -U compinit; compinit
source ~/.config/zsh-plugins/fzf-tab/fzf-tab.plugin.zsh
source ~/.config/zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(starship init zsh)"

bindkey -v
export KEYTIMEOUT=1
bindkey '^e' edit-command-line
autoload edit-command-line; zle -N edit-command-line

# Custom config 
alias f="ranger"
alias qp="python3 $HOME/.custom_config/banner.py"
alias qr="$HOME/.custom_config/rust_banner"
alias c="clear"
alias e="exit"
alias nv="nvim"
alias nf="neofetch"
alias cf="cpufetch"
alias ff="fzf"
alias dps="docker ps -a"
alias bp="cat $HOME/.custom_config/black_panther_art.txt"
alias bi="brew install"
alias :q="exit"
alias bi="brew install"
alias bu="brew uninstall"
alias fedit="cat << EOF > $1"     # Fast edit with cat and EOF
alias marcus="$HOME/.custom_config/marcus"
alias ss="tty-clock -Ssc"
alias cm="cmatrix"
alias cpumanage="$HOME/.custom_config/cpu_manage"
alias arch="qemu-system-x86_64 -m 2G -hda $HOME/arch_operating_system/archlinux.img"
alias untar="tar xvf"
alias la="lsd -la"
alias browse="ddgr"
alias imgview="kitten icat"
alias rzsh="source ~/.zshrc"
alias kt="kitty +kitten themes --reload-in=all"
alias thome="cd ~; tmux"
alias lz="lazygit"

# Commands replacement 
alias ls="lsd"
alias cat="bat"
# Commands replacement ends

fh() {
  sed '1!G;h;$!d' ~/.zsh_history | awk '!seen[$0]++' | fzf | zsh
}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

shells() {
  cat /etc/shells | awk -F "/" '/^\// {print $NF}' | uniq | sort
}

hollywood_docker() {
  docker run --rm -it bcbcarl/hollywood
}

autoremix() {
  remixd -s ./$1 -u https://remix.ethereum.org
}

data_structures() {
  bat /Users/adityapatil/DSA/data_structures/*
}

fv() {                  # open files in nvim with fuzzy finder                  
  open_loc=$(fzf)
  nvim $open_loc
}

backup() {              # Create Backup of the file
  if [ -f "$1.bak" ]; then
    echo "File: $1 backup already exists, update the backup: [y/n]: "
    read -r backup_option
    if [ "$backup_option" = "y" ]; then
      rm "$1.bak"
      cp "$1" "$1.bak"
      echo "Backup File: $1.bak created successfully!"
    fi
  else
    cp "$1" "$1.bak"
    echo "Backup File: $1.bak created sucessfully!"
  fi
}

# Delete with backup of file
newrm() {
  cp $1 $HOME/.deleted_files
  rm $1
  echo "File: $1 deleted, restore with restore <file> command"
}

restore() {
  cp $HOME/.deleted_files/$1 .
  rm $HOME/.deleted_files/$1
  echo "File: $1 restored sucessfully!"
}

empty_trash() {
  rm $HOME/.deleted_files/*
  echo "Deleted files backup cleared sucessfully"
}

b64() {
  echo "$1" | base64 -d && echo ""
}

fb() {
  feroxbuster --url $1 -w ~/Hacker\'s\ Notes/SecLists/Discovery/Web-Content/common.txt
}

# End of Delete with backup of file

# Git Modifications 
alias gadd="git add ."
alias gcom="git commit -m"
alias gpush="git push"
alias grem="git remote add origin " # remote repository link with .git ending
alias gmain="git push -u origin main"
alias gstatus="git status"
alias glog="git log | nv" 
alias gclone="git clone"
alias gcheckout="git checkout"

gauto() {       # Takes 1 arguement: commit message 
  git add . 
  git commit -m $1
  git push
}

ginit() {       # Takes 1 arguement: remote repository link with .git ending
  git init
  git add .
  git commit -m "initial commit"
  git branch -M main
  git remote add origin $1
  git push -u origin main
}
# Git Aliases End 

export VISUAL=nvim
export EDITOR=nvim

export STM32CubeMX_PATH=/Applications/STMicroelectronics/STM32CubeMX.app/Contents/Resources

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
