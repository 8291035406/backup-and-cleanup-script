# Backup and Cleanup Script

## 1. Project Overview

The **Backup and Cleanup Script** is a Linux shell scripting project that automates directory backups and removes old backup files based on a defined retention period.

This project demonstrates practical Linux system tasks, including backup automation, file compression.

## 2. Project Objectives

- Create compressed backups of a specified directory.
- Generate timestamp-based backup filenames.
- Automatically identify and delete old backup files.
- Maintain log files containing timestamps and execution status.
- Handle errors when the source directory is unavailable or a backup fails.

## 3. Project Structure

```text
backup-and-cleanup-script/
├── backup_clean.sh
├── backup/
│   └── backup_27Oct2026.tar.gz
├── logs/
    └── 27Oct2026.log
```

**File descriptions:**

- `backup_clean.sh` — Main shell script responsible for backup and cleanup operations.
- `backup/` — Stores compressed backup archives.
- `logs/` — Stores log files containing execution details.
- `README.md` — Contains project documentation and usage instructions.

*Note: The filenames shown above are examples. Actual filenames depend on the execution date.*

## 4. Script Configuration

The following variables control the script's behavior:

| Variable | Description |
|---|---|
| `source_dir` | Directory whose contents need to be backed up |
| `backup_dir` | Directory where compressed backups are stored |
| `log_dir` | Directory where execution logs are stored |
| `log_file` | Log file for the current execution date |
| `retention_day` | Retention threshold used to identify old files |
| `year`, `mon`, `day` | Current year, month, and day |

Example configuration:

```bash
source_dir="/home/abhishek/june2026/Assignment/project1"
backup_dir="./backup"
log_dir="./logs"
retention_day=2
```

The retention period is set to two days. Files matching the cleanup criteria are removed automatically.

## 5. How the Script Works

### Step 1: Initialize date variables

The script retrieves the current year, month, and day using the Linux `date` command. These values help generate backup and log filenames.

### Step 2: Create the log directory

The `mkdir -p` command ensures the log directory exists before the script writes log entries.

### Step 3: Check the source directory

The script verifies that the configured source directory exists.

If the directory is missing, it records an error in the log and exits.

### Step 4: Create a compressed backup

The `tar` utility compresses the source directory into a `.tar.gz` archive.

Example command:

```bash
tar -czf "$backup_file" "$source_dir"
```

Example backup filename:

```text
backup_27Oct2026.tar.gz
```

### Step 5: Check the backup result

The script checks the exit status of the backup command.

- If successful, it logs a success message.
- If unsuccessful, it logs an error and exits.

### Step 6: Identify and remove old files

The `find` command identifies files older than the configured retention threshold.

Example:

```bash
find "$source_dir/backup" -type f -mtime +"$retention_day"
```

If matching files are found, the script deletes them using `find -delete` and records the result in the log.

**Important:** The current script searches inside `$source_dir/backup`, while the configured backup output directory is `./backup`. These paths should be aligned before running the cleanup in production.

### Step 7: Record completion

The script writes a final log entry indicating that the backup and cleanup process has completed.

## 7. Logging

The script records execution messages with timestamps.

Example log entries:

```text
2026-10-27 22:00:00 : Backup created successfully
2026-10-27 22:00:01 : No files older than 2 days found.
2026-10-27 22:00:01 : Backup and cleanup process completed
```

Log files are stored in the `logs/` directory and organized by execution date.

Logging helps administrators troubleshoot failures and verify scheduled operations.
```
### How to run 
### Step 1: Grant execution permission

```bash
chmod +x backup_clean.sh
```

### Step 2: Configure the source directory

Open the script:

```bash
nano backup_clean.sh
```

Update `source_dir`, `backup_dir`, `log_dir`, and `retention_day` according to your environment.

Ensure that the cleanup path matches the directory in which the script stores backups.

### Step 3: Execute the script

```bash
./backup_clean.sh
```

