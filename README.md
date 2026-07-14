# kickstart.nvim

## Introduction

一个 Neovim 的起点配置，具有以下特点：

* 小巧
* 单文件
* 文档齐全

**不是**一个 Neovim 发行版，而是你配置的起点。

## Installation

### Install Neovim

Kickstart.nvim **仅** 支持最新的
[稳定版](https://github.com/neovim/neovim/releases/tag/stable) 和最新的
[每夜版](https://github.com/neovim/neovim/releases/tag/nightly) Neovim。
如果你遇到问题，请确保你至少安装了最新的稳定版。通常，你更希望通过 [包管理器](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package) 来安装 neovim。
要检查 neovim 版本，请运行 `nvim --version`，确保其不低于最新的
[稳定版](https://github.com/neovim/neovim/releases/tag/stable)。如果你选择的安装方式只能获得过时的 neovim 版本，请查看下方的 [其他安装方法](#alternative-neovim-installation-methods)。

### Install External Dependencies

外部依赖要求：
- 基本工具：`git`、`make`、`unzip`、C 编译器（`gcc`）
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)、
  [fd-find](https://github.com/sharkdp/fd#installation)
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md#installation)
- 剪贴板工具（根据平台选择 xclip/xsel/win32yank 等）
- [Nerd Font](https://www.nerdfonts.com/)：可选，提供各种图标
  - 如果有安装，请在 `init.lua` 中将 `vim.g.have_nerd_font` 设置为 true
- Emoji 字体（仅限 Ubuntu，且只有当你需要 emoji 时！）`sudo apt install fonts-noto-color-emoji`
- 语言环境设置：
  - 如果要编写 TypeScript，需要 `npm`
  - 如果要编写 Golang，需要 `go`
  - 等等。

> [!NOTE]
> 请参阅 [Install Recipes](#Install-Recipes) 获取 Windows 和 Linux 的额外说明以及快速安装命令片段。

### Install Kickstart

> [!NOTE]
> 请先 [备份](#FAQ) 你之前的配置（如果存在）

Neovim 的配置文件位于以下路径，取决于你的操作系统：

| 操作系统 | 路径 |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`、`~/.config/nvim` |
| Windows (cmd) | `%localappdata%\nvim\` |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[复刻（Fork）](https://docs.github.com/en/get-started/quickstart/fork-a-repo) 此仓库，以便你拥有自己可修改的副本，然后根据你的操作系统，使用下面相应的命令将复刻版本克隆到你的计算机。

> [!NOTE]
> 你复刻后的仓库 URL 格式类似于：
> `https://github.com/<你的GitHub用户名>/kickstart.nvim.git`

你可能还想从复刻仓库的 `.gitignore` 文件中移除 `nvim-pack-lock.json` —— 它在 kickstart 仓库中被忽略是为了方便维护，但建议在版本控制中跟踪它（参见 `:help vim.pack-lockfile`）。

#### Clone kickstart.nvim

> [!NOTE]
> 如果按照上面的推荐步骤操作（即复刻仓库），请在以下命令中将 `nvim-lua` 替换为 `<你的GitHub用户名>`

<details><summary> Linux 和 Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

如果你使用 `cmd.exe`：

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

如果你使用 `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

启动 Neovim

```sh
nvim
```

就是这样！`vim.pack` 会根据你的配置安装所有插件。使用
`:lua vim.pack.update(nil, { offline = true })` 来检查插件状态，使用
`:lua vim.pack.update()` 来获取更新（`:write` 应用更新，`:quit` 取消更新）。

#### Read The Friendly Documentation

阅读你配置文件夹中的 `init.lua` 文件，了解更多关于扩展和探索 Neovim 的信息，其中还包括添加一些常见需求插件的示例。

> [!NOTE]
> 关于特定插件的更多信息，请查阅其仓库的文档。

### Getting Started

[开始使用 Neovim 唯一需要看的视频](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* 如果我已经有现有的 Neovim 配置，该怎么办？
  * 你应该备份它，然后删除所有相关文件。
  * 这包括你现有的 init.lua 以及 `~/.local` 中的 Neovim 文件，可以使用 `rm -rf ~/.local/share/nvim/` 删除。
* 我能将现有配置与 kickstart 并行保留吗？
  * 可以！你可以使用 [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME` 来维护多个配置。例如，你可以将 kickstart 配置安装到 `~/.config/nvim-kickstart` 并创建一个别名：
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    当你使用 `nvim-kickstart` 别名运行 Neovim 时，它将使用备用配置目录以及对应的本地目录 `~/.local/share/nvim-kickstart`。你可以将此方法应用于任何你想尝试的 Neovim 发行版。
* 如果我想“卸载”此配置怎么办：
  * 删除你的配置目录和本地数据目录（例如，`~/.config/nvim` 和 `~/.local/share/nvim`）。
* 为什么 kickstart 的 `init.lua` 是一个单文件？把它拆分成多个文件不是更合理吗？
  * kickstart 的主要目的是作为教学工具和参考配置，方便他人通过 `git clone` 快速使用并作为自己配置的基础。随着你学习 Neovim 和 Lua 的深入，你可能会考虑将 `init.lua` 拆分成更小的部分。有一个 kickstart 的复刻版本实现了同样的功能且拆分了文件，可在此获取：
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * 相关讨论可查看：
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

下面你可以找到针对特定操作系统的 Neovim 及其依赖的安装说明。

安装所有依赖后，继续执行 [安装 Kickstart](#install-kickstart) 步骤。

#### Windows Installation

<details><summary>使用 Microsoft C++ Build Tools 和 CMake 的 Windows</summary>
Kickstart 默认配置仅针对 `telescope-fzf-native.nvim` 使用 make 构建。如果 `make` 不可用，该插件会被跳过。

推荐：安装 `make`（见下方 chocolatey 部分）。

如果你想要纯 CMake 设置，请在 `init.lua` 两处进行自定义：

1. 当 `cmake` 可用时包含 `telescope-fzf-native.nvim`：

```lua
if vim.fn.executable 'make' == 1 or vim.fn.executable 'cmake' == 1 then
  table.insert(plugins, gh 'nvim-telescope/telescope-fzf-native.nvim')
end
```

2. 在 `PackChanged` 钩子中，当 `make` 不可用时使用 CMake：

```lua
if name == 'telescope-fzf-native.nvim' then
  if vim.fn.executable 'make' == 1 then
    run_build(name, { 'make' }, ev.data.path)
  elseif vim.fn.executable 'cmake' == 1 then
    run_build(name, { 'cmake', '-S.', '-Bbuild', '-DCMAKE_BUILD_TYPE=Release' }, ev.data.path)
    run_build(name, { 'cmake', '--build', 'build', '--config', 'Release', '--target', 'install' }, ev.data.path)
  end
  return
end
```

有关构建细节，请参阅 `telescope-fzf-native` 的 [文档](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)。
</details>
<details><summary>使用 chocolatey 安装 gcc/make 的 Windows</summary>
或者，你也可以安装 gcc 和 make，这样就无需修改配置，最简单的方法是使用 choco：

1. 安装 [chocolatey](https://chocolatey.org/install)
   按照页面说明或使用 winget，以 **管理员** 身份在 cmd 中运行：
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. 使用 choco 安装所有依赖，退出之前的 cmd 并打开一个新的以确保 choco 路径已设置，然后以 **管理员** 身份在 cmd 中运行：
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make tree-sitter
```
</details>
<details><summary>WSL (适用于 Linux 的 Windows 子系统)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu 安装步骤</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip neovim
```
</details>
<details><summary>Debian 安装步骤</summary>

```
sudo apt update
sudo apt install make gcc ripgrep fd-find tree-sitter-cli unzip git xclip curl

# 现在安装 nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# 使其在 /usr/local/bin 中可用，发行版通常会安装到 /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora 安装步骤</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find tree-sitter-cli unzip neovim
```
</details>

<details><summary>Arch 安装步骤</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd tree-sitter-cli unzip neovim
```
</details>

### Alternative neovim installation methods

对于某些系统，Neovim 推荐的 [包管理器安装方式](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-package) 可能严重过时，这并不罕见。如果你遇到这种情况，请从以下方法中选择一种，这些方法以能快速提供最新 Neovim 版本而闻名。它们因流行且易于安装和更新 Neovim 至最新版而被选中。你还可以在 [这里](https://github.com/nvim-lua/kickstart.nvim/issues/1583) 查看关于可用方法的更多讨论。

<details><summary>Bob</summary>

[Bob](https://github.com/MordechaiHadad/bob) 是一个适用于所有平台的 Neovim 版本管理器。只需安装
[rustup](https://rust-lang.github.io/rustup/installation/other.html)，然后运行以下命令：

```bash
rustup default stable
rustup update stable
cargo install bob-nvim
bob use stable
```

</details>

<details><summary>Homebrew</summary>

[Homebrew](https://brew.sh) 是一个在 Mac 和 Linux 上流行的包管理器。只需使用 [`brew install`](https://formulae.brew.sh/formula/neovim) 安装即可。

</details>

<details><summary>Flatpak</summary>

Flatpak 是一个应用程序包管理器，它允许开发者只需打包一次，就能让应用在所有 Linux 系统上可用。只需 [安装 flatpak](https://flatpak.org/setup/) 并设置 [flathub](https://flathub.org/setup) 来 [安装 neovim](https://flathub.org/apps/io.neovim.nvim)。

</details>

<details><summary>asdf 和 mise-en-place</summary>

[asdf](https://asdf-vm.com/) 和 [mise](https://mise.jdx.dev/) 是工具版本管理器，主要用于项目特定的工具版本控制。不过两者也支持在用户空间中全局管理工具：

<details><summary>mise</summary>

[安装 mise](https://mise.jdx.dev/getting-started.html)，然后运行：

```bash
mise plugins install neovim
mise use neovim@stable
```

</details>

<details><summary>asdf</summary>

[安装 asdf](https://asdf-vm.com/guide/getting-started.html)，然后运行：

```bash
asdf plugin add neovim
asdf install neovim stable
asdf set neovim stable --home
asdf reshim neovim
```

</details>

</details>
