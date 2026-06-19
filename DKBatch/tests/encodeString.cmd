@echo off
setlocal

rem #   ALL:  "  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
rem # VALID:  "      # $   & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~"
  set "string=#" &::$&'()*+,-./:;<=>?@[\]^_`{|}~"


rem Define simple macros to support JavaScript within batch
set "beginJS=mshta "javascript:code(close(new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write("
set "endJS=)));""



rem FOR /F does not need pipe
for /f %%N in (
  '%beginJS% encodeURIComponent("%string%") %endJS%'
) do set encoded=%%N

echo %string% -^> %encoded%
pause