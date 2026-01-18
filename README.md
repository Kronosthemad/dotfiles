# dotfiles
my dotfiles with a bare repository

# Installing
In order to get it so you can have all of the files in the correct place you need to do a pull and it sets it up so you can use the aliases to work with the 
repository

``` sh
git clone --depth 1 https://github.com/Kronosthemad/dotfiles
mv .bashrc .bashrc.bak
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME pull origin master
```

# Getting repo
If you just want to get the files to pull one or two files out of but don't care about keeping up with the bare repo you can jus run

``` sh
git clone --depth 1 https://gihub.com/Kronosthemad/dotfiles
```

# quick setup
This repo has a few dependancys for some of the convenince scripts mostly the fish functions to make it easy to get them all i have written a setup
script that sets up the system the way i use mine and if you want to use it you need to set the name and email for the git setup area to get it you can run

``` sh
nano $HOME/bin/setup-system.sh
$HOME/bin/setup-system.sh
```
If you just closed out of nano your name and email will be set to mine so you should change them by running 

``` sh
git config --global user.name <Your Name>
git config --global user.email <Your Email>
```
