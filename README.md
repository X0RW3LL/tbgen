# Timed Background Generator

<p>This bash script will create timed backgrounds for GNOME display managers. Based on Kali's timed theme—more on that later.</br>
Ideally, you're gonna wanna choose a well-lit background (think daytime lighting conditions).</p>
</br>
<h2>Instructions</h2>
<p>1. clone this repo locally</br>
$ git clone https://github.com/X0RW3LL/tbgen.git</br></br>
2. cd into the repo</br>
$ cd tbgen</br></br>
3. Make sure tbgen.sh has execute permissions</br>
$ chmod +x tbgen.sh</br></br>
4. Copy and paste the image of your choice inside the repo</br>
$ cp /path/to/image .</br></br>
5. Run the script with the image as the first argument</br>
$ ./tbgen.sh your_image.jpg</br>
<strong>OR</strong></br>
$ sh tbgen.sh your_image.jpg</p>
</br>
<h2>Inspiration</h2>
<p> I was tinkering around Kali's background when I came across one that's timed based on the time of day. It's lighter and brighter during daytime, and gets darker towards night time. I just <strong>had</strong> to figure out how it worked.</br>
I went through gnome-tweaks ($ sudo apt install gnome-tweaks), got the location of said background (/usr/share/backgrounds/gnome/adwaita-timed.xml) and made sense of how it worked.</br>
I thought it would be cool to create custom ones at will. Hence the idea for this script came to being.</p>
</br>
<h2>What does the script actually do?</h2>
<p>1. Checks if you have ImageMagick installed, and installs it if it's not on your system—we need this package to modulate the brightness of the image</br>
2. Creates a directory called timed_themes (and checks if it already exists on later runs)</br>
3. Creates 2 images with 66% and 33% brightness, respectively, titled day-image and night-image, respectively</br>
4. Copies the image you passed in as an argument to the timed_themes directory
5. Creates an xml file (based on adwaita-timed.xml , many thanks for the original author(s)), and uses the newly generated images in place
6. Sets your <strong>desktop</strong> background image to the newly generated timed background. Kindly note that it will only change your desktop background image, and not the lockscreen image. Refer to <strong>Limitations</strong> for more</p>
</br>
<h2>Limitations</h2>
<p>1. I'm not, by any means, skilled at bash scripting; the timed image will preserve its extension (aka if you have image.png, the generated image will be titled image.png.xml). It still runs without a hitch, but I know it does bug me when it comes to aesthetics</br>
2. Some images might not be perfect in terms of brightness modulation. Unfortunately, I don't have an immediate workaround to analyze the image beforehand</br>
3. This script will only change the desktop background, not the lockscreen image.
4. This has only been tested on GNOME. I do not know whether or not this works on other display managers like XFCE, MATE, KDE, etc.</p>
</br>
<h2>Troubleshooting</h2>
<p><strong>Artifacts in brighter areas of the image when later towards the evening</strong></br>
Current workaround: choose a different image, or play around in the modulation value in the script</br>
<strong>Xsession broke, I'm logged out, and I can't log back in. WTF did you do?</strong></br>
Current workaround:</br>
1. Switch to a tty2 session</br>
CTRL + ALT + F2</br>
2. Provide your username, followed by your password</br>
3. Change your desktop background to the image your provided with the following command</br>
gsettings set org.gnome.desktop.background picture-uri file:///path/to/your_image.jpg</br>
For example, if your your_image.jpg is in the repo, and your username is userx, issue the following command:</br>
gsettings set org.gnome.desktop.background picture-uri file:///home/userx/tbgen/your_image.jpg</br>
4. Exit out of the tty2 session, and proceed to login to your Xsession</br>
$ exit</br>
<strong>Note: </strong>I did run into this issue at first because I handled the path to the image incorrectly. It works fine now</p>
</br>
<h2>Credits</h2>
<p>The entire Linux and Open Source community</br>
The Kali Linux team: <a href="https://twitter.com/kalilinux">&#64;kalilinux</a></br>
Stök Fredrik: <a href="https://twitter.com/stokfredrik">&#64;stokfredrik</a>, for inspiration with his Medium post: <a href="https://medium.com/@stokochtrubbel/how-to-make-kali-bearable-to-look-at-5593771fafc5">HOW TO MAKE KALI BEARABLE TO LOOK AT..</a></br>
Daniel Ruiz: <a href="https://twitter.com/dani_ruiz24">&#64;dani_ruiz24</a>, for his continuous improvements for Kali's themes. Check out his website: <a href="https://drasite.com/">DяA | Daniel Ruiz de Alegría</a></br>
The image I'm using: <a href="https://www.pixel4k.com/small-lake-red-sunset-111735.html">Small Lake Red Sunset</a></br>
Bash snippet to check for installed packages: https://stackoverflow.com/a/10439058</br>
</br>
<h2>Preview Images</h2>
<p float="center">
<img src="./previews/lake.jpg" raw=true alt="Morning" width="33%" title="Morning"/>
<img src="./previews/day-lake.jpg" raw=true alt="Day" width="33%" title="Day"/>
<img src="./previews/night-lake.jpg" raw=true alt="Night" width="33%" title="Night"/>
</p>
