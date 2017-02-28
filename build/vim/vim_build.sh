#!/bin/bash -ex

source ./get_os_info.sh

# エラー用 echo [赤・太字]
function echo_error_ { echo -e "\e[1;31m$*\e[m"; }
function echo_success_ { echo -e "\e[1;32m$*\e[m"; }

# =============================================================================
# env
# =============================================================================
_apt_install() {
    # require package install
    sudo apt-get -y build-dep vim

    if [ $? -ne 0 ]; then
        echo_error_ "apt-get build-dep vim failed"
        exit 0
    fi

    sudo apt-get -y install --no-install-recommends \
        libpython2.7-dev \
        lua5.1 \
        liblua5.1-dev \
        luajit \
        libluajit-5.1 \
        libclang-3.5-dev \
        exuberant-ctags

    if [ $? -ne 0 ]; then
        echo_error_ "apt-get install failed"
        exit 0
    fi
}

_yum_install() {
    sudo yum -y install \
        gcc \
        ncurses-devel \
        python-devel \
        ruby-devel \
        lua-devel \
        luajit-devel
}

_update_env() {
    case $(_get_os_distribution) in
        ubuntu|debian)
            _apt_install
            if [ $(_get_os_bit) = "i686" ]; then
                python_config=/usr/lib/python2.7/config-i386-linux-gnu
            else
                python_config=/usr/lib/python2.7/config-x86_64-linux-gnu
            fi
            ;;
        redhat|fedora)
            _yum_install
            if [ $(_get_os_bit) = "i686" ]; then
                python_config=/usr/lib/python2.7/config
            else
                python_config=/usr/lib64/python2.7/config
            fi
            ;;
        *)
            echo $(_get_os_distribution) $(_get_os_bit)
            echo "unsupported distribution"
    esac
}

# =============================================================================
# main
# =============================================================================
_main() {
    _update_env

    if [ ! -e ./vim ]; then
        git clone -b master --single-branch --depth=1 https://github.com/vim/vim.git
        if [ $? -ne 0 ]; then
            echo_error_ "git clone vim failed"
            exit 0
        fi
    fi

    cd ./vim

    # configure
    ./configure \
        --with-features=huge \
        --enable-multibyte \
        --enable-gui=gtk2 \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --with-python-config-dir=${python_config} \
        --enable-luainterp \
        --with-lua-prefix=/usr --with-luajit \
        --enable-gpm \
        --enable-cscope \
        --enable-fontset \
        --enable-fail-if-missing

    if [ $? -ne 0 ]; then
        echo_error_ "configure failed"
        exit 0
    fi

    # build
    make -j8

    if [ $? -ne 0 ]; then
        echo_error_ "make failed"
        exit 0
    fi

    # install
    sudo make install

    echo_success_ "success to install vim"
}

# =============================================================================
_main
