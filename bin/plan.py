#! /usr/bin/env python
from os.path import isfile
from datetime import datetime 
#import subprocess
import os

date = datetime.now()
filename = "plan_for_{}_{}_{}.txt".format(date.year, date.month, date.day)
path = "/home/mihailo/.plans/" + filename

os.system("vim {}".format(path))


