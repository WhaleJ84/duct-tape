#!/bin/bash
# This script is heavily influenced by Pi-Hole's bootstrapping script:
# https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh
set -e

TEST_PACKAGES="cowsay lolcat"

DETECTED_OS=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
DETECTED_VERSION=$(grep VERSION_ID /etc/os-release | cut -d '=' -f2 | tr -d '"')
APT_DEPENDENCIES="$TEST_PACKAGES git python3"

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
        spinner_text "Checking for ${i}..." &
        SPIN_PID="$!"
        trap "kill -9 $SPIN_PID" `seq 0 15`
        set +e
        if dpkg-query -W -f='${Status}' "${i}" 2>/dev/null | grep "ok installed" &>/dev/null; then
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] Checked for %s\\n" "${OVERWRITE}" "${SUCCESS}" "${i}"
        else
            rc="$?"
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] Checked for %s (will be installed)\\n" "${OVERWRITE}" "${FAILURE}" "${i}"
            installArray="$installArray$i "
        fi
        set -e
    done
}

install_apt_dependencies(){
    if [[ "${#installArray[@]}" -gt 0 ]]; then
        for package in $installArray; do
            spinner_text "Processing install(s) for: $package" &
            SPIN_PID="$!"
            trap "kill -9 $SPIN_PID" `seq 0 15`
            set +e
            sleep 1
            if "${PACKAGE_MANAGER}" install -y "$package" &>/dev/null; then
                rc="$?"
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] Processed install(s) for: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$package"
            else
                rc="$?"
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] Processed install(s) for: %s\\n" "${OVERWRITE}" "${FAILURE}" "$package"
            fi
            set -e
        done
    fi
}

[ "$(is_command apt)" ] || PACKAGE_MANAGER="apt"
check_apt_dependencies $APT_DEPENDENCIES
install_apt_dependencies
"${PACKAGE_MANAGER}" remove -y $TEST_PACKAGES
