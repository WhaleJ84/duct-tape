#!/bin/bash
# This script is heavily influenced by Pi-Hole's bootstrapping script:
# https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh
set -e

export PY_COLORS='1'
export ANSIBLE_FORCE_COLOR='1'

DETECTED_OS=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
DETECTED_VERSION=$(grep VERSION_ID /etc/os-release | cut -d '=' -f2 | tr -d '"')
APT_DEPENDENCIES="curl git python3"
PIP_DEPENDENCIES="ansible"

COL_NC='\e[0m'
COL_LIGHT_GREEN='\e[1;32m'
COL_LIGHT_RED='\e[1;31m'
SUCCESS="${COL_LIGHT_GREEN}*${COL_NC}"
FAILURE="${COL_LIGHT_RED}x${COL_NC}"
OVERWRITE='\r\033[K'

spinner_text(){
    spinner='| / - \ | / - \'

    while true; do
        for pos in $spinner; do
            printf "[ %s ] %s" "$pos" "$1"
            printf "%b[ %s ] %s" "$OVERWRITE" "$pos" "$1"
            sleep 0.1
        done
    done
}

is_command(){
    command -v "$1" > /dev/null 2>&1
}

check_apt_dependencies(){
    installArray=""
    for i in "$@"; do
        spinner_text "${PACKAGE_MANAGER}: Checking for ${i}..." &
        SPIN_PID="$!"
        trap "kill -9 $SPIN_PID" `seq 0 15`
        set +e
        if dpkg-query -W -f='${Status}' "${i}" 2>/dev/null | grep "ok installed" &>/dev/null; then
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT: Checked for %s\\n" "${OVERWRITE}" "${SUCCESS}" "${i}"
        else
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT: Checked for %s (will be installed)\\n" "${OVERWRITE}" "${FAILURE}" "${i}"
            installArray="$installArray$i "
        fi
        set -e
    done
}

install_apt_dependencies(){
    if [[ "${#installArray[@]}" -gt 0 ]]; then
        for package in $installArray; do
            spinner_text "Processing ${PACKAGE_MANAGER} install(s) for: $package..." &
            SPIN_PID="$!"
            trap "kill -9 $SPIN_PID" `seq 0 15`
            set +e
            if "${PACKAGE_MANAGER}" install -y "$package" &>/dev/null; then
                rc="$?"
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] Processed ${PACKAGE_MANAGER} install(s) for: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$package"
            else
                rc="$?"
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] Processed ${PACKAGE_MANAGER} install(s) for: %s\\n" "${OVERWRITE}" "${FAILURE}" "$package"
            fi
            set -e
        done
    fi
}

install_pip(){
    if [ ! -f "/tmp/get-pip.py" ]; then
        spinner_text "Downloading pip bootstrapping script..." &
        SPIN_PID="$!"
        trap "kill -9 $SPIN_PID" `seq 0 15`
        set +e
        if curl https://bootstrap.pypa.io/get-pip.py -s -o /tmp/get-pip.py; then
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] Downloaded pip bootstrapping script\\n" "${OVERWRITE}" "${SUCCESS}"
        else
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] Downloading pip bootstrapping script\\n" "${OVERWRITE}" "${FAILURE}"
        fi
        set -e
    fi

    spinner_text "Installing pip..." &
    SPIN_PID="$!"
    trap "kill -9 $SPIN_PID" `seq 0 15`
    set +e
    if python3 /tmp/get-pip.py --user &>/dev/null; then
        rc="$?"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] Installed pip\\n" "${OVERWRITE}" "${SUCCESS}"
    else
        rc="$?"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] Installing pip\\n" "${OVERWRITE}" "${FAILURE}"
    fi
    set -e
}

check_pip(){
    spinner_text "PYTHON: Checking for pip..." & 
    SPIN_PID="$!"
    trap "kill -9 $SPIN_PID" `seq 0 15`
    set +e
    if python3 -m pip -V 2&>/dev/null; then 
        rc="$?"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] PYTHON: Checked for pip\\n" "${OVERWRITE}" "${SUCCESS}"
    else
        rc="$?"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] PYTHON: Checked for pip (will be installed)\\n" "${OVERWRITE}" "${FAILURE}"
        install_pip
    fi
    set -e
}

check_pip_dependencies(){
    installArray=""
    for i in "$@"; do
        spinner_text "PIP: Checking for ${i}..." &
        SPIN_PID="$!"
        trap "kill -9 $SPIN_PID" `seq 0 15`
        set +e
        if python3 -m pip list | grep "$i " &>/dev/null; then
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] PIP: Checked for %s\\n" "${OVERWRITE}" "${SUCCESS}" "${i}"
        else
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] PIP: Checked for %s (will be installed)\\n" "${OVERWRITE}" "${FAILURE}" "${i}"
            installArray="$installArray$i "
        fi
        set -e
    done
}

install_pip_dependencies(){
    if [[ "${#installArray[@]}" -gt 0 ]]; then
        for package in $installArray; do
            spinner_text "Processing pip install(s) for: $package..." &
            SPIN_PID="$!"
            trap "kill -9 $SPIN_PID" `seq 0 15`
            set +e
            if python3 -m pip install --user "$package" &>/dev/null; then
                rc="$?"
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] Processed pip install(s) for: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$package"
            else
                rc="$?"
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] Processed pip install(s) for: %s\\n" "${OVERWRITE}" "${FAILURE}" "$package"
            fi
            set -e
        done
    fi
}

install_ansible_dependencies(){
    if [ ! -f "/tmp/requirements.yml" ]; then
        spinner_text "Downloading ansible requirements file..." &
        SPIN_PID="$!"
        trap "kill -9 $SPIN_PID" `seq 0 15`
        set +e
        if curl https://raw.githubusercontent.com/WhaleJ84/duct-tape/main/requirements.yml -s -o /tmp/requirements.yml; then
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] Downloaded ansible requirements file\\n" "${OVERWRITE}" "${SUCCESS}"
        else
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] Downloading ansible requirements file\\n" "${OVERWRITE}" "${FAILURE}"
        fi
        set -e
    fi

    spinner_text "Installing ansible requirements..." &
    SPIN_PID="$!"
    trap "kill -9 $SPIN_PID" `seq 0 15`
    set +e
    if ansible-galaxy install -r /tmp/requirements.yml &>/dev/null; then
        rc="$?"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] Installed ansible requirements\\n" "${OVERWRITE}" "${SUCCESS}"
    else
        rc="$?"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] Installing ansible requirements\\n" "${OVERWRITE}" "${FAILURE}"
    fi
    set -e
}

[ "$(is_command apt)" ] || PACKAGE_MANAGER="apt"
check_apt_dependencies $APT_DEPENDENCIES
install_apt_dependencies
check_pip
check_pip_dependencies $PIP_DEPENDENCIES
install_pip_dependencies
install_ansible_dependencies
ansible-pull -KU https://github.com/WhaleJ84/duct-tape.git
