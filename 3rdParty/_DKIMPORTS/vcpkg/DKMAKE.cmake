# Getting Started  https://vcpkg.io/en/getting-started.html
# Documentation    https://vcpkg.io/en/docs/README.html
#

DKDEPEND(git)


dk_import(https://github.com/Microsoft/vcpkg.git)


DKSETPATH(${VCPKG})
WIN_DKQCOMMAND(bootstrap-vcpkg.bat)
