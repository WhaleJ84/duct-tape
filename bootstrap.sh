#!/bin/bash
# This script is heavily influenced by Pi-Hole's bootstrapping script:
# https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh
LOGO="::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::
:::::::::::::::;::;::;::;::;::;::;::::::::::::::::::::::::::::::::::::::::::::::
:::;::;::;::;;:.   .  .. .. .. . . .:;:;::;::;::;::;::;::;::;::;::;::;::;::;::;:
::::::::::;.t8S ;t%%tt:..     . . .tX8S:::::::::::::::::::::::::::::::::::::::::
::;::;:;:;X%88888888888888S;;;;;;;t;t%t;;8;:;::;::;::;::;::;::;::;::;::;::;::;::
::::::;.S@X8888888@888888888Stttttttttttt%t8.:::::::::::::::::::::::::::::::::::
::;::;.S88888888@88@888@888888S%%%%%%%%%%%%S.@.;:;::;:;::;::;::;::;::;::;::;::;:
:::;:t%@88888@8@8X@8@@8888888888SSSSSSSSSSSSSX %:::::::::::::;::::::::;:::::::::
::::.tX88@88@@88@8@8@8@888888@888SXXSXXXXXXXXXX%%::;:::;::;:::::;::;:::::;::;::;
::;.tX88@8@@88@8@@8@8X8@8X88@8@8@8X%SSSSSSSSSSSStX.;::::::::;::::::::;::::::::::
:; 8@8888@@8X@@@8@8@8X8X@8X88@8X888@tttttttt;t;t;t8::;::;:::::;::;:::::;::;::;::
:::SX888X@@@@88 S. X 8X88X@@8@88@888%.::::.::.:.:.:S.;::::;::::::::;:::::::::::;
;.8@888X@@@8S :.;;t;:  8X88X@8@88@888:      .  .   ;;:::;:::;::;:::::;::;::;::::
;.;X8@@@@@@ .:t8.888888S; 88X8@@88X8@8.:::.:.:.:... X.;::::::::::;:::::::::::;::
:;8@@8@@@8  ;88888 t888 . :8@8X8X8@@8@t;.::.:.:.:.:..S.;::;::;:::::;::;::;:::::;
.@@88X@@@X 88888888888888.  8X8X8@8@8@8 :::::::.:.:: X.::::::::;:::::::::::;::::
 @X88@8@8 888S888888888% ;.% 8@8X8@8X8@X:::::::::::::.S::;::;::::;::;::;:::::;::
 %X8@88@@ 88888St@888888::; S @@8@8@8X88.;;;;;;;:;::; 8 ;:::::;::::::::::;:::::;
 tS888@8X 88888888S88.8S.;:.S%@8S8@8@8X8t%;;;;;;;;:::.S::::;:::::;::;::;:::;::::
 SX8@8X@8;888888888888X%::;;   X@8X8@@8 %%ttt;;;:::::.:t::::::;::::::::::::::;::
 @S88@@8 %8@888@@@@@@@@X.;::.8 @8X8@88X88:t;;;::::.... S.;::;::::;::;::;::;:::::
.8@8@8X888X88@@@XXXXXSX8:::;:;8X8@8@8X8X8 t;;:::.......X.:;::::;::::::::::::;::;
:t8@8@@X8;@88XXXS8XXSX8 S:::;.8%@@X8X8X8  t:::.....   :8.;::::::::;::;::;:::::::
:.t@8@8S8 X@XXXX8@8888888;;:; 8%888X8X8@8t;::...   ...;8.:::;::;::::::::::;::;::
; SX8@8S88 X@888888@8@@8 t::::8S88X8S8X8X%:..    .....;@.;:::::::;::;::;::::::::
::t8@8X8X@.888@8@@XX@@XX8 8:.@;8@88@8X8X@S.   .....:.:;@.:::;::;:::::::::;::;:;:
:; :S8XX888t@@@88@@8@XX@X@ 8 t.8@88XX8X8XS.. ....:... :@.;::::::::;::;::::::::::
::.S8X8X8 XS88888@8@@8X8@88X888X8888S8X@8@..  . ....::.8 ;::;::;:::::::;::;:::::
::;.XX@8X888 88@@@8@8@@@@8@888@8888S8X8XS@t;;;;;;;;;;::tt:::::::::;::;::::::;:;:
:::;.%XX8X888 .8X@888888888X8@@8888X8XX8 X%tttttt;;;:;:.8.:;::;:::::::::;:::::::
:::;.X8XX8@8888:88888888.S SXX8888@X8S8@@8:%t;;;;::::::::S::::::;::;::;:::;:::;:
::::;.@8XX88888888  ;t888@8S@8888X@8S8S@@ t;:;:::::::...  8.;:::::::::::::::;:::
:::::;.8X8S88888@X88888888 @8888@X@XS8XX88@.;::.::... .::;%8 ;:;::;::;::;:::::::
::;:::;.@8S@888888888S8@8888888@X88S8S8S8888:...  .:;ttt%SSStt::;:::::::::;::;::
:::::::;:XtX@888888888@888888@@@8XX8S@X8@888@.:;t%%SSSXXXXSSSS.8;:::;:;:::::;:::
::;::;::::. S@@8888888888888 888X@8S8X@@8888@X.S%SXXXXSXSSSSSS%X%X%...:::;:::.::
:::::::::;::88X@@88 X X888888@@@8S8SX@@8@.%8;.ttSXSSSSSSSSSS%S%S%S%;.tS@888@SXt:
:::;:::;:::;;:8.8 @88888 8@@@88XX88X:@Xt:.::::;:tS;S%%%%%%%%%%S%%S%%%%%%%%%%S;::
::::::::::::::; :%8 8@888888XSXX:8; .;;::::;::::;.:S%St%%%%%%%%%S%%%%%%%t;;X.;::
:;::;:::;::;:::;:::XS::t%%; S8%::::;:::::;::::;:::::t8;;%%t%%%%%%%%%tt;t;t%.::::
::::::;:::::::::::;::::.:.:.;;:::::::::;::::;::::;::::.:%8t:tSS%%%%%%% 8;:::;:;:
::;::::::;::;:::;::::::::::::::::::;:::::::::::;:::::::;::..%8:tXXXS;% :;:::::::
::::;::::::::;:::::;::;:::;:::;:;::::;::;:;::;:::::;:::::;:::.:;S8X;::;::::;:::;
::::::;:::;::::;::::::::;:::;:::::;::::::::::::::;:::;::::::;:::;:;::::::;::::::
::; duct-tape :::;::;:::::::::::;::::;::;::;:::;:::::::;::;::::::::::::;::::;::;
::::;:::::::;::;::::::;::;:::;:::::;:::::::::;::::;::;:::::::;::;::;::::::::::::
::;:::;::;::::::::;::::::::;::::;:::::;::;::::::;:::::::;::;:::::::::;::;::;::;:"
set -e

export PY_COLORS='1'
export ANSIBLE_FORCE_COLOR='1'

#DETECTED_OS=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
#DETECTED_VERSION=$(grep VERSION_ID /etc/os-release | cut -d '=' -f2 | tr -d '"')
APT_DEPENDENCIES="curl git python3"
PIP_DEPENDENCIES="ansible"

COL_NC='\e[0m'
COL_LIGHT_GREEN='\e[1;32m'
COL_LIGHT_RED='\e[1;31m'
SUCCESS="${COL_LIGHT_GREEN}*${COL_NC}"
FAILURE="${COL_LIGHT_RED}x${COL_NC}"
OVERWRITE='\r\033[K'

spinner_text(){
    spinner='| / - \ | / - \ '

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

check_test_mode(){
    spinner_text "ENV: checking for DT_TEST... " &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if [ "$DT_TEST" ]; then
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] ENV: DT_TEST found. Running as new\\n" "${OVERWRITE}" "${SUCCESS}"
    else
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] ENV: DT_TEST not found. Running as normal\\n" "${OVERWRITE}" "${SUCCESS}"
    fi
    set -e
}

ensure_in_path(){
    spinner_text "ENV: checking for $1 in PATH... " &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    case ":${PATH:=$1}:" in
        *:"$1":*) kill -9 $SPIN_PID 2>/dev/null ; printf "%b[ %b ] ENV: %s found in PATH\\n" "${OVERWRITE}" "${SUCCESS}" "$1" ;;
        *) PATH="$1:$PATH" ; kill -9 $SPIN_PID 2>/dev/null ; printf "%b[ %b ] ENV: %s added to PATH for session\\n" "${OVERWRITE}" "${SUCCESS}" "$1" ;;
    esac
    set -e
}

check_git_branch(){
    spinner_text "GIT: checking branch... " &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if [ "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" ]; then
        GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] GIT: %s branch found\\n" "${OVERWRITE}" "${SUCCESS}" "$GIT_BRANCH"
    else
        GIT_BRANCH="dev"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] GIT: defaulted to %s branch\\n" "${OVERWRITE}" "${SUCCESS}" "$GIT_BRANCH"
    fi
    set -e
    ANSIBLE_REQUIREMENT_FILE="/tmp/$GIT_BRANCH-requirements.yml"
}

check_apt_dependencies(){
    installArray=""
    for i in "$@"; do
        spinner_text "${PACKAGE_MANAGER}: Checking for ${i}... " &
        SPIN_PID="$!"
        trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
        set +e
        if dpkg-query -W -f='${Status}' "${i}" 2>/dev/null | grep "ok installed" &>/dev/null; then
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT: Checked for %s\\n" "${OVERWRITE}" "${SUCCESS}" "${i}"
        else
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
            spinner_text "Processing ${PACKAGE_MANAGER} install(s) for: $package... " &
            SPIN_PID="$!"
            trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
            set +e
            if "${PACKAGE_MANAGER}" install -y "$package" &>/dev/null; then
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] Processed ${PACKAGE_MANAGER} install(s) for: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$package"
            else
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] Processed ${PACKAGE_MANAGER} install(s) for: %s\\n" "${OVERWRITE}" "${FAILURE}" "$package"
            fi
            set -e
        done
    fi
}

install_pip(){
    if [ ! -f "/tmp/get-pip.py" ]; then
        spinner_text "Downloading pip bootstrapping script... " &
        SPIN_PID="$!"
        trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
        set +e
        if curl https://bootstrap.pypa.io/get-pip.py -s -o /tmp/get-pip.py; then
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] Downloaded pip bootstrapping script\\n" "${OVERWRITE}" "${SUCCESS}"
        else
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] Downloading pip bootstrapping script\\n" "${OVERWRITE}" "${FAILURE}"
        fi
        set -e
    fi

    spinner_text "Installing pip... " &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if python3 /tmp/get-pip.py --user &>/dev/null; then
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] Installed pip\\n" "${OVERWRITE}" "${SUCCESS}"
    else
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] Installing pip\\n" "${OVERWRITE}" "${FAILURE}"
    fi
    set -e
}

check_pip(){
    spinner_text "PYTHON: Checking for pip... " & 
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if python3 -m pip -V 2&>/dev/null; then 
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] PYTHON: Checked for pip\\n" "${OVERWRITE}" "${SUCCESS}"
    else
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] PYTHON: Checked for pip (will be installed)\\n" "${OVERWRITE}" "${FAILURE}"
        install_pip
    fi
    set -e
}

check_pip_dependencies(){
    installArray=""
    for i in "$@"; do
        spinner_text "PIP: Checking for ${i}... " &
        SPIN_PID="$!"
        trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
        set +e
        if python3 -m pip list | grep "$i " &>/dev/null; then
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] PIP: Checked for %s\\n" "${OVERWRITE}" "${SUCCESS}" "${i}"
        else
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
            spinner_text "PIP: Processing install(s) for: $package... " &
            SPIN_PID="$!"
            trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
            set +e
            if python3 -m pip install --user "$package" &>/dev/null; then
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] PIP: Processed install(s) for: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$package"
            else
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] PIP: Processed install(s) for: %s\\n" "${OVERWRITE}" "${FAILURE}" "$package"
            fi
            set -e
        done
    fi
}

check_ansible_dependencies(){
    if [ ! -f "$ANSIBLE_REQUIREMENT_FILE" ] || [ "$DT_TEST" ]; then
        REQUIREMENT_URL="https://raw.githubusercontent.com/WhaleJ84/duct-tape/$GIT_BRANCH/requirements.yml"
        spinner_text "ANSIBLE: Downloading requirements.yml... " &
        SPIN_PID="$!"
        trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
        set +e
        if curl "$REQUIREMENT_URL" -so "$ANSIBLE_REQUIREMENT_FILE" &>/dev/null; then
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] ANSIBLE: Downloaded requirements.yml \\n" "${OVERWRITE}" "${SUCCESS}"
        fi
        set -e
    fi
}

install_ansible_dependencies(){
    spinner_text "ANSIBLE: Installing $GIT_BRANCH requirements... " &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if [ "$DT_TEST" ]; then
        ansible-galaxy install --force -r "$ANSIBLE_REQUIREMENT_FILE" &>/dev/null 
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] ANSIBLE: Installed $GIT_BRANCH requirements\\n" "${OVERWRITE}" "${SUCCESS}"
    else
        ansible-galaxy install -r "$ANSIBLE_REQUIREMENT_FILE" &>/dev/null &
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] ANSIBLE: $GIT_BRANCH installed\\n" "${OVERWRITE}" "${SUCCESS}"
    fi
    set -e
}

# TODO: Make keyboard interrupts kill script entirely
[ "$(is_command apt)" ] || PACKAGE_MANAGER="apt"
printf "%s" "$LOGO"
sleep 1
check_test_mode
ensure_in_path "$HOME/.local/bin"
check_git_branch
# shellcheck disable=SC2086
check_apt_dependencies $APT_DEPENDENCIES 
install_apt_dependencies
check_pip
# shellcheck disable=SC2086
check_pip_dependencies $PIP_DEPENDENCIES
install_pip_dependencies
check_ansible_dependencies
exit 1
install_ansible_dependencies
ansible-pull -KU https://github.com/WhaleJ84/duct-tape.git
