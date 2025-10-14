#!/usr/bin/env bash
# Script to convert old-style slides to Ubuntu 24.04 format
# Creates numbered subdirectories with localized HTML files

set -e

SLIDES_DIR="ubiquity/slides-new"
OLD_SLIDES="ubiquity/slides"

echo "Converting slides to Ubuntu 24.04 format..."

# Remove old converted slides if they exist
rm -rf "$SLIDES_DIR"
mkdir -p "$SLIDES_DIR"

# Array of slide files in the order they should appear
declare -a slides=(
    "welcome.html"
    "distro.html"
    "gazebo.html"
    "tools.html"
    "viewers.html"
    "wiki.html"
    "gethelp.html"
    "accessibility.html"
)

# Create numbered directories and copy slides
counter=1
for slide in "${slides[@]}"; do
    if [ -f "$OLD_SLIDES/$slide" ]; then
        echo "Creating slide $counter from $slide..."
        mkdir -p "$SLIDES_DIR/$counter"
        
        # Copy as English (US) default
        cp "$OLD_SLIDES/$slide" "$SLIDES_DIR/$counter/slide_en_US.html"
        
        # Copy icons directory to each slide if it exists
        if [ -d "$OLD_SLIDES/icons" ]; then
            cp -r "$OLD_SLIDES/icons" "$SLIDES_DIR/$counter/"
        fi
        
        # Copy screenshots directory to each slide if it exists
        if [ -d "$OLD_SLIDES/screenshots" ]; then
            cp -r "$OLD_SLIDES/screenshots" "$SLIDES_DIR/$counter/"
        fi
        
        counter=$((counter + 1))
    fi
done

echo "Conversion complete! New slides are in $SLIDES_DIR"
echo "You can now use this directory in your install.sh script"
