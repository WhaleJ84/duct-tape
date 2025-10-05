# duct-tape

Collection of bootstrapping scripts and repos intended for desktop configuration via Ansible-pull.

**WARNING:** Unless you are me, do not run any of the code you see here.
This repository is only public for my own convenience reasons.
Code within can be unstable at any moment and is not tested on any systems other than my own.
You have been warned.

## Requirements

Most of the requirements are automatically installed via the bootstrapping script.
However, to run the script as intended, `curl` is required.

## Usage

To initiate the installation process, run the bootstrapping script with one of the following commands:

```shell
# remotely
curl -s https://raw.githubusercontent.com/WhaleJ84/duct-tape/main/duct-tape.sh | sudo bash

# shorter URL for above
curl -sL dt.james-whale.com | sudo bash

# locally
sudo ./PATH/TO/duct-tape.sh

# simulate curl locally
curl -s file:///PATH/TO/duct-tape.sh | sudo bash

# to pass arguments to the script (e.g. `-h`)
curl -s file:///PATH/TO/duct-tape.sh | sudo bash -s - -h
```

## Developer Notes

Any extra bits of information that makes development of the tools including this, `ansible-pull`, it's respective roles, etc. should be noted here.

- Create a file with the local system's sudo password and specify it with the `ansible-pull` command with `--become-pass-file /path/to/file`

