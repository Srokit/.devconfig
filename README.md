# Configuration for dev work.

Clone this repo to home dir and run setup.sh.

## Setup

Running setup.sh will create the symlinks for the config files that need to be
in the home dir.

## Compatibilty across devices

Each of the configuration files is aware of which device the scripts are run on
and include the necessary private scripts as apporiate such as work specific
code.

## Overview

Most of the general purpose macros are defined in sourcme.sh.

Initial setup and installation in setup.sh.

Uninstallation can be done in remove.sh.

There is a lot of proprietary configuration that is sourced if the host machine
calling the setup script is of the right type (mac, linux, remote, personal, etc).

If the device is...             Then you need to have the scripts...

WorkRemoteLinux                .goog-envsetup-remote.sh   -  secret env vars
                               .goog-remote-setup.sh -  remote machine speficic macros
                               .goog-common-setup.sh -  common between work remote and macbook

WorkMacbook                    .goog-envsetup-macbook.sh  - secret env vars
                               .goog-macbook-setup.sh - work macbook specific macros
                               .goog-common-setup.sh - common

PersonalMacbook                None :)

If the work macbook cannot find goog-common and goog-macbook, it will 
  actually retreieve them from remote through scp. Be careful to keep copies
  safe on the remote though.
