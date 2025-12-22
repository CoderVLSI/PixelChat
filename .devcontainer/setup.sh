#!/bin/bash

# Install Flutter
echo "Installing Flutter..."
cd /tmp
git clone https://github.com/flutter/flutter.git -b stable
mv flutter /opt/

# Add Flutter to PATH
echo 'export PATH="$PATH:/opt/flutter/bin"' >> ~/.bashrc
export PATH="$PATH:/opt/flutter/bin"

# Pre-download Flutter dependencies
echo "Setting up Flutter..."
flutter config --no-analytics
flutter doctor -v

echo "Flutter installation complete!"
echo "Please reload your terminal or run: source ~/.bashrc"
