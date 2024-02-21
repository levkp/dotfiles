
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
alias du="du -sh"
alias dr="docker"
alias npm="npm --no-fund --no-audit"
alias pls="sudo"
alias top="top -d1 -o %CPU"
alias xcb="xclip -selection c"
alias gte="gnome-text-editor"
alias ssh_probook="ssh -p 422 levi@192.168.0.212"

function scp_probook {
    scp -P 422 "$1" levi@192.168.0.212:/home/levi
}

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

function syncdirs {
    laptop_dir="/home/levi/Sync"
    phone_dir="/run/user/1000/gvfs/mtp:host=Xiaomi_Redmi_Note_8T_1996ecbb/Internal shared storage/Sync"
    cp -rv "$laptop_dir/Pavilion 15" "$phone_dir"
    cp -rv "$phone_dir/Note 8T" "$laptop_dir"
}

function move_phone_pics {
    phone_home_dir="/run/user/1000/gvfs/mtp:host=Xiaomi_Redmi_Note_8T_1996ecbb/Internal shared storage"
    target_dir="/home/levi/Pictures/Note 8T"
    mv -v "$phone_home_dir/DCIM" "$target_dir"
    mv -v "$phone_home_dir/Pictures" "$target_dir"
    nautilus "$target_dir" &
}

function mirror_home {
    target_dir="/run/media/levi/4d43afc4-008c-44fe-b207-3f85505f5e97/Sync/home"
    rsync -av \
         --delete \
         --exclude=".cache" /home/levi "$target_dir"
}

function add_journal_entry {
    path="/home/levi/Documents/Notes/journal.txt"
    echo "Date:" $(date) >> $path
    echo "Location:" $1 >> $path
    echo "Score:" $2 >> $path
    gte $path
}

