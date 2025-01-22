import sys 
sys.path.append(".")
import DK

##################################################################################
# dk_color(on/off)
#
# Enable / Disable console text and background coloring
#
#   on/off:  Default ON
#
#   https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
#   https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
#   https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences
#
#def dk_color(*args):
    #dk_debugFunc 0 1

global USE_COLOR
USE_COLOR=1
#if defined args[0] if args[0] equ 0 USE_COLOR=

#    if USE_COLOR == 1:
ESC=""                          # escape character

### Attributes on ##
clr=ESC+"[0m"                  # Default                     - Returns all attributes to the default state prior to modification
bold=ESC+"[1m"                 # Bold/Bright                 - Applies brightness/intensity flag to foreground color
dim=ESC+"[2m"                  # Dim
italic=ESC+"[3m"               # Italic
underline=ESC+"[4m"            # Underline                   - Adds underline
blink=ESC+"[5m"                # Blink
fblink=ESC+"[6m"               # Rapid Blink
negative=ESC+"[7m"             # Negative                    - Swaps foreground and background colors
invisible=ESC+"[8m"            # Invisible
strike=ESC+"[9m"               # Strike Through

### Attributes off ###
# 20m=ESC+"[20m"               # 20
# 21m=ESC+"[21m"               # 21
nobold=ESC+"[22m"              # No bold/bright              - Removes brightness/intensity flag from foreground color
noitalic=ESC+"[23m"            # No italic
nounderline=ESC+"[24m"         # No underline                - Removes underline
noblink=ESC+"[25m"             # No Blink
# 26m=ESC+"[26m"               # 26
nonegative=ESC+"[27m"          # Positive(No negative)       - Returns foreground/background to normal
visible=ESC+"[28m"             # Visible(No invisible)
nostrike=ESC+"[29m"            # No Strike Through

### Foreground Colors ##
black=ESC+"[30m"               # Foreground Black            - Applies non-bold/bright black to foreground
red=ESC+"[31m"                 # Foreground Red              - Applies non-bold/bright red to foreground
green=ESC+"[32m"               # Foreground Green            - Applies non-bold/bright green to foreground
yellow=ESC+"[33m"              # Foreground Yellow           - Applies non-bold/bright yellow to foreground
blue=ESC+"[34m"                # Foreground Blue             - Applies non-bold/bright blue to foreground
magenta=ESC+"[35m"             # Foreground Magenta          - Applies non-bold/bright magenta to foreground
cyan=ESC+"[36m"                # Foreground Cyan             - Applies non-bold/bright cyan to foreground
white=ESC+"[37m"               # Foreground White            - Applies non-bold/bright white to foreground
extended=ESC+"[38m"            # Foreground Extended         - Applies extended color value to the foreground
default=ESC+"[39m"             # Foreground Default          - Applies only the foreground portion of the defaults

### Background Colors ###
bg_black=ESC+"[40m"            # Background Black            - Applies non-bold/bright black to background
bg_red=ESC+"[41m"              # Background Red              - Applies non-bold/bright red to background
bg_green=ESC+"[42m"            # Background Green            - Applies non-bold/bright green to background
bg_yellow=ESC+"[43m"           # Background Yellow           - Applies non-bold/bright yellow to background
bg_blue=ESC+"[44m"             # Background Blue             - Applies non-bold/bright blue to background
bg_magenta=ESC+"[45m"          # Background Magenta          - Applies non-bold/bright magenta to background
bg_cyan=ESC+"[46m"             # Background Cyan             - Applies non-bold/bright cyan to background
bg_white=ESC+"[47m"            # Background White            - Applies non-bold/bright white to background
bg_extended=ESC+"[48m"         # Background Extended         - Applies extended color value to the background
bg_default=ESC+"[49m"          # Background Default          - Applies only the background portion of the defaults

### Foreground Colors (light) ###
lblack=ESC+"[90m"              # Bright Foreground Black     - Applies bold/bright black to foreground
lred=ESC+"[91m"                # Bright Foreground Red       - Applies bold/bright red to foreground
lgreen=ESC+"[92m"              # Bright Foreground Green     - Applies bold/bright green to foreground
lyellow=ESC+"[93m"             # Bright Foreground Yellow    - Applies bold/bright yellow to foreground
lblue=ESC+"[94m"               # Bright Foreground Blue      - Applies bold/bright blue to foreground
lmagenta=ESC+"[95m"            # Bright Foreground Magenta   - Applies bold/bright magenta to foreground
lcyan=ESC+"[96m"               # Bright Foreground Cyan      - Applies bold/bright cyan to foreground
lwhite=ESC+"[97m"              # Bright Foreground White     - Applies bold/bright white to foreground

### Background Colors (light) ###
bg_lblack=ESC+"[100m"          # Bright Background Black     - Applies bold/bright black to background
bg_lred=ESC+"[101m"            # Bright Background Red       - Applies bold/bright red to background
bg_lgreen=ESC+"[102m"          # Bright Background Green     - Applies bold/bright green to background
bg_lyellow=ESC+"[103m"         # Bright Background Yellow    - Applies bold/bright yellow to background
bg_lblue=ESC+"[104m"           # Bright Background Blue      - Applies bold/bright blue to background
bg_lmagenta=ESC+"[105m"        # Bright Background Magenta   - Applies bold/bright magenta to background
bg_lcyan=ESC+"[106m"           # Bright Background Cyan      - Applies bold/bright cyan to background
bg_lwhite=ESC+"[107m"          # Bright Background White     - Applies bold/bright white to background

### Foreground RGB Colors ###
RGB=ESC+"[38;2;"               # +RGB+50;100;150m         = ESC+"[38;2;50;100;150m
### Background RGB Colors ###
bg_RGB=ESC+"[48;2;"            # +bg_RGB+150;100;50m      = ESC+"[38;2;150;100;50m

print(blue+"C"+green+"O"+red+"L"+magenta+"O"+cyan+"R "+blue+"O"+green+"N"+clr)
  
#    else
#       # dk_unset ESC
#        # dk_unset clr
#
#        ### Attributes on ###
#        dk_unset bold
#        dk_unset dim
#        dk_unset italic
#        dk_unset underline
#        dk_unset blink
#        dk_unset fblink
#        dk_unset negative
#        dk_unset invisible
#        dk_unset strike
#
#        ### Attributes off ###
#        dk_unset nobold
#        dk_unset noitalic
#        dk_unset nounderline
#        dk_unset noblink
#        dk_unset nonegative
#        dk_unset visible
#        dk_unset nostrike
#
#        ### Foreground Colors ###
#        dk_unset black
#        dk_unset red
#        dk_unset green
#        dk_unset yellow
#        dk_unset blue
#        dk_unset magenta
#        dk_unset cyan
#        dk_unset white
#
#       ### Background Colors ###
#        dk_unset bg_black
#        dk_unset bg_red
#        dk_unset bg_green
#        dk_unset bg_yellow
#        dk_unset bg_blue
#        dk_unset bg_magenta
#        dk_unset bg_cyan
#        dk_unset bg_white
#
#        ### Foreground Colors (bright) ###
#        dk_unset lblack
#        dk_unset lred
#        dk_unset lgreen
#        dk_unset lyellow
#        dk_unset lblue
#        dk_unset lmagenta
#        dk_unset lcyan
#        dk_unset lwhite
#
#        ### Background Colors (bright) ###
#        dk_unset bg_lblack
#        dk_unset bg_lred
#        dk_unset bg_lgreen
#        dk_unset bg_lyellow
#        dk_unset bg_lblue
#        dk_unset bg_lmagenta
#        dk_unset bg_lcyan
#        dk_unset bg_lwhite
#
#        dk_unset RGB
#        dk_unset bg_RGB
#
#        dk_echo(clr+"COLOR OFF")

#dk_color()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#	dk_debugFunc 0

    print()
    print(black+bg_lblack+"           Styles            "+clr)
    print("clr        "+clr+" default "+clr)
    print("bold       "+bold+" bold "+clr)
    print("dim        "+dim+" dim"+clr)
    print("italic     "+italic+" italic"+clr)
    print("underline  "+underline+" underline"+clr)
    print("blink      "+blink+" blink"+clr)
    print("fblink     "+fblink+" fblink"+clr)
    print("negative   "+negative+" negative"+clr)
    print("invisible  "+invisible+" invisible"+clr)
    print("strike     "+strike+" strike"+clr)
    print()
    print()
    print(black+bg_lblack+"      Foreground Colors      "+clr)
    print("black      "+black+" black"+clr)
    print("red        "+red+" red"+clr)
    print("green      "+green+" green"+clr)
    print("yellow     "+yellow+" yellow"+clr)
    print("blue       "+blue+" blue"+clr)
    print("magenta    "+magenta+" magenta"+clr)
    print("cyan       "+cyan+" cyan"+clr)
    print("white      "+white+" white"+clr)
    print()
    print()
    print(black+bg_lblack+"      Background Colors      "+clr)
    print("bg_black   "+bg_black+" bg_black"+clr)
    print("bg_red     "+bg_red+" bg_red"+clr)
    print("bg_green   "+bg_green+" bg_green"+clr)
    print("bg_yellow  "+bg_yellow+" bg_yellow"+clr)
    print("bg_blue    "+bg_blue+" bg_blue"+clr)
    print("bg_magenta "+bg_magenta+" bg_magenta"+clr)
    print("bg_cyan    "+bg_cyan+" bg_cyan"+clr)
    print("bg_white   "+bg_white+" bg_white"+clr)
    print()
    print()
    print(black+bg_lblack+" Foreground Colors  bright  "+clr)
    print("lblack      "+lblack+" lblack"+clr)
    print("lred        "+lred+" lred"+clr)
    print("lgreen      "+lgreen+" lgreen"+clr)
    print("lyellow     "+lyellow+" lyellow"+clr)
    print("lblue       "+lblue+" lblue"+clr)
    print("lmagenta    "+lmagenta+" lmagenta"+clr)
    print("lcyan       "+lcyan+" lcyan"+clr)
    print("lwhite      "+lwhite+" lwhite"+clr)
    print()
    print()
    print("black+ +bg_lblack+ Background Colors  bright "+clr)
    print("bg_lblack   "+bg_lblack+" bg_lblack"+clr)
    print("bg_lred     "+bg_lred+" bg_lred"+clr)
    print("bg_lgreen   "+bg_lgreen+" bg_lgreen"+clr)
    print("bg_lyellow  "+bg_lyellow+" bg_lyellow"+clr)
    print("bg_lblue    "+bg_lblue+" bg_lblue"+clr)
    print("bg_lmagenta "+bg_lmagenta+" bg_lmagenta"+clr)
    print("bg_lcyan    "+bg_lcyan+" bg_lcyan"+clr)
    print("bg_lwhite   "+bg_lwhite+" bg_lwhite"+clr)
    print()
    print()
    print(black+bg_lblack+"   RGB Foreground Colors  "+clr)
    print(RGB+"255;10;10m    RGB test 255;0;10    "+clr)
    print(RGB+"10;255;10m    RGB test 0;255;10   "+clr)
    print(RGB+"0;0;255m    RGB test 0;0;255    "+clr)
    print(RGB+"0;0;250m    RGB test 0;0;250    "+clr)
    print(RGB+"0;0;245m    RGB test 0;0;245    "+clr)
    print(RGB+"0;0;240m    RGB test 0;0;240    "+clr)
    print(RGB+"0;0;235m    RGB test 0;0;235    "+clr)
    print(RGB+"0;0;230m    RGB test 0;0;230    "+clr)
    print(RGB+"0;0;225m    RGB test 0;0;225    "+clr)
    print(RGB+"0;0;220m    RGB test 0;0;220    "+clr)
    print(RGB+"0;0;215m    RGB test 0;0;215    "+clr)
    print(RGB+"0;0;210m    RGB test 0;0;210    "+clr)
    print(RGB+"0;0;205m    RGB test 0;0;205    "+clr)
    print(RGB+"0;0;200m    RGB test 0;0;200    "+clr)
    print(RGB+"0;0;195m    RGB test 0;0;195    "+clr)
    print(RGB+"0;0;190m    RGB test 0;0;190    "+clr)
    print(RGB+"0;0;185m    RGB test 0;0;185    "+clr)
    print(RGB+"0;0;180m    RGB test 0;0;180    "+clr)
    print(RGB+"0;0;175m    RGB test 0;0;175    "+clr)
    print(RGB+"0;0;170m    RGB test 0;0;170    "+clr)
    print(RGB+"0;0;165m    RGB test 0;0;165    "+clr)
    print(RGB+"0;0;160m    RGB test 0;0;160    "+clr)
    print(RGB+"0;0;155m    RGB test 0;0;155    "+clr)
    print(RGB+"0;0;150m    RGB test 0;0;150    "+clr)
    print(RGB+"0;0;145m    RGB test 0;0;145    "+clr)
    print(RGB+"0;0;140m    RGB test 0;0;140    "+clr)
    print(RGB+"0;0;135m    RGB test 0;0;135    "+clr)
    print(RGB+"0;0;130m    RGB test 0;0;130    "+clr)
    print(RGB+"0;0;125m    RGB test 0;0;125    "+clr)
    print(RGB+"0;0;120m    RGB test 0;0;120    "+clr)
    print(RGB+"0;0;115m    RGB test 0;0;115    "+clr)
    print(RGB+"0;0;110m    RGB test 0;0;110    "+clr)
    print(RGB+"0;0;105m    RGB test 0;0;105    "+clr)
    print(RGB+"0;0;100m    RGB test 0;0;100    "+clr)
    print(RGB+"0;0;95m    RGB test 0;0;95     "+clr)
    print(RGB+"0;0;90m    RGB test 0;0;90     "+clr)
    print(RGB+"0;0;85m    RGB test 0;0;85     "+clr)
    print(RGB+"0;0;80m    RGB test 0;0;80     "+clr)
    print(RGB+"0;0;75m    RGB test 0;0;75     "+clr)
    print(RGB+"0;0;70m    RGB test 0;0;70     "+clr)
    print(RGB+"0;0;65m    RGB test 0;0;65     "+clr)
    print(RGB+"0;0;60m    RGB test 0;0;60     "+clr)
    print(RGB+"0;0;55m    RGB test 0;0;55     "+clr)
    print(RGB+"0;0;50m    RGB test 0;0;50     "+clr)
    print(RGB+"0;0;45m    RGB test 0;0;45     "+clr)
    print(RGB+"0;0;40m    RGB test 0;0;40     "+clr)
    print(RGB+"0;0;35m    RGB test 0;0;35     "+clr)
    print(RGB+"0;0;30m    RGB test 0;0;30     "+clr)
    print(RGB+"0;0;25m    RGB test 0;0;25     "+clr)
    print(RGB+"0;0;20m    RGB test 0;0;20     "+clr)
    print(RGB+"0;0;15m    RGB test 0;0;15     "+clr)
    print(RGB+"0;0;10m    RGB test 0;0;10     "+clr)
    print(RGB+"0;0;5m    RGB test 0;0;5      "+clr)
    print(RGB+"0;0;0m    RGB test 0;0;0      "+clr)
    print()
    print()
    print(black+bg_lblack+"   RGB Background Colors  "+clr)
    print(bg_RGB+"255;10;10m    bg_RGB test 255;0;10   "+clr)
    print(bg_RGB+"10;255;10m    bg_RGB test 0;255;10   "+clr)
    print(bg_RGB+"0;0;255m    bg_RGB test 0;0;255    "+clr)
    print(bg_RGB+"0;0;250m    bg_RGB test 0;0;250    "+clr)
    print(bg_RGB+"0;0;245m    bg_RGB test 0;0;245    "+clr)
    print(bg_RGB+"0;0;240m    bg_RGB test 0;0;240    "+clr)
    print(bg_RGB+"0;0;235m    bg_RGB test 0;0;235    "+clr)
    print(bg_RGB+"0;0;230m    bg_RGB test 0;0;230    "+clr)
    print(bg_RGB+"0;0;225m    bg_RGB test 0;0;225    "+clr)
    print(bg_RGB+"0;0;220m    bg_RGB test 0;0;220    "+clr)
    print(bg_RGB+"0;0;215m    bg_RGB test 0;0;215    "+clr)
    print(bg_RGB+"0;0;210m    bg_RGB test 0;0;210    "+clr)
    print(bg_RGB+"0;0;205m    bg_RGB test 0;0;205    "+clr)
    print(bg_RGB+"0;0;200m    bg_RGB test 0;0;200    "+clr)
    print(bg_RGB+"0;0;195m    bg_RGB test 0;0;195    "+clr)
    print(bg_RGB+"0;0;190m    bg_RGB test 0;0;190    "+clr)
    print(bg_RGB+"0;0;185m    bg_RGB test 0;0;185    "+clr)
    print(bg_RGB+"0;0;180m    bg_RGB test 0;0;180    "+clr)
    print(bg_RGB+"0;0;175m    bg_RGB test 0;0;175    "+clr)
    print(bg_RGB+"0;0;170m    bg_RGB test 0;0;170    "+clr)
    print(bg_RGB+"0;0;165m    bg_RGB test 0;0;165    "+clr)
    print(bg_RGB+"0;0;160m    bg_RGB test 0;0;160    "+clr)
    print(bg_RGB+"0;0;155m    bg_RGB test 0;0;155    "+clr)
    print(bg_RGB+"0;0;150m    bg_RGB test 0;0;150    "+clr)
    print(bg_RGB+"0;0;145m    bg_RGB test 0;0;145    "+clr)
    print(bg_RGB+"0;0;140m    bg_RGB test 0;0;140    "+clr)
    print(bg_RGB+"0;0;135m    bg_RGB test 0;0;135    "+clr)
    print(bg_RGB+"0;0;130m    bg_RGB test 0;0;130    "+clr)
    print(bg_RGB+"0;0;125m    bg_RGB test 0;0;125    "+clr)
    print(bg_RGB+"0;0;120m    bg_RGB test 0;0;120    "+clr)
    print(bg_RGB+"0;0;115m    bg_RGB test 0;0;115    "+clr)
    print(bg_RGB+"0;0;110m    bg_RGB test 0;0;110    "+clr)
    print(bg_RGB+"0;0;105m    bg_RGB test 0;0;105    "+clr)
    print(bg_RGB+"0;0;100m    bg_RGB test 0;0;100    "+clr)
    print(bg_RGB+"0;0;95m    bg_RGB test 0;0;95     "+clr)
    print(bg_RGB+"0;0;90m    bg_RGB test 0;0;90     "+clr)
    print(bg_RGB+"0;0;85m    bg_RGB test 0;0;85     "+clr)
    print(bg_RGB+"0;0;80m    bg_RGB test 0;0;80     "+clr)
    print(bg_RGB+"0;0;75m    bg_RGB test 0;0;75     "+clr)
    print(bg_RGB+"0;0;70m    bg_RGB test 0;0;70     "+clr)
    print(bg_RGB+"0;0;65m    bg_RGB test 0;0;65     "+clr)
    print(bg_RGB+"0;0;60m    bg_RGB test 0;0;60     "+clr)
    print(bg_RGB+"0;0;55m    bg_RGB test 0;0;55     "+clr)
    print(bg_RGB+"0;0;50m    bg_RGB test 0;0;50     "+clr)
    print(bg_RGB+"0;0;45m    bg_RGB test 0;0;45     "+clr)
    print(bg_RGB+"0;0;40m    bg_RGB test 0;0;40     "+clr)
    print(bg_RGB+"0;0;35m    bg_RGB test 0;0;35     "+clr)
    print(bg_RGB+"0;0;30m    bg_RGB test 0;0;30     "+clr)
    print(bg_RGB+"0;0;25m    bg_RGB test 0;0;25     "+clr)
    print(bg_RGB+"0;0;20m    bg_RGB test 0;0;20     "+clr)
    print(bg_RGB+"0;0;15m    bg_RGB test 0;0;15     "+clr)
    print(bg_RGB+"0;0;10m    bg_RGB test 0;0;10     "+clr)
    print(bg_RGB+"0;0;5m    bg_RGB test 0;0;5      "+clr)
    print(bg_RGB+"0;0;0m    bg_RGB test 0;0;0      "+clr)
    print()
    print()
    print(black+bg_lblack+"        Combinations        "+clr)
    print("negative                            "+negative+"   inverse foreground <-> background  "+clr)
    print("bg_yellow red                     "+bg_yellow+red+"  yellow backgroud / red foreground  "+clr)
    print("bg_yellow red negative           "+bg_yellow+red+negative+"        yellow / red inversed         "+clr)
    print("bg_red.. bg_green.. bg_blue     "+bg_red+"    nested   "+bg_green+"    colors    "+bg_blue+"    text   "+clr)
    print()
    print()
    print(black+bg_lblack+"        ASCII Color Art      "+clr)
    print()
    print(bg_blue+" * * * * * * * * * "+bg_red+"                                 "+clr)
    print(bg_blue+"  * * * * * * * *  "+bg_white+"                                 "+clr)
    print(bg_blue+" * * * * * * * * * "+bg_red+"                                 "+clr) 
    print(bg_blue+"  * * * * * * * *  "+bg_white+"                                 "+clr)
    print(bg_blue+" * * * * * * * * * "+bg_red+"                                 "+clr)
    print(bg_blue+"  * * * * * * * *  "+bg_white+"                                 "+clr)
    print(bg_blue+" * * * * * * * * * "+bg_red+"                                 "+clr)
    print(bg_white+"                                                    "+clr)
    print(bg_red+"                                                    "+clr)
    print(bg_white+"                                                    "+clr)
    print(bg_red+"                                                    "+clr)
    print(bg_white+"                                                    "+clr)
    print(bg_red+"                                                    "+clr)

