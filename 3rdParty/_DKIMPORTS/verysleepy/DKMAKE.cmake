# https://github.com/VerySleepy/verysleepy.git
# http://www.codersnotes.com/sleepy/
# https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe
# https://github.com/VerySleepy/verysleepy/archive/refs/tags/v0.91.zip (source)


WIN_dk_set(VERYSLEEPY_VERSION 0.91)
WIN_dk_set(VERYSLEEPY_NAME verysleepy-${VERYSLEEPY_VERSION})
WIN_dk_set(VERYSLEEPY_DL https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe)
WIN_X86_dk_set(VERYSLEEPY "${ProgramFiles}/Very Sleepy/32")
WIN_X86_64_dk_set(VERYSLEEPY "${ProgramFiles}/Very Sleepy")
WIN_dk_set(VERYSLEEPY_EXE "${VERYSLEEPY}/sleepy.exe")
#dk_import(https://github.com/VerySleepy/verysleepy/releases/download/v0.91/verysleepy-0.91.exe)
#dk_import(https://github.com/VerySleepy/verysleepy.git)
