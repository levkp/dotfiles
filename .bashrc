# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

# Added by me

source ~/.config/shell/aliases.sh

PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\W\$\[\033[00m\] '

# alias wlc="wl-copy"
# alias cbd="wl-paste >> /home/levi/Documents/Dump/clipboard_dump.txt"

export EDITOR=vim

function add_journal_entry {
    path="/home/levi/Documents/Notes/journal_2024.txt"
    for ((i = 1; i <= 80; i++)); do
        echo -n "—" >> $path
    done
    echo -e "\n" >> $path
    echo "Date:" $(date) >> $path
    echo "Location:" $1 >> $path
    $EDITOR $path
}
