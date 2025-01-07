#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()


function(fun_expr ARGS)
  unset(args)
  unset(fxns)
  while(ARGN)
    list(POP_FRONT ARGN tok)
    if (tok STREQUAL "(")
      list(APPEND args ${tok})
    elseif (tok STREQUAL ")")
      unset(call)
      unset(arg)
      list(POP_BACK args arg)
      while (args AND NOT arg STREQUAL "(")
        list(PREPEND call "${arg}")
        list(POP_BACK args arg)
      endwhile ()
      list(POP_BACK fxns fn)
      cmake_language(CALL ${fn} RET ${call})
      list(APPEND args ${RET})
    else ()
      list(APPEND fxns ${tok})
    endif ()
  endwhile()
  return_("${args}")
endfunction()

# Definitions from the blog post

function(format_name ARGS first last)
  return_("First: ${first}, last: ${last}")
endfunction()

function(get_first_name ARGS)
  return_("John")          # return quoted
endfunction()

function(get_last_name ARGS)
  return_(Doe)             # return unquoted
endfunction()


