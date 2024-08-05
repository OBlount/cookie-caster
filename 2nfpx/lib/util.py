import os
import PIL
from PIL import Image
from split_image import split_image as splitImage

monoFileName = "mono.nfpx"

fileWhitelist = [
    ".gitkeep",
    ".gitignore",
    monoFileName
]

def cleanFolder(directory, overrideWhitelist=fileWhitelist):
    for filename in os.listdir(directory):
        path = os.path.join(directory, filename)
        if (os.path.isfile(path) and filename not in overrideWhitelist):
            os.remove(path)

def resizeFrames(inDir, width, height):
    for filename in os.listdir(inDir):
        path = os.path.join(inDir, filename)
        if (os.path.isfile(path) and filename not in fileWhitelist):
            PIL.Image.open(path).resize((width, height)).save(path)

def tileFrames(inDir, totalMonitorsX, totalMonitorsY):
    for filename in os.listdir(inDir):
        path = os.path.join(inDir, filename)
        if (os.path.isfile(path) and totalMonitorsX*totalMonitorsY > 1 and filename not in fileWhitelist):
            splitImage(path, totalMonitorsY, totalMonitorsX, False, True, True, inDir)

def createMonoFile(outDir):
    with open(f"{outDir}{monoFileName}", "w") as monoFile:
        for filename in os.listdir(outDir):
            path = os.path.join(outDir, filename)
            if (os.path.isfile(path) and filename not in fileWhitelist):
                with open(path, "r", newline="\r\n") as frameFile:
                    monoFile.write(frameFile.read())
