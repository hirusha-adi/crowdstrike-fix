#!/bin/bash

# Create a temporary mount point
TEMP_MOUNT_POINT="/mnt/temp_mount_point"

# Create the mount point directory if it doesn't exist
mkdir -p $TEMP_MOUNT_POINT

# Get a list of all block devices
BLOCK_DEVICES=$(lsblk -ln -o NAME,TYPE | grep "disk" | awk '{print $1}')

# Loop through each block device
for DEVICE in $BLOCK_DEVICES; do
    # Get a list of all partitions for the device
    PARTITIONS=$(lsblk -ln -o NAME,TYPE | grep "part" | awk '{print $1}' | grep "^$DEVICE")

    for PARTITION in $PARTITIONS; do
        # Check if the partition is mounted
        MOUNT_POINT=$(lsblk -ln -o NAME,MOUNTPOINT | grep "^$PARTITION" | awk '{print $2}')

        if [ -z "$MOUNT_POINT" ]; then
            echo "Partition /dev/$PARTITION is not mounted. Listing contents..."
            # Temporarily mount the partition
            sudo mount /dev/$PARTITION $TEMP_MOUNT_POINT

            if [ $? -eq 0 ]; then
                # List contents
                ls -lah $TEMP_MOUNT_POINT
                
                # Check for the Windows/System32/drivers/CrowdStrike/ directory
                CROWDSTRIKE_DIR="$TEMP_MOUNT_POINT/Windows/System32/drivers/CrowdStrike"
                
                if [ -d "$CROWDSTRIKE_DIR" ]; then
                    echo "Found CrowdStrike directory. Checking for files to delete..."
                    
                    # Find and delete specific files
                    FILES_FOUND=$(find "$CROWDSTRIKE_DIR" -name "C-0000291*.sys")
                    
                    if [ -n "$FILES_FOUND" ]; then
                        echo "Deleting files: $FILES_FOUND"
                        rm "$CROWDSTRIKE_DIR/C-0000291*.sys"
                    else
                        echo "No files matching C-0000291*.sys found."
                    fi
                else
                    echo "CrowdStrike directory not found."
                fi
                
                # Unmount the partition
                sudo umount $TEMP_MOUNT_POINT
            else
                echo "Failed to mount /dev/$PARTITION"
            fi
        else
            echo "Partition /dev/$PARTITION is already mounted at $MOUNT_POINT"
        fi
    done
done

# Clean up: remove the temporary mount point directory
rmdir $TEMP_MOUNT_POINT
