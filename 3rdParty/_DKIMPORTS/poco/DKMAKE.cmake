# https://github.com/pocoproject/poco.git


### IMPORT ###
dk_import(https://github.com/pocoproject/poco.git)


### LINK ###
dk_include				(${POCO}/include)
dk_include				(${POCO}/${OS})

# PocoActiveRecord
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoActiveRecordmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoActiveRecordmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoActiveRecordd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoActiveRecord.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoActiveRecordd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoActiveRecord.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoActiveRecordd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoActiveRecord.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoActiveRecordd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoActiveRecord.a)

# PocoData
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoDatamtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoDatamt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoDatad.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoData.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoDatad.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoData.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoDatad.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoData.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoDatad.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoData.a)

# PocoDataODBC
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoDataODBCmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoDataODBCmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoDataODBCd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoDataODBC.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoDataODBCd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoDataODBC.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoDataODBCd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoDataODBC.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoDataODBCd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoDataODBC.a)

# PocoDataSQLite
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoDataSQLitemtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoDataSQLitemt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoDataSQLited.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoDataSQLite.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoDataSQLited.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoDataSQLite.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoDataSQLited.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoDataSQLite.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoDataSQLited.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoDataSQLite.a)

# PocoEncodings
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoEncodingsmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoEncodingsmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoEncodingsd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoEncodings.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoEncodingsd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoEncodings.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoEncodingsd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoEncodings.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoEncodingsd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoEncodings.a)

# PocoFoundation
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoFoundationmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoFoundationmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoFoundationd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoFoundation.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoFoundationd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoFoundation.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoFoundationd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoFoundation.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoFoundationd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoFoundation.a)

# PocoJSON
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoJSONmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoJSONmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoJSONd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoJSON.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoJSONd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoJSON.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoJSONd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoJSON.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoJSONd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoJSON.a)

# PocoMongoDB
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoMongoDBmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoMongoDBmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoMongoDBd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoMongoDB.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoMongoDBd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoMongoDB.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoMongoDBd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoMongoDB.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoMongoDBd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoMongoDB.a)

# PocoNet
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoNetmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoNetmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoNetd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoNet.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoNetd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoNet.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoNetd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoNet.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoNetd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoNet.a)

# PocoPrometheus
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoPrometheusmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoPrometheusmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoPrometheusd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoPrometheus.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoPrometheusd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoPrometheus.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoPrometheusd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoPrometheus.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoPrometheusd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoPrometheus.a)

# PocoRedis
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoRedismtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoRedismt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoRedisd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoRedis.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoRedisd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoRedis.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoRedisd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoRedis.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoRedisd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoRedis.a)

# PocoUtil
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoUtilmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoUtilmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoUtild.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoUtil.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoUtild.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoUtil.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoUtild.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoUtil.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoUtild.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoUtil.a)

# PocoXML
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoXMLmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoXMLmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoXMLd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoXML.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoXMLd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoXML.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoXMLd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoXML.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoXMLd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoXML.a)

# PocoZip
WIN_dk_libDebug			(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoZipmtd.lib)
WIN_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoZipmt.lib)
APPLE_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/libPocoZipd.a)
APPLE_dk_libRelease		(${POCO}/${OS}/lib/${RELEASE_DIR}/libPocoZip.a)
LINUX_dk_libDebug		(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoZipd.a)
LINUX_dk_libRelease		(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoZip.a)
RASPBERRY_dk_libDebug	(${POCO}/${OS}/${DEBUG_DIR}/lib/libPocoZipd.a)
RASPBERRY_dk_libRelease	(${POCO}/${OS}/${RELEASE_DIR}/lib/libPocoZip.a)
ANDROID_dk_libDebug		(${POCO}/${OS}/lib/${DEBUG_DIR}/PocoZipd.a)
ANDROID_dk_libRelease	(${POCO}/${OS}/lib/${RELEASE_DIR}/PocoZip.a)


### GENERATE ###
dk_setPath(${POCO}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} -DPOCO_MT=ON ${POCO})


### COMPILE ###
dk_build(${POCO_FOLDER})
