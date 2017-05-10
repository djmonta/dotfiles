#!/bin/sh
# mkshellapp.sh - make application from shell_script
PROG=`basename $0`
USAGE="Usage: $PROG shell_script"

case $# in
1)  scr="$1" ;;
*)  echo $USAGE >&2
    exit 2 ;;
esac

app_name=`basename "$scr" .sh`.app

mkdir -p "$app_name"/Contents/MacOS

if [ -x "$scr" ]; then
    cp -p "$scr" "$app_name"/Contents/MacOS
else
    echo "Error: $PROG: $scr is not found or not executable." 2>&1
    exit 1
fi

cat << EOF > "$app_name"/Contents/Info.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>CFBundleExecutable</key>
    <string>`basename "$scr"`</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleSignature</key>
    <string>????</string>
  </dict>
</plist>
EOF

echo "$PROG: $app_name successfully created."