function ssh
    if test -n "$TMUX"
	env (tmux showenv SSH_AUTH_SOCK) ssh $argv[2..-1]
    else
        /usr/bin/ssh $argv[2..-1]
    end
end
