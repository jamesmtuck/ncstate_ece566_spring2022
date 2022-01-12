#!/usr/bin/env python

import sys
import re
import os

Stats = {}

p_name = re.compile('(\w*)\.?(\w+)?\.tune\.bc\.stats',re.IGNORECASE)

Ids = {}

Normalize = False
if len(sys.argv) > 1:
    if sys.argv[1] == '-N':
        Normalize = True
        field = sys.argv[2]
    else:
        field = sys.argv[1]
else:
    print ("No field specifield. Assuming Instructions.")
    field = "Instructions"
    
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

    basename = os.path.basename(fName)
        
    m = p_name.match(basename)
    if m==None:
        #print (fName)
        continue
    else:
        g = m.groups()
        if len(g) < 2:
            continue
        name = g[0]
        opt = g[1]
        #print (name,opt)
        if opt==None:
            opt = "-"
        
    Ids[name] = 1
    
    if not Stats.has_key(opt):
        Stats[opt] = {}

    if not Stats[opt].has_key(name):
        Stats[opt][name] = {}

    for line in iter(f.readline, ''):
        s = line.split(',')
        if len(s) != 2:
            continue

        Stats[opt][name][s[0]] = s[1].rstrip()
        

s = "Category".ljust(20,)
keys = Stats.keys()
keys.sort(cmp)
for k in keys:
    s += k.rjust(10)

print s

benchs = Ids.keys()
benchs.sort(cmp)

for i in benchs:
    s = str(i).ljust(20,'.')
    for k in keys:
        if Stats[k].has_key(i):
            if Stats[k][i].has_key(field):
                if Normalize==True and Stats.has_key('None') :
                    if Stats['None'][i][field] > 0:
                        s += str(float(Stats[k][i][field])/float(Stats['None'][i][field]))[0:3].rjust(10,'.')
                    else:
                        s += str('x').rjust(10,'.');
                else:
                    s += str(Stats[k][i][field]).rjust(10,'.')
            else:
                s += '(missing)'.rjust(10,'.')
        else:
            s += '(missing)'.rjust(10,'.')
    print s


#for i in Ids.keys():
#    s = str(i).ljust(20,'.')
#    for k in Stats.keys():
#        if Stats[k].has_key(i):
#            if Stats[k][i].has_key(sys.argv[1]):
#                s += str(Stats[k][i][sys.argv[1]]).rjust(10,'.')
#            else:
#                s += '(missing)'.rjust(10,'.')
#        else:
#            s += '(missing)'.rjust(10,'.')
#    print s
