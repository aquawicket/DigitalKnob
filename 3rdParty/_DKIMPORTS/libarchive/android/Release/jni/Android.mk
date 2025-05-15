ZLIB := zlib-1.2.8
#LOCAL_PATH := $(call my-dir)
LOCAL_PATH := $(subst ../../../,,$(call my-dir))
$(info LOCAL_PATH = $(LOCAL_PATH))



include $(CLEAR_VARS)
LOCAL_MODULE    := zlib
LIBDIR := obj/local/armeabi
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
LIBDIR := obj/local/armeabi-v7a
endif
LOCAL_SRC_FILES := ../../../../$(ZLIB)/Android_Arm32/Release/$(LIBDIR)/libzlib.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libarchive
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_ARM_NEON := true
endif

LOCAL_SRC_FILES := \
	../../../libarchive/archive_acl.c \
	../../../libarchive/archive_check_magic.c \
	../../../libarchive/archive_cmdline.c \
	../../../libarchive/archive_cryptor.c \
	../../../libarchive/archive_digest.c \
	../../../libarchive/archive_entry.c \
	../../../libarchive/archive_entry_copy_stat.c \
	../../../libarchive/archive_entry_link_resolver.c \
	../../../libarchive/archive_entry_sparse.c \
	../../../libarchive/archive_entry_stat.c \
	../../../libarchive/archive_entry_strmode.c \
	../../../libarchive/archive_entry_xattr.c \
	../../../libarchive/archive_getdate.c \
	../../../libarchive/archive_hmac.c \
	../../../libarchive/archive_match.c \
	../../../libarchive/archive_options.c \
	../../../libarchive/archive_pack_dev.c \
	../../../libarchive/archive_pathmatch.c \
	../../../libarchive/archive_ppmd7.c \
	../../../libarchive/archive_random.c \
	../../../libarchive/archive_rb.c \
	../../../libarchive/archive_read.c \
	../../../libarchive/archive_read_add_passphrase.c \
	../../../libarchive/archive_read_append_filter.c \
	../../../libarchive/archive_read_data_into_fd.c \
	../../../libarchive/archive_read_disk_entry_from_file.c \
	../../../libarchive/archive_read_disk_posix.c \
	../../../libarchive/archive_read_disk_set_standard_lookup.c \
	../../../libarchive/archive_read_extract.c \
	../../../libarchive/archive_read_extract2.c \
	../../../libarchive/archive_read_open_fd.c \
	../../../libarchive/archive_read_open_file.c \
	../../../libarchive/archive_read_open_filename.c \
	../../../libarchive/archive_read_open_memory.c \
	../../../libarchive/archive_read_set_format.c \
	../../../libarchive/archive_read_set_options.c \
	../../../libarchive/archive_read_support_filter_all.c \
	../../../libarchive/archive_read_support_filter_bzip2.c \
	../../../libarchive/archive_read_support_filter_compress.c \
	../../../libarchive/archive_read_support_filter_grzip.c \
	../../../libarchive/archive_read_support_filter_gzip.c \
	../../../libarchive/archive_read_support_filter_lrzip.c \
	../../../libarchive/archive_read_support_filter_lz4.c \
	../../../libarchive/archive_read_support_filter_lzop.c \
	../../../libarchive/archive_read_support_filter_none.c \
	../../../libarchive/archive_read_support_filter_program.c \
	../../../libarchive/archive_read_support_filter_rpm.c \
	../../../libarchive/archive_read_support_filter_uu.c \
	../../../libarchive/archive_read_support_filter_xz.c \
	../../../libarchive/archive_read_support_filter_zstd.c \
	../../../libarchive/archive_read_support_format_7zip.c \
	../../../libarchive/archive_read_support_format_all.c \
	../../../libarchive/archive_read_support_format_ar.c \
	../../../libarchive/archive_read_support_format_by_code.c \
	../../../libarchive/archive_read_support_format_cab.c \
	../../../libarchive/archive_read_support_format_cpio.c \
	../../../libarchive/archive_read_support_format_empty.c \
	../../../libarchive/archive_read_support_format_iso9660.c \
	../../../libarchive/archive_read_support_format_lha.c \
	../../../libarchive/archive_read_support_format_mtree.c \
	../../../libarchive/archive_read_support_format_rar.c \
	../../../libarchive/archive_read_support_format_raw.c \
	../../../libarchive/archive_read_support_format_tar.c \
	../../../libarchive/archive_read_support_format_warc.c \
	../../../libarchive/archive_read_support_format_xar.c \
	../../../libarchive/archive_read_support_format_zip.c \
	../../../libarchive/archive_string.c \
	../../../libarchive/archive_string_sprintf.c \
	../../../libarchive/archive_util.c \
	../../../libarchive/archive_version_details.c \
	../../../libarchive/archive_virtual.c \
	../../../libarchive/archive_write.c \
	../../../libarchive/archive_write_disk_posix.c \
	../../../libarchive/archive_write_disk_set_standard_lookup.c \
	../../../libarchive/archive_write_open_fd.c \
	../../../libarchive/archive_write_open_file.c \
	../../../libarchive/archive_write_open_filename.c \
	../../../libarchive/archive_write_open_memory.c \
	../../../libarchive/archive_write_add_filter.c \
	../../../libarchive/archive_write_add_filter_b64encode.c \
	../../../libarchive/archive_write_add_filter_by_name.c \
	../../../libarchive/archive_write_add_filter_bzip2.c \
	../../../libarchive/archive_write_add_filter_compress.c \
	../../../libarchive/archive_write_add_filter_grzip.c \
	../../../libarchive/archive_write_add_filter_gzip.c \
	../../../libarchive/archive_write_add_filter_lrzip.c \
	../../../libarchive/archive_write_add_filter_lz4.c \
	../../../libarchive/archive_write_add_filter_lzop.c \
	../../../libarchive/archive_write_add_filter_none.c \
	../../../libarchive/archive_write_add_filter_program.c \
	../../../libarchive/archive_write_add_filter_uuencode.c \
	../../../libarchive/archive_write_add_filter_xz.c \
	../../../libarchive/archive_write_add_filter_zstd.c \
	../../../libarchive/archive_write_set_format.c \
	../../../libarchive/archive_write_set_format_7zip.c \
	../../../libarchive/archive_write_set_format_ar.c \
	../../../libarchive/archive_write_set_format_by_name.c \
	../../../libarchive/archive_write_set_format_cpio.c \
	../../../libarchive/archive_write_set_format_cpio_newc.c \
	../../../libarchive/archive_write_set_format_iso9660.c \
	../../../libarchive/archive_write_set_format_mtree.c \
	../../../libarchive/archive_write_set_format_pax.c \
	../../../libarchive/archive_write_set_format_raw.c \
	../../../libarchive/archive_write_set_format_shar.c \
	../../../libarchive/archive_write_set_format_ustar.c \
	../../../libarchive/archive_write_set_format_v7tar.c \
	../../../libarchive/archive_write_set_format_gnutar.c \
	../../../libarchive/archive_write_set_format_warc.c \
	../../../libarchive/archive_write_set_format_xar.c \
	../../../libarchive/archive_write_set_format_zip.c \
	../../../libarchive/archive_write_set_options.c \
	../../../libarchive/archive_write_set_passphrase.c \
	../../../libarchive/filter_fork_posix.c \
	../../../libarchive/xxhash.c

#ifeq ($(HOST_OS),windows)
#libarchive_host_src_files := \
#	../../../libarchive/archive_entry_copy_bhfi.c \
#	../../../libarchive/archive_read_disk_windows.c \
#	../../../libarchive/archive_write_disk_windows.c \
#	../../../libarchive/filter_fork_windows.c \
#	../../../libarchive/archive_windows.c
							
#FILE_LIST := $(wildcard $(LOCAL_PATH)/../../../libarchive/*.c)
#LOCAL_SRC_FILES += $(FILE_LIST:$(LOCAL_PATH)/%=%)

#LOCAL_SRC_FILES += ../../../Android_Arm32/Release/jni/mbtowc.c

libarchive_config := $(LOCAL_PATH)/../../../contrib/android/config/android.h

LOCAL_CFLAGS := -DPLATFORM_CONFIG_H=\"$(libarchive_config)\"
#LOCAL_C_INCLUDES := ../../../libarchive ../../../libarchive_fe ../../../contrib/android/include
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../libarchive $(LOCAL_PATH)/../../../libarchive_fe $(LOCAL_PATH)/../../../contrib/android/include

LOCAL_STATIC_LIBRARIES := zlib

include $(BUILD_STATIC_LIBRARY)