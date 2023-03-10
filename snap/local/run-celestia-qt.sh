#!/bin/sh

case "$SNAP_ARCH" in
    "amd64") ARCH='x86_64-linux-gnu'
    ;;
    "i386") ARCH='i386-linux-gnu'
    ;;
    "amd64") ARCH='aarch64-linux-gnu'
    ;;
    *)
        echo "Unsupported architecture for this app build"
        exit 1
    ;;
esac

# Tell libGL where to find the drivers
if [ -e "/var/lib/snapd/lib/gl/xorg/nvidia_drv.so" ]; then
    # special case for nvidia
    export LIBGL_DRIVERS_PATH=/var/lib/snapd/lib/gl/xorg
    export LD_LIBRARY_PATH=/var/lib/snapd/lib/gl:$LD_LIBRARY_PATH
else
    export LIBGL_DRIVERS_PATH=$SNAP/usr/lib/$ARCH/dri
fi

exec $SNAP/usr/bin/celestia-qt "$@"
