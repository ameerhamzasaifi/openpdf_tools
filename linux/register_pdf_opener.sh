#!/bin/bash
# Linux PDF opener registration script
# This script registers OpenPDF Tools as the default PDF opener on Linux systems

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_NAME="openpdf_tools"
DESKTOP_DIR="${HOME}/.local/share/applications"
MIME_DIR="${HOME}/.local/share/mime/packages"
ICONS_DIR="${HOME}/.local/share/icons/hicolor/256x256/apps"

echo "Registering OpenPDF Tools as PDF opener..."

# Create necessary directories
mkdir -p "$DESKTOP_DIR"
mkdir -p "$MIME_DIR"

# Install desktop entry
if [ -f "$SCRIPT_DIR/$APP_NAME.desktop" ]; then
    cp "$SCRIPT_DIR/$APP_NAME.desktop" "$DESKTOP_DIR/$APP_NAME.desktop"
    echo "✓ Desktop entry installed"
else
    echo "✗ Desktop file not found"
    exit 1
fi

# Install MIME type definitions
if [ -f "$SCRIPT_DIR/mimetypes.xml" ]; then
    cp "$SCRIPT_DIR/mimetypes.xml" "$MIME_DIR/$APP_NAME-mimetypes.xml"
    
    # Update MIME database if available
    if command -v update-mime-database &> /dev/null; then
        update-mime-database "$HOME/.local/share/mime"
        echo "✓ MIME types registered"
    else
        echo "⚠ MIME database not updated (install shared-mime-info to enable)"
    fi
else
    echo "⚠ MIME types file not found, skipping"
fi

# Update desktop database if available
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database "$DESKTOP_DIR"
    echo "✓ Desktop database updated"
fi

# Set as default PDF opener
echo "Setting as default PDF opener..."

# Using xdg-mime if available
if command -v xdg-mime &> /dev/null; then
    xdg-mime default "$APP_NAME.desktop" application/pdf
    xdg-mime default "$APP_NAME.desktop" x-scheme-handler/openpdf
    echo "✓ Set as default PDF opener"
else
    echo "⚠ xdg-mime not available, please set manually through your file manager settings"
fi

# Copy icon if it exists
if [ -f "$SCRIPT_DIR/../asset/app_img/OpenPDF Tools.png" ]; then
    mkdir -p "$ICONS_DIR"
    cp "$SCRIPT_DIR/../asset/app_img/OpenPDF Tools.png" "$ICONS_DIR/$APP_NAME.png"
    
    if command -v gtk-update-icon-cache &> /dev/null; then
        gtk-update-icon-cache "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
        echo "✓ Icon cache updated"
    fi
else
    echo "⚠ Icon not found"
fi

echo ""
echo "✓ OpenPDF Tools registered as PDF opener successfully!"
echo ""
echo "To uninstall, run:"
echo "  rm '$DESKTOP_DIR/$APP_NAME.desktop'"
echo "  rm '$MIME_DIR/$APP_NAME-mimetypes.xml'"
echo "  update-mime-database ~/.local/share/mime"
