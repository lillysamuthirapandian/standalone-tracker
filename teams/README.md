# Teams App Deployment Guide

## Prerequisites
1. Microsoft Teams Admin access
2. Azure subscription (for hosting)
3. App registration in Azure AD

## Step 1: Deploy the Backend

### Option A: Azure App Service (Recommended)
```bash
# Install Azure CLI if not installed
# brew install azure-cli  # macOS

# Login to Azure
az login

# Create resource group
az group create --name standalone-tracker-rg --location eastus

# Create App Service plan
az appservice plan create --name tracker-plan --resource-group standalone-tracker-rg --sku B1 --is-linux

# Create web app
az webapp create --resource-group standalone-tracker-rg --plan tracker-plan --name standalone-tracker-app --runtime "PYTHON:3.11" --deployment-source-url https://github.com/lillysamuthirapandian/standalone-tracker --deployment-source-branch main

# Configure startup command
az webapp config set --resource-group standalone-tracker-rg --name standalone-tracker-app --startup-file "gunicorn --bind=0.0.0.0:8000 --timeout 600 app:app"

# Enable CORS for Teams
az webapp cors add --resource-group standalone-tracker-rg --name standalone-tracker-app --allowed-origins "https://teams.microsoft.com" "https://*.teams.microsoft.com"
```

Your app will be available at: `https://standalone-tracker-app.azurewebsites.net`

### Option B: Use Render.com (Free)
1. Deploy to Render following the main README
2. Get your app URL (e.g., `https://standalone-tracker.onrender.com`)

## Step 2: Register Azure AD App

1. Go to [Azure Portal](https://portal.azure.com) → Azure Active Directory → App registrations
2. Click **New registration**
3. Name: `Standalone Tracker Teams App`
4. Supported account types: **Accounts in this organizational directory only**
5. Redirect URI: `https://YOUR_APP_URL/auth-end`
6. Click **Register**
7. Copy the **Application (client) ID** - this is your `AAD_APP_ID`
8. Go to **Certificates & secrets** → New client secret → Copy the value
9. Go to **Expose an API**:
   - Set Application ID URI: `api://YOUR_APP_DOMAIN/AAD_APP_ID`
   - Add a scope: `access_as_user`
10. Go to **API permissions**:
    - Add Microsoft Graph permissions: `User.Read`, `email`, `openid`, `profile`

## Step 3: Update Teams Manifest

1. Open `teams/manifest.json`
2. Replace placeholders:
   - `{{TEAMS_APP_ID}}`: Generate a new GUID at [guidgenerator.com](https://www.guidgenerator.com/)
   - `{{APP_URL}}`: Your deployed app URL (without trailing slash)
   - `{{APP_DOMAIN}}`: Your app domain (e.g., `standalone-tracker-app.azurewebsites.net`)
   - `{{AAD_APP_ID}}`: Your Azure AD App ID from Step 2

Example:
```json
"id": "a1b2c3d4-e5f6-7890-abcd-ef1234567890",
"validDomains": ["standalone-tracker-app.azurewebsites.net"],
"webApplicationInfo": {
  "id": "12345678-1234-1234-1234-123456789012",
  "resource": "api://standalone-tracker-app.azurewebsites.net/12345678-1234-1234-1234-123456789012"
}
```

## Step 4: Create App Icons

Create two PNG images:
- **color.png**: 192x192px, full color icon
- **outline.png**: 32x32px, transparent background, white outline

Save both in the `teams/` folder.

## Step 5: Package the Teams App

```bash
cd teams
zip -r ../StandaloneTracker.zip manifest.json color.png outline.png config.html
cd ..
```

## Step 6: Upload to Teams

### For Personal Use:
1. Open Microsoft Teams
2. Click **Apps** in the left sidebar
3. Click **Manage your apps** → **Upload an app**
4. Select **Upload a custom app**
5. Choose `StandaloneTracker.zip`
6. Click **Add** to install

### For Organization (Requires Admin):
1. Go to [Teams Admin Center](https://admin.teams.microsoft.com)
2. Navigate to **Teams apps** → **Manage apps**
3. Click **Upload** → Upload the `StandaloneTracker.zip`
4. Set publishing status to **Available**
5. Optionally set permissions and assignments

## Step 7: Use the App

1. In Teams, click **Apps** → Search for "Tracker"
2. Click **Add** to add to your personal apps
3. Or add to a channel: Go to a channel → **+** → Search "Tracker" → **Add**

## Troubleshooting

### CORS Issues
If you get CORS errors, ensure your backend allows Teams domains:
```python
# In app.py, update CORS settings
CORS(app, resources={
    r"/*": {
        "origins": [
            "https://teams.microsoft.com",
            "https://*.teams.microsoft.com",
            "https://*.office.com"
        ]
    }
})
```

### Authentication
For production, implement proper authentication using Azure AD tokens.

## Security Considerations

1. **Enable HTTPS**: Always use HTTPS in production
2. **Authentication**: Implement proper user authentication
3. **Data Storage**: Consider using Azure Storage or Database for persistent data
4. **API Security**: Add API keys or OAuth for backend endpoints

## Support

For issues or questions, contact your IT administrator or the development team.
