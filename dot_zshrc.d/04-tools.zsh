if [[ "$CLAUDECODE" != "1" ]]; then
    eval "$(zoxide init --cmd cd zsh)"
fi

eval "$(thefuck --alias)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh && source ~/.fzf-git.sh

# starship
eval "$(starship init zsh)"

# direnv
eval "$(direnv hook zsh)"
