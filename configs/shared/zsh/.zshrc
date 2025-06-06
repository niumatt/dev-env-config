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

# 核心插件（同步加载，调整加载顺序）
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search

# 语法高亮放在最后，避免冲突
zinit ice wait"0" lucid
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
    # macOS Homebrew 安装路径
    if [[ -d "/opt/homebrew/opt/fzf" ]]; then
        source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2>/dev/null
        source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh" 2>/dev/null
    elif [[ -d "/usr/local/opt/fzf" ]]; then
        source "/usr/local/opt/fzf/shell/completion.zsh" 2>/dev/null
        source "/usr/local/opt/fzf/shell/key-bindings.zsh" 2>/dev/null
    # Ubuntu/Debian apt 安装路径
    elif [[ -f "/usr/share/doc/fzf/examples/completion.zsh" ]]; then
        source "/usr/share/doc/fzf/examples/completion.zsh" 2>/dev/null
        source "/usr/share/doc/fzf/examples/key-bindings.zsh" 2>/dev/null
    elif [[ -f "/usr/share/fzf/completion.zsh" ]]; then
        # 某些 Ubuntu 版本的路径
        source "/usr/share/fzf/completion.zsh" 2>/dev/null
        source "/usr/share/fzf/key-bindings.zsh" 2>/dev/null
    elif [[ -f "/usr/share/zsh/vendor-completions/_fzf" ]]; then
        # Debian 系统可能的路径
        source "/usr/share/bash-completion/completions/fzf" 2>/dev/null
        [[ -f "/usr/share/fzf/key-bindings.zsh" ]] && source "/usr/share/fzf/key-bindings.zsh" 2>/dev/null
    fi
else 
    zinit lucid as=program pick="$ZPFX/bin/(fzf|fzf-tmux)" \
     atclone="cp shell/completion.zsh _fzf_completion; \
     cp bin/(fzf|fzf-tmux) $ZPFX/bin" \
     make="PREFIX=$ZPFX install" for \
     junegunn/fzf
fi

# FZF 环境变量设置（无论哪种安装方式）
if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info --cycle"
    
    # 优先使用现代搜索工具
    if command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"  
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    elif command -v rg >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
fi

# thefuck 集成
if command -v thefuck >/dev/null 2>&1; then
    # 如果已安装，直接使用
    eval $(thefuck --alias)
else
    # 方案3: 传统安装提示
    echo "💡 要安装 thefuck，运行: pip3 install --user thefuck"
    echo "💡 要删除该提醒，则在~/.zshrc中注释掉这两句代码"
fi

# eza 集成
if command -v eza >/dev/null 2>&1; then
    alias ls="eza --icons=always"
    alias ll="eza --icons=always -l"
    alias la="eza --icons=always -la"
else
    echo "💡 暂未安装 eza，请自行安装"
    echo  "💡 要删除该提醒，则在~/.zshrc中注释掉这两句代码"
fi

# PowerLevel10k 配置
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 补全系统初始化
autoload -Uz compinit
compinit
