# SVA SentinelOne Update Check - Ansible Project

## Project Overview
This project automates checking for updates from the SentinelOne Linux download page (`https://dl.sva.de/sentinelone/linux/`). It uses Ansible to set up a shell script that periodically checks for changes on the website, compares the current version with the previously saved version, and sends GNOME notifications if an update is detected. The script is scheduled to run 10 minutes after system startup and continues to run on each subsequent system startup.

## Repository Structure
- `inventory`: An Ansible inventory file that targets `localhost`.
- `playbook.yml`: The main Ansible playbook that handles:
  - Creating necessary directories.
  - Copying the shell script to the appropriate location.
  - Setting up the autostart configuration to run the script after system startup.
- `files/`: Contains the shell script `update_check.sh`.

## Shell Script Functionality (`update_check.sh`)
- The script checks if an `update-flag` file exists in the cache directory (`~/.cache/sva-sentinelone-update-check`):
  - If it exists, the script sends a GNOME notification alerting the user that an update has been detected and informs them how to remove the flag (`rm ~/.cache/sva-sentinelone-update-check/update-flag`).
  - If the flag does not exist, it proceeds with querying the SentinelOne website.
- The script saves the website’s content to a file `state-website.html` in the cache directory.
- If a previous state file exists, it is renamed to `state-website.html.bak` before the new query result is saved.
- The script compares the new state file with the backup:
  - If they differ, a GNOME notification is sent to inform the user of an update, and an `update-flag` file is created in the cache directory to signal the update.
  
## Installation & Setup

1. **Clone the Repository:**
   ```bash
   git clone <repository-url>
   cd sva-sentinelone-update-check
   ```

2. **Run the Ansible Playbook:**
   Ensure Ansible is installed, then run:
   ```bash
   ansible-playbook -i inventory playbook.yml
   ```
   This will:
   - Copy the `update_check.sh` script to `~/.local/lib/sva-sentinelone-update-check/update_check.sh`.
   - Set up an autostart entry in `~/.config/autostart/sva-sentinelone-update-check.desktop` to run the script 10 minutes after system startup.

3. **Verify the Setup:**
   After running the playbook, you should find:
   - The script in `~/.local/lib/sva-sentinelone-update-check/`.
   - An autostart file in `~/.config/autostart/` that triggers the script after startup.

## How the Script Works
- **On Startup:**
  The script will run 10 minutes after system startup.
  
- **Update Check Process:**
  - The script checks for updates by querying the SentinelOne website and comparing the output to the previous run.
  - If the website content differs from the last check, a GNOME notification is sent to inform the user of an update, and an `update-flag` is created.
  
- **Notification on Update:**
  - Once an update is detected, the `update-flag` file will persist in the cache directory. Each time the script runs, if the flag is found, it will immediately notify the user without re-querying the website.

- **Clearing the Update Flag:**
  The user can manually remove the `update-flag` by running:
  ```bash
  rm ~/.cache/sva-sentinelone-update-check/update-flag
  ```

## File Paths
- **Script Location:** `~/.local/lib/sva-sentinelone-update-check/update_check.sh`
- **Cache Directory:** `~/.cache/sva-sentinelone-update-check/`
  - `state-website.html`: The most recent output from the SentinelOne website.
  - `state-website.html.bak`: The previous output from the website.
  - `update-flag`: Created when a new update is detected.

## Autostart Configuration
The script is set to run automatically 10 minutes after system startup. This is managed via a `desktop` entry located at:
```
~/.config/autostart/sva-sentinelone-update-check.desktop
```

## Customization
- **Check Interval:**
  The delay before the script runs can be adjusted by changing the `sleep` value in the autostart entry (default is 600 seconds or 10 minutes).
  
- **Notification System:**
  The script uses `notify-send` to send GNOME notifications. This can be replaced with other notification systems if needed.

## Uninstallation
To remove this setup:
1. Delete the script and autostart entry:
   ```bash
   rm -rf ~/.local/lib/sva-sentinelone-update-check/
   rm ~/.config/autostart/sva-sentinelone-update-check.desktop
   ```
2. Remove the cache directory:
   ```bash
   rm -rf ~/.cache/sva-sentinelone-update-check/
   ```