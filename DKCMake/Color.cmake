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
set(B_black       "${ESC}[1;30;47m")
set(B_red         "${ESC}[1;31m")
set(B_green       "${ESC}[1;32m")
set(B_yellow      "${ESC}[1;33m")
set(B_blue        "${ESC}[1;34m")
set(B_magenta     "${ESC}[1;35m")
set(B_cyan        "${ESC}[1;36m")
set(B_white       "${ESC}[1;37m")

# Underline
set(U_black       "${ESC}[4;30;47m")
set(U_red         "${ESC}[4;31m")
set(U_green       "${ESC}[4;32m")
set(U_yellow      "${ESC}[4;33m")
set(U_blue        "${ESC}[4;34m")
set(U_magenta     "${ESC}[4;35m")
set(U_cyan        "${ESC}[4;36m")
set(U_white       "${ESC}[4;37m")

# High Intensity
set(H_black     "${ESC}[0;90m")
set(H_red       "${ESC}[0;91m")
set(H_green     "${ESC}[0;92m")
set(H_yellow    "${ESC}[0;93m")
set(H_blue      "${ESC}[0;94m")
set(H_magenta   "${ESC}[0;95m")
set(H_cyan      "${ESC}[0;96m")
set(H_white     "${ESC}[0;97m")

# Bold High Intensity
set(HB_black     "${ESC}[1;30;90m")
set(HB_red       "${ESC}[1;91m")
set(HB_green     "${ESC}[1;92m")
set(HB_yellow    "${ESC}[1;93m")
set(HB_blue      "${ESC}[1;94m")
set(HB_magenta   "${ESC}[1;95m")
set(HB_cyan      "${ESC}[1;96m")
set(HB_white     "${ESC}[1;97m")

# Background
set(BG_black     "${ESC}[40m")
set(BG_red       "${ESC}[41m")
set(BG_green     "${ESC}[30;42m")
set(BG_yellow    "${ESC}[30;43m")
set(BG_blue      "${ESC}[44m")
set(BG_magenta   "${ESC}[45m")
set(BG_cyan      "${ESC}[30;46m")
set(BG_white     "${ESC}[30;47m")

 # High Intensity background
set(HBG_black     "${ESC}[0;100m")
set(HBG_red       "${ESC}[0;101m")
set(HBG_green     "${ESC}[0;102m")
set(HBG_yellow    "${ESC}[0;103m")
set(HBG_blue      "${ESC}[0;104m")
set(HBG_magenta   "${ESC}[0;105m")
set(HBG_cyan      "${ESC}[0;106m")
set(HBG_white     "${ESC}[0;107m")


message("Text Color normal")

message("            Regualar") # color
message("${black}Text Color black${ColourReset}")
message("${red}Text Color red${ColourReset}")
message("${green}Text Color green${ColourReset}")
message("${yellow}Text Color yellow${ColourReset}")
message("${blue}Text Color blue${ColourReset}")
message("${magenta}Text Color magenta${ColourReset}")
message("${cyan}Text Color cyan${ColourReset}")
message("${white}Text Color white${ColourReset}\n")

message("             Bold")   # B_color
message("${B_black}Text Color B_black${ColourReset}")
message("${B_red}Text Color B_red${ColourReset}")
message("${B_green}Text Color B_green${ColourReset}")
message("${B_yellow}Text Color B_yellow${ColourReset}")
message("${B_blue}Text Color B_blue${ColourReset}")
message("${B_magenta}Text Color B_magenta${ColourReset}")
message("${B_cyan}Text Color B_cyan${ColourReset}")
message("${B_white}Text Color B_white${ColourReset}\n")

message("           Underline") # U_color
message("${U_black}Text Color U_black${ColourReset}")
message("${U_red}Text Color U_red${ColourReset}")
message("${U_green}Text Color U_green${ColourReset}")
message("${U_yellow}Text Color U_yellow${ColourReset}")
message("${U_blue}Text Color U_blue${ColourReset}")
message("${U_magenta}Text Color U_magenta${ColourReset}")
message("${U_cyan}Text Color U_cyan${ColourReset}")
message("${U_white}Text Color U_white${ColourReset}\n")

message("          High Intensity") # H_color
message("${H_black}Text Color H_black${ColourReset}")
message("${H_red}Text Color H_red${ColourReset}")
message("${H_green}Text Color H_green${ColourReset}")
message("${H_yellow}Text Color H_yellow${ColourReset}")
message("${H_blue}Text Color H_blue${ColourReset}")
message("${H_magenta}Text Color H_magenta${ColourReset}")
message("${H_cyan}Text Color H_cyan${ColourReset}")
message("${H_white}Text Color H_white${ColourReset}\n")

message("          High Intensity Bold") # HB_color
message("${HB_black}Background Color HB_black${ColourReset}")
message("${HB_red}Background Color HB_red${ColourReset}")
message("${HB_green}Background Color HB_green${ColourReset}")
message("${HB_yellow}Background Color HB_yellow${ColourReset}")
message("${HB_blue}Background Color HB_blue${ColourReset}")
message("${HB_magenta}Background Color HB_magenta${ColourReset}")
message("${HB_cyan}Background Color HB_cyan${ColourReset}")
message("${HB_white}Background Color HB_white${ColourReset}\n")

message("           Background") # BG_color
message("${BG_black}Background Color BG_black${ColourReset}")
message("${BG_red}Background Color BG_red${ColourReset}")
message("${BG_green}Background Color BG_green${ColourReset}")
message("${BG_yellow}Background Color BG_yellow${ColourReset}")
message("${BG_blue}Background Color BG_blue${ColourReset}")
message("${BG_magenta}Background Color BG_magenta${ColourReset}")
message("${BG_cyan}Background Color BG_cyan${ColourReset}")
message("${BG_white}Background Color BG_white${ColourReset}\n")

message("        High Intensity Background") # HBG_color
message("${HBG_black}Text Color HBG_black${ColourReset}")
message("${HBG_red}Text Color HBG_red${ColourReset}")
message("${HBG_green}Text Color HBG_green${ColourReset}")
message("${HBG_yellow}Text Color HBG_yellow${ColourReset}")
message("${HBG_blue}Text Color HBG_blue${ColourReset}")
message("${HBG_magenta}Text Color HBG_magenta${ColourReset}")
message("${HBG_cyan}Text Color HBG_cyan${ColourReset}")
message("${HBG_white}Text Color HBG_white${ColourReset}\n")