function fish_greeting
end

function fish_prompt
    ~/.prompt/powerline-shell.py $status --mode patched --cwd-max-depth 3 --shell bare ^/dev/null
end

function fish_right_prompt
	set last_status $status

	if math $last_status >> /dev/null
		set_color 875F00
		echo -ne '\b' \uE0B2
		set_color -b 875F00
		set_color FFFF00
		echo -n '' $last_status ''
		set_color normal
	end
end

#https://www.reddit.com/r/ProgrammerHumor/comments/5py7dg/i_think_this_sums_it_up/dcuwrzc/
#function extract
#    switch (echo $argv[1])
#    case *.tar.bz2
#        echo tar xvjf $argv[1]
#        tar xvjf $argv[1]
#    case *.tar.gz
#        echo tar zxvf $argv[1]
#        tar zxvf $argv[1]
#    end
#end


alias la "ls -a"

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
