import sys
import time
import shutil
from art import text2art

text = text2art(sys.argv[1])
width = shutil.get_terminal_size(fallback=(80, 20)).columns
left_padding = max((width - text.find("\n")) // 2, 0)
text = text.replace("\n", "\n" + " " * left_padding)
height = shutil.get_terminal_size(fallback=(80, 20)).lines
top_padding = height // 2
print("\n" * top_padding + " " * left_padding + text)
time.sleep(float(sys.argv[2]))
