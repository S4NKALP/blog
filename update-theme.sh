#!/bin/bash

# This script updates the theme to the latest version and removes the unnecessary files

# Remove the existing theme directory
rm -rf themes/hugo-blog-awesome

# Clone the theme
git clone https://github.com/hugo-sid/hugo-blog-awesome.git themes/hugo-blog-awesome

# Go to themes/gokarna directory
cd themes/hugo-blog-awesome

# Remove the .git directory
rm -rf .git
rm -rf .github

# Remove the .devcontainer directory
rm -rf .devcontainer

# Remove exampleSite directory
rm -rf exampleSite

# Remove images directory
rm -rf images

# Remove README.md
rm README.md

# Remove other .md file
rm CODE_OF_CONDUCT.md CHANGELOG.md CONTRIBUTING.md

