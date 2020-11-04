# copy-config-changes

This is a bash script which copies config files which have diverged from the (debian) package
maintainer's version, useful for making succinct backups or installation scripts.

This script uses "debsums" to detect changes.

	$ sudo apt install debsums

Copy to your ~/bin and make executable.
