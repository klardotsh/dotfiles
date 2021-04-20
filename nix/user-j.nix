let
  swayModifier = "Mod4";
in
{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    # since a lot of my projects use Makefiles as general-purpose entrypoints,
    # let's just install that now
    gnumake

    # for now, I use niv quite a bit for nix projects (eventually I'll move
    # them off to flakes, but until then...)
    niv
    cachix

    # misc term accessories
    fzf
    ripgrep
    fd
    sd

    # "DE"
    grim
    slurp
    sway-contrib.grimshot
    swaylock
    wl-clipboard
    wofi
    qt5.qtwayland
    libsForQt5.qtstyleplugin-kvantum

    # rock and roll ain't noise pollution
    cmus
    pulsemixer

    # network-related
    aria2 # rarely used but *shrug*
    curl
    httpie
    picocom
    tremc
    youtube-dl

    # chat
    discord
    nheko
    zoom-us

    # games
    multimc

    # VM stuff
    qemu
    virt-viewer
  ];

  gtk = {
    enable = true;
    font = {
      package = pkgs.paratype-pt-sans;
      name = "PT Sans 11";
    };
    theme = {
      package = pkgs.shades-of-gray-theme;
      name = "Shades-of-gray-Firebrick";
    };
  };

  programs.alacritty = {
    enable = true;
    # there's real nix support for this, but I am too lazy to port it right now.
    # instead, this file was generated from my old alacritty.yml with:
    #
    # yj < .config/alacritty/alacritty.yml | json_pp  > non-nix-configs/alacritty.json
    settings = lib.importJSON ../non-nix-configs/alacritty.json;
  };

  /*
  programs.chromium = {
    enable = true;
    package = (pkgs.ungoogled-chromium.override {
      enableVaapi = true;
    });
    extensions = [
      "gcbommkclmclpchllfjekcdonpmejbdp" # https everywhere
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
      "ogfcmafjalglgifnmanfmnieipoejdcf" # umatrix
      "eimadpbcbfnmbkopoojfekhnkhdbieeh" # dark reader
      "jnofiabkigekemighcdaejlpgdhmbaog" # simple auto hd youtube
      "clngdbkpkpeebahjckkjfobafhncgmne" # stylus
      "nngceckbapebfimnlniiiahkandclblb" # bitwarden
      "ihlenndgcmojhcghmfjfneahoeklbjjh" # cvim
    ];
  };
  */

  programs.direnv.enable = true;

  programs.firefox = {
    enable = true;
    profiles = {
      myprofile = {
        settings = {
          "accessibility.typeaheadfind.flashBar" = 0;
          "general.smoothScroll" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.peerconnection.video.vp9_preferred" = true;
        };
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Josh Klar";
    userEmail = "josh@klar.sh";
    signing.key = "josh@klar.sh";
    lfs.enable = true;

    extraConfig = {
      # TODO: determine if this is still needed
      # gpg.program = "/home/j/bin/gpg";

      commit.gpgsign = true;
      fetch.prune = true;
      pull.rebase = true;
      push.default = "current";
      rerere.enabled = true;
      url."git@gitlab.com:".insteadOf = "https://gitlab.com/";

      alias = {
        # These yanked straight outta
        # https://hackernoon.com/lesser-known-git-commands-151a1918a60#.47hyswh0f
        please = "push --force-with-lease";
        shorty = "status --short --branch";

        # http://gitready.com/intermediate/2009/02/18/temporarily-ignoring-files.html#comment-247215295
        ignore = "!git update-index --assume-unchanged";
        unignore = "!git update-index --no-assume-unchanged";
        ignored = "!git ls-files -v | grep ^[a-z]";

        # https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
        ll = "log --graph --format=\"%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)\"";

        # And now either my own stuff, or stuff I adopted from sources I've long since forgotten
        lol = "log --format='%Cred%h%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset%C(yellow)%d%Creset' --no-merges";
        # "cram" a file into the last commit. This is my "oh shit, forgot a migration" button
        cram = "commit --amend --no-edit";
        # default branch = "main"
        initt = "!git init && echo \"ref: refs/heads/main\" > .git/HEAD";
      };
    };
  };

  programs.home-manager.enable = true;

  programs.htop = {
    enable = true;
    sortKey = "PERCENT_MEM";
    hideThreads = false;
    hideKernelThreads = true;
    treeView = false;
    colorScheme = 6;
    showCpuFrequency = true;
    showThreadNames = true;
    shadowOtherUsers = true;

    meters = {
      left = [
        "LeftCPUs2"
        "Blank"
        "Memory"
        "Swap"
      ];

      right = [
        "RightCPUs2"
        "Tasks"
        "LoadAverage"
        "Uptime"
      ];
    };
  };

  programs.jq.enable = true;

  programs.mako = {
    enable = true;
    layer = "overlay";
    ignoreTimeout = true;
    defaultTimeout = 7000;
    markup = true;

    font = "sans-serif 11";
    backgroundColor = "#222222";
    textColor = "#c1c1c1";
    borderColor = "#c1c1c1";
    borderRadius = 5;
    padding = "10";
  };

  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      gpu-context = "wayland";
      hwdec = "vaapi";
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      editorconfig-vim

      vim-nix

      {
        plugin = vim-terraform;
        config = builtins.readFile ../non-nix-configs/terraform.vim;
      }

      vim-toml
      vim-javascript-syntax
      yats-vim

      dhall-vim
      vim-cue

      lightline-vim
      vim-better-whitespace

      # the junegunn section
      fzf-vim

      {
        plugin = rainbow_parentheses-vim;
        config = builtins.readFile ../non-nix-configs/rainbow-parentheses.vim;
      }

      # the tpope section
      vim-fugitive
      vim-markdown
      vim-surround
      vim-repeat
      vim-commentary

      vim-gitgutter

      {
        plugin = ale;
        config = builtins.readFile ../non-nix-configs/ale.vim;
      }

      {
        plugin = coc-nvim;
        config = builtins.readFile ../non-nix-configs/coc-nvim.vim;
      }
      coc-json
      #coc-pyright
      coc-python
      coc-rls
      coc-tsserver
      coc-yaml
    ];

    extraConfig = builtins.readFile ../non-nix-configs/nvim.vim;
  };

  programs.newsboat = {
    enable = true;
    urls = lib.importJSON ../non-nix-configs/newsboat-urls.json;
    autoReload = true;

    extraConfig = builtins.readFile ../non-nix-configs/newsboat-extra.conf;
  };

  /*
  programs.qutebrowser = {
    enable = true;
    settings = {
      auto_save.session = true;

      colors.webpage = {
        prefers_color_scheme_dark = true;
        darkmode = {
          enabled = true;
          threshold.background = 100;
          threshold.text = 256;
          policy.images = "never"; # or "smart"?
        };
        bg = "#000000";
      };

      content.cache.appcache = true;
      content.dns_prefetch = true;

      fonts.default_family = "PT Sans";
    };
    keyBindings = {
      normal = {
        "<Ctrl-v>" = "spawn mpv {url}";
      };
    };
  };
  */

  programs.tmux.enable = true;

  programs.zathura = {
    enable = true;
    # I used to theme this with pywal, but now that I don't use wal for theming,
    # I guess stock config is fine?
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    initExtra = builtins.readFile ../non-nix-configs/init-extra.sh;

    initExtraBeforeCompInit = ''
      setopt appendhistory autocd beep extendedglob notify promptsubst hist_ignore_dups hist_ignore_space noflowcontrol PROMPT_SUBST
      autoload -Uz colors && colors
      zstyle :compinstall filename \$HOME/.zshrc
      source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
    '';

    history = {
      size = 10000;
      save = 10000;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      sudo="${pkgs.doas}/bin/doas ";

      todo="todo.sh -d \${HOME}/.todo/todo.cfg";
      t="todo";

      e="\$EDITOR";
      v="\$EDITOR";
      m="${pkgs.mosh}/bin/mosh";
      mux="tmux.sh \$(hostname)";
      glowpage="${pkgs.glow}/bin/glow -p";

      nmap-quickscan="sudo ${pkgs.nmap}/bin/nmap -sV -T4 -O -F --version-light";

      df="df -h -x devtmpfs -x rootfs -x tmpfs";
      cp="cp -iv";
      mv="mv -iv";
      rm="rm -iv";
      chmod="chmod -c";
      chown="chown -c";
      grep="grep --colour=auto";
      egrep="egrep --colour=auto";
      ls="ls --color=auto --human-readable --group-directories-first --classify";
      tree="${pkgs.tree}/bin/tree -CA";

      gl="${pkgs.git}/bin/git lol";
      gls="${pkgs.git}/bin/git lol --since '2 weeks' --author 'Josh Klar'";
      gca="${pkgs.git}/bin/git cram"; # Muscle memory dies hard - this is NOT git commit -a

      diff="${pkgs.colordiff}/bin/colordiff -Nuar";
    };

    sessionVariables = {
      PROMPT="(%m) %c %F{cyan} \$(__git_ps1 '» %s ')» %{\$reset_color%}%";

      GPG_TTY="\$(tty)";
      SSH_AUTH_SOCK="$${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh";
      TERMINAL="alacritty";
      EDITOR="nvim";
      BROWSER="xdg-open";
      LANG="en_US.utf8";

      IBUS_ENABLE_CTRL_SHIFT_U=1;
      XMODIFIERS="@im=ibus";

      AWS_SDK_LOAD_CONFIG=true;
      AWS_VAULT_BACKEND="file";
      FZF_DEFAULT_COMMAND="${pkgs.ripgrep}/bin/rg --files --hidden";

      XDG_CONFIG_HOME="\${HOME}/.config";
      LESS="-r";
    };
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  services.lorri.enable = true;

  wayland.windowManager.sway = {
    enable = true;

    config = {
      bars = [];
      startup = [
        {
          # systemctl --user restart waybar is currently broken for reasons I'm
          # not totally sure of (dbus claims to not be running a user bus)
          # soooooooo
          command = "${pkgs.killall}/bin/killall -r waybar; ${pkgs.waybar}/bin/waybar";
          always = true;
        }
      ];
      gaps = {
        inner = 8;
        outer = 8;
      };
      modifier = swayModifier;
      keybindings = {
        "${swayModifier}+Shift+c" = "reload";
        "${swayModifier}+Return" = "exec alacritty";
        "${swayModifier}+Space" = "exec ${pkgs.wofi}/bin/wofi -Imi -t alacritty --show drun,run -p 'Run:'";
        "${swayModifier}+h" = "focus left";
        "${swayModifier}+l" = "focus right";
        "${swayModifier}+j" = "focus down";
        "${swayModifier}+k" = "focus up";
        "${swayModifier}+Shift+h" = "move left";
        "${swayModifier}+Shift+l" = "move right";
        "${swayModifier}+Shift+j" = "move down";
        "${swayModifier}+Shift+k" = "move up";
        "${swayModifier}+Control+h" = "move workspace to output left";
        "${swayModifier}+Control+left" = "move workspace to output left";
        "${swayModifier}+Control+l" = "move workspace to output right";
        "${swayModifier}+Control+right" = "move workspace to output right";
        "${swayModifier}+Control+j" = "move workspace to output down";
        "${swayModifier}+Control+down" = "move workspace to output down";
        "${swayModifier}+Control+k" = "move workspace to output up";
        "${swayModifier}+Control+up" = "move workspace to output up";
        "${swayModifier}+1" = "workspace 1";
        "${swayModifier}+2" = "workspace 2";
        "${swayModifier}+3" = "workspace 3";
        "${swayModifier}+4" = "workspace 4";
        "${swayModifier}+5" = "workspace 5";
        "${swayModifier}+6" = "workspace 6";
        "${swayModifier}+7" = "workspace 7";
        "${swayModifier}+8" = "workspace 8";
        "${swayModifier}+9" = "workspace 9";
        "${swayModifier}+0" = "workspace 10";
        "${swayModifier}+Shift+1" = "move container to workspace 1";
        "${swayModifier}+Shift+2" = "move container to workspace 2";
        "${swayModifier}+Shift+3" = "move container to workspace 3";
        "${swayModifier}+Shift+4" = "move container to workspace 4";
        "${swayModifier}+Shift+5" = "move container to workspace 5";
        "${swayModifier}+Shift+6" = "move container to workspace 6";
        "${swayModifier}+Shift+7" = "move container to workspace 7";
        "${swayModifier}+Shift+8" = "move container to workspace 8";
        "${swayModifier}+Shift+9" = "move container to workspace 9";
        "${swayModifier}+Shift+0" = "move container to workspace 10";
        "${swayModifier}+f" = "fullscreen";
        "${swayModifier}+Shift+space" = "floating toggle";
        "${swayModifier}+b" = "splith";
        "${swayModifier}+v" = "splitv";
        "${swayModifier}+r" = "mode resize";
      };
      output = {
        "*" = { bg = "~/.wallpaper fill"; };
      };
    };

    extraConfig = ''
      # Eliminate titlebars
      for_window [title="^.*"] border pixel 1
      for_window [title="Firefox - Sharing Indicator"] floating enable
      # ^ seems to have stopped working in v84 because of course it did
      for_window [shell="xwayland"] title_format "%title [XWayland]"
    '';

    extraSessionCommands = ''
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland

      export BEMENU_BACKEND=wayland
      export CLUTTER_BACKEND=wayland
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland-egl
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export QT_QPA_PLATFORMTHEME=qt5ct
      export QT_STYLE_OVERRIDE=kvantum
      export QT_IM_MODULE=ibus
      export _JAVA_AWT_WM_NONREPARENTING=1
      export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'
      export GTK_CSD=0
      # export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
      export GTK_IM_MODULE=ibus

      export MOZ_ENABLE_WAYLAND=1
      export MOZ_WAYLAND_USE_VAAPI=1
      export MOZ_USE_XINPUT2=1
    '';

    wrapperFeatures.gtk = true;
  };

  programs.waybar = {
    enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 24;
      # gtk-layer-shell = true;

      modules-left = [
        "sway/workspaces"
        "sway/mode"
      ];
      modules-center = [
        "sway/window"
      ];
      modules-right = [
        "custom/weather"
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "battery"
        "tray"
        "clock"
      ];

      modules = {
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons =  {
            urgent = "";
            focused = "";
            default = "";
          };
        };

        "sway/mode" = {
          format = "<span style=\"italic\">{}</span>";
        };

        tray = {
          # icon-size = 21;
          spacing = 2;
        };

        clock = {
          format = "{:%a %d %b  %H:%M}";
        };

        cpu = {
            format = "{usage}% ";
        };
        memory = {
            format = "{}% ";
        };
        battery = {
          bat = "BAT0";
          states = {
            # good = 95;
            warning = 25;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          # format-good = ""; # An empty format will hide the module
          # format-full = "";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        network = {
          # "interface" = "wlp2s0"; // (Optional) To force the use of this interface
          format-wifi = "{essid} ";
          format-ethernet = "{ipaddr} ";
          format-disconnected = "Disconnected ⚠";
        };
        pulseaudio = {
          # scroll-step = 1;
          format = "{volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
              headphones = "";
              handsfree = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
              ];
          };
          on-click = "alacritty -e ${pkgs.pulsemixer}/bin/pulsemixer";
        };
        "custom/weather" = {
          format = "{}";
          format-alt = "{alt} = {}";
          format-alt-click = "click-right";
          interval = 1800;
          return-type = "json";
          exec = "~/bin/weather-waybar.sh";
          exec-if = "ping -c1 wttr.in";
        };
      };
    }];

    style = builtins.readFile ../non-nix-configs/waybar.css;
    systemd.enable = true;
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
  };
  xdg.userDirs.enable = true;
}
