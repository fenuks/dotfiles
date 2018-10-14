#!/usr/bin/env bash
if [ -f /usr/bin/visual-studio-code-oss ]; then
    CODE=visual-studio-code-oss
else
    CODE=code
fi

while read -r ext
do
    yes 0 | "${CODE}" --install-extension "${ext}"
done < extensions.txt
