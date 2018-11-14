#!/bin/env python3
import pathlib
import sys
from zipfile import ZipFile

if len(sys.argv) != 2:
    print('Please provide name of directory to be compressed')

SPECIAL_FILES = {'installed.txt', 'IntelliJ IDEA Global Settings'}
PRODUCTS = {'idea': '.IdeaIC2018.2', 'pycharm': '.PyCharmCE2018.2',
            'android': '.AndroidStudio3.2'}


def add_file(zf: ZipFile, file: pathlib.Path, root_dir: pathlib.Path, product: str):
    if file.is_file():
        if file.name not in SPECIAL_FILES:
            zf.write(file, f'../../../{product}/config/' + (file.relative_to(root_dir)).as_posix())
    elif file.is_dir():
        for child_file in file.iterdir():
            add_file(zf, child_file, root_dir, product)


dirname = sys.argv[1]

z = ZipFile(f'{dirname}.jar', 'w')

p = pathlib.Path(dirname)
add_file(z, p, p, PRODUCTS[dirname])

for filename in SPECIAL_FILES:
    z.write((p / filename).as_posix(), filename)

z.close()
