#!/usr/bin/env bash
set -e

echo "=== Replacing images with correct names ==="

# Mapping: new image -> target name in each slide
# 1.png -> wallpaper_1.png (slide 1)
# 2.png -> ros2_distro.png (slide 2) 
# 3.png -> gazebo.png (slide 3)
# 4.png -> ROSuntu_logo.png (slide 4)
# 5.png -> rviz.png (slide 5)
# 6.png -> ros2_wiki.png (slide 6)
# 7.png -> welcome.png (slide 7)
# 8.png -> customize.png (slide 8)

declare -A image_mapping=(
    [1]="wallpaper_1.png"
    [2]="ros2_distro.png"
    [3]="gazebo.png"
    [4]="ROSuntu_logo.png"
    [5]="rviz.png"
    [6]="ros2_wiki.png"
    [7]="welcome.png"
    [8]="customize.png"
)

# Copy ALL images to ALL slides with proper names
declare -A all_names=(
    [1]="wallpaper_1.png"
    [2]="ros2_distro.png"
    [3]="gazebo.png"
    [4]="ROSuntu_logo.png"
    [5]="rviz.png"
    [6]="ros2_wiki.png"
    [7]="welcome.png"
    [8]="customize.png"
)

for i in {1..8}; do
    SCREENSHOTS_DIR="ubiquity/slides-new/$i/screenshots"
    
    echo "Slide $i: Copying all images with proper names..."
    
    # Remove all PNG files first
    rm -f "$SCREENSHOTS_DIR"/*.png
    
    # Copy ALL 8 images with their proper names to this slide
    for j in {1..8}; do
        if [ -f "$j.png" ]; then
            TARGET_NAME="${all_names[$j]}"
            cp "$j.png" "$SCREENSHOTS_DIR/$TARGET_NAME"
            echo "  ✓ Copied $j.png → $TARGET_NAME"
        fi
    done
done

echo ""
echo "=== ✓ ALL IMAGES REPLACED! ==="
