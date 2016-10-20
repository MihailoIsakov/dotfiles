#! /bin/bash

sudo ifconfig wlan0 down
sudo ifconfig wlan0 hw ether $1
sudo ifconfig wlan0 up
