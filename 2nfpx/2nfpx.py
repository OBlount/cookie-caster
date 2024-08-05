#!/usr/bin/env python

import os
from lib.io import userInput
from lib.util import cleanFolder, fileWhitelist, resizeFrames, tileFrames, createMonoFile, monoFileName
from lib.generate import generate

def main():
    inDir  = os.path.join(os.getcwd(), "input/")
    outDir = os.path.join(os.getcwd(), "build/")

    # User input
    monitorColumns, monitorRows, width, height, monoFlag = userInput()

    # Prepare frames
    print("Preparing frames")
    cleanFolder(outDir, overrideWhitelist=[fileName for fileName in fileWhitelist if fileName != monoFileName])
    resizeFrames(inDir, width*monitorColumns, height*monitorRows)
    tileFrames(inDir, monitorColumns, monitorRows)

    # Convert each image to nfpx
    generate(inDir, outDir, monitorColumns*monitorRows)

    # Cleanup
    if monoFlag:
        createMonoFile(outDir)
        cleanFolder(outDir)
    cleanFolder(inDir)
    print("Finished conversion")

main()
