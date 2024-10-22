import __main__
import os

DKSCRIPT_PATH = __main__.__file__
print("DKSCRIPT_PATH = "+DKSCRIPT_PATH)

DKSCRIPT_DIR = os.path.dirname(DKSCRIPT_PATH)
print("DKSCRIPT_DIR = "+DKSCRIPT_DIR)

DKSCRIPT_NAME = os.path.basename(DKSCRIPT_PATH)
print("DKSCRIPT_NAME = "+DKSCRIPT_NAME)

DKSCRIPT_EXT = os.path.splitext(DKSCRIPT_NAME)[1]
print("DKSCRIPT_EXT = "+DKSCRIPT_EXT)
