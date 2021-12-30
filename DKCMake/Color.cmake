# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

string(ASCII 27 ESC)
set(ColourReset "${ESC}[0m")
set(ColourBold  "${ESC}[1m")

# Regular Colors
set(black       "${ESC}[30;47m")
set(red         "${ESC}[31m")
set(green       "${ESC}[32m")
set(yellow      "${ESC}[33m")
set(blue        "${ESC}[34m")
set(magenta     "${ESC}[35m")
set(cyan        "${ESC}[36m")
set(white       "${ESC}[37m")

# Bold
set(Black       "${ESC}[1;30;47m")  # 90m
set(Red         "${ESC}[1;31m")     # 91m
set(Green       "${ESC}[1;32m")     # 92m
set(Yellow      "${ESC}[1;33m")     # 93m
set(Blue        "${ESC}[1;34m")     # 94m
set(Magenta     "${ESC}[1;35m")     # 95m
set(Cyan        "${ESC}[1;36m")     # 96m
set(White       "${ESC}[1;37m")     # 97m

# Underline
set(Ublack       "${ESC}[4;30;47m")
set(Ured         "${ESC}[4;31m")
set(Ugreen       "${ESC}[4;32m")
set(Uyellow      "${ESC}[4;33m")
set(Ublue        "${ESC}[4;34m")
set(Umagenta     "${ESC}[4;35m")
set(Ucyan        "${ESC}[4;36m")
set(Uwhite       "${ESC}[4;37m")

# Background
set(BGblack     "${ESC}[40m")
set(BGred       "${ESC}[41m")
set(BGgreen     "${ESC}[30;42m")
set(BGyellow    "${ESC}[30;43m")
set(BGblue      "${ESC}[44m")
set(BGmagenta   "${ESC}[45m")
set(BGcyan      "${ESC}[30;46m")
set(BGwhite     "${ESC}[30;47m")

# High Intensity
set(Hblack     "${ESC}[0;90m")
set(Hred       "${ESC}[0;91m")
set(Hgreen     "${ESC}[0;92m")
set(Hyellow    "${ESC}[0;93m")
set(Hblue      "${ESC}[0;94m")
set(Hmagenta   "${ESC}[0;95m")
set(Hcyan      "${ESC}[0;96m")
set(Hwhite     "${ESC}[0;97m")

# Bold High Intensity
set(HBlack     "${ESC}[1;90m")
set(HRed       "${ESC}[1;91m")
set(HGreen     "${ESC}[1;92m")
set(HYellow    "${ESC}[1;93m")
set(HBlue      "${ESC}[1;94m")
set(HMagenta   "${ESC}[1;95m")
set(HCyan      "${ESC}[1;96m")
set(HWhite     "${ESC}[1;97m")

 # High Intensity background
set(HBGblack     "${ESC}[0;100m")
set(HBGred       "${ESC}[0;101m")
set(HBGgreen     "${ESC}[0;102m")
set(HBGyellow    "${ESC}[0;103m")
set(HBGblue      "${ESC}[0;104m")
set(HBGmagenta   "${ESC}[0;105m")
set(HBGcyan      "${ESC}[0;106m")
set(HBGwhite     "${ESC}[0;107m")


message("Text Color normal")

message("            Regualar")
message("${black}Text Color black${ColourReset}")
message("${red}Text Color red${ColourReset}")
message("${green}Text Color green${ColourReset}")
message("${yellow}Text Color yellow${ColourReset}")
message("${blue}Text Color blue${ColourReset}")
message("${magenta}Text Color magenta${ColourReset}")
message("${cyan}Text Color cyan${ColourReset}")
message("${white}Text Color white${ColourReset}\n")

message("             Bold")
message("${Black}Text Color Black${ColourReset}")
message("${Red}Text Color Red${ColourReset}")
message("${Green}Text Color Green${ColourReset}")
message("${Yellow}Text Color Yellow${ColourReset}")
message("${Blue}Text Color Blue${ColourReset}")
message("${Magenta}Text Color Magenta${ColourReset}")
message("${Cyan}Text Color Cyan${ColourReset}")
message("${White}Text Color White${ColourReset}\n")

message("           Underline")
message("${Ublack}Text Color Ublack${ColourReset}")
message("${Ured}Text Color Ured${ColourReset}")
message("${Ugreen}Text Color Ugreen${ColourReset}")
message("${Uyellow}Text Color Uyellow${ColourReset}")
message("${Ublue}Text Color Ublue${ColourReset}")
message("${Umagenta}Text Color Umagenta${ColourReset}")
message("${Ucyan}Text Color Ucyan${ColourReset}")
message("${Uwhite}Text Color Uwhite${ColourReset}\n")

message("           Background")
message("${BGblack}Background Color BGblack${ColourReset}")
message("${BGred}Background Color BGred${ColourReset}")
message("${BGgreen}Background Color BGgreen${ColourReset}")
message("${BGyellow}Background Color BGyellow${ColourReset}")
message("${BGblue}Background Color BGblue${ColourReset}")
message("${BGmagenta}Background Color BGmagenta${ColourReset}")
message("${BGcyan}Background Color BGcyan${ColourReset}")
message("${BGwhite}Background Color BGwhite${ColourReset}\n")

message("          High Intensity")
message("${Hblack}Text Color Hblack${ColourReset}")
message("${Hred}Text Color Hred${ColourReset}")
message("${Hgreen}Text Color Hgreen${ColourReset}")
message("${Hyellow}Text Color Hyellow${ColourReset}")
message("${Hblue}Text Color Hblue${ColourReset}")
message("${Hmagenta}Text Color Hmagenta${ColourReset}")
message("${Hcyan}Text Color Hcyan${ColourReset}")
message("${Hwhite}Text Color Hwhite${ColourReset}\n")

message("          Bold High Intensity")
message("${HBlack}Background Color HBlack${ColourReset}")
message("${HRed}Background Color HRed${ColourReset}")
message("${HGreen}Background Color HGreen${ColourReset}")
message("${HYellow}Background Color HYellow${ColourReset}")
message("${HBlue}Background Color HBlue${ColourReset}")
message("${HMagenta}Background Color HMagenta${ColourReset}")
message("${HCyan}Background Color HCyan${ColourReset}")
message("${HWhite}Background Color HWhite${ColourReset}\n")

message("        High Intensity Background")
message("${HBGblack}Text Color HBGblack${ColourReset}")
message("${HBGred}Text Color HBGred${ColourReset}")
message("${HBGgreen}Text Color HBGgreen${ColourReset}")
message("${HBGyellow}Text Color HBGyellow${ColourReset}")
message("${HBGblue}Text Color HBGblue${ColourReset}")
message("${HBGmagenta}Text Color HBGmagenta${ColourReset}")
message("${HBGcyan}Text Color HBGcyan${ColourReset}")
message("${HBGwhite}Text Color HBGwhite${ColourReset}\n")