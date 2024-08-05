import os
import PIL
from PIL import Image
from tqdm import tqdm
from colorthief import ColorThief
from lib.pallete import CC_COLOURS as ccColours
from lib.util import fileWhitelist

def generate(inDir, outDir, numberOfMonitors):
    frameIndex = 0
    chunkCount = 0
    for filename in tqdm([file for file in os.listdir(inDir) if file not in fileWhitelist], desc="Frame Conversion"):
        path = os.path.join(inDir, filename)
        if (os.path.isfile(path)):
            toNFPX(path, frameIndex, outDir)
            chunkCount += 1
        if (chunkCount % numberOfMonitors == 0):
            frameIndex += 1
            chunkCount = 0

def toNFPX(imagePath, frameIndex, outDir, modColourPalette=True):
    buffer = []
    image  = PIL.Image.open(imagePath)
    pixels = image.load()
    frameColourPallete = getColourPalette(imagePath) if modColourPalette else ccColours

    # Write pallete to buffer, each colour seperated by a new line
    for colour in frameColourPallete:
        buffer.append(f"0x{colour[1].upper()}\n")
    
    # Write pixel colour to buffer
    for i in range(image.height):
        for j in range(image.width):
            buffer.append(normaliseColour(pixels[j, i], frameColourPallete))
    
    # Write buffer to nfpx file
    with open(f"{outDir}frame_{frameIndex:08}.nfpx", "a", newline="\r\n") as file:
        for code in buffer:
            file.write(code)
        file.write("\n")

def getColourPalette(imagePath):
    colorThief = ColorThief(imagePath)
    palette    = colorThief.get_palette(color_count=17, quality=10)
    for i in range(len(palette), 16):
        palette.append((0, 0, 0))
    return [(f"modded_{ccColours[i][0]}", "%02x%02x%02x" % palette[i], hex(i)[2:]) for i in range(0, len(palette))]

def normaliseColour(rgb, pallete):
    bestColourCode = "f"
    bestDistance   = float("inf")
    for (_, colour, colourCode) in pallete:
        selectedColour = hexToRGB(colour)
        if rgb == 0:
            rgb = (0, 0, 0)
        # https://www.baeldung.com/cs/compute-similarity-of-colours
        d = (0.3  * ((selectedColour[0] - rgb[0])**2)) + \
            (0.59 * ((selectedColour[1] - rgb[1])**2)) + \
            (0.11 * ((selectedColour[2] - rgb[2])**2))
        if (d < bestDistance):
            bestDistance   = d
            bestColourCode = colourCode
    return bestColourCode

def hexToRGB(h):
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))
