#!/usr/bin/env bash
themes=(AtomOneLight Github gruvbox_light Material PencilLight Solarized_Light Tomorrow)
for theme in "${themes[@]}"; do
    wget -N https://raw.githubusercontent.com/dexpota/kitty-themes/master/themes/"${theme}".conf
done
