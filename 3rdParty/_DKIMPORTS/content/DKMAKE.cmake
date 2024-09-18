include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
#### MDN Web Docs ####
# https://github.com/mdn/content.git
# https://www.peterbe.com/plog/how-to-get-all-of-mdn-web-docs-running-locally


### IMPORT ###
#dk_import(https://github.com/mdn/content.git BRANCH main)
#dk_import(https://github.com/mdn/content/archive/4a616cb539e1ccece651e171c00e8f8db64fb570.zip)
dk_import(https://github.com/mdn/content/archive/refs/heads/main.zip)



# TODO
#cd content
#yarn install
#yarn start
