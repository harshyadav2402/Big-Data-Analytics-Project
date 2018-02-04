#!/usr/bin/env python

import sys
import string
import re

for line in sys.stdin:

    s = line.strip()
    s1 = (s.lower())
    line1 = re.sub('[^0-9a-zA-Z]+', ' ', s1)
    words = line1.split()
    for i in range(len(words)):
        if(i == len(words)-1):
            word = words[i]
        else:
            word = words[i]+' ' + words[i+1]
        print('%s\t%s' % (word, 1))
