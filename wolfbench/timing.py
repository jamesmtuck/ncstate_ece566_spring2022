#!/usr/bin/env python

import sys
import re
import os

Stats = {}

p_name = re.compile('.*/(\w+)(\.[\-\w]+)?\.out\.time',re.IGNORECASE)

Ids = {}

argv = sys.argv
Normalize = False
Normalize_key = ".None"
if len(argv) > 2:
    if argv[1] == '-N':
        Normalize = True
        Normalize_key = argv[2]

timings = []
cwd = os.getcwd()
for root, dirs, files in os.walk(cwd):
    for f in files:
        if f.endswith('.time'):
            timings.append(os.path.join(root,f))

    
for fName in timings:
    try: 
        f = open(fName,"r")
    except:
        print "Error: could not find file %s" % fName
        sys.exit(1)

    m = p_name.match(fName)
    if m==None:
        opt = "-"
        continue
    else:
        g = m.groups()
        if len(g) < 2:
            continue
        name = g[0]
        opt = g[1]
        if opt==None:
            opt = "-"

    Ids[name] = 1
    
    if not Stats.has_key(opt):
        Stats[opt] = {}

    if not Stats[opt].has_key(name):
        Stats[opt][name] = 0

    for line in iter(f.readline, ''):
        s = line.split(' ')
        if len(s) != 2:
            continue

        if s[0] == "program":
            Stats[opt][name] = float(s[1])
            break


s = "Category".ljust(20,)
keys = Stats.keys()
keys.sort(cmp)
for k in keys:
    s += k.rjust(10)

print s

benchs = Ids.keys()
benchs.sort()

for i in benchs:
    s = str(i).ljust(20,'.')
    for k in keys:
        if Stats[k].has_key(i):
            if Normalize==True and Stats.has_key(Normalize_key) :
                if Stats['.None'][i] > 0:
                    s += str(Stats[k][i]/Stats[Normalize_key][i])[0:3].rjust(10,'.')
                else:
                    s += str('x').rjust(10,'.');
            else:
                s += str(Stats[k][i]).rjust(10,'.')
        else:
            s += '(missing)'.rjust(10,'.')
    print s
