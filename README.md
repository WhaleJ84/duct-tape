# duct-tape

Collection of bootstrapping scripts and repos intended for desktop configuration via Ansible-pull

**WARNING:** Unless you are me, do not run any of the code you see here.
This repository is only public for my own convenience reasons and no branches are used.
Code within can be unstable at any moment and is not tested on any systems other than my own.
You have been warned.

## Requirements

Most of the requirements are automatically installed via the bootstrapping script.
However, to run the script as intended, `curl` is required.

## Usage

To initiate the installation process, run the bootstrapping script with one of the following commands:

```shell
# remotely
curl -s https://raw.githubusercontent.com/WhaleJ84/duct-tape/main/bootstrap.sh | sudo bash

# locally
sudo ./PATH/TO/bootstrap.sh

# simulate curl locally
curl -s file:///PATH/TO/bootstrap.sh | sudo bash
```

When testing ansible locally, the bootstrap will only pull from the remote repository.
To test the latest local changes, run `ansible-playbook -K local.yml`.

