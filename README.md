# Dotfiles Setup (macOS)

Personal dotfiles managed with GNU Stow for macOS.

## Quick Start

Run the automated setup script:

```bash
git clone https://github.com/[YOUR-USERNAME]/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```

## What Gets Installed

### Core Tools (via Homebrew)
- **Homebrew** - Package manager for macOS
- **Git** - Version control
- **GNU Stow** - Symlink manager for dotfiles
- **iTerm2** - Terminal emulator
- **tmux** - Terminal multiplexer

### Shell Setup
- **Oh My Zsh** - ZSH framework
- **PowerLevel10k** - ZSH theme with awesome prompts
- **zsh-autosuggestions** - Fish-like command suggestions
- **zsh-syntax-highlighting** - Fish-like syntax highlighting

### Tmux Setup
- **TPM** - Tmux Plugin Manager
- **vim-tmux-navigator** - Seamless navigation between vim and tmux
- **tmux-themepack** - Theme support
- **tmux-resurrect** - Session persistence across reboots
- **tmux-continuum** - Automatic session saving

## File Structure

```
dotfiles/
├── .zshrc                    # ZSH configuration
├── .tmux.conf               # Tmux configuration
├── .stow-local-ignore       # Files to ignore when stowing
├── coolnight.itermcolors    # iTerm2 color scheme
├── iterm-default.json       # iTerm2 settings export
├── setup.sh                 # Automated setup script
└── README.md               # This file
```

## Manual Setup (Alternative)

If you prefer step-by-step control:

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Add to PATH:
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Install Core Tools

```bash
brew install git stow tmux
brew install --cask iterm2
```

### 3. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 4. Install PowerLevel10k Theme

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### 5. Install ZSH Plugins

```bash
# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### 6. Install TPM (Tmux Plugin Manager)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 7. Clone and Stow Dotfiles

```bash
# Clone your dotfiles
git clone https://github.com/[YOUR-USERNAME]/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Backup existing dotfiles (optional)
mkdir -p ~/dotfiles_backup
mv ~/.zshrc ~/dotfiles_backup/ 2>/dev/null || true
mv ~/.tmux.conf ~/dotfiles_backup/ 2>/dev/null || true

# Create symlinks
stow -v -t ~ .
```

### 8. Apply Configuration

```bash
# Reload ZSH
exec zsh

# Configure PowerLevel10k (if not auto-started)
p10k configure

# Start tmux and install plugins
tmux
# Press: Ctrl+a then Shift+i
```

## Configuration Details

### ZSH (.zshrc)
- **Theme**: PowerLevel10k
- **Plugins**: git, vscode, zsh-autosuggestions, zsh-syntax-highlighting
- Add custom aliases at the bottom of the file

### Tmux (.tmux.conf)
- **Prefix**: `Ctrl+a` (instead of default `Ctrl+b`)
- **Split panes**: 
  - `|` for vertical split
  - `-` for horizontal split
- **Reload config**: `prefix + r`
- **Resize panes**: `prefix + h/j/k/l` (vim-style)
- **Maximize pane**: `prefix + m`
- **Mouse support**: Enabled
- **Copy mode**: Vi keys (`prefix + [` to enter)

### iTerm2 Color Scheme

Apply the included color scheme:

1. Open iTerm2 Preferences (`⌘,`)
2. Navigate to: **Profiles** > **Colors**
3. Click **Color Presets** dropdown
4. Select **Import**
5. Choose: `~/dotfiles/coolnight.itermcolors`
6. Select **coolnight** from the presets

## Managing Your Dotfiles

### Making Changes

Simply edit files in `~/dotfiles`. Changes are reflected immediately since they're symlinked:

```bash
vim ~/dotfiles/.zshrc
# Changes are immediately active in ~/.zshrc
```

### Adding New Dotfiles

```bash
cd ~/dotfiles

# Move file from home directory
mv ~/.config/somefile .config/

# Restow to create new symlinks
stow -R .
```

### Syncing to Another Mac

```bash
# On new Mac
git clone https://github.com/[YOUR-USERNAME]/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

### Pushing Changes

```bash
cd ~/dotfiles
git add .
git commit -m "Updated configuration"
git push
```

### Removing Symlinks

```bash
cd ~/dotfiles
stow -D .
```

## Troubleshooting

### Stow reports conflicts

```bash
# The file exists and isn't a symlink. Back it up:
mv ~/.zshrc ~/.zshrc.backup

# Try stowing again
cd ~/dotfiles
stow -v -t ~ .
```

### PowerLevel10k not loading

```bash
# Verify installation
ls ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Check .zshrc theme setting
grep "ZSH_THEME" ~/.zshrc
# Should show: ZSH_THEME="powerlevel10k/powerlevel10k"

# Reload and reconfigure
exec zsh
p10k configure
```

### Tmux plugins not installing

```bash
# Verify TPM installation
ls ~/.tmux/plugins/tpm

# In tmux, reload config
prefix + r
# (That's Ctrl+a, then r)

# Install plugins
prefix + Shift+i
# (That's Ctrl+a, then Shift+i)
```

### ZSH plugins not working

```bash
# Verify plugin installation
ls ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/

# Check .zshrc plugins line
grep "plugins=" ~/.zshrc
# Should include: zsh-autosuggestions zsh-syntax-highlighting

# Reload ZSH
exec zsh
```

## Quick Command Reference

### Stow Commands
```bash
cd ~/dotfiles
stow .          # Create symlinks
stow -R .       # Restow (recreate symlinks)
stow -D .       # Remove symlinks
stow -n .       # Dry run (see what would happen)
```

### Tmux Commands
```bash
tmux                    # Start new session
tmux ls                 # List sessions
tmux attach             # Attach to session
tmux kill-session       # Kill session

# Inside tmux (prefix = Ctrl+a):
prefix + |              # Split vertically
prefix + -              # Split horizontally
prefix + h/j/k/l        # Resize pane
prefix + m              # Maximize/restore pane
prefix + r              # Reload config
prefix + Shift+i        # Install plugins
prefix + [              # Enter copy mode
```

## Additional Tools to Consider

Optional tools that work well with this setup:

```bash
# Development tools
brew install neovim          # Modern vim
brew install fzf             # Fuzzy finder
brew install ripgrep         # Fast grep alternative
brew install bat             # Better cat with syntax highlighting
brew install exa             # Modern ls replacement
brew install node            # Node.js

# Fonts
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

## Resources

- [Josean's Terminal Setup Guide](https://www.josean.com/posts/terminal-setup)
- [Managing Dotfiles with GNU Stow](https://www.josean.com/posts/how-to-manage-dotfiles-with-gnu-stow)
- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Oh My Zsh Documentation](https://github.com/ohmyzsh/ohmyzsh)
- [PowerLevel10k](https://github.com/romkatv/powerlevel10k)
- [TPM Documentation](https://github.com/tmux-plugins/tpm)

## License

Free to use and modify as needed.