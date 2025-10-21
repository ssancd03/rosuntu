#!/usr/bin/env bash
set -e

echo "=== Creating proper Ubuntu 24.04 slides ==="

SLIDES_NEW="ubiquity/slides-new"

# Slide titles and descriptions
declare -A slide_titles=(
    [1]="Welcome to ROSuntu"
    [2]="ROS 2 Jazzy Jalisco"
    [3]="Gazebo Simulation"
    [4]="Development Tools"
    [5]="RViz and RQt viewers"
    [6]="ROS 2 Documentation"
    [7]="Get Help and Support"
    [8]="Accessibility Features"
)

declare -A slide_descriptions=(
    [1]="Fast and full of new features, the latest version of ROSuntu makes robotics development easier than ever."
    [2]="ROSuntu comes with ROS 2 Jazzy, the latest ROS distribution with improved performance and new features."
    [3]="Simulate your robots in Gazebo with realistic physics and sensors before deploying to real hardware."
    [4]="ROSuntu includes VS Code, Chrome, Docker and all the tools you need for modern robotics development."
    [5]="Monitor and visualize your robots with RViz 2 and RQt-based tools included in ROSuntu."
    [6]="Access comprehensive ROS 2 documentation and tutorials to accelerate your robotics projects."
    [7]="Join the ROS community forums, tutorials, and get support from robotics experts worldwide."
    [8]="ROSuntu includes accessibility features to make robotics development available to everyone."
)

# Create proper HTML for each slide
for i in {1..8}; do
    HTML_FILE="$SLIDES_NEW/$i/slide_en_US.html"
    
    echo "Creating slide $i: ${slide_titles[$i]}"
    
    cat > "$HTML_FILE" << SLIDEHTML
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>${slide_titles[$i]}</title>
    <style>
        body {
            font-family: Ubuntu, sans-serif;
            margin: 0;
            padding: 40px;
            background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);
            color: white;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            overflow: hidden;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            z-index: 10;
            position: relative;
        }
        
        .slidetitle {
            font-size: 3em;
            font-weight: 300;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.8);
            color: #FF6B35;
        }
        
        .main {
            display: flex;
            align-items: center;
            justify-content: center;
            flex: 1;
            position: relative;
        }
        
        .content {
            text-align: center;
            z-index: 5;
            max-width: 800px;
        }
        
        .description {
            font-size: 1.5em;
            line-height: 1.6;
            margin: 30px 0;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.8);
        }
        
        .screenshot {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            max-width: 80%;
            max-height: 60%;
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            z-index: 1;
        }
        
        .background {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.3;
            z-index: 0;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1 class="slidetitle">${slide_titles[$i]}</h1>
    </div>
    
    <div class="main">
        <div class="content">
            <p class="description">${slide_descriptions[$i]}</p>
        </div>
        <img class="screenshot" src="$i.png" alt="${slide_titles[$i]}">
    </div>
</body>
</html>
SLIDEHTML

done

echo "✓ All slides created with proper HTML structure"
echo "✓ Using images: 1.png, 2.png, 3.png, 4.png, 5.png, 6.png, 7.png, 8.png"
