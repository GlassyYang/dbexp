#!/usr/bin/python3
# -*- coding: utf-8 -*-

import os
import random
from base64 import b64encode

c_range = "0123456789qwertyuiopsdfghjkl;'[]zxcvbnm,./<>?~@#$%^&*(()"


def textGen():
    global c_range
    ans = ''
    for i in range(12):
        ans += c_range[random.randint(0, len(c_range) - 1)]
    return ans


def dataGen():
    # 生成索引数据
    index = [x for x in range(1, int(1e6 + 1))]
    random.shuffle(index)
    line = [str(x)+ ' ' + textGen() + '\n' for x in index]
    with open('data.txt', "w") as f:
        f.writelines(line)

if __name__ == "__main__":
    dataGen()