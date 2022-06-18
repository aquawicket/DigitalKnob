dk_depend(DKDuktape)
dk_depend(DKRml)  #let's make the Dom only require javascript

generateCmake(DKDom)
dk_assets(DKDom)