# :cookie: cookie-caster

_A [CC: Tweaked](https://tweaked.cc/) render engine to convert your images and display them in Minecraft_
<div align="center">
	<img src="https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExYjI0MTcxOGY0a2c1cnQyemY3cm5ycnlzZ2duZTJtNTh3NjM2enB4YyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/cpYN50eSMbac3Phf4w/giphy.gif">
</div>

## :memo: How to
This project requires python and either a modpack running CC: Tweaked or a forge instance that has CC: Tweaked installed.

### Building in-game 
Place down your desired size monitor and advanced computer close by. Place wired modems, one on the computer and one on each multi-block monitor. Connect them up by cable. Right click on the modems to activate them and assign them name Id's (these cannot be changed).
### Image => .nfpx conversion
1. Firstly, clone down the repo onto your machine
2. `2nfpx.py` enables you to bulk process image files, meaning that you can also render video in-game
    * If you just want to render a single image, simply drop your image file into `2nfpx/input/`
    * If you want to render video, please prepare your video before hand. Choose any method to convert your video to individual frames/images. I strongly recommend [ezgif](https://ezgif.com/video-to-jpg) to convert your video/gif to jpeg format, but you can do this however you wish. Drop all the images into `2nfpx/input/`
3. Make sure you cd into the `2nfpx/` directory before running the script
4. Run `python3 ./2nfpx` and follow the prompts

Input the number of monitor rows and columns you wish to use in-game. If you're not sure what the width and height in pixels your in-game monitors are, you can find this out by:
* Right click on the advanced computer and run `lua`
* type: `m = peripheral.wrap("monitor_*x*")` where *x* is the monitor Id when activating it's modem
* type: `m.setTextScale(0.5)` and then `m.getSize()`. This should output the width and height respectively, and should be the numbers you use in the python conversion script

### Running cookie-caster in Minecraft
1. Copy `cookie-caster/` into your minecraft save folder: `...saves/<saveGameName>/computercraft/computer/<computerID/`
* **Optional:** configure computer craft behaviour like max folder size in `...saves/<saveGameName>/serverconfig/computercraft-server.toml`. I recommend doing this if you require more space to hold bigger video
* **Optional:** delete `2nfpx/` folder (and git files) after copying the project files into your minecraft save. The python script does not need to be there
2. Copy the `*.nfpx` file(s) that you generated located in `2nfpx/build/` to the minecraft save's `cookie-caster/build/`. The frames must be in order if you desire video rendering
3. Finally, edit your config found in the `cookie-caster/` folder in-game:
* Make sure the width and height are the same as the monitor size and when you converted your image
* `mono.nfpx` files are a portable way to carry multiple images in one file for video rendering. Set this option to true if you copied a single mono file to the `build/` directory
* `MONITOR_LAYOUT` is a table that must contain all multi-block monitor Id's and their respective position (starting from the top left, is ID `1`, and then going left to right the Id increments)

## :wrench: How it works
Computer craft uses `.nfp` files, along side it's [paintUtils](https://computercraft.info/wiki/Paintutils_(API)) API to display colour on terminals and monitors. A `.nfp` file contains alphanumerical characters that correspond to a CC [colour](https://www.computercraft.info/wiki/Colors_(API)) (I.e. `e` => :red_circle:).

cookie-caster extends this file format `.nfpx` which holds higher resolution images, is video compatable, and has a devoted 16 colour palette per frame.

`2nfpx.py` is a script to convert your image file(s) to `.nfpx` to then be later imported into your minecraft world and rendered onto monitors of variable screen size.

cookie-caster also renders better colour representation - each frame has it's own colour palette. Meaning that we are not confined to computer craft's predetermined colour palette.
