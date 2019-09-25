# install “spidev” correctly:
# sudo apt-get install python3-spidev python-spidev

#!/usr/bin/python 
import spidev
import time
import os
 
# Open SPI bus
spi = spidev.SpiDev()
spi.open(0,0)
spi.max_speed_hz=1000000
 
# Function to read SPI data from MCP3008 chip
# Channel must be an integer 0-7
def ReadChannel(channel):
  adc = spi.xfer2([1,(8+channel)<<4,0])
  data = ((adc[1]&3) << 8) + adc[2]
  return data
 
"""
# Function to convert data to voltage level,
# rounded to specified number of decimal places.
def ConvertVolts(data,places):
  volts = (data * 5) / float(1023)
  volts = round(volts,places)
  return volts
"""
 
# Define sensor channels
he_channel = 0
 
while True:
 
  # Read the magnet sensor data
  magnet_level = ReadChannel(he_channel)
  #magnet_volts = ConvertVolts(magnet_level,2)
  #print(magent_level, magnet_volts)
  print(magent_level)
