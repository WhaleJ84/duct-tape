#!/bin/bash
# This script is heavily influenced by Pi-Hole's bootstrapping script:
# https://github.com/pi-hole/pi-hole/blob/master/automated%20install/basic-install.sh
LOGO=":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;::;:
:::::::::::::::;::;::;::;::;::;::;:::::::::::::::::::::::::::::::::::::::::::::
:::;::;::;::;;..   . ... .. .. . . .:;:;::;::;::;::;::;::;::;::;::;::;::;::;:::
:::::::::;::%8;:tSSS%t;:......... .tX8t::::::::::::::::::::::::::::::::::::::;:
::;::;:;.%;X8888888888888@%;;;;;t;ttttt:%@::;::;::;::;::;::;::;::;::;::;::;::::
::::::; 88888888888888@88888%tttttttt%tttS t.;::::::::::::::::::::::::::::::;::
::;:;:;.8888888888@8@888@88888%%%%%%%%%%%%S%S;:;::;:;::;:;::;::;::;::;::;::::::
:::;.X8@88888@888@@@@8@8888@8888SSSXSSSXSSSSXS@:::::::::::::::::;::::::::;::;::
::::;@@88@88@8@8@8@8@8@8@8@888888SXSXXSXXXXXXS8t.;:::;::;::;:;:::::;::;:::::::;
::;. X88@8@@88@@8X8X8X8@8X8@8@8888SS%SSSS%S%S%SSt::;::::::::::::;:::::::;::;:::
:; %X8888@@8X@8X@@8X8@8X@@88@888888%tt;t;tt;;t;;t:;:::;::;:::;:::::;::;::::::::
::;8@88@X@@@@8S  :: XX@88@@@8@8@8@88:.:.:........:S.;::::::;::::;::::::::;::;::
; @X88@@@@@8 ..:;8.;;. 8X8@8X8@88888X.  . .  .  .  8.:;::;::::;::::;::;:::::::;
::%@8@@@@@@ .:8.888888:; @8@8X8@88X8@%::.:.:.:.:....%:::::::;::::;:::::::;::;::
.%8X8@@@@8.::888t888%X88tt:8@8X8X8@888 :::::.:..:.: @.;:::;:::::::::;::;:::::::
 8X88X@@@  888888888888X .% 8@8X8@8@88X:::.:::::.:.::%.;::::::;::;::::::::;::;:
 SX8@88@8S88888888888888.;   8@8X8@8@8@:;:::::::::::.8.;:::;:::::::;::;::::::::
 tX8@@8X%:888888888888 %;:; 888S8@8@8@@St;;;;;;;;;:::;:::;:::;::;:::::::;::;:::
 tS88X@8X.888X88888888S.::;.% X8S8X8@8@8;t;t;;;;::;::.%:::::::::::;::;:::::::;:
 %X8X8S@@88@888888@8@8%.;::;.8X8X88X8X8X.%t;t;;:::..:.8.;::;::;::::::::;::;::::
 @X88@8X 8888888@@@@888;:::;.  S@X8X8@@8t%;;;:::::....8.::::::::;::;:::::::::;:
.@@8@@@88:@8@@@XXSXS8XSX.;:; 8 @88X88@8XXt;;:::......:@.:;::;::::::::;::;::;:::
:;8@8@@X@tXX@XXXSXSXX@X :;:::@ @8@8S8X@88:;::....    :S.::::::;::;:::::::::::::
; :S8@8S8;8X@@@8@@X@XX@@8:;; 8 8888X88XX8 :..    ....;S.:;::;::::::;::;::;::;::
;.8X@8X888:@@8@X@@@X@XX@XX.;.8:888X8%8X8@ ..  . ...:.tX.:::::::;::::::::::::::;
::;SX8XX88 8@X@88XXX@X88X S:. .8888%8X8S8:   ....:.:.;X.;::;:::::;::;::;::;::::
:; 8X@8X888 8@@888@@@@X@888888X888@X8X8X8: . ..   ... S.:::::;::::::::::::::;::
::;:tX@8X888t@@8@88888@@@X@88@8888@X8XX8X ...::;;;:;:;:t::;::::;::;::;::;:::::;
::;.88XX8@888:8@X@88@@@888888X@888@X8X8SX.ttt;t;;;;;;:.8.:::;:::::::::::::;::::
:::;.X@8%888@8 ;888888888888SX8888@8S8S8 :Stt;;;;;::::::@.;::::;::;::;::;:::;::
::::;  %8X@8888@@S@88S88%t8SX8@88@X8SX8S@8;;;::::::::::..t:::;:::::::::::::::::
::::::;%S8X88888888.XXt88X8S@@888X@X8XXX@X;;::::::.:..  :.S:::::;::;::;::;::;::
::;::;::.S8X8888 88888@X@@@88888 88%8X@@@88.;:..  .:;ttt%SStt:::::::::::::::::;
:::::::; .%8X888X8888888888888888XS8S8S8@88@. .::tt%%SSXXXSXS8.:;:;::;:;::;::::
:::;::::;.%@X@@8 @88888888888888@@8S8%8X8888t t%%SSXXXXSSSSSSS.@S:::::::;::;:::
:::::;:::;:t:8S88 @ X X8888888@@@8S8%XX8@:%@;:X%XSXSSSSSSSS%SS%SSt.;X888@888@t:
:;:::::::::;.SS 88@888888888 8@8XXSt8SSS. :;::.%:X%%SS%%S%%%S%%%S%t%%SXXXXXS8.:
:::;:::;::::;:.8:8X@@@@@8@888X@8@ S8%:.::;:::;:::8.%%%%%%%%%%%S%%%%%%%%ttt:%:::
:::::::::::::::::;S@::SX@X%.t8S;:::;:::;::::::::::.t8t;%%t%%%%%%%%%%t;;t:X.;::;
::;::;::;::;::;:::;:..     .:;;::::::;:::::;::;:::;::.:8.SS%%%%%%%%tt%t8.::::::
::::::::::::::::::::;:;:;:;::::::;::::::;:::::::;::::::.:%8%.;%SSSS;;8;::;:::;:
::;::;:::;::;::;::;::::::::::;:::::;::;::::;::;::::::::::;::::;S88t:.::::::;:::
:::::::;::::::::::::::;::;:::::;::;::::::;::::::::;::;:;::::::;::;::;::;::::::;
::; duct-tape ;:;::;:::::::;:::::::::;::::::;::;::::::::::;::::::::::::::;::;::
::::::::;:::::::::::::;::::::;::;::;:::;::;:::::::;::;::;::::;::;::;::;::::::::
:::;::;:::::;:::;:::;:::;::;:::::::::::::::::;::;::::::::::;:::::::::::::;::;::"
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
    spinner_text "ENV: checking for DT_TEST" &
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
    spinner_text "ENV: checking for $1 in PATH" &
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
    spinner_text "GIT: checking branch" &
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
        spinner_text "${PACKAGE_MANAGER}: Checking for ${i}" &
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
            spinner_text "Processing ${PACKAGE_MANAGER} install(s) for: $package" &
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
        spinner_text "Downloading pip bootstrapping script" &
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

    spinner_text "Installing pip" &
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
    spinner_text "PYTHON: Checking for pip" & 
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
        spinner_text "PIP: Checking for ${i}" &
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
            spinner_text "PIP: Processing install(s) for: $package" &
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
    if [[ ! -f "$ANSIBLE_REQUIREMENT_FILE" ]] || [[ "$DT_TEST" ]]; then
        REQUIREMENT_URL="https://raw.githubusercontent.com/WhaleJ84/duct-tape/$GIT_BRANCH/requirements.yml"
        # FIXME: Bug where if the text is longer than term length
        # (e.g. [ | ] ANSIBLE: very long text... [ / ] ANSIBLE: v)
        # and gets cut off when doubled, the spinner doesn't work
        # as intended. Visual bug only. 39 chars max
        spinner_text "ANSIBLE: Pulling requirements" &
        SPIN_PID="$!"
        trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
        sleep 1
        if curl "$REQUIREMENT_URL" -so "$ANSIBLE_REQUIREMENT_FILE" &>/dev/null; then
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] ANSIBLE: Pulled requirements file\\n" "${OVERWRITE}" "${SUCCESS}"
        fi
        set -e
    fi
}

install_ansible_dependencies(){
    spinner_text "ANSIBLE: Installing requirements" &
    [ "$DT_TEST" ] && flag="--force" || flag=""
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    mkdir -p "$HOME/.ansible/roles"
    set +e
    if ansible-galaxy install "${flag}" -r "$ANSIBLE_REQUIREMENT_FILE" &>/dev/null; then
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] ANSIBLE: Installed requirements\\n" "${OVERWRITE}" "${SUCCESS}"
    fi
    set -e
}

# TODO: Make keyboard interrupts kill script entirely
[ "$(is_command apt)" ] || PACKAGE_MANAGER="apt"
printf "%s\\n" "$LOGO"
sleep 1
check_test_mode
ensure_in_path "$HOME/.local/bin"
check_git_branch
check_apt_dependencies $APT_DEPENDENCIES 
install_apt_dependencies
check_pip
check_pip_dependencies $PIP_DEPENDENCIES
install_pip_dependencies
check_ansible_dependencies
install_ansible_dependencies
ansible-pull -KU https://github.com/WhaleJ84/duct-tape.git
