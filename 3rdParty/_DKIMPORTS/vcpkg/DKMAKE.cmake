# Getting Started  https://vcpkg.io/en/getting-started.html
# Documentation    https://vcpkg.io/en/docs/README.html

dk_depend(git)

dk_import(https://github.com/Microsoft/vcpkg.git)

dk_setPath(${VCPKG})
WIN_dk_queueCommand(bootstrap-vcpkg.bat)
