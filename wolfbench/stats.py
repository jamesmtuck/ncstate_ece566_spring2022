#!/usr/bin/env python

import sys
import re
import os

Stats = {}
p_name = re.compile('.*\.(\w+)\.tune.bc\.stats',re.IGNORECASE)
Ids = {}

stats = []
cwd = os.getcwd()
for root, dirs, files in os.walk(cwd):
    for f in files:
        if f.endswith('.stats'):
            stats.append(os.path.join(root,f))

for fName in stats:
    try:
        f = open(fName,"r")
    except:
        print "Error: could not find file %s" % fName
        sys.exit(1)

    m = p_name.match(fName)
    if m == None:
        opt = "-"
    else:
        g = m.groups()
        opt = g[0]
        if opt == 'tune' or opt == None:
            opt = "-"
    
    if not Stats.has_key(opt):
        Stats[opt] = {}
        
    stats = {}

    for line in iter(f.readline, ''):
        s = line.split(',')
        if stats.has_key(s[0]):
            stats[s[0]] += int(s[1])
        else:
            if not s[0]=='id':
                Ids[s[0]] = 0
                stats[s[0]] = int(s[1])

    for k in stats.keys():
        if Stats[opt].has_key(k):
            Stats[opt][k] += stats[k]
        else:
            Stats[opt][k] = stats[k]


s = "Category".ljust(20,)
for k in Stats.keys():
    s += k.rjust(10)

print s

for i in Ids.keys():
    s = str(i).ljust(20,'.')
    for k in Stats.keys():
        s += str(Stats[k][i]).rjust(10,'.')
    print s
