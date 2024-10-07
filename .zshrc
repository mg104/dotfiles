# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/

# SET MY SPECIFIC VARIABLES (PACKAGES, FOLDERS, ETC)

# ZSH
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  zsh-history-substring-search
  zsh-vi-mode
)
ZSH_THEME="powerlevel10k/powerlevel10k"

# APT
APT_PACKAGES=(
  fdfind
  git
  curl
)

# GITHUB (BINARY INSTALLS)
typeset -A BINARY_PACKAGES
BINARY_PACKAGES=(
  # 'kitty' 'https://sw.kovidgoyal.net/kitty/installer.sh' 
)

# FLATPAK

# CONDA/MAMBA
MAMBA_PACKAGES=(
)

# NEW DIRECTORIES IN HOME DIR
NEW_DIRS=(
  # "~/dotfiles"
)

# NEW SYMLINKS
typeset -A SYMLINKS
SYMLINKS=(
  "fdfind" "~/.local/bin/fd"
)


############### INSTALLATION FLAGS ################# 

# INSTALL CONDA FLAG
INSTALL_MAMBA="y"

############# CODE EXECUTION STARTS ############### 

################# CREATE NEW DIRS ################# 
for NEW_DIR in "${NEW_DIRS[@]}"; do
  if [[ ! -e ${NEW_DIR} ]]; then
    mkdir -p ${NEW_DIR}
  fi
done

################# CREATE SYMLINKS ################# 

for TARGET in "${(k)SYMLINKS[@]}"; do
  SYMLINK="${SYMLINKS[$TARGET]}"
  SYMLINK_PARENT_DIR="$(dirname ${SYMLINK})"
  if command -v "${TARGET}" &>/dev/null; then
    TARGET="$(which ${TARGET})"
  fi
  if [[ -e "${TARGET}" && ! -e "${SYMLINK}" ]]; then
      mkdir -p "${SYMLINK_PARENT_DIR}"
      ln -s "${TARGET}" "${SYMLINK}"
  fi
done

################# PACKAGE INSTALLATION ################# 

################# INSTALL APT PACKAGES ################# 

for APT_PACKAGE in "${APT_PACKAGES[@]}"; do
  if ! command -v ${APT_PACKAGE} &>/dev/null ; then
    sudo apt install ${APT_PACKAGE} -y -qq # Install apt packages
  fi
done

################# INSTALL APT PACKAGES ################# 

for BINARY_TOOL_NAME in "${!BINARY_PACKAGES[@]}"; do
  if ! command -v "${BINARY_TOOL_NAME}" &>/dev/null; then
    BINARY_PACKAGE_URL="${BINARY_PACKAGES[${BINARY_TOOL_NAME}]}"
    curl -fsSL -O ${BINARY_PACKAGE_URL}
    chmod +x ${BINARY_PACKAGE_URL}
  fi
done

####################### CONFIGS ######################## 
# To use batpipe, eval the output of this command in your shell init script.
LESSOPEN="|/usr/local/bin/batpipe %s";
export LESSOPEN;
unset LESSCLOSE;

# The following will enable colors when using batpipe with less:
LESS="$LESS -R";
BATPIPE="color";
export LESS;
export BATPIPE;
####################### CONFIGS ######################## 

LESSOPEN="|/usr/local/bin/batpipe %s";
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.local/share:/usr/local/bin:$PATH

# Add mamba/etc to PATH
export PATH=${PATH}:/home/madhur/miniforge3/bin

# Modify MANPATH
export MANPATH=${HOME}/.local/share/man

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Useful plugin to set & modify the themes of ZSH

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

################# SET BY MADHUR ################# 
# Increase the base volume
pactl set-sink-volume @DEFAULT_SINK@ 200%

################ ALIASES ################

# Make alias for nvim
if command -v flatpak &>/dev/null && flatpak info io.neovim.nvim &>/dev/null; then

  if [[ ! -d ~/.local/share/man ]]; then
    mkdir ~/.local/share/man
    rsync -a /usr/share/man ~/.local/share/man
  fi

  flatpak override --user \
    --env=MANPATH=${MANPATH} \
    --env=FLATPAK_ENABLE_SDK_EXT=node20 \
    --env=PATH=${HOME}/.local/share:/app/bin:/usr/bin/:${HOME}/miniforge3/envs/r_env_flatpak_nvim/bin/:${HOME}/.local/bin \
    io.neovim.nvim
fi

nvim() {
  flatpak run io.neovim.nvim "$@"
}

################ ALIASES ################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/madhur/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/madhur/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/madhur/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/madhur/miniforge3/bin:$PATH"
    fi
    eval "$(_CONDA_COMPLETE=source_zsh conda)"
fi
unset __conda_setup
# <<< conda initialize <<<

################ INSTALLING APT PACKAGES ################


################ INSTALLING APT PACKAGES ################

# if [[ -n $(which fdfind) && -e ~/miniforge3/bin && ! -e ~/miniforge3/bin/fd ]]; then
#     ln -s $(which fdfind) ~/miniforge3/bin/fd # Create shorter command name for fdfind
# fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bindkey -rpM viins '^D'
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# Give flatpak the read-only permissions to the manpages
# flatpak override --user --filesystem=host io.neovim.nvim

# Make "nvim" the default display manager for the output of "man ..." commands
# export MANPAGER='flatpak run io.neovim.nvim "$@"'
# export MANPAGER='flatpak run io.neovim.nvim +Man!'
# export MANWIDTH=999

manv() {
  MANPAGER=cat man "$@" | nvim --clean -
}

################# CODE EXECUTION STARTS ################# 
