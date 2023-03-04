#! /bin/bash

google-chrome $(ip route | grep default | cut -d ' ' -f 3)
