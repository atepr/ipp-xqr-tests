#!/usr/bin/env python3
import os
from subprocess import call
from os.path import isfile


rewrite_results = True

with open("make-tests.sql") as f:
    lines = [x for x in f.readlines() if x[:2] != '--' and x.strip() != '']
    for i, r in enumerate(lines, 50):
        r = r.strip()
        result = "ref-out/test%d.out" % i
        
        if not rewrite_results and isfile(result):
            continue
        
        try:
            sql, code = r.split(' -- ')
        except ValueError:
            sql, code = r, '0'
        
        with open("input/test%d.qu" % i, 'w') as o:
            o.write(sql + "\n")
        with open("ref-out/test%d.!!!" % i, 'w') as o:
            o.write(code)

        try:
            os.remove(result)
        except OSError:
            pass

        # print('   [%d]' % i, r)

        if code == '0':
            call(['./xqr.py',
                  '--input', 'vstup.xml',
                  '--query', sql,
                  '--output', result,
                  '--root', 'knihovna'])
    
    with open("make-tests-last", 'w') as o:
        o.write(str(i))

