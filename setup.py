# Sets up the dotfiles in my BashVimRCs repo because my setup has gotten too
#  convoluted for me to remember everything.
# Christopher Siu (cesiu)

import os
import sys
import shutil


# A map of files to setup to their delimiters, None if they're files.
_dotfiles = {".bash_profile": '#',
             ".bash_logout": '#',
             ".vim": None,
             ".vimrc": '"',
             ".config": None}
_is_calpoly = False  # Whether or not to target Cal Poly dotfiles.
_home_dir = []       # A list of files already in the home directory.


def main(argv):
    global _dotfiles, _is_calpoly, _home_dir

    if setup() == 1:
        return 1

    for dotfile in _dotfiles:
        if _dotfiles[dotfile] is not None:
            copy_file(dotfile[1:], dotfile, _dotfiles[dotfile])


# Preps for copying by touching all necessary files.
# Returns 1 if there was an exception on file creation, 0 otherwise.
def setup():
    global _dotfiles, _is_calpoly, _home_dir

    # Get the files that are already in the home directory.
    _home_dir = os.listdir(os.path.expanduser("~"))

    # Determine if we need to target Cal Poly's special "mybashrc" file.
    if ".mybashrc" in _home_dir:
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
        if dotfile not in home_dir:
            # Attempt to create the file.
            print("does not exist. Creating..." % dotfile, end = '')
            try:
                if dotfiles[dotfile] is None:
                    os.mkdir(os.path.expanduser("~/%s" % dotfile),
                             mode = 0o700)
                else:
                    open(os.path.expanduser("~/%s" % dotfile, "x")).close()
            except:
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


if __name__ == "__main__":
    sys.exit(main(sys.argv))
