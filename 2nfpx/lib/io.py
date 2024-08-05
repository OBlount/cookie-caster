def userInput():
    x = int(input(": How many columns of monitors? [default:1]\n ---> ")           .strip() or 1)
    y = int(input(": How many rows of monitors? [default:1]\n ---> ")              .strip() or 1)
    w = int(input(": How many pixels wide are the monitors? [default:164]\n ---> ").strip() or 164)
    h = int(input(": How many pixels tall are the monitors? [default:81]\n ---> ") .strip() or 81)

    monoFlag = True if \
    (input(": Would you like the output to be mono format y/n? [default:y]\n ---> ").strip().capitalize() or "Y") == "Y" \
    else False

    return (x, y, w, h, monoFlag)
