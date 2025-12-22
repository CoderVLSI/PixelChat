#!/bin/bash
set -e

echo "🔧 Installing Flutter..."

# Download Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1 /opt/flutter

# Add Flutter to PATH for all sessions
echo 'export PATH="$PATH:/opt/flutter/bin"' | tee -a /etc/bash.bashrc
echo 'export PATH="$PATH:/opt/flutter/bin"' | tee -a ~/.bashrc

# Export for current session
export PATH="$PATH:/opt/flutter/bin"

# Accept Android licenses (non-interactive)
yes | flutter doctor --android-licenses > /dev/null 2>&1 || true

# Run flutter doctor to install necessary components
flutter config --no-analytics
flutter precache --android
flutter doctor -v

echo "✅ Flutter installation complete!"
echo "Flutter version: $(flutter --version 2>&1 | head -n 1)"
echo ""
echo "Please reload your terminal by running: source ~/.bashrc"
