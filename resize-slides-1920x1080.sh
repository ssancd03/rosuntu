#!/usr/bin/env bash
set -e

SLIDES_NEW="ubiquity/slides-new"
TARGET_WIDTH=1920
TARGET_HEIGHT=1080

echo "=== Resizing all slides to 1920x1080 ==="

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Installing ImageMagick..."
    sudo apt install -y imagemagick
fi

# Find and resize all PNG images in slides-new
echo "✓ Resizing all images to ${TARGET_WIDTH}x${TARGET_HEIGHT}..."
find "$SLIDES_NEW" -type f -name "*.png" | while read img; do
    echo "  Processing: $(basename "$img")"
    convert "$img" -resize "${TARGET_WIDTH}x${TARGET_HEIGHT}" -background white -gravity center -extent "${TARGET_WIDTH}x${TARGET_HEIGHT}" "$img"
done

echo ""
echo "=== ✓ RESIZE COMPLETE! ==="
echo "All images resized to 1920x1080"
