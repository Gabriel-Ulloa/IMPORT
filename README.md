# IMPORT Repository

Welcome to the IMPORT repository, designed to work in tandem with the SENSOR repository for enhanced network forensic analysis on a Security Onion setup tailored for pcap import.

## Overview

The IMPORT repository takes over where SENSOR leaves off, refining and analyzing the captured data to extract actionable insights into malicious traffic.

## Operation

- **Data Reception**: IMPORT receives data from SENSOR's `sensor_catches` directory.
- **Filtering Process**: Utilizing scripts to filter through the data, isolating and analyzing malicious traffic stored in new pcap files.
- **Malware Analysis**: Leveraging APIs like `vt-cli` and `VxAPI` for detailed malware hash analysis.
- **Data Archiving**: Compiling all captured malwares into a password-protected zip and compressing filtered information into a tar file.
- **Cloud Export**: Securely transferring the final dataset to a private cloud database with `rclone`.

## Integration with SENSOR

Import PCAP operations are scheduled to follow SENSOR's automatic data capture and transfer, ensuring a seamless flow from capture to analysis.

## Installation

1. Copy the command located in command.txt
2. Paste the command into the terminal of your Security Onion IMPORT deployment
3. Follow the instructions

## Contribution

Your contributions to the IMPORT repository are valued. Please adhere to our contribution guidelines when submitting changes.

Thank you for your support in advancing our network forensic capabilities.
