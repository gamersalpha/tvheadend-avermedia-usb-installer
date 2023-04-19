
This script installs the AverMedia A835b USB tuner driver and TVHeadend on a fresh install of Ubuntu 22.04. It checks for required prerequisites and provides instructions after each step is completed.

## Prerequisites

- A fresh install of Ubuntu 22.04
- The following packages must be installed: `unzip` and `apt-transport-https`

## Installation

1. Clone this repository to your local machine.
2. Navigate to the cloned repository's directory using the command line.
3. Make the shell script executable by running the command `chmod +x install.sh`.
4. Run the script with root privileges using the command `sudo ./install.sh`.
5. Follow the on-screen instructions to complete the installation process.

## Usage

Once the script has completed successfully, you can access TVHeadend by opening your web browser and navigating to `https://<IP address>:9981`. Make sure to configure users and permissions in TVHeadend before continuing.

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.



