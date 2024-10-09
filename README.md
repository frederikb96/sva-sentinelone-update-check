# SVA SentinelOne Update Check - Ansible Project

## Quickstart

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd sva-sentinelone-update-check
   ```

2. **Copy variable file and fill out**

3. **Run the playbook**:
   ```bash
   ansible-playbook -i inventory playbook.yml
   ```

   This will:
   - Copy the script to `~/.local/lib/sva-sentinelone-update-check/update_check.sh`
   - Create an autostart entry at `~/.config/autostart/sva-sentinelone-update-check.desktop`

## How It Works

- The script checks the provided SentinelOne download page for updates after system startup.
- If an update is found, a GNOME notification is sent.
- It runs at every subsequent startup, checking for changes on the website.

## Uninstallation

1. Remove the script and autostart entry:
   ```bash
   rm -rf ~/.local/lib/sva-sentinelone-update-check/
   rm ~/.config/autostart/sva-sentinelone-update-check.desktop
   ```

2. Delete the cache directory:
   ```bash
   rm -rf ~/.cache/sva-sentinelone-update-check/
   ```