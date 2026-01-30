#!/bin/sh
printf '\033c\033]0;%s\a' godot_GGJ26
base_path="$(dirname "$(realpath "$0")")"
"$base_path/godot_GGJ26.x86_64" "$@"
