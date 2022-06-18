# Getting Started  https://vcpkg.io/en/getting-started.html
# Documentation    https://vcpkg.io/en/docs/README.html
#

dk_depend(git)


dk_import(https://github.com/Microsoft/vcpkg.git)


dk_setPath(${VCPKG})
WIN_DKQCOMMAND(bootstrap-vcpkg.bat)
