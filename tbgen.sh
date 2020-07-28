#!/bin/bash

GREEN='\e[1;32m'
RED='\e[1;31m'
RESET='\e[0m'

REQUIRED_COMMAND='convert'
INSTALLATION_INSTRUCTIONS='
Installation:
  * Debian/Ubuntu
      sudo apt install imagemagick
  * Fedora/RHEL
      sudo dnf install ImageMagick
  * Arch/Manjaro
      sudo pacman -S imagemagick'


if [ $# -eq 0 ]; then
  echo You need to specify an image file
  exit 1
fi
echo -n "Checking for '$REQUIRED_COMMAND' command: "
if command -v $REQUIRED_COMMAND >/dev/null; then
  echo -e "$GREEN[ ok ]$RESET"
else
  echo -e "$RED[ not found ]$RESET"
  echo "$INSTALLATION_INSTRUCTIONS"
  exit 2
fi


[ ! -d timed_themes ] && mkdir timed_themes

convert "$1" -modulate 66 "timed_themes/day-$1"
convert "$1" -modulate 33 "timed_themes/night-$1"
cwd="$(pwd)"

cp "$1" timed_themes

cat << EOF > "timed_themes/$1.xml"
<background>
  <starttime>
    <year>2011</year>
    <month>11</month>
    <day>24</day>
    <hour>7</hour>
    <minute>00</minute>
    <second>00</second>
  </starttime>

<!-- This animation will start at 7 AM. -->

<!-- We start with sunrise at 7 AM. It will remain up for 1 hour. -->
<static>
<duration>3600.0</duration>
<file>$cwd/timed_themes/$1</file>
</static>

<!-- Sunrise starts to transition to day at 8 AM. The transition lasts for 5 hours, ending at 1 PM. -->
<transition type="overlay">
<duration>18000.0</duration>
<from>$cwd/timed_themes/$1</from>
<to>$cwd/timed_themes/day-$1</to>
</transition>

<!-- It's 1 PM, we're showing the day image in full force now, for 5 hours ending at 6 PM. -->
<static>
<duration>18000.0</duration>
<file>$cwd/timed_themes/day-$1</file>
</static>

<!-- It's 7 PM and it's going to start to get darker. This will transition for 6 hours up until midnight. -->
<transition type="overlay">
<duration>21600.0</duration>
<from>$cwd/timed_themes/day-$1</from>
<to>$cwd/timed_themes/night-$1</to>
</transition>

<!-- It's midnight. It'll stay dark for 5 hours up until 5 AM. -->
<static>
<duration>18000.0</duration>
<file>$cwd/timed_themes/night-$1</file>
</static>

<!-- It's 5 AM. We'll start transitioning to sunrise for 2 hours up until 7 AM. -->
<transition type="overlay">
<duration>7200.0</duration>
<from>$cwd/timed_themes/night-$1</from>
<to>$cwd/timed_themes/$1</to>
</transition>
</background>
EOF

gsettings set org.gnome.desktop.background picture-uri "file://$cwd/timed_themes/$1.xml"
