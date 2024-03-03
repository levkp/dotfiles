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
alias l="ls -a"
alias lla="ls -la"
alias du="du -sh"
alias dr="docker"
alias npm="npm --no-fund --no-audit"
alias pls="sudo"
alias top="top -d1 -o %CPU"
alias code="flatpak run com.visualstudio.code"
alias wlc="wl-copy"
alias cbd="wl-paste >> ~/Downloads/linkdump.txt"

export PATH="$PATH:/home/levi/.jdks/corretto-19.0.2/bin"
export PATH="$PATH:/home/levi/.local/share/JetBrains/Toolbox/scripts"

function destroy {
    for path in "$@"; do
        if [ -f "$path" ]; then
            shred -zv "$path" && rm -v "$path"
        elif [ -d "$path" ]; then
            cd "$path" || exit 1
            destroy *
            cd ..
            rmdir -v "$path"
        fi
    done
}

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

function sync_pocketbook {
    echo ""
}

function mirror_home {
    target_dir="/run/media/levi/4d43afc4-008c-44fe-b207-3f85505f5e97/Sync/home"
    rsync -av \
         --delete \
         --exclude=".cache" /home/levi "$target_dir"
}

function add_journal_entry {
    path="/home/levi/Documents/Notes/journal.txt"
    for ((i = 1; i <= 80; i++)); do
        echo -n "—" >> $path
    done
    echo -e "\n" >> $path
    echo "Date:" $(date) >> $path
    echo "Location:" $1 >> $path
    nano $path
}

complete -C /usr/bin/terraform terraform
