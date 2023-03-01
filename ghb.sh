#!/usr/bin/env bash


context=$1 # work, personal, etc.

git_hook_location="$HOME/.githooks"
this_dir=$PWD

if [ ! -d $this_dir/.git/ ]; then
	echo "This does not look like it is tracked by git."
fi

for file in $git_hook_location/$context/*; do
	if [ -d "$file" ]; then
		continue
	fi

    # If the commit hook already exists, we want to back it up before
    # any changes we make. If we are dealing with an existing symlink
    # we'll assume it's us and overwrite it.
    filename=$(basename $file)
    hook_path="$this_dir/.git/hooks/$filename"
    now=$(date +%s%3N)
    if [ -f "$hook_path" ] && [ ! -L "$hook_path" ]; then
        mv $hook_path "$hook_path.$now.bak"
    fi
	ln -sf $file $this_dir/.git/hooks/
done




