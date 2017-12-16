### Normal installation: ###
`python3 setup.py`
Note that the script needs Python, and you should install Python through
Homebrew (on macOS). This means the part of the script that checks for Homebrew
is redundant. Oh well.

### Manual installation: ###
Copy `vimrc` to `~/.vimrc`, `vim/*` to `~/.vim/`, etc. Then `source ~/.bashrc`.

Other stuff you should then install (assuming macOS):
* Homebrew
* GDB
* Valgrind
* Cling (C++ REPL)
* python, python3, pip, and pip3
* flake8
* Java (using cask)
* LaTeX (from MacTeX)
* ChkTeX
* Vim 8
* Vim Pathogen
* Vim Airline, Airline Themes, and Powerline patched fonts
* Vim ALE
* Vim NERDTree
* Vim gitgutter
* coreutils
* dos2unix
* tree
* Bash completion for git
* Leiningen (Clojure build manager)
* Node.js

### Caveats: ###
* If you don't have permission or for some other reason can't install Vim 8,
  ALE won't work. Syntastic's an option, but in my experience, if you don't
  have that permission, you're on someone else's server, which is going to be
  slow enough that you don't want syntax checking in Vim.
* Cycling color schemes in Vim is known to be buggy. For this reason, cycling
  back to the default in the projector_mode plugin is disabled.
* Leiningen won't download the Clojure JAR until you run it once. After
  installing it, you need to run `lein repl` once, otherwise the bashrc won't
  find the JAR.

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

#### Stuff I need to check sometime: ####
* ALE is running syntax checking on load? And not picking up flake8 configs?
  Don't pull it for now.
* Did ChkTeX get installed with MacTeX?
