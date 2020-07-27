#!/bin/bash

REQUIRED_PKG="imagemagick"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "$REQUIRED_PKG was not found. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG 
fi

if [ ! -d "timed_themes" ]; then
  mkdir timed_themes
fi


convert $1 -modulate 66 ./timed_themes/"day-$1"
convert $1 -modulate 33 ./timed_themes/"night-$1"
cwd=$(pwd)

cp $1 $cwd/timed_themes/

echo "<background>
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
<transition type=\"overlay\">
<duration>18000.0</duration>
<from>$cwd/timed_themes/$1</from>
<to>$cwd/timed_themes/"day-$1"</to>
</transition>

<!-- It's 1 PM, we're showing the day image in full force now, for 5 hours ending at 6 PM. -->
<static>
<duration>18000.0</duration>
<file>$cwd/timed_themes/"day-$1"</file>
</static>

<!-- It's 7 PM and it's going to start to get darker. This will transition for 6 hours up until midnight. -->
<transition type=\"overlay\">
<duration>21600.0</duration>
<from>$cwd/timed_themes/"day-$1"</from>
<to>$cwd/timed_themes/"night-$1"</to>
</transition>

<!-- It's midnight. It'll stay dark for 5 hours up until 5 AM. -->
<static>
<duration>18000.0</duration>
<file>$cwd/timed_themes/"night-$1"</file>
</static>

<!-- It's 5 AM. We'll start transitioning to sunrise for 2 hours up until 7 AM. -->
<transition type=\"overlay\">
<duration>7200.0</duration>
<from>$cwd/timed_themes/"night-$1"</from>
<to>$cwd/timed_themes/$1</to>
</transition>
</background>" > $cwd"/timed_themes/$1.xml"

gsettings set org.gnome.desktop.background picture-uri file://$cwd/timed_themes/$1.xml
