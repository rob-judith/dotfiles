""" Install script for my dotfiles. This adds a source PATH/TO/DOTFILE
line to each of the config files int he directory. It will optionally
append the old config file after the source line, allowing you to keep
custom settings. It will also optionally back up your old config files to
*.backup.
"""
import os
import sys

def yes_no_to_true_false(string):
    if string[0].lower() == 'y':
        return True
    else:
        return False


script_path = sys.path[0]

install_paths = [('bash_profile', ('~/.bash_profile', '~/.bashrc')),
                ('tmux.conf', ('~/.tmux.conf',)),
                ('gitconfig', ('~/.gitconfig',))]

# Get user responses
contin = raw_input("This script sets up your configuration files by adding"
        " to the dotfiles configuration files. \n" 
        "Would you like to continue (y,n):"
        )

# Ask the user if he wants to exit.
if not yes_no_to_true_false(contin):
    sys.exit()

backup = yes_no_to_true_false(
        raw_input("Would you like to backup your current config files?"
                  " (y,n):"))
append = yes_no_to_true_false(
        raw_input("Would you like to append your current config files?"
                  " (y,n):"))

        
# Handle Config Files
for config_file, paths in install_paths:
    for path in paths:
        path = os.path.expanduser(path)
        if os.path.isfile(path):
            os.system('mv "{}" "{}"'.format(path, path+'.backup'))
            print 'Backing up "{}" to "{}"'.format(path, path+'.backup')
        
        print 'Adding source to "{}"'.format(path)
        if config_file == 'gitconfig':
            git_line = ("[include]\n"
                        "    path = {}\n\n"
                        "[core]\n"
                        "    excludesfile = {}\n").format(script_path + '/' +
                                                config_file, script_path +
                                                '/gitignore')
            os.system('echo "{}" > "{}"'.format(git_line, path))
        else:
            os.system('echo "source {}" > {}'.format(script_path + '/' + 
                      config_file, path))

        if os.path.isfile(path+'.backup') and append:
            print 'Appending old config to "{}"'.format(path)
            os.system('cat "{}" >> {}'.format(path + '.backup', path))

        if os.path.isfile(path+'.backup') and not backup:
            print "Removing backup {}".format(path + '.backup')
            os.system('rm "{}"'.format(path + '.backup'))


