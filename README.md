# duct-tape

Collection of bootstrapping scripts and repos intended for desktop configuration via Ansible-pull.
Will eventually replace [older repository](https://github.com/WhaleJ84/duct_tape).

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
curl -s https://raw.githubusercontent.com/WhaleJ84/duct-tape/dev/duct-tape.sh | sudo bash

# shorter URL for above
curl -sL dt-dev.james-whale.com | sudo bash

# locally
./PATH/TO/duct-tape.sh

# simulate curl locally
curl -s file:///PATH/TO/duct-tape.sh | bash

# to pass arguments to the script (e.g. `-h`)
curl -s file:///PATH/TO/duct-tape.sh | bash -s - -h
```

To run specific Ansible roles after successful installation, you can filter using tags (e.g. `--tags firefox --skip-tags install` to only configure Firefox and not run any other roles). 

When testing ansible locally, the bootstrap will only pull from the remote repository.
To test the latest local changes, run `ansible-playbook -K local.yml`.

Download the latest Ansible requirements with `ansible-galaxy install -r [collections|roles]/requirements.yml $TARGET --force`.

## Development Notes

Any development related notes will be kept here.

### Git Hooks

- pre-commit
	- Lint and syntax check code (requires pip modules: yamllint ansible-lint).

```shell
#!/bin/sh

yamllint . || exit 1
ansible-playbook local.yml --syntax-check || exit 1
ansible-lint . || exit 1
``` 

### Ansible Facts

Gather facts on the relevant local systems using `ansible localhost -m ansible.builtin.setup`.

### Using local roles

To prevent requiring pushing changes to the remote role repo after every change and redownloading the role, a simpler method exists.
Create a local environment variable called `ANSIBLE_ROLES_PATH` and point it to the directory where the roles exist.
Ensure the directory names within match the role names in the playbooks, and they will take priority over the downloaded counterparts.

