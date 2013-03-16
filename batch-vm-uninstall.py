#!/usr/bin/env python

import sys
import time
import subprocess
import argparse



def vm_uninstall(vm_uuid_list):
    outputfile = "vm-uninstall-" + time.time() + ".log"
    fp = open(outputfile, "w")
    try:
        for vm_uuid in vm_uuid_list:
            cmd = "xe vm-uninstall uuid="+ vm_uuid + " force=true"
            fp.write(cmd+'\n')
            """
               [option]
                   shell=True, this can fork child process to execute the specified cmd.
            """
            proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            (stdout, stderr) = proc.communicate()
            print stdout.strip()
            fp.write(stdout.strip()+'\n')

    finally:
        fp.close()


def main():
   vm_uuid_list = []
   fp = open(sys.argv[1], "rb")
   for vm_uuid in fp.readlines():
      vm_uuid_list.append(vm_uuid)
   #print vm_uuid_list
   print "The vm-uuid list is established!"
   vm_uninstall(vm_uuid_list)



if __name__ == '__main__':
  main()
