# Clone repos
git clone git@github.com:StuckAt7/dotfiles.git

# Install pyenv
sudo apt-get install git python-pip make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl libffi-dev
sudo pip install virtualenvwrapper

git clone https://github.com/yyuu/pyenv.git ~/.pyenv
git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'pyenv virtualenvwrapper' >> ~/.bashrc

exec $SHELL

# Setup global python 
pyenv install 3.7.6
pyenv global 3.7.6

#Setup python and jupyter
pip install jupyter numpy scipy matplotlib seaborn pandas
jupyter notebook --generate-config


# Setup haskell
sudo apt-get install haskell-stack
sudo apt-get install 
git clone https://github.com/gibiansky/IHaskell
pip install -r requirements.txt
