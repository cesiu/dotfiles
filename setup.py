import os
import sys
import shutil

cur_files = os.listdir(os.path.expanduser("~"))

# Cal Poly has a mybashrc that you're supposed to modify instead.
with open(os.path.expanduser("~/.mybashrc") if ".mybashrc" in cur_files \
          else os.path.expanduser("~/.bashrc"), "a+") as bashrc:
    if "# cesiu" in bashrc.read():
        print "bashrc already set up."
    else:
        with open("bashrc", "r") as additions:
            bashrc.write(additions.read())
        print "Set up bashrc."

if ".bash_profile" in cur_files:
    with open(os.path.expanduser("~/.bash_profile"), "a+") as bash_profile:
        if "# cesiu" in bash_profile.read():
            print "bash_profile already set up."
        else:
            with open("bashrc", "r") as additions:
                bash_profile.write(additions.read())
            print "Set up bash_profile."
else:
    print "bash_profile not found."

with open(os.path.expanduser("~/.bash_logout"), "a+") as bash_logout:
    if "# cesiu" in bash_logout.read():
        print "bash_logout already set up."
    else:
        with open("bash_logout", "r") as additions:
            bash_logout.write(additions.read())
        print "Set up bash_logout."

with open(os.path.expanduser("~/.vimrc"), "rw+") as temp:
    vimrc = temp.read().strip()
    if "\" cesiu" in vimrc:
        print "vimrc already set up."
    else:
        if not vimrc or raw_input("vimrc not empty. Add? ") == 'y':
            with open("vimrc", "r") as additions:
                temp.write(additions.read())
            print "Set up vimrc."

if ".vim" not in cur_files:
    os.mkdir(os.path.expanduser("~/.vim"), 0700)
    print "Created .vim directory."
else:
    print ".vim directory already exists."

for sub_dir in ["after", "colors", "plugin"]:
    if sub_dir not in os.listdir(os.path.expanduser("~/.vim")):
        os.mkdir(os.path.expanduser("~/.vim/" + sub_dir), 0700)
        print "Created " + sub_dir + " directory."
    else:
        print sub_dir + " directory already exists."

try:
    shutil.copytree("vim/after/syntax", \
                    os.path.expanduser("~/.vim/after/syntax"))
except:
    print "syntax directory already exists."

shutil.copy2("vim/colors/monokai.vim", \
             os.path.expanduser("~/.vim/colors/monokai.vim"))
print "Created or overwrote monokai.vim."
shutil.copy2("vim/plugin/cSyntaxAfter.vim", \
             os.path.expanduser("~/.vim/plugin/cSyntaxAfter.vim"))
print "Created or overwrote cSyntaxAfter.vim"

print "Done! Don't forget to install Syntastic, typically done with:\n" \
      + "   mkdir -p ~/.vim/autoload ~/.vim/bundle && \\\n" \
      + "   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim\n" \
      + "Add \"execute pathogen#infect()\" to ~/.vimrc.\n" \
      + "   cd ~/.vim/bundle && \\\n" \
      + "   git clone --depth=1 https://github.com/scrooloose/syntastic.git"
