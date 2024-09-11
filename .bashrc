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

PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\W\$\[\033[00m\] '

alias lla="ls -la"
alias du="du -h"
alias dr="docker"
alias ff="sudo find / -type f -name"
alias npm="npm --no-fund --no-audit"
alias pls="sudo"
alias top="top -d1 -o %CPU"
alias wlc="wl-copy"
alias cbd="wl-paste >> /home/levi/Documents/Dump/clipboard_dump.txt"
alias k="kubectl"

export PATH="$PATH:/home/levi/.jdks/corretto-19.0.2/bin"
export PATH="$PATH:/home/levi/.local/share/JetBrains/Toolbox/scripts"

function sync_redmi {
    thinkpad_sync_dir="/home/levi/Sync"
    thinkpad_pics_dir="/home/levi/Pictures/Redmi"
    redmi_sync_dir="/sdcard/Sync"

    adb push "$thinkpad_sync_dir/Thinkpad" "$redmi_sync_dir"
    adb pull "$redmi_sync_dir/Redmi" "$thinkpad_sync_dir"

    adb pull "/sdcard/DCIM" "$thinkpad_pics_dir"
    adb shell rm -rf "/sdcard/DCIM/*"

    adb pull "/sdcard/Pictures" "$thinkpad_pics_dir"
    adb shell rm -rf "/sdcard/Pictures/*"

    adb pull "/sdcard/Download" "$thinkpad_pics_dir"
    adb shell rm -rf "/sdcard/Download/*"
}

function add_journal_entry {
    path="/home/levi/Documents/Notes/journal_2024.txt"
    for ((i = 1; i <= 80; i++)); do
        echo -n "—" >> $path
    done
    echo -e "\n" >> $path
    echo "Date:" $(date) >> $path
    echo "Location:" $1 >> $path
    nano $path
}
