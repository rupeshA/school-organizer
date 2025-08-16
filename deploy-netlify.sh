#!/bin/bash

# Japanese School Organizer - Netlify Deployment Script

echo "🚀 Deploying Japanese School Organizer to Netlify..."

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Git repository not initialized. Run 'git init' first."
    exit 1
fi

# Check if remote origin exists
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "❌ No remote origin found. Please add your GitHub repository:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/school-organizer.git"
    exit 1
fi

# Add all files
echo "📁 Adding files to git..."
git add .

# Commit changes
echo "💾 Committing changes..."
git commit -m "Update: $(date)"

# Push to GitHub
echo "⬆️ Pushing to GitHub..."
git push origin main

echo "✅ Deployment complete!"
echo ""
echo "📋 Netlify will automatically deploy from your GitHub repository"
echo ""
echo "🔧 To set up Supabase backend:"
echo "1. Follow the instructions in supabase-setup.md"
echo "2. Update your HTML file with Supabase credentials"
echo "3. Push changes - Netlify will auto-deploy"
echo ""
echo "🌐 Your Netlify site URL: https://your-site-name.netlify.app"
echo ""
echo "💡 Benefits of Netlify:"
echo "- Automatic deployments from Git"
echo "- Global CDN for fast loading"
echo "- Custom domains included"
echo "- Easy rollbacks and previews"
