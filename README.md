## Raspberry Pi Power Supply Check
This script is designed to assess the stability of your Raspberry Pi's power supply and cable connection.

### Before running this script, make sure you have sysbench installed:
```
sudo apt-get install sysbench
```

### Running the Script
```
wget https://raw.githubusercontent.com/senhan07/Raspberry-Pi-Power-Supply-Check/main/raspberrypi-power-supply-check.sh
sudo chmod +x raspberrypi-power-supply-check.sh
sudo ./raspberrypi-power-supply-check.sh
```

 If you're pi is correctly powered (stable power supply and quality cable), after running the script, you should get something like:
```
 45.6'C 1400 / 600 MHz 1.3813V -
 55.3'C 1400 / 1400 MHz 1.3813V -
 58.0'C 1400 / 1400 MHz 1.3813V -
 60.2'C 1400 / 1400 MHz 1.3813V -
 60.2'C 1400 / 1400 MHz 1.3813V -
 61.1'C 1400 / 1400 MHz 1.3813V -
 61.1'C 1400 / 1400 MHz 1.3813V -
 60.8'C 1400 / 1400 MHz 1.3813V -
```
If your power supply cannot provide a stable 5V 2.5A or if the cable is insufficient, the script output may indicate throttling and under-voltage occurrences:
```
 39.7'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
 48.3'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
 52.1'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
 54.8'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
 55.8'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
 56.4'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
 57.5'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
 58.0'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
 59.6'C 1400 / 1400 MHz 1.3875V - Throttling has occurred, Under-voltage has occurred,
```

### Throttle Code
Refer to the following table for code meanings:
| Code | Meaning | 
| :---: | :---: |
| 0x80000 | Soft temperature limit has occurred |
| 0x40000 | Throttling has occurred |
| 0x20000 | Arm frequency capping has occurred |
| 0x10000 | Under-voltage has occurred |
| 0x8 | Soft temperature limit active |
| 0x4 | Currently throttled |
| 0x2 | Arm frequency capped |
| 0x1 | Under-voltage detected |