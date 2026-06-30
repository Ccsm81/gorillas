#!/bin/bash
set -e
cd "$(dirname "$0")"
ROOT="$(cd .. && pwd)"
APP="Gorillas.app"
BUILD="build"
DIST="$ROOT/dist"

echo "==> curăț build vechi"
rm -rf "$BUILD" "$APP" AppIcon.icns Gorillas.iconset
mkdir -p "$BUILD"

echo "==> compilez GorillasApp.swift (arm64)"
swiftc -O -o "$BUILD/Gorillas" GorillasApp.swift -framework Cocoa -framework WebKit

echo "==> generez AppIcon.icns din icon-512.png"
mkdir -p Gorillas.iconset
SRC="$ROOT/icon-512.png"
for s in 16 32 128 256 512; do
  sips -z $s $s "$SRC" --out "Gorillas.iconset/icon_${s}x${s}.png" >/dev/null
  d=$((s*2))
  sips -z $d $d "$SRC" --out "Gorillas.iconset/icon_${s}x${s}@2x.png" >/dev/null
done
iconutil -c icns Gorillas.iconset -o AppIcon.icns

echo "==> asamblez $APP"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources/web"
cp "$BUILD/Gorillas" "$APP/Contents/MacOS/Gorillas"
chmod +x "$APP/Contents/MacOS/Gorillas"
cp Info.plist "$APP/Contents/Info.plist"
cp AppIcon.icns "$APP/Contents/Resources/AppIcon.icns"
# asseturile jocului
for f in index.html manifest.json sw.js icon-180.png icon-192.png icon-512.png; do
  [ -f "$ROOT/$f" ] && cp "$ROOT/$f" "$APP/Contents/Resources/web/$f"
done

echo "==> semnez ad-hoc (rulează local fără cont developer)"
codesign --force --deep --sign - "$APP" 2>/dev/null || echo "  (codesign ad-hoc a dat warning, dar app-ul rulează)"

echo "==> creez DMG"
mkdir -p "$DIST"
STAGE="$BUILD/dmg"
rm -rf "$STAGE"; mkdir -p "$STAGE"
cp -R "$APP" "$STAGE/"
ln -s /Applications "$STAGE/Applications"
DMG="$DIST/Gorillas-v24.dmg"
rm -f "$DMG"
hdiutil create -volname "Gorillas" -srcfolder "$STAGE" -ov -format UDZO "$DMG" >/dev/null

echo "==> gata:"
ls -lh "$DMG" | awk '{print "   "$5"  "$NF}'
echo "   app: $ROOT/mac/$APP"
