# Teams App Quick Setup Script

# This script helps you quickly set up and package your Teams app

echo "🚀 Standalone Tracker - Teams App Setup"
echo "========================================"
echo ""

# Check if required files exist
if [ ! -f "teams/manifest.json" ]; then
    echo "❌ Error: teams/manifest.json not found"
    exit 1
fi

# Generate GUID for Teams App ID (if not already set)
TEAMS_APP_ID=$(uuidgen)
echo "Generated Teams App ID: $TEAMS_APP_ID"

# Prompt for app URL
read -p "Enter your deployed app URL (e.g., https://standalone-tracker.onrender.com): " APP_URL
APP_URL=${APP_URL%/}  # Remove trailing slash
APP_DOMAIN=$(echo $APP_URL | sed 's|https://||' | sed 's|http://||')

# Prompt for Azure AD App ID
read -p "Enter your Azure AD App ID (or press Enter to use placeholder): " AAD_APP_ID
if [ -z "$AAD_APP_ID" ]; then
    AAD_APP_ID="YOUR_AAD_APP_ID_HERE"
fi

echo ""
echo "📝 Updating manifest.json with your configuration..."

# Update manifest.json
cd teams
cp manifest.json manifest.json.backup

sed "s|{{TEAMS_APP_ID}}|$TEAMS_APP_ID|g" manifest.json > temp.json && mv temp.json manifest.json
sed "s|{{APP_URL}}|$APP_URL|g" manifest.json > temp.json && mv temp.json manifest.json
sed "s|{{APP_DOMAIN}}|$APP_DOMAIN|g" manifest.json > temp.json && mv temp.json manifest.json
sed "s|{{AAD_APP_ID}}|$AAD_APP_ID|g" manifest.json > temp.json && mv temp.json manifest.json

echo "✅ Manifest updated successfully"
echo ""

# Check for icons
if [ ! -f "color.png" ] || [ ! -f "outline.png" ]; then
    echo "⚠️  Warning: Icons not found. Please add:"
    echo "   - color.png (192x192px)"
    echo "   - outline.png (32x32px)"
    echo ""
    echo "Creating placeholder icons..."
    
    # Create placeholder icons using ImageMagick (if available)
    if command -v convert &> /dev/null; then
        convert -size 192x192 xc:#4472C4 -gravity center -pointsize 48 -fill white -annotate +0+0 "ST" color.png
        convert -size 32x32 xc:transparent -gravity center -pointsize 12 -fill white -annotate +0+0 "ST" outline.png
        echo "✅ Placeholder icons created"
    else
        echo "   Install ImageMagick to auto-generate icons, or add them manually"
    fi
    echo ""
fi

# Package the app
echo "📦 Creating Teams app package..."
if [ -f "../StandaloneTracker.zip" ]; then
    rm ../StandaloneTracker.zip
fi

zip -r ../StandaloneTracker.zip manifest.json color.png outline.png config.html 2>/dev/null

cd ..

if [ -f "StandaloneTracker.zip" ]; then
    echo "✅ Teams app package created: StandaloneTracker.zip"
    echo ""
    echo "📌 Next Steps:"
    echo "1. Deploy your app to Azure/Render"
    echo "2. Register an Azure AD app"
    echo "3. Upload StandaloneTracker.zip to Microsoft Teams"
    echo ""
    echo "For detailed instructions, see teams/README.md"
else
    echo "❌ Error: Failed to create package"
    exit 1
fi
