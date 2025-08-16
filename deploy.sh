#!/bin/bash

# Japanese School Organizer - Zero Cost Deployment Script

echo "🚀 Deploying Japanese School Organizer to GitHub Pages..."

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
echo "📋 Next steps:"
echo "1. Go to your GitHub repository"
echo "2. Settings → Pages"
echo "3. Source: Deploy from a branch"
echo "4. Branch: main, Folder: / (root)"
echo "5. Save - your site will be available in a few minutes"
echo ""
echo "🌐 Your site URL will be: https://YOUR_USERNAME.github.io/school-organizer"
echo ""
echo "🔧 To set up Supabase backend:"
echo "1. Follow the instructions in supabase-setup.md"
echo "2. Update your HTML file with Supabase credentials"
echo "3. Deploy again with this script"
