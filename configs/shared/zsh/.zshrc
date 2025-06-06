source ~/.bash_profile

# 环境变量设置
export LANGUAGE=en_US
export LANG=en_US.UTF-8

# 历史记录配置
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

# 启用 vi 模式
bindkey -v

# Zinit 安装和初始化
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# PowerLevel10k 即时提示
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 主题
zinit ice depth=1; zinit light romkatv/powerlevel10k

# 核心插件（同步加载）
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting

# 实用插件（异步加载）
zinit wait lucid for \
    OMZP::git \
    OMZP::extract \
    OMZP::colored-man-pages \
    hlissner/zsh-autopair \
    MichaelAquilina/zsh-you-should-use

# 目录跳转
zinit wait lucid light-mode for rupa/z

# FZF 集成（如果已安装）
if command -v fzf >/dev/null 2>&1; then
    if [[ -d "/opt/homebrew/opt/fzf" ]]; then
        source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2>/dev/null
        source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" 2>/dev/null
    elif [[ -d "/usr/local/opt/fzf" ]]; then
        source "/usr/local/opt/fzf/shell/completion.zsh" 2>/dev/null
        source "/usr/local/opt/fzf/shell/key-bindings.zsh" 2>/dev/null
    fi
fi

# thefuck 集成（如果已安装）
if command -v thefuck >/dev/null 2>&1; then
    eval $(thefuck --alias)
fi

# PowerLevel10k 配置
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 补全系统初始化
autoload -Uz compinit
compinit 