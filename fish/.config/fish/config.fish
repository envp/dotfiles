set -g EDITOR nvim

# Git prompt
set -g __fish_git_prompt_show_informative_status 'yes'
set -g __fish_git_prompt_color_upstream_ahead brgreen
set -g __fish_git_prompt_color_upstream_behind brred
set -g __fish_git_prompt_color_branch brmagenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

# If 'bat' is available, use is as $MANPAGER.
if command -qs bat
    set -gx BAT_PAGER 'less -R'
    set -gx MANPAGER 'sh -c "col -bx | bat -l man -p --theme \'Monokai Extended Light\'"'
end

# Set GPG_TTY so that GPG can ask for a password
set -g GPG_TTY (tty)

# Non standard extensions to $PATH
set -l paths_with_binaries \
  "$HOME/.local/bin" \
  "$HOME/.cargo/bin" \
  "$HOME/.cabal/bin" \
  "$HOME/.ghcup/bin" \
  "/usr/local/opt/bin" \
  "/usr/local/opt/llvm/bin" \
  "/usr/local/opt/coreutils/libexec/gnubin" \
  "/usr/local/opt/findutils/libexec/gnubin" \
  "/usr/local/opt/binutils/bin" \
  "/usr/local/opt/gawk/libexec/gnubin" \
  "/usr/local/opt/gnu-getopt/bin" \
  "/usr/local/opt/gnu-indent/libexec/gnubin" \
  "/usr/local/opt/gnu-sed/libexec/gnubin" \
  "/usr/local/opt/gnu-tar/libexec/gnubin" \
  "/usr/local/opt/gnu-which/libexec/gnubin" \
  "/usr/local/opt/gnu-time/libexec/gnubin" \
  "/usr/local/opt/gcc/bin/" \
  "/usr/local/opt/sqlite/bin" \
  "/usr/local/opt/bison/bin" \
  "/usr/local/sbin"

# Clear user paths before setting again
set -u fish_user_paths
# Don't want this this to be -U otherwise its preserved across shell
# restarts
fish_add_path --global --append $paths_with_binaries


set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --glob '!{.git,target}'"
set -gx FZF_CTRL_T_COMMAND "rg --files --hidden --glob '!{.git,target,build}'"

set -gx PKG_CONFIG_PATH "/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"
set -gx PKG_CONFIG_PATH "/usr/local/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH"
set -gx PKG_CONFIG_PATH "/usr/local/opt/lapack/lib/pkgconfig:$PKG_CONFIG_PATH"
set -gx PKG_CONFIG_PATH "/usr/local/Cellar/pcre2/10.42/lib/pkgconfig:$PKG_CONFIG_PATH"

source ~/.config/fish/lscolors.fish

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ;  # ghcup-env
