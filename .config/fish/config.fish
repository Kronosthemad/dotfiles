if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr ls "ls -a"
    abbr dgit "dotfiles-git"

    fastfetch
end
alias dotfiles-git "git --work-tree=$HOME --git-dir=$HOME/dotfiles" 
