#!/usr/bin/env fish

function setup-kernel
    pkgctl repo clone --protocol=https linux
    cd linux
    git clone --depth 1 https://github.com/Kronosthemad/kronos-linux
    cp config ./kronos-linux/.config
    cd kronos-linux
    make prepare
    make menuconfig
end
