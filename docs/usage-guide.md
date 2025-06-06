# 开发环境使用指南

## 🎯 概述

本开发环境基于 **zsh + zinit + nvim** 构建，提供现代化的命令行开发体验。

### 环境组成
- **Shell**: Zsh with Zinit 插件管理器
- **编辑器**: Neovim with Lazy.nvim 插件管理器
- **终端**:
  - macOS: iTerm2
  - Windows: WezTerm

---

## 🚀 快速入门

### 基本导航

#### Zsh 基础操作
```bash
# 切换目录
cd ~/Documents/projects
cd -  # 返回上一个目录

# 列出文件
ls -la
ll    # 别名，等同于 ls -la

# 查找文件
find . -name "*.js"
```

#### eza - 现代化的 ls 替代工具
eza 是一个功能强大的 `ls` 替代品，提供更美观的输出和更多功能：

```bash
# 基本用法
eza                    # 基本列表，彩色输出
eza -l                 # 长格式列表（类似 ls -l）
eza -la                # 显示隐藏文件的长格式列表
eza -lah               # 人类可读的文件大小格式

# 高级功能
eza --tree             # 树状显示目录结构
eza --tree --level=2   # 限制树状显示的层级
eza -l --git           # 显示 Git 状态信息
eza -l --time-style=long-iso  # 使用 ISO 时间格式

# 排序选项
eza -l --sort=size     # 按文件大小排序
eza -l --sort=modified # 按修改时间排序
eza -l --sort=created  # 按创建时间排序
eza -l --reverse       # 反向排序

# 过滤和显示
eza -l --only-dirs     # 仅显示目录
eza -l --group-directories-first  # 目录优先显示
eza -la --ignore-glob="*.tmp"     # 忽略特定文件

# 彩色和图标
eza --icons            # 显示文件类型图标
eza --no-filesize      # 隐藏文件大小
eza --no-time          # 隐藏时间信息
eza --no-permissions   # 隐藏权限信息
```

**推荐别名设置** (可添加到 `~/.zshrc`)：
```bash
# eza 别名 - 逐步替代传统 ls
alias ls='eza --icons'
alias ll='eza -l --icons --git'
alias la='eza -la --icons --git'
alias tree='eza --tree --icons'
alias lt='eza -l --sort=modified --reverse --icons'  # 最新修改的文件在最前
```

#### 快速目录跳转 (z 插件)
```bash
# 记住访问过的目录，智能跳转
z projects    # 跳转到包含 "projects" 的目录
z doc         # 跳转到包含 "doc" 的目录
```

---

## 🔧 Zsh 插件功能详解

### 1. 自动建议 (zsh-autosuggestions)
- **功能**: 根据历史命令提供智能建议
- **使用**: 输入命令时会显示灰色建议，按 `→` 键接受

```bash
# 示例：输入 "git" 后会提示之前使用过的 git 命令
git s  # 可能提示 "git status"
```

### 2. 自动补全 (zsh-completions)
- **功能**: 增强的 Tab 补全功能
- **使用**: 按 `Tab` 键获得更智能的补全

```bash
# 示例：
docker <Tab>     # 显示所有 docker 子命令
npm run <Tab>    # 显示 package.json 中的脚本
```

### 3. 语法高亮 (fast-syntax-highlighting)
- **功能**: 实时语法高亮，错误命令显示红色
- **特点**: 
  - 正确命令显示绿色
  - 错误/不存在的命令显示红色
  - 字符串、路径等不同颜色区分

### 4. Git 插件 (OMZP::git)
提供大量 Git 别名和功能：

```bash
# 常用别名
g          # git
ga         # git add
gaa        # git add --all
gc         # git commit -v
gca        # git commit -v -a
gco        # git checkout
gd         # git diff
gl         # git pull
gp         # git push
gst        # git status
glog       # git log --oneline --decorate --graph
```

### 5. 文件解压 (OMZP::extract)
统一的解压命令：

```bash
# 支持多种格式的智能解压
extract file.zip
extract file.tar.gz
extract file.rar
extract file.7z
```

### 6. 彩色手册页 (OMZP::colored-man-pages)
- **功能**: 为 man 手册添加颜色高亮
- **使用**: `man ls` 将显示彩色的帮助文档

### 7. 智能配对 (zsh-autopair)
- **功能**: 自动配对括号、引号等
- **特点**: 输入 `(` 自动添加 `)`，输入 `"` 自动配对

### 8. 使用建议 (zsh-you-should-use)
- **功能**: 提醒你使用已配置的别名
- **示例**: 当你输入 `git status` 时，会提示使用 `gst`

### 9. 模糊查找 (fzf)
强大的命令行模糊查找工具：

```bash
# 基本用法
fzf                    # 模糊查找当前目录文件
cat ** <Tab>           # fzf 集成的文件选择
cd ** <Tab>            # fzf 集成的目录选择

# 历史命令搜索
Ctrl+R                 # 模糊搜索历史命令

# 进程查看
kill -9 ** <Tab>       # 模糊选择要结束的进程
```

### 10. 命令纠错 (thefuck)
智能命令纠错工具：

```bash
# 当命令输入错误时
$ git statsu
git: 'statsu' is not a git command.

# 输入 fuck 自动纠正
$ fuck
git status [enter/↑/↓/ctrl+c]
```

---

## 📝 Neovim 使用指南

### 插件概览
我们的 Neovim 配置包含以下主要插件：

1. **主题**: Tokyo Night
2. **补全**: Blink.cmp + Mason LSP
3. **语法高亮**: Tree-sitter
4. **文件管理**: NvimTree + Telescope
5. **Git 集成**: GitSigns
6. **状态栏**: Lualine
7. **智能功能**: 自动括号、注释等

### 基本操作

#### 启动 Neovim
```bash
nvim filename.txt     # 编辑特定文件
nvim .               # 在当前目录启动
```

#### 基本导航
```
h j k l              # 左下上右移动
w                    # 下一个单词
b                    # 上一个单词
0                    # 行首
$                    # 行尾
gg                   # 文件开头
G                    # 文件结尾
```

### 插件快捷键

#### 文件管理
```
<leader>e            # 切换文件树 (NvimTree)
<leader>ff           # 查找文件 (Telescope)
<leader>fg           # 搜索文件内容
<leader>fb           # 查找缓冲区
<leader>fh           # 帮助标签
```

#### Git 操作
```
<leader>gb           # Git blame 当前行
<leader>gp           # 预览 Git 更改
```

#### 编辑功能
```
gcc                  # 注释/取消注释当前行
gc                   # 注释选中区域 (可视模式)
```

#### 代码补全
- `Ctrl+Space`: 触发补全
- `Tab`: 选择下一个补全项
- `Shift+Tab`: 选择上一个补全项
- `Enter`: 确认选择

### 语言服务器 (LSP) 功能

#### 支持的语言
- Python (pylsp)
- Rust (rust-analyzer)
- TypeScript/JavaScript (ts_ls)
- HTML, CSS, JSON
- C/C++ (clangd)
- YAML, Markdown

#### LSP 快捷键
```
gd                   # 跳转到定义
K                    # 显示悬停信息
<leader>rn           # 重命名符号
<leader>ca           # 代码操作
]d                   # 下一个诊断
[d                   # 上一个诊断
```

---

## 💡 高级技巧

### Zsh 高级功能

#### 1. 历史记录增强
```bash
# 搜索包含特定关键词的历史命令
history | grep docker

# 执行历史记录中的特定命令
!123                 # 执行第123条历史命令
!!                   # 执行上一条命令
!$                   # 获取上一条命令的最后一个参数
```

#### 2. 通配符高级用法
```bash
# 递归匹配
ls **/*.js           # 查找所有JS文件
rm **/*.tmp          # 删除所有临时文件

# 字符类匹配
ls *.{js,ts,jsx}     # 匹配多种扩展名
```

#### 3. 进程管理
```bash
# 后台运行
command &            # 后台运行命令
jobs                 # 查看后台任务
fg                   # 将后台任务调至前台
bg                   # 将暂停的任务放到后台

# 任务控制
Ctrl+Z               # 暂停当前任务
Ctrl+C               # 中断当前任务
```

### Neovim 高级技巧

#### 1. 多文件编辑
```
:e filename          # 打开新文件
:vs filename         # 垂直分割打开文件
:sp filename         # 水平分割打开文件
Ctrl+w + h/j/k/l     # 在分割窗口间移动
```

#### 2. 查找和替换
```
/pattern             # 向前搜索
?pattern             # 向后搜索
n                    # 下一个匹配
N                    # 上一个匹配
:%s/old/new/g        # 全文替换
:%s/old/new/gc       # 全文替换（确认）
```

#### 3. 宏录制
```
qa                   # 开始录制宏到寄存器a
...                  # 执行一系列操作
q                    # 停止录制
@a                   # 执行宏a
@@                   # 重复上次宏
```

---

## 🛠️ 自定义配置

### 添加 Zsh 别名
编辑 `~/.zshrc` 或创建 `~/.zsh_aliases`：

```bash
# 常用别名示例
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git 别名
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# 项目相关
alias dev='cd ~/Development'
alias docs='cd ~/Documents'
```

### 自定义 Neovim 配置
在 `~/.config/nvim/lua/` 目录下创建个人配置文件：

```lua
-- ~/.config/nvim/lua/custom.lua
-- 自定义快捷键
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "保存文件" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "退出" })

-- 自定义设置
vim.opt.number = true         -- 显示行号
vim.opt.relativenumber = true -- 相对行号
vim.opt.tabstop = 4          -- Tab 宽度
vim.opt.shiftwidth = 4       -- 缩进宽度
vim.opt.expandtab = true     -- 使用空格替代 Tab
```

---

## 🚨 常见问题解决

### Zsh 相关问题

#### 1. 插件加载缓慢
```bash
# 检查插件加载时间
zsh -i -c exit

# 异步加载慢速插件
zinit ice wait"1" lucid
zinit load "slow-plugin"
```

#### 2. 命令补全不工作
```bash
# 重建补全缓存
rm ~/.zcompdump*
exec zsh
```

### Neovim 相关问题

#### 1. LSP 服务器未启动
```vim
:Mason               " 打开 Mason 管理器
:LspInfo             " 查看 LSP 状态
:LspRestart          " 重启 LSP 服务器
```

#### 2. 插件安装失败
```vim
:Lazy                " 打开 Lazy 插件管理器
:Lazy sync           " 同步所有插件
:Lazy clean          " 清理无用插件
```

---

## 📚 推荐学习资源

### Zsh 资源
- [Zsh 官方文档](https://zsh.sourceforge.io/Doc/)
- [Oh My Zsh Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [Zinit 文档](https://github.com/zdharma-continuum/zinit)

### Neovim 资源
- [Neovim 官方文档](https://neovim.io/doc/)
- [Lua 指南](https://neovim.io/doc/user/lua-guide.html)
- [插件开发指南](https://github.com/nanotee/nvim-lua-guide)

### 在线练习
- [Vim Adventures](https://vim-adventures.com/) - Vim 游戏化学习
- [OpenVim](https://www.openvim.com/) - 交互式 Vim 教程

---

## 🎨 个性化建议

### 主题推荐
```bash
# Zsh 主题 (通过 zinit)
zinit ice depth=1; zinit light romkatv/powerlevel10k

# iTerm2 配色方案
# 推荐：Dracula, Solarized Dark, One Dark
```

### 字体推荐
- **Nerd Fonts**: 支持图标的编程字体
  - Fira Code Nerd Font
  - JetBrains Mono Nerd Font
  - Hack Nerd Font

### 终端配置
```bash
# iTerm2 配置建议
- 启用 Natural Text Editing
- 设置 Unlimited scrollback
- 启用 Focus follows mouse
- 配置 Hotkey Window (快速呼出)
```

---

祝您使用愉快！如有问题，请查阅相关文档或提交 Issue。
