# 🎯 Microsoft Teams App Deployment - Quick Start Guide

Your Standalone Tracker is now ready to be deployed as a Microsoft Teams app!

## 📋 What You Need

1. **Deployed Backend**: Your Flask app must be accessible via HTTPS
2. **Azure AD App Registration**: For authentication (optional for basic setup)
3. **Teams Admin Access**: To upload custom apps
4. **App Icons**: Two PNG files (see below)

## 🚀 Quick Deployment Steps

### Step 1: Deploy Your Backend (Choose One)

#### Option A: Azure App Service (Recommended for Production)
```bash
# Install Azure CLI
brew install azure-cli  # macOS
# or download from: https://aka.ms/installazurecliwindows

# Login
az login

# Create and deploy
az group create --name tracker-rg --location eastus
az webapp up --name standalone-tracker-app --resource-group tracker-rg --runtime "PYTHON:3.11"
```

Your app URL: `https://standalone-tracker-app.azurewebsites.net`

#### Option B: Render (Free - Easy)
1. Go to https://render.com
2. Sign in with GitHub
3. New → Web Service
4. Connect repo: `lillysamuthirapandian/standalone-tracker`
5. Auto-detects configuration ✓
6. Click "Create Web Service"

Your app URL: `https://standalone-tracker.onrender.com`

### Step 2: Create App Icons

**Need two PNG files:**
- `color.png`: 192x192 pixels (full color logo)
- `outline.png`: 32x32 pixels (white outline, transparent background)

**Quick way to create:**
1. Use Canva, Figma, or any image editor
2. Create simple icons with your company logo or "ST" text
3. Save as PNG files in the `teams/` folder

**Or use online tools:**
- https://www.canva.com (free)
- https://favicon.io/favicon-generator/

### Step 3: Configure and Package

```bash
cd "/Users/lilly.samuthirapandian/Downloads/Standalone Tracker/teams"

# Run the setup script
./setup.sh
```

The script will:
- Generate a unique Teams App ID
- Ask for your deployed app URL
- Update the manifest
- Create `StandaloneTracker.zip`

### Step 4: Upload to Teams

#### For Personal/Testing:
1. Open Microsoft Teams
2. Click **Apps** (left sidebar)
3. Click **Manage your apps** (bottom left)
4. Click **Upload a custom app** → **Upload for me or my teams**
5. Select `StandaloneTracker.zip`
6. Click **Add**

#### For Your Organization (Requires Admin):
1. Go to [Teams Admin Center](https://admin.teams.microsoft.com)
2. **Teams apps** → **Manage apps**
3. Click **Upload**
4. Select `StandaloneTracker.zip`
5. Approve and publish

### Step 5: Use the App! 🎉

1. In Teams, go to **Apps**
2. Search for "Tracker"
3. Click **Add** to use personally
4. Or click **+** in any channel → Search "Tracker" → Add to channel

---

## 🔧 Troubleshooting

### "App failed to load"
- Check that your backend URL is accessible via HTTPS
- Verify CORS settings in `app.py` allow Teams domains
- Check browser console for errors (F12)

### CORS Errors
Your app.py already has CORS configured for Teams. If issues persist:
```python
CORS(app, resources={
    r"/*": {
        "origins": "*",  # For testing only!
        "allow_headers": ["Content-Type"],
        "methods": ["GET", "POST", "PUT", "DELETE"]
    }
})
```

### Icons Not Loading
- Ensure `color.png` and `outline.png` are in the `teams/` folder
- Icons must be exactly 192x192 and 32x32 pixels
- Use PNG format only

### Can't Upload Custom App
- Your Teams organization may block custom apps
- Contact your IT admin to enable custom app uploads
- Go to Teams Admin Center → Teams apps → Setup policies

---

## 📝 Manual Setup (Alternative)

If the setup script doesn't work:

1. **Edit `teams/manifest.json`:**
   - Replace `{{TEAMS_APP_ID}}` with a new GUID from https://www.guidgenerator.com/
   - Replace `{{APP_URL}}` with your deployed URL
   - Replace `{{APP_DOMAIN}}` with your domain (no https://)
   - Replace `{{AAD_APP_ID}}` with "00000000-0000-0000-0000-000000000000" (for testing)

2. **Create the package:**
   ```bash
   cd teams
   zip -r ../StandaloneTracker.zip manifest.json color.png outline.png config.html
   ```

3. **Upload to Teams** (see Step 4 above)

---

## 🔐 Production Considerations

For production deployment:

1. **Azure AD Authentication**:
   - Register app in Azure AD
   - Add authentication to your Flask app
   - Update manifest with real AAD App ID

2. **Persistent Storage**:
   - Current app uses Excel files (temporary on cloud)
   - Consider Azure SQL Database or Cosmos DB
   - Or use Azure Storage for persistent files

3. **Security**:
   - Enable HTTPS only
   - Implement proper authentication
   - Add rate limiting
   - Use environment variables for secrets

---

## 📚 Resources

- [Teams App Documentation](https://learn.microsoft.com/en-us/microsoftteams/platform/)
- [Azure App Service](https://azure.microsoft.com/en-us/services/app-service/)
- [Render Documentation](https://render.com/docs)

---

## ✅ Checklist

Before uploading to Teams:
- [ ] Backend deployed and accessible via HTTPS
- [ ] App icons created (192x192 and 32x32)
- [ ] Manifest updated with correct URLs
- [ ] Package created (StandaloneTracker.zip)
- [ ] CORS configured for Teams domains
- [ ] Tested in browser first

---

## 🆘 Need Help?

Contact your IT administrator or check the detailed guide in `teams/README.md`

**Repository**: https://github.com/lillysamuthirapandian/standalone-tracker
