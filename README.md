# 跨平台开发环境配置

## 项目描述
这是一个多平台开发环境配置项目，用于在 macOS、Linux (Ubuntu) 和 Windows 之间同步命令行开发环境配置和插件。

## 支持的平台
- **macOS**
- **Linux** 
- **Windows**

## 配置组件
- **终端配置**: iTerm2 (macOS)、Wezterm (Windows)、Windows Terminal (Windows 备选)
- **Shell**: Zsh + zinit 插件管理器
- **主题**: Powerlevel10k (p10k)
- **编辑器**: Neovim 配置
- **工具链**: 各种开发工具和插件

## 目录结构
```
├── configs/
│   ├── macos/          # macOS 专用配置
│   ├── linux/          # Linux 专用配置
│   ├── windows/        # Windows 专用配置
│   └── shared/         # 跨平台共用配置
├── scripts/            # 安装和同步脚本
├── backup/             # 配置备份
└── docs/               # 文档
```

## 快速开始

### 📖 详细文档
- **[部署手册](./docs/deployment-guide.md)** - 从零开始的详细部署指南
- **[使用手册](./docs/usage-guide.md)** - 工具和插件的使用技巧

## 当前配置保存
- [x] iTerm2 配置
- [x] Zsh + zinit 配置
- [x] Powerlevel10k 配置
- [x] Neovim 配置

## 配置管理理念
- **声明式配置**: zinit 插件通过 `.zshrc` 中的配置声明管理，自动下载和更新
- **轻量级**: 只备份配置文件，不备份大量的插件文件
- **跨平台一致性**: 确保在不同平台上获得一致的体验

## 贡献
欢迎提交 Issue 和 Pull Request 来改进这个配置项目。
