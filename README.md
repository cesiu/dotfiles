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
* python, python3, pip, and pip3
* flake8
* LaTeX
* Vim 8
* Vim Pathogen
* Vim Airline, Airline Themes, and Powerline patched fonts
* Vim ALE 
* Vim NERDTree
* coreutils
* dos2unix
* tree
* Leiningen (Clojure build manager)
* Node.js

If you don't have permission or for some other reason can't install Vim 8, ALE
won't work. Syntastic's an option, but in my experience, if you don't have that
permission, you're on someone else's server, which is going to be slow enough
that you don't want syntax checking in Vim.

### About `Monokai.terminal`: ###
This is a config file for macOS's built-in Terminal. It gives you nice colors
stolen from the Monokai color scheme. If you install Vim Airline with the
Powerline patched fonts, you need to install this config, set it as default,
_and_ change the font to one of the patched fonts.
