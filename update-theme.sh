#!/bin/bash

# This script updates the theme to the latest version and removes the unnecessary files

# Remove the existing theme directory
rm -rf themes/gokarna

# Clone the theme
git clone https://github.com/526avijitgupta/gokarna.git themes/gokarna

# Go to themes/gokarna directory
cd themes/gokarna

# Remove the .git directory
rm -rf .git

# Remove exampleSite directory
rm -rf exampleSite

# Remove images directory
rm -rf images

# Remove README.md
rm README.md

# Remove screenshot.py
rm screenshot.py
