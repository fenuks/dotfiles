#!/usr/bin/env bash
if [ -f /usr/bin/visual-studio-code-oss ]; then
    CODE=visual-studio-code-oss
else
    CODE=code
fi

while read -r ext
do
    ${CODE} --install-extension ${ext}
done < extensions.txt
