### Normal installation: ###
`python3 setup.py`
Note that the script needs Python, and you should install Python through
Homebrew (on macOS). This means the part of the script that checks for Homebrew
is redundant. Oh well.

* The `texmf` directory is in different places on different systems (I usually
  only need it on macOS, in `~/Library`), so the script won't copy it.

### Manual installation: ###
Copy `vimrc` to `~/.vimrc`, `vim/*` to `~/.vim/`, etc. Then `source ~/.bashrc`.

Other stuff you should then install (assuming macOS):
* Homebrew
* coreutils
* gnu-sed
* dos2unix
* tree
* Ripgrep
* Vim 8
* Vim Pathogen
* Vim Airline, Airline Themes, and Powerline patched fonts
* Vim ALE
* Vim NERDTree and undotree
* Vim gitgutter
* Vim abolish
* Cling (C++ REPL)
* python, python3, pip, and pip3
* flake8 (for Python 3 only)
* Java (using cask)
* LaTeX (from MacTeX)
* ChkTeX
* Clojure
* Node.js
* Bash completion for git
* gpg, pinentry, pinentry-mac (for signing commits)

### Caveats: ###
* If you don't have permission or for some other reason can't install Vim 8,
  ALE won't work. Syntastic's an option, but in my experience, if you don't
  have that permission, you're on someone else's server, which is going to be
  slow enough that you don't want syntax checking in Vim.
* Cycling color schemes in Vim is known to be buggy. For this reason, cycling
  back to the default in the projector_mode plugin is disabled.

### About `Monokai.terminal`: ###
This is a config file for macOS's built-in Terminal. It gives you nice colors
stolen from the Monokai color scheme. You may or may not need to install the
Powerline patched fonts first. I don't remember.

### About `Pencil.terminal`: ###
This is a high-contrast, light background color scheme for use on projectors. It matches the projector mode color scheme used by the custom `:Beam` command in vim.

### About `sVimrc`: ###
[sVim](https://github.com/flipxfx/sVim) is a Safari extension for vim keybindings.

#### Even more stuff I forget to do: ####
* macOS uses Ctrl+Arrow to switch spaces, so it uses Alt+Arrow to move by words in terminal. This is inane. Change it.
* There are a bunch of cool quicklook plugins. Just Google them.
