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
::; duct-tape ;:;::;:::::::;:::::::::;::::::;::;::::::::::;:::::::  v1.2.0  ;::
::::::::;:::::::::::::;::::::;::;::;:::;::;:::::::;::;::;::::;::;::;::;::::::::
:::;::;:::::;:::;:::;:::;::;:::::::::::::::::;::;::::::::::;:::::::::::::;::;::"
VERSION=$(printf "%s\\n" "$LOGO" | grep "duct-tape" | awk '{print $4}')
DETECTED_OS=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
TESTED_OSES="ubuntu"
DETECTED_VERSION=$(grep VERSION_ID /etc/os-release | cut -d '=' -f2 | tr -d '"')
TESTED_UBUNTU_VERSIONS="20.04 24.04"
PRE_APT_DEPENDENCIES="software-properties-common"
APT_DEPENDENCIES="ansible git"
DEV_APT_PACKAGES="ansible-lint yamllint"
SPECIFIED_GIT_BRANCH="main"

COL_NC='\e[0m'
COL_LIGHT_GREEN='\e[1;32m'
COL_LIGHT_RED='\e[1;31m'
COL_LIGHT_BLUE='\e[1;34m'
SUCCESS="${COL_LIGHT_GREEN}*${COL_NC}"
FAILURE="${COL_LIGHT_RED}x${COL_NC}"
DEBUG="${COL_LIGHT_BLUE}?${COL_NC}"
OVERWRITE='\r\033[K'

DRY_RUN=0
DEV=0
BYPASS_CHECKS=0
FORCE=0
SKIP_UPDATE=0
GIT_BRANCH_SPECIFIED=0
TOTAL_CHECKS=0
PASSED_CHECKS=0

usage(){
    cat << EOF
Usage: duct-tape [OPTION]... [-f ["REQUIREMENT[ REQUIREMENT]..."]]
Installs the relevant requirements to get Ansible installed on 
the system and pull down desired runbooks from Git repository.

OPTIONS:
    -b	    Specify 'ansible-pull' git branch. Defaults to '$SPECIFIED_GIT_BRANCH'
    -B      Bypass OS check. Run script on untested systems
    -d      Perform dry run. Do not make any modifications
    -D	    Install development packages
    -f REQ. Force the program to redownload requirements where possible.
	    Specific requirements can be passed in a space separated 
	    string (e.g. "req1 req2 req3"). Must be specified last
    -h      Display this message and exit
    -s      Display supported operating systems and versions and exit
    -v	    Display version number of duct-tape and exit
EOF
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
    TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
    spinner_text "      OS" "Checking OS distribution" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    case "$TESTED_OSES" in
        *"$DETECTED_OS"*) \
            kill -9 $SPIN_PID 2>/dev/null && \
            printf "\r%b[ %b ]       OS:\tChecked %s in distribution list\\n" "${OVERWRITE}" "${SUCCESS}" "${DETECTED_OS}"
            PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1) ;;
        *) \
            if [ "$BYPASS_CHECKS" == 0 ]; then \
                kill -9 $SPIN_PID 2>/dev/null && \
                printf "\r%b[ %b ]       OS:\tChecked %s not in distribution list (use '-b' flag to force operation)\\n" "${OVERWRITE}" "${FAILURE}" "${DETECTED_OS}" && \
                exit 0
            else \
                TIMER=3 && \
                kill -9 $SPIN_PID 2>/dev/null && \
                printf "\r%b[ %b ]       OS:\tChecked %s bypassed in distribution list (%s SECONDS TO CANCEL)" "${OVERWRITE}" "${DEBUG}" "${DETECTED_OS}" "${TIMER}" && \
                while [ "$TIMER" -gt 0 ]; do
                    printf "\r%b[ %b ]       OS:\tChecked %s bypassed in distribution list (%s SECONDS TO CANCEL)" "${OVERWRITE}" "${DEBUG}" "${DETECTED_OS}" "${TIMER}" && \
                    sleep 1 && \
                    TIMER=$(expr "$TIMER" - 1) 
                done
                printf "\r%b[ %b ]       OS:\tChecked %s bypassed in distribution list\\n" "${OVERWRITE}" "${DEBUG}" "${DETECTED_OS}"
                PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
            fi ;;
        esac
}

bypass_version(){
    # Bypasses OS version check if '-b' flag is detected.
    # Called in `tested_version_warning`.
    TIMER=3
    kill -9 $SPIN_PID 2>/dev/null
    printf "\r%b[ %b ]       OS:\tChecked %s bypassed in version list (%s SECONDS TO CANCEL)" "${OVERWRITE}" "${DEBUG}" "${DETECTED_VERSION}" "${TIMER}"
    while [ "$TIMER" -gt 0 ]; do
        printf "\r%b[ %b ]       OS:\tChecked %s bypassed in version list (%s SECONDS TO CANCEL)" "${OVERWRITE}" "${DEBUG}" "${DETECTED_VERSION}" "${TIMER}"
        sleep 1
        TIMER=$(expr "$TIMER" - 1)
    done
    printf "\r%b[ %b ]       OS:\tChecked %s bypassed in version list\\n" "${OVERWRITE}" "${DEBUG}" "${DETECTED_VERSION}"
}

tested_version_warning(){
    # Checks if detected version is in list of tested versions.
    # Warns if version is not tested and requires explicit flag.
    TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
    spinner_text "      OS" "Checking OS version" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    if [ "$DETECTED_OS" == "ubuntu" ]; then
        case "$TESTED_UBUNTU_VERSIONS" in
            *"$DETECTED_VERSION"*) \
                kill -9 $SPIN_PID 2>/dev/null && \
                printf "\r%b[ %b ]       OS:\tChecked %s in version list\\n" "${OVERWRITE}" "${SUCCESS}" "${DETECTED_VERSION}"
                PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1) ;;
            *) \
                kill -9 $SPIN_PID 2>/dev/null && \
                if [ "$BYPASS_CHECKS" == 0 ]; then \
                    printf "\r%b[ %b ]       OS:\tChecked %s not in version list (use '-b' flag to force operation)\\n" "${OVERWRITE}" "${FAILURE}" "${DETECTED_VERSION}" && \
                    exit 0
                else
                    bypass_version
                fi ;;
        esac
    else
        printf "\r%b[ %b ]       OS:\tChecked %s not in any OS version (see '\$DETECTED_*VERSION')" "${OVERWRITE}" "${FAILURE}" "${DETECTED_VERSION}"
        exit 2  # TODO: document unique exit code. This shouldn't really happen so if 2 occurs, then logic weirdness.
    fi
}

update_apt_repository(){
    # Updates apt repository.
    TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
    spinner_text "     APT" "Updating apt repository" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    if [ "$SKIP_UPDATE" == 0 ]; then  # normal operation
        if [ "$DRY_RUN" == 0 ]; then  # if application running without `-d` flag
            if apt update &>/dev/null; then  # if repository updates successfully
                kill -9 $SPIN_PID 2>/dev/null
                printf "\r%b[ %b ]      APT:\tUpdated apt repository\\n" "${OVERWRITE}" "${SUCCESS}"
                PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
            else  # if repository fails to update
                kill -9 $SPIN_PID 2>/dev/null
                printf "\r%b[ %b ]      APT:\tUpdating apt repository\\n" "${OVERWRITE}" "${FAILURE}"
            fi
        else  # if application running without `-d` flag
            kill -9 $SPIN_PID 2>/dev/null
            printf "\r%b[ %b ]      APT:\tUpdating apt repository (skipped from dry-run)\\n" "${OVERWRITE}" "${DEBUG}"
            PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
        fi
    else
        kill -9 $SPIN_PID 2>/dev/null
        printf "\r%b[ %b ]      APT:\tUpdate apt repository not needed\\n" "${OVERWRITE}" "${SUCCESS}"
        PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
    fi
}

install_apt_dependencies(){
    # Reads `installArray`, expecting a space separated list `"pkg1 pkg2 pkg3"`.
    # Loop through each package in list and tries to install using apt.
    # Displays a message reflecting installation outcome.
    if [[ "${#installArray[@]}" -gt 0 ]]; then
        for package in $installArray; do
            TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
            spinner_text "     APT" "Installing apt install(s) for: $package" &
            SPIN_PID="$!"
            trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
            if [ "$DRY_RUN" == 0 ]; then  # if application running without `-d` flag
                if apt install -y "$package" &>/dev/null; then  # if package installs correctly
                    kill -9 $SPIN_PID 2>/dev/null
                    printf "\r%b[ %b ]      APT:\tInstalled apt install(s) for: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$package"
                    PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
                else  # if package fails to install
                    kill -9 $SPIN_PID 2>/dev/null
                    printf "\r%b[ %b ]      APT:\tInstalling apt install(s) for: %s\\n" "${OVERWRITE}" "${FAILURE}" "$package"
                fi
            else  # if application running with `-d` flag
                kill -9 $SPIN_PID 2>/dev/null
                printf "\r%b[ %b ]      APT:\tInstalling apt install(s) for: %s (skipped from dry-run)\\n" "${OVERWRITE}" "${DEBUG}" "$package"
                PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
            fi
        done
    fi
}

check_apt_dependencies(){
    installArray=""
    for i in "$@"; do
        TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
        spinner_text "     APT" "Checking for ${i}" &
        SPIN_PID="$!"
        trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
        if dpkg-query -W -f='${Status}' "${i}" 2>/dev/null | grep "ok installed" &>/dev/null; then  # if apt package is installed
            kill -9 $SPIN_PID 2>/dev/null
            printf "\r%b[ %b ]      APT:\tChecked for %s\\n" "${OVERWRITE}" "${SUCCESS}" "${i}"
            PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
        else  # if apt package isn't installed
            kill -9 $SPIN_PID 2>/dev/null
            printf "\r%b[ %b ]      APT:\tChecked for %s (will be installed)\\n" "${OVERWRITE}" "${FAILURE}" "${i}"
            installArray="$installArray$i "
        fi
    done
    update_apt_repository
    install_apt_dependencies
}

add_apt_repository(){
    TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
    spinner_text "     APT" "Adding apt repository: $2:$1" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    if [ "$DRY_RUN" == 0 ]; then  # if application running without `-d` flag
        if add-apt-repository --yes "$2:$1" &>/dev/null; then  # if apt repository is installed
            kill -9 $SPIN_PID 2>/dev/null
            printf "\r%b[ %b ]      APT:\tAdded apt repository: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$2:$1"
            PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
        else  # if apt repository isn't installed
            kill -9 $SPIN_PID 2>/dev/null
            printf "\r%b[ %b ]      APT:\tAdding apt repository: %s\\n" "${OVERWRITE}" "${FAILURE}" "$2:$1"
        fi
    else  # if application running with `-d` flag
        kill -9 $SPIN_PID 2>/dev/null
        printf "\r%b[ %b ]      APT:\tAdded apt repository: %s (skipped from dry-run)\\n" "${OVERWRITE}" "${DEBUG}" "$2:$1"
        PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
    fi
}

check_apt_repository(){
    TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
    repo="ppa"
    if [ -n "$2" ]; then
        repo="$2"
    fi
    spinner_text "      APT" "Checking apt repository: $repo:$1" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    if apt-cache policy | grep "$1" &>/dev/null; then  # if apt repository is installed
        kill -9 $SPIN_PID 2>/dev/null
        printf "\r%b[ %b ]      APT:\tChecked apt repository: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$repo:$1"
        PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
        SKIP_UPDATE=1
    else  # if apt repository isn't installed
        kill -9 $SPIN_PID 2>/dev/null
        printf "\r%b[ %b ]      APT:\tChecked apt repository: %s (will be installed)\\n" "${OVERWRITE}" "${FAILURE}" "$repo:$1"
        add_apt_repository "$1" "$repo"
    fi
}

check_git_branch(){
    TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
    spinner_text "     GIT" "Checking branch" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    GIT_BRANCH="$SPECIFIED_GIT_BRANCH"
    if [ "$GIT_BRANCH_SPECIFIED" -ne 0 ]; then
	kill -9 $SPIN_PID 2>/dev/null
	printf "\r%b[ %b ]      GIT:\tUsing %s branch\\n" "${OVERWRITE}" "${SUCCESS}" "$GIT_BRANCH"
    elif [ "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)" ]; then  # if a Git branch is detected
        GIT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
        kill -9 $SPIN_PID 2>/dev/null
        printf "\r%b[ %b ]      GIT:\tUsing %s branch\\n" "${OVERWRITE}" "${SUCCESS}" "$GIT_BRANCH"
    else  # if no Git branch is detected
        kill -9 $SPIN_PID 2>/dev/null
        printf "\r%b[ %b ]      GIT:\tUsing %s branch by default\\n" "${OVERWRITE}" "${SUCCESS}" "$GIT_BRANCH"
    fi
    PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
    ANSIBLE_REQUIREMENT_FILE="/tmp/$GIT_BRANCH-requirements.yml"
}

install_ansible_dependencies(){
    for dependency in $1; do
	TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
	spinner_text " ANSIBLE" "Installing requirement: $dependency" &
	[ "$FORCE" ] && flag="--force" || flag=""
	SPIN_PID="$!"
	trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
	if [ "$DRY_RUN" == 0 ]; then  # if application running without `-d` flag
	    sudo -u $SUDO_USER ansible-galaxy install ${flag} -r $ANSIBLE_REQUIREMENT_FILE $dependency &>/dev/null
	    if [ "$?" ]; then  # if requirement successfully installs
	        kill -9 $SPIN_PID 2>/dev/null
	        printf "\r%b[ %b ]  ANSIBLE:\tInstalled requirement: %s\\n" "${OVERWRITE}" "${SUCCESS}" "${dependency}"
	        PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
	    else  # if requirement fails to install
	        kill -9 $SPIN_PID 2>/dev/null
	        printf "\r%b[ %b ]  ANSIBLE:\tInstalling requirement: %s\\n" "${OVERWRITE}" "${FAILURE}" "${dependency}"
	    fi
	else  # if application running with `-d` flag
	    kill -9 $SPIN_PID 2>/dev/null
	    printf "\r%b[ %b ]  ANSIBLE:\tInstalling requirement: %s (skipped from dry-run)\\n" "${OVERWRITE}" "${DEBUG}" "${dependency}"
	    PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
	fi
    done
}

compare_ansible_dependencies(){
    ROLE_REQUIREMENTS="$(grep name /tmp/$GIT_BRANCH-requirements.yml | awk '{print $3}' | paste -sd ' ' -)"
    REQUIRES_INSTALL=""
    [ "$ARGS" != "-f" ] && [ "$ARGS" != "" ] && ROLE_REQUIREMENTS="$ARGS"
    for requirement in $ROLE_REQUIREMENTS; do
	TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
	spinner_text " ANSIBLE" "Checking dependency: $requirement" &
	SPIN_PID="$!"
	trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
	if [ "$FORCE" == 1 ]; then
	    kill -9 $SPIN_PID 2>/dev/null
	    REQUIRES_INSTALL="$REQUIRES_INSTALL$requirement "
	    printf "\r%b[ %b ]  ANSIBLE:\tChecked dependency: %s (force install)\\n" "${OVERWRITE}" "${FAILURE}" "$requirement"
	elif [ "$(sudo -u $SUDO_USER ansible-galaxy role list $requirement 2>/dev/null)" ]; then
	    kill -9 $SPIN_PID 2>/dev/null
	    printf "\r%b[ %b ]  ANSIBLE:\tChecked dependency: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$requirement"
	    PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
	elif [ "$(sudo -u $SUDO_USER ansible-galaxy collection list $requirement 2>/dev/null)" ]; then
	    kill -9 $SPIN_PID 2>/dev/null
	    printf "\r%b[ %b ]  ANSIBLE:\tChecked dependency: %s\\n" "${OVERWRITE}" "${SUCCESS}" "$requirement"
	    PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
	else
	    kill -9 $SPIN_PID 2>/dev/null
	    REQUIRES_INSTALL="$REQUIRES_INSTALL$requirement "
	    printf "\r%b[ %b ]  ANSIBLE:\tChecked dependency: %s (will be installed)\\n" "${OVERWRITE}" "${FAILURE}" "$requirement"
	fi
    done
    [ "$REQUIRES_INSTALL" ] && install_ansible_dependencies "$REQUIRES_INSTALL"
}

check_ansible_dependencies(){
    TOTAL_CHECKS=$(expr "$TOTAL_CHECKS" + 1)
    REQUIREMENT_URL="https://raw.githubusercontent.com/WhaleJ84/ansible-pull/$GIT_BRANCH/requirements.yml"
    spinner_text " ANSIBLE" "Pulling requirements" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    if [[ ! -f "$ANSIBLE_REQUIREMENT_FILE" ]]; then
        if curl "$REQUIREMENT_URL" -so "$ANSIBLE_REQUIREMENT_FILE" &>/dev/null; then  # if requirement file successfully downloads
            kill -9 $SPIN_PID 2>/dev/null
            printf "\r%b[ %b ]  ANSIBLE:\tPulled %s-requirements file\\n" "${OVERWRITE}" "${SUCCESS}" "${GIT_BRANCH}"
            PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
        else
            kill -9 $SPIN_PID 2>/dev/null
            printf "\r%b[ %b ]  ANSIBLE:\tFailed to pull %s-requirements\\n" "${OVERWRITE}" "${FAILURE}" "${GIT_BRANCH}"
        fi
    else
        kill -9 $SPIN_PID 2>/dev/null
        printf "\r%b[ %b ]  ANSIBLE:\tFound %s-requirements file\\n" "${OVERWRITE}" "${SUCCESS}" "${GIT_BRANCH}"
        PASSED_CHECKS=$(expr "$PASSED_CHECKS" + 1)
    fi
    compare_ansible_dependencies
}

check_succcessful_tasks(){
    spinner_text "CHECKING" "Comparing tasks" &
    SPIN_PID="$!"
    trap 'kill -9 "$SPIN_PID"' $(seq 0 15)
    if [ "$TOTAL_CHECKS" == "$PASSED_CHECKS" ]; then
        kill -9 $SPIN_PID 2>/dev/null
        message="Script ran successfully"
    else
        kill -9 $SPIN_PID 2>/dev/null
        message="Rerun script"
    fi
    printf "\r%b[ %b ] COMPLETE:\t%s checks completed of %s. %s\\n" "${OVERWRITE}" "${SUCCESS}" "${PASSED_CHECKS}" "${TOTAL_CHECKS}" "${message}"
}

while getopts b:BdDfhsv arg; do
    case "$arg" in
	b) GIT_BRANCH_SPECIFIED=1 SPECIFIED_GIT_BRANCH="$OPTARG" ;;
        B) BYPASS_CHECKS=1 ;;
        d) DRY_RUN=1 ;;
	D) DEV=1 ;;
        f) FORCE=1 ARGS="${!#}" ;;
        h) usage && exit 0 ;;
        s) supported && exit 0 ;;
	v) echo $VERSION && exit 0 ;;
        ?) usage | head -1 && printf "Try 'duct-tape -h' for more information.\\n" && exit 0 ;;
    esac
done 2>/dev/null

# TODO: Make keyboard interrupts kill script entirely
printf "%s\\n" "$LOGO"
sleep 1
[ $DRY_RUN == 1 ] && printf "[ %b ]    DEBUG:\tRunning in dry run mode           No modifications will be made\\n" "${DEBUG}"

# Check system OS
tested_os_warning

# Check OS verison
tested_version_warning

# Ensure that all the relevant apt dependencies are installed
check_apt_dependencies $PRE_APT_DEPENDENCIES 
check_apt_repository "ansible/ansible"
check_apt_dependencies $APT_DEPENDENCIES 
[ $DEV == 1 ] && check_apt_dependencies $DEV_APT_PACKAGES

# Determine which Duct-tape git branch to pull ansible requirements from
check_git_branch

# Ensire the relevant ansible dependencies are installed
check_ansible_dependencies

# Inform user of number of successful tasks
check_succcessful_tasks

printf "[ %b ] COMPLETE:\tTo continue configuring system, run:\\nexport PY_COLORS='1' ANSIBLE_FORCE_COLOR='1' && \\\\\nansible-pull -KU https://github.com/WhaleJ84/ansible-pull.git\\n" "${SUCCESS}"
printf "[ %b ]      TIP:\tSee README on how to configure specific applications\\n" "${SUCCESS}"
