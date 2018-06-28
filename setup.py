# Sets up the dotfiles in my BashVimRCs repo because my setup has gotten too
#  convoluted for me to remember everything.
# Christopher Siu (cesiu)

import os
import sys
import shutil
import subprocess


# A map of files to setup to their delimiters, None if they're files.
_dotfiles = {".bash_profile": '#',
             ".bash_logout": '#',
             ".vim": None,
             ".vimrc": '"',
             ".config": None,
             ".ssh/config": '#',
             ".chktexrc": '#'}
_is_calpoly = False  # Whether or not to target Cal Poly dotfiles.
_home_dir = ""       # The full path of the user's home directory.
# A list of miscellaneous programs to check the existence of, where each
#  3-tuple is of the form, (<command>, <name>, <install command>).
_to_check = [("brew", "Homebrew", "echo \"placeholder\""),
             ("gdb", "GNU Debugger", "echo \"placeholder\""),
             ("valgrind", "Valgrind", "echo \"placeholder\""),
             ("pip2", "pip2", "echo \"placeholder\""),
             ("pip3", "pip3", "echo \"placeholder\""),
             ("flake8", "flake8", "echo \"placeholder\""),
             ("latex", "LaTeX", "echo \"placeholder\""),
             ("chktex", "ChkTeX", "echo \"placeholder\""),
             ("gls", "GNU coreutils", "echo \"placeholder\""),
             ("colordiff", "colordiff", "echo \"placeholder\""),
             ("dos2unix", "dos2unix", "echo \"placeholder\""),
             ("tree", "tree", "echo \"placeholder\""),
             ("rg", "Ripgrep", "echo \"placeholder\""),
             ("cling", "Cling", "echo \"placeholder\""),
             ("clj", "Clojure", "echo \"placeholder\""),
             ("node", "Node.js", "echo \"placeholder\"")]
# In the same form as above, the details for Vim.
_vim_check = ("vim --version | head -n 1", "Vi IMproved 8",
              "echo \"placeholder\"")
# In the same form as above, plugins for Vim.
_vim_plugins = [("~/.vim/autoload/pathogen.vim", "Vim Pathogen",
                 "echo \"placeholder\""),
                ("~/.vim/bundle/vim-airline", "Vim Airline",
                 "echo \"placeholder\""),
                ("~/.vim/bundle/vim-airline-themes", "Vim Airline Themes",
                 "echo \"placeholder\""),
                ("~/.vim/bundle/nerdtree", "Vim NERDTree",
                 "echo \"placeholder\""),
                ("~/.vim/bundle/undotree", "Vim undotree",
                 "echo \"placeholder\""),
                ("~/.vim/bundle/ale", "Vim ALE",
                 "echo \"placeholder\""),
                ("~/.vim/bundle/vim-gitgutter", "Vim gitgutter",
                 "echo \"placeholder\"")]
# The output file for subprocess calls.
_log_out = sys.stdout


def main(argv):
    global _dotfiles, _is_calpoly, _home_dir, _to_check, _vim_check,\
           _vim_plugins, _log_out

    # Check args and perform setup.
    if check_args(argv) == 1 or setup() == 1:
        return 1

    # Copy or update dotfiles.
    for dotfile in _dotfiles:
        if _dotfiles[dotfile] is not None:
            copy_file(dotfile[1:], dotfile, _dotfiles[dotfile])
        else:
            overwrite_dir(dotfile[1:], dotfile)

    # Perform utility checks.
    misc_checks(_to_check)

    # Check the Vim install.
    check_vim(*_vim_check, vim_plugins = _vim_plugins)

    # Clean up.
    if len(argv) == 3 and argv[1] == "-l":
        _log_out.close()
    print("\nDone! Don't forget to \"source ~/.bashrc\".")
    return 0


# Checks command line arguments and sets globals appropriately.
# argv - The command line arguments
def check_args(argv):
    global _dotfiles, _log_out
    last_opt = ""

    for arg in argv[1:]:
        if arg[0] == '-':
            if arg == '-h' or arg == '--help':
                print_usage()
                return 1
            else:
                last_opt = arg
        elif last_opt == "-l" or last_opt == "--logfile":
            _log_out = open(arg, "a")
        elif last_opt == "-e" or last_opt == "--exclude":
            if arg in _dotfiles:
                _dotfiles.pop(arg)


# Prints usage help.
# msg - An optional error message.
def print_usage(msg = ""):
    sys.stderr.write("%sUsage: python3 setup.py [options]\n" % msg)


# Preps for copying by touching all necessary files.
# Returns 1 if there was an exception on file creation, 0 otherwise.
def setup():
    global _dotfiles, _is_calpoly, _home_dir

    # Expand the home directory.
    _home_dir = os.path.expanduser("~")

    # Determine if we need to target Cal Poly's special "mybashrc" file.
    if os.path.isfile("%s/.mybashrc" % _home_dir):
        _is_calpoly = True
        _dotfiles[".mybashrc"] = '#'
    else:
        _dotfiles[".bashrc"] = '#'

    # Touch files if necessary.
    return check_dotfiles(_dotfiles, _home_dir)


# Creates dotfiles if they do not already exist.
# dotfiles - A map of required dotfiles to their delimiters
# home_dir - A list of files in the home directory
# Returns 1 if there was an exception on creation, 0 otherwise.
def check_dotfiles(dotfiles, home_dir):
    for dotfile in dotfiles:
        print("Checking ~/%s..." % dotfile, end = '')
        # If a file does not exist, then...
        if not os.path.exists("%s/%s" % (home_dir, dotfile)):
            # Attempt to create the file.
            print("does not exist. Creating...", end = '')
            try:
                if dotfiles[dotfile] is None:
                    os.makedirs("%s/%s" % (home_dir,
                                '/'.join(dotfile.split('/'))),
                                mode = 0o700, exist_ok = True)
                else:
                    if '/' in dotfile:
                        os.makedirs("%s/%s" % (home_dir,
                                    '/'.join(dotfile.split('/')[:-1])),
                                    mode = 0o700, exist_ok = True)
                    open("%s/%s" % (home_dir, dotfile), "x").close()
            except Exception as e:
                print(e)
                return 1
            print("done.")
        else:
            print("found.")
    return 0


# Copies the contents of one dotfile.
# src - The file in the repo from which to copy
# dest - The file in the home directory to which to copy
# delimiter - The comment character for the file, essentially
def copy_file(src, dest, delimiter):
    in_cesiu = False  # Whether or not we're in the section to copy
    did_copy = False  # Whether or not we've already copied

    print("Setting up ~/%s..." % dest, end = '')
    # Open the destination for reading and a temporary buffer.
    with open(os.path.expanduser("~/%s" % dest), "r") as dest_file,\
         open(".tmpdotfile", "w") as temp_file:
        # For every existing line, do...
        for dest_line in dest_file:
            # Figure out whether or not we need to do some copying.
            if "%s Begin cesiu." % delimiter in dest_line:
                in_cesiu = True
            elif "%s End cesiu." % delimiter in dest_line:
                in_cesiu = False
                continue

            # If we need to copy, then...
            if in_cesiu:
                if not did_copy:
                    print("copying...", end = '')
                    # Open up the source file and copy it into the buffer.
                    with open(src, "r") as src_file:
                        for src_line in src_file:
                            temp_file.write(src_line)
                    did_copy = True
            # Else copy the existing line into the buffer.
            else:
                temp_file.write(dest_line)

        # If we never copied, do it now.
        if not did_copy:
            print("copying...", end = '')
            with open(src, "r") as src_file:
                for src_line in src_file:
                    temp_file.write(src_line)
            did_copy = True

    # Now overwrite the dest file with the temp buffer.
    shutil.copy2(".tmpdotfile", os.path.expanduser("~/%s" % dest))
    print("done.")


# Copies the contents of one directory (dotdir?).
# NOTE: This does not check for existing contents; it just overwrites them!
#       Generally, these are plugin or config files, not settings that might
#       vary depending on environment.
# src - The directory in the repo from which to copy
# dest - The directory in the home directory to which to copy
def overwrite_dir(src, dest):
    # The first level is already properly setup per the setup function, so, for
    #  every node a level down, do...
    for src_node in os.listdir(src):
        print("Setting up ~/%s/%s..." % (dest, src_node), end = '')
        # If it's a directory, then...
        if os.path.isdir("%s/%s" % (src, src_node)):
            # If it already exists, double check with the user -- rmtree is
            #  irreversible!
            if os.path.isdir(os.path.expanduser("~/%s/%s" % (dest, src_node))):
                if input("~/%s/%s already exists! Overwrite? " %
                         (dest, src_node)) == 'y':
                    print("Overwriting tree...", end = '')
                    shutil.rmtree(os.path.expanduser("~/%s/%s"
                                                     % (dest, src_node)))
                else:
                    print("Ignoring...")
                    continue

            # Copy the entire tree.
            shutil.copytree("%s/%s" % (src, src_node),
                            os.path.expanduser("~/%s/%s"
                                               % (dest, src_node)))
        # Else (it's not a directory)...
        else:
            # Again, if it already exists, double check with the user.
            if os.path.isfile(os.path.expanduser("~/%s/%s"
                                                 % (dest, src_node))):
                if input("~/%s/%s already exists! Overwrite? "
                         % (dest, src_node)) == 'y':
                    print("Overwriting file...", end = '')
                else:
                    print("Ignoring...")
                    continue

            # Copy the file.
            shutil.copy2("%s/%s" % (src, src_node),
                         os.path.expanduser("~/%s/%s" % (dest, src_node)))
        print("done.")


# Performs assorted checks for other stuff you should install.
# to_check - A list of 3-tuples representing other programs to check
def misc_checks(to_check):
    for prog in to_check:
        check_cmd(*prog)


# Checks the existence of one program and installs it if necessary.
# cmd - The command that would normally be used to run the program
# name - The human-readable name of the program
# install_cmd - The command that installs the program
def check_cmd(cmd, name, install_cmd):
    global _log_out

    print("Checking %s..." % name, end = '')
    if shutil.which(cmd) is None:
        if input("not found. Install? ") == 'y':
            subprocess.call(install_cmd, stdout = _log_out,
                            stderr = subprocess.STDOUT, shell = True)
    else:
        print("found.")


# Checks the installation of Vim.
# cmd - The command used to display Vim versioning information
# name - The name and version of Vim for which to check
# install_cmd - The command to install Vim
# vim_plugins - Vim plugins for which to check
def check_vim(cmd, name, install_cmd, vim_plugins):
    print("Checking %s..." % name, end = '')
    with open(".tmpdotfile", "w") as temp_file:
        subprocess.call(cmd, stdout = temp_file,
                        stderr = subprocess.STDOUT, shell = True)
    with open(".tmpdotfile", "r") as temp_file:
        if name not in temp_file.read():
            if input("not found or not up-to-date. Install? ") == 'y':
                subprocess.call(install_cmd, stdout = _log_out,
                                stderr = subprocess.STDOUT, shell = True)
        else:
            print("found.")

    for vim_plugin in vim_plugins:
        check_vim_plugin(*vim_plugin)


# Checks the existence of one vim plugin.
# path - The path to the plugin
# name - The name of the plugin
# install_cmd - The command to install the plugin
def check_vim_plugin(path, name, install_cmd):
    print("Checking %s..." % name, end = '')
    if not os.path.exists(os.path.expanduser(path)):
        if input("not found. Install? ") == 'y':
            subprocess.call(install_cmd, stdout = _log_out,
                            stderr = subprocess.STDOUT, shell = True)
    else:
        print("found.")


if __name__ == "__main__":
    sys.exit(main(sys.argv))
