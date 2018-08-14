DESCRIPTION = "A console-only image for STYL Bigeye platform."

LICENSE = "CLOSED"

#package openssh-7.5p1-r0.cortexa7hf_neon conflicts with dropbear provided by dropbear-2017.75-r0.cortexa7hf_neon
#	package packagegroup-core-ssh-dropbear-1.0-r1.noarch requires dropbear, but none of the providers can be installed
#	conflicting requests
IMAGE_FEATURES_remove = " ssh-server-dropbear"
