# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors

string(ASCII 27 ESC)
set(ColourReset "${ESC}[m")
set(ColourBold  "${ESC}[1m")
set(black       "${ESC}[30m")
set(red         "${ESC}[31m")
set(green       "${ESC}[32m")
set(yellow      "${ESC}[33m")
set(blue        "${ESC}[34m")
set(magenta     "${ESC}[35m")
set(cyan        "${ESC}[36m")
set(white       "${ESC}[37m")
set(Black     "${ESC}[1;30m")  # 90m
set(Red       "${ESC}[1;31m")  # 91m
set(Green     "${ESC}[1;32m")  # 92m
set(Yellow    "${ESC}[1;33m")  # 93m
set(Blue      "${ESC}[1;34m")  # 94m
set(Magenta   "${ESC}[1;35m")  # 95m
set(Cyan      "${ESC}[1;36m")  # 96m
set(White     "${ESC}[1;37m")  # 97m
set(BRwhite   "${ESC}[30;47m")
  
message("Text Color normal")
message("${black}Text Color black${ColourReset}")
message("${red}Text Color red${ColourReset}")
message("${green}Text Color green${ColourReset}")
message("${yellow}Text Color yellow${ColourReset}")
message("${blue}Text Color blue${ColourReset}")
message("${magenta}Text Color magenta${ColourReset}")
message("${cyan}Text Color cyan${ColourReset}")
message("${white}Text Color white${ColourReset}")
message("${black}Text Color black${ColourReset}")
message("${red}Text Color red${ColourReset}")
message("${green}Text Color green${ColourReset}")
message("${yellow}Text Color yellow${ColourReset}")
message("${blue}Text Color blue${ColourReset}")
message("${magenta}Text Color magenta${ColourReset}")
message("${cyan}Text Color cyan${ColourReset}")
message("${white}Text Color white${ColourReset}")


