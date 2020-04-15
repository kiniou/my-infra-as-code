packages:
  pkgs:
    wanted:
      - ark
      - bambam
      - bluez-hcidump
      - brightnessctl
      - dunst
      - feh
      - ffmpeg
      - filezilla
      - fonts-dejavu-core
      - fonts-f500
      - fonts-noto
      - fonts-symbola
      - konsole
      - ksshaskpass
      - plasma-desktop
      - polkit-kde-agent-1
      - pulseaudio-utils
      - sddm
      - gwenview
      - ibus
      - keepassxc
      - mesa-utils
      - mesa-utils-extra
      - mpv
      - qdbus
      - suckless-tools
      - timewarrior
      - vulkan-tools
      - vulkan-utils
      - webp
      - wpagui
      - xmms2
      - xmms2-client-nycli
      - xorg
      - xserver-xorg-input-evdev
      - xserver-xorg-input-kbd
      - xserver-xorg-input-mouse
      {% if grains['os'] == 'Ubuntu' %}
      - firefox
      {% elif grains['os'] == 'Debian' %}
      - firefox-esr
      {% endif %}
