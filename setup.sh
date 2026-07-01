#!/usr/bin/env bash

###############################################################################
# macOS Environment Setup Script
# Based on: https://www.josean.com/posts/terminal-setup
#           https://www.josean.com/posts/how-to-manage-dotfiles-with-gnu-stow
###############################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

command_exists() {
    command -v "$1" &> /dev/null
}

# Check if running on macOS
check_macos() {
    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script is for macOS only"
        exit 1
    fi
    print_info "Running on macOS"
}

# Install Xcode Command Line Tools (includes Git)
install_xcode_tools() {
    if command_exists git; then
        print_success "Git already installed (Xcode Command Line Tools present)"
    else
        print_info "Installing Xcode Command Line Tools (includes Git)..."
        print_warning "A dialog will appear - click 'Install' to proceed"
        xcode-select --install
        
        # Wait for installation to complete
        print_info "Waiting for Xcode Command Line Tools installation..."
        until command_exists git; do
            sleep 5
        done
        
        print_success "Xcode Command Line Tools installed"
    fi
}

# Install Homebrew
install_homebrew() {
    if command_exists brew; then
        print_success "Homebrew already installed"
    else
        print_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
        print_success "Homebrew installed"
    fi
}

# Install GNU Stow
install_stow() {
    if command_exists stow; then
        print_success "GNU Stow already installed"
    else
        print_info "Installing GNU Stow..."
        brew install stow
        print_success "GNU Stow installed"
    fi
}

# Install iTerm2
install_iterm2() {
    if [[ -d "/Applications/iTerm.app" ]]; then
        print_success "iTerm2 already installed"
    else
        print_info "Installing iTerm2..."
        brew install --cask iterm2
        print_success "iTerm2 installed"
        print_warning "Please switch to iTerm2 and re-run this script for the best experience"
    fi
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        print_success "Oh My Zsh already installed"
    else
        print_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        print_success "Oh My Zsh installed"
    fi
}

# Install PowerLevel10k theme
install_powerlevel10k() {
    local P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [[ -d "$P10K_DIR" ]]; then
        print_success "PowerLevel10k already installed"
    else
        print_info "Installing PowerLevel10k theme..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
        print_success "PowerLevel10k installed"
    fi
}

# Install ZSH plugins
install_zsh_plugins() {
    # zsh-autosuggestions
    local AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    if [[ -d "$AUTOSUGGESTIONS_DIR" ]]; then
        print_success "zsh-autosuggestions already installed"
    else
        print_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGESTIONS_DIR"
        print_success "zsh-autosuggestions installed"
    fi
    
    # zsh-syntax-highlighting
    local SYNTAX_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    if [[ -d "$SYNTAX_DIR" ]]; then
        print_success "zsh-syntax-highlighting already installed"
    else
        print_info "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$SYNTAX_DIR"
        print_success "zsh-syntax-highlighting installed"
    fi
}

# Install tmux
install_tmux() {
    if command_exists tmux; then
        print_success "tmux already installed"
    else
        print_info "Installing tmux..."
        brew install tmux
        print_success "tmux installed"
    fi
}

# Install TPM (Tmux Plugin Manager)
install_tpm() {
    local TPM_DIR="$HOME/.tmux/plugins/tpm"
    if [[ -d "$TPM_DIR" ]]; then
        print_success "TPM already installed"
    else
        print_info "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
        print_success "TPM installed"
        print_info "After starting tmux, press prefix + I (Ctrl+a then Shift+i) to install plugins"
    fi
}

# Install fzf (fuzzy finder)
install_fzf() {
    if command_exists fzf; then
        print_success "fzf already installed"
    else
        print_info "Installing fzf..."
        brew install fzf
        print_success "fzf installed"
    fi
}

# Install fd (alternative to find)
install_fd() {
    if command_exists fd; then
        print_success "fd already installed"
    else
        print_info "Installing fd..."
        brew install fd
        print_success "fd installed"
    fi
}

# Install bat (alternative to cat)
install_bat() {
    if command_exists bat; then
        print_success "bat already installed"
    else
        print_info "Installing bat..."
        brew install bat
        print_success "bat installed"
    fi
}

# Install eza (alternative to ls)
install_eza() {
    if command_exists eza; then
        print_success "eza already installed"
    else
        print_info "Installing eza..."
        brew install eza
        print_success "eza installed"
    fi
}

# Install zoxide (alternative to cd)
install_zoxide() {
    if command_exists zoxide; then
        print_success "zoxide already installed"
    else
        print_info "Installing zoxide..."
        brew install zoxide
        print_success "zoxide installed"
    fi
}

# Install git-delta (better git diff viewer)
install_git_delta() {
    if command_exists git-delta; then
        print_success "git-delta already installed"
    else
        print_info "Installing git-delta..."
        brew install git-delta
        print_success "git-delta installed"
    fi
}

# Configure git-delta in ~/.gitconfig
configure_git_delta() {
    print_info "Configuring git-delta..."
    
    git config --global core.pager "delta"
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.navigate "true"
    git config --global delta.side-by-side "true"
    git config --global merge.conflictstyle "diff3"
    git config --global diff.colorMoved "default"
    
    print_success "git-delta configured in ~/.gitconfig"
}

# Backup existing dotfiles
backup_dotfiles() {
    print_info "Checking for existing dotfiles..."
    local BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
    local files=(".zshrc" ".tmux.conf" ".p10k.zsh")
    local backed_up=0
    
    for file in "${files[@]}"; do
        if [[ -f "$HOME/$file" && ! -L "$HOME/$file" ]]; then
            if [[ $backed_up -eq 0 ]]; then
                mkdir -p "$BACKUP_DIR"
            fi
            mv "$HOME/$file" "$BACKUP_DIR/"
            print_info "Backed up $file"
            backed_up=1
        fi
    done
    
    if [[ $backed_up -eq 1 ]]; then
        print_success "Existing dotfiles backed up to: $BACKUP_DIR"
    else
        print_info "No existing dotfiles to backup"
    fi
}

# Stow dotfiles
stow_dotfiles() {
    local DOTFILES_DIR
    
    # Check if already in dotfiles directory
    if [[ "$(basename "$PWD")" == "dotfiles" ]]; then
        DOTFILES_DIR="$PWD"
    elif [[ -d "$HOME/dotfiles" ]]; then
        DOTFILES_DIR="$HOME/dotfiles"
    else
        print_error "Dotfiles directory not found"
        print_info "Please ensure this script is run from the dotfiles directory"
        print_info "Or that your dotfiles are cloned to ~/dotfiles"
        exit 1
    fi
    
    print_info "Stowing dotfiles from: $DOTFILES_DIR"
    cd "$DOTFILES_DIR"
    
    # Unstow first (in case of conflicts)
    stow -D . 2>/dev/null || true
    
    # Stow the dotfiles
    stow -v -t "$HOME" .
    
    print_success "Dotfiles stowed successfully"
}

# Install iTerm2 color scheme
install_iterm_colors() {
    local COLOR_FILE="$HOME/dotfiles/coolnight.itermcolors"
    if [[ -f "$COLOR_FILE" ]]; then
        print_success "iTerm2 color scheme available at: $COLOR_FILE"
        print_info "To apply:"
        print_info "  1. Open iTerm2 Preferences (⌘,)"
        print_info "  2. Go to Profiles > Colors"
        print_info "  3. Click 'Color Presets' > 'Import'"
        print_info "  4. Select: $COLOR_FILE"
        print_info "  5. Choose 'coolnight' from the presets"
    fi
}

# Main setup function
main() {
    echo ""
    echo "###############################################################################"
    echo "#                    macOS Development Environment Setup                     #"
    echo "###############################################################################"
    echo ""
    
    check_macos
    
    # Confirm before proceeding
    read -p "This will install and configure your development environment. Continue? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Setup cancelled"
        exit 0
    fi
    
    echo ""
    print_info "Starting installation..."
    echo ""
    
    # Installation steps
    install_xcode_tools
    install_homebrew
    install_stow
    install_iterm2
    install_oh_my_zsh
    install_powerlevel10k
    install_zsh_plugins
    install_tmux
    install_tpm
    install_fzf
    install_fd
    install_bat
    install_eza
    install_zoxide
    install_git_delta
    configure_git_delta
    
    echo ""
    print_info "Setting up dotfiles..."
    echo ""
    
    # Dotfiles setup
    backup_dotfiles
    stow_dotfiles
    install_iterm_colors
    
    # Post-installation
    echo ""
    echo "###############################################################################"
    print_success "Setup completed successfully!"
    echo "###############################################################################"
    echo ""
    print_info "Next steps:"
    echo ""
    echo "  1. Restart your terminal or run: exec zsh"
    echo ""
    echo "  2. Configure PowerLevel10k (if it doesn't auto-start):"
    echo "     p10k configure"
    echo ""
    echo "  3. Start tmux and install plugins:"
    echo "     tmux"
    echo "     Press: Ctrl+a then Shift+i"
    echo ""
    echo "  4. Apply iTerm2 color scheme (optional):"
    echo "     iTerm2 > Preferences > Profiles > Colors > Import"
    echo ""
    print_warning "Note: If iTerm2 was just installed, please switch to it and restart your terminal"
    echo ""
    print_info "Your dotfiles are symlinked from: ~/dotfiles"
    print_info "Any changes to files in ~/dotfiles will be reflected immediately"
    echo ""
}

# Run main function
main