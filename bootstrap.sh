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

DETECTED_OS=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
TESTED_OSES="ubuntu"
DETECTED_VERSION=$(grep VERSION_ID /etc/os-release | cut -d '=' -f2 | tr -d '"')
TESTED_UBUNTU_VERSIONS="20.04"
PRE_APT_DEPENDENCIES="software-properties-common"
APT_DEPENDENCIES="ansible git"
ANSIBLE_PATH="/home/$SUDO_USER/.local/bin"

COL_NC='\e[0m'
COL_LIGHT_GREEN='\e[1;32m'
COL_LIGHT_RED='\e[1;31m'
COL_LIGHT_BLUE='\e[1;34m'
SUCCESS="${COL_LIGHT_GREEN}*${COL_NC}"
FAILURE="${COL_LIGHT_RED}x${COL_NC}"
DEBUG="${COL_LIGHT_BLUE}?${COL_NC}"
OVERWRITE='\r\033[K'
DRY_RUN=0
BYPASS_CHECKS=0

usage(){
    cat << EOF
Usage: duct-tape [OPTION]
Installs the relevant requirements to get Ansible installed on the system
and pull down desired runbooks from Git repository.

OPTIONS:
    -b      Bypass OS check. Run script on untested systems
    -d      Perform dry run. Do not make any modifications
    -h      Display this message and exit
    -s      Display supported operating systems and versions and exit
EOF
    exit 0
}

supported(){
    # Displays supported OSes and versions.
    # Loops through each OS in TESTED_OS
    # and displays each TESTED_$OS_VERSION supported.
    printf "SUPPORTED:\\n"
    for system in $TESTED_OSES; do
        printf "    %s:\\n" "$system"
        versions_var="TESTED_$(echo "${system}" | tr '[:lower:]' '[:upper:]')_VERSIONS"
        for version in $(eval echo \$"$versions_var"); do
            printf "        %s\\n" "$version"
        done
    done
    exit 0
}

spinner_text(){
    # Takes an input and displays it next to a spinner inside a box.
    # Continues spinning until the PID is killed.
    # 1. Start the process with `spinner_text "Example text" &`.
    # 2. Save the PID by using `SPIN_PID="$!"`.
    # 3. Trap the process with `trap 'kill -9 "$SPIN_PID"' $(seq 0 15)`
    # 4. Kill it using `kill -9 $SPIN_PID 2>/dev/null`
    spinner='| / - \ | / - \ '

    while true; do
        for pos in $spinner; do
            printf "\r[ %s ] %s:\t%s" "$pos" "$1" "$2"
            printf "\r%b[ %s ] %s:\t%s" "$OVERWRITE" "$pos" "$1" "$2"
            sleep 0.1
        done
    done
}

tested_os_warning(){
    # Checks if detected OS is in list of tested OSes.
    # Warns if system is not tested and requires explicit flag.
    spinner_text "OS" "Checking OS distribution" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    case "$TESTED_OSES" in
        "$DETECTED_OS") \
            kill -9 $SPIN_PID 2>/dev/null && \
            printf "%b[ %b ] OS:\tChecked %s in distribution list\\n" "${OVERWRITE}" "${SUCCESS}" "${DETECTED_OS}" ;;
        *) \
            if [ "$BYPASS_CHECKS" == 0 ]; then \
                kill -9 $SPIN_PID 2>/dev/null && \
                printf "%b[ %b ] OS:\tChecked %s not in distribution list (use '-b' flag to force operation)\\n" "${OVERWRITE}" "${FAILURE}" "${DETECTED_OS}" && \
                exit 0
            else \
                TIMER=3 && \
                kill -9 $SPIN_PID 2>/dev/null && \
                printf "%b[ %b ] OS:\t%Checked s bypassed in distribution list (%s SECONDS TO CANCEL)" "${OVERWRITE}" "${DEBUG}" "${DETECTED_OS}" "${TIMER}" && \
                while [ "$TIMER" -gt 0 ]; do
                    printf "%b[ %b ] OS:\t%Checked s bypassed in distribution list (%s SECONDS TO CANCEL)" "${OVERWRITE}" "${DEBUG}" "${DETECTED_OS}" "${TIMER}" && \
                    sleep 1 && \
                    TIMER=$(expr "$TIMER" - 1) 
                done
                printf "%b[ %b ] OS:\t%Checked s bypassed in distribution list\\n" "${OVERWRITE}" "${DEBUG}" "${DETECTED_OS}"
            fi ;;
        esac
    set -e
}

bypass_version(){
    # Bypasses OS version check if '-b' flag is detected.
    # Called in `tested_version_warning`.
    TIMER=3
    kill -9 $SPIN_PID 2>/dev/null
    printf "%b[ %b ] OS:\t%Checked s bypassed in version list (%s SECONDS TO CANCEL)" "${OVERWRITE}" "${DEBUG}" "${DETECTED_VERSION}" "${TIMER}"
    while [ "$TIMER" -gt 0 ]; do
        printf "%b[ %b ] OS:\t%Checked s bypassed in version list (%s SECONDS TO CANCEL)" "${OVERWRITE}" "${DEBUG}" "${DETECTED_VERSION}" "${TIMER}"
        sleep 1
        TIMER=$(expr "$TIMER" - 1)
    done
    printf "%b[ %b ] OS:\t%Checked s bypassed in version list\\n" "${OVERWRITE}" "${DEBUG}" "${DETECTED_VERSION}"
}

tested_version_warning(){
    # Checks if detected version is in list of tested versions.
    # Warns if version is not tested and requires explicit flag.
    spinner_text "OS" "Checking OS version" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if [ "$DETECTED_OS" == "ubuntu" ]; then
        case "$TESTED_UBUNTU_VERSIONS" in
            "$DETECTED_VERSION") \
                kill -9 $SPIN_PID 2>/dev/null && \
                printf "%b[ %b ] OS:\tChecked %s in version list\\n" "${OVERWRITE}" "${SUCCESS}" "${DETECTED_VERSION}" ;;
            *) \
                kill -9 $SPIN_PID 2>/dev/null && \
                if [ "$BYPASS_CHECKS" == 0 ]; then \
                    printf "%b[ %b ] OS:\tChecked %s not in version list (use '-b' flag to force operation)\\n" "${OVERWRITE}" "${FAILURE}" "${DETECTED_VERSION}" && \
                    exit 0
                else
                    bypass_version
                fi ;;
        esac
    else
        printf "%b[ %b ] OS:\tChecked %s not in any OS version (see '\$DETECTED_*VERSION')" "${OVERWRITE}" "${FAILURE}" "${DETECTED_VERSION}"
        exit 2  # TODO: document unique exit code. This shouldn't really happen so if 2 occurs, then logic weirdness.
    fi
}

update_apt_repository(){
    # Updates apt repository.
    spinner_text "APT" "Updating apt repository" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if [ "$DRY_RUN" == 0 ]; then  # if application running without `-d` flag
        if apt update &>/dev/null; then  # if repository updates successfully
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT:\tUpdated apt repository\\n" "${OVERWRITE}" "${SUCCESS}"
        else  # if repository fails to update
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT:\tUpdating apt repository\\n" "${OVERWRITE}" "${FAILURE}"
        fi
    else  # if application running without `-d` flag
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] APT:\tUpdating apt repository (skipped from dry-run)\\n" "${OVERWRITE}" "${DEBUG}"
    fi
    set -e
}

install_apt_dependencies(){
    # Reads `installArray`, expecting a space separated list `"pkg1 pkg2 pkg3"`.
    # Loop through each package in list and tries to install using apt.
    # Displays a message reflecting installation outcome.
    if [[ "${#installArray[@]}" -gt 0 ]]; then
        for package in $installArray; do
            spinner_text "APT" "Installing apt install(s) for: $package" &
            SPIN_PID="$!"
            trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
            set +e
            if [ "$DRY_RUN" == 0 ]; then  # if application running without `-d` flag
                if apt install -y "$package" &>/dev/null; then  # if package installs correctly
                    kill -9 $SPIN_PID 2>/dev/null
                    printf "%b[ %b ] APT:\tInstalled apt install(s) for: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$package"
                else  # if package fails to install
                    kill -9 $SPIN_PID 2>/dev/null
                    printf "%b[ %b ] APT:\tInstalling apt install(s) for: %s\\n" "${OVERWRITE}" "${FAILURE}" "$package"
                fi
            else  # if application running with `-d` flag
                kill -9 $SPIN_PID 2>/dev/null
                printf "%b[ %b ] APT:\tInstalling apt install(s) for: %s (skipped from dry-run)\\n" "${OVERWRITE}" "${DEBUG}" "$package"
            fi
            set -e
        done
    fi
}

check_apt_dependencies(){
    installArray=""
    for i in "$@"; do
        spinner_text "APT" "Checking for ${i}" &
        SPIN_PID="$!"
        trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
        set +e
        if dpkg-query -W -f='${Status}' "${i}" 2>/dev/null | grep "ok installed" &>/dev/null; then  # if apt package is installed
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT:\tChecked for %s\\n" "${OVERWRITE}" "${SUCCESS}" "${i}"
        else  # if apt package isn't installed
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT:\tChecked for %s (will be installed)\\n" "${OVERWRITE}" "${FAILURE}" "${i}"
            installArray="$installArray$i "
        fi
        set -e
    done
    update_apt_repository
    install_apt_dependencies
}

add_apt_repository(){
    spinner_text "APT" "Adding apt repository: $2:$1" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if [ "$DRY_RUN" == 0 ]; then  # if application running without `-d` flag
        if add-apt-repository --yes "$2:$1" &>/dev/null; then  # if apt repository is installed
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT:\tAdded apt repository: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$2:$1"
        else  # if apt repository isn't installed
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] APT:\tAdding apt repository: %s\\n" "${OVERWRITE}" "${FAILURE}" "$2:$1"
        fi
    else  # if application running with `-d` flag
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] APT:\tAdded apt repository: %s (skipped from dry-run)\\n" "${OVERWRITE}" "${DEBUG}" "$2:$1"
    fi
    set -e
}

check_apt_repository(){
    repo="ppa"
    if [ -n "$2" ]; then
        repo="$2"
    fi
    spinner_text "APT" "Checking apt repository: $repo:$1" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if apt-cache policy | grep "$1" &>/dev/null; then  # if apt repository is installed
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] APT:\tChecked apt repository: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$repo:$1"
    else  # if apt repository isn't installed
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] APT:\tChecked apt repository: %s (will be installed)\\n" "${OVERWRITE}" "${FAILURE}" "$repo:$1"
        add_apt_repository "$1" "$repo"
    fi
    set -e
}

check_git_branch(){
    spinner_text "GIT" "Checking branch" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if [ "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" ]; then  # if a Git branch is detected
        GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] GIT:\tUsing %s branch\\n" "${OVERWRITE}" "${SUCCESS}" "$GIT_BRANCH"
    else  # if no Git branch is detected
        GIT_BRANCH="dev"
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] GIT:\tUsing %s branch by default\\n" "${OVERWRITE}" "${SUCCESS}" "$GIT_BRANCH"
    fi
    set -e
    ANSIBLE_REQUIREMENT_FILE="/tmp/$GIT_BRANCH-requirements.yml"
}

install_ansible_dependencies(){
    spinner_text "ANSIBLE" "Installing requirements" &
    [ "$DRY_RUN" ] && flag="--force" || flag=""
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    set +e
    if ansible-galaxy install ${flag} -r "$ANSIBLE_REQUIREMENT_FILE" &>/dev/null; then  # if requirement successfully installs
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] ANSIBLE:\tInstalled requirements\\n" "${OVERWRITE}" "${SUCCESS}"
    else  # if requirement fails to install
        kill -9 $SPIN_PID 2>/dev/null
        printf "%b[ %b ] ANSIBLE:\tSomething failed!\\n" "${OVERWRITE}" "${FAILURE}"
    fi
    set -e
}

check_ansible_dependencies(){
    if [[ ! -f "$ANSIBLE_REQUIREMENT_FILE" ]] || [[ "$DRY_RUN" ]]; then
        REQUIREMENT_URL="https://raw.githubusercontent.com/WhaleJ84/duct-tape/$GIT_BRANCH/requirements.yml"
        spinner_text "ANSIBLE" "Pulling requirements" &
        SPIN_PID="$!"
        trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
        set +e
        if curl "$REQUIREMENT_URL" -so "$ANSIBLE_REQUIREMENT_FILE" &>/dev/null; then  # if requirement file successfully downloads
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] ANSIBLE:\tPulled requirements file\\n" "${OVERWRITE}" "${SUCCESS}"
        else
            kill -9 $SPIN_PID 2>/dev/null
            printf "%b[ %b ] ANSIBLE:\tFailed to pull requirements" "${OVERWRITE}" "${FAILURE}"
        fi
        set -e
        # install_ansible_dependencies
    fi
}

while getopts bdhs arg; do
    case "$arg" in
        b) BYPASS_CHECKS=1 ;;
        d) DRY_RUN=1 ;;
        h) usage ;;
        s) supported ;;
        ?) usage ;;
    esac
done

# TODO: Make keyboard interrupts kill script entirely
# TODO: Put install tasks inside check tasks and only run them if not in test mode
printf "%s\\n" "$LOGO"
sleep 1
[ $DRY_RUN == 1 ] && printf "[ %b ] DEBUG:\tRunning in dry run mode           No modifications will be made\\n" "${DEBUG}"

# Check system OS
tested_os_warning

# Check OS verison
tested_version_warning

# Ensure that all the relevant apt dependencies are installed
check_apt_dependencies $PRE_APT_DEPENDENCIES 
check_apt_repository "ansible/ansible"
check_apt_dependencies $APT_DEPENDENCIES 

# Determine which Duct-tape git branch to pull ansible requirements from
check_git_branch

# Ensire the relevant ansible dependencies are installed
check_ansible_dependencies

printf "[ %b ] COMPLETE:\tTo continue configuring system, run:\\n\tansible-pull -KU https://github.com/WhaleJ84/duct-tape.git\\n" "${SUCCESS}"
