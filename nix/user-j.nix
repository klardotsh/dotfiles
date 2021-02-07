{ lib, pkgs, ... }:
{
  # broken? conflicting definitions error when uncommented
  # fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    # since a lot of my projects use Makefiles as general-purpose entrypoints,
    # let's just install that now
    gnumake

    # misc term accessories
    fzf
    zsh # not using programs.zsh to preserve my current zshrc?

    # "DE"
    grim
    mako
    qt5.qtwayland
    slurp
    sway-contrib.grimshot
    swaylock
    waybar
    wofi

    # rock and roll ain't noise pollution
    pulsemixer

    # network-related
    aria2 # rarely used but *shrug*
    curl
    httpie
    picocom
    tremc
    youtube-dl

    # chat
    nheko
  ];

  programs.alacritty = {
    enable = true;
    # there's real nix support for this, but I am too lazy to port it right now.
    # instead, this file was generated from my old alacritty.yml with:
    #
    # yj < .config/alacritty/alacritty.yml | json_pp  > non-nix-configs/alacritty.json
    settings = lib.importJSON ../non-nix-configs/alacritty.json;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
  };

  programs.direnv.enable = true;

  programs.firefox = {
    enable = true;
    profiles = {
      myprofile = {
        settings = {
          "accessibility.typeaheadfind.flashBar" = 0;
          "general.smoothScroll" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.peerconnection.video.use_rtx" = false;
          # ^ is this still needed? was originally there to work around an
          # obnoxious jitsi bug
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

  programs.kakoune = {
    enable = true;

    config = {
      keyMappings = [
        {
          docstring = "buffer back";
          mode = "normal";
          key = "<c-p>";
          effect = ":buffer-previous<ret>";
        }
        {
          docstring = "buffer next";
          mode = "normal";
          key = "<c-n>";
          effect = ":buffer-next<ret>";
        }
        {
          docstring = "lsp hover";
          mode = "normal";
          key = "<c-k>";
          effect = ":lsp-hover<ret>";
        }
      ];
    };

    plugins = [
      pkgs.kakounePlugins.kak-fzf
      pkgs.kak-lsp
    ];
  };

  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      gpu-context = "wayland";
      hwdec = "vaapi";
    };
  };

  programs.newsboat = {
    enable = true;
    urls = lib.importJSON ../non-nix-configs/newsboat-urls.json;
    autoReload = true;

    extraConfig = builtins.readFile ../non-nix-configs/newsboat-extra.conf;
  };

  programs.tmux.enable = true;

  programs.zathura = {
    enable = true;
    # I used to theme this with pywal, but now that I don't use wal for theming,
    # I guess stock config is fine?
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  services.lorri.enable = true;

  wayland.windowManager.sway = {
    enable = true;

    extraSessionCommands = ''
      export XDG_SESSION_TYPE=wayland

      export SDL_VIDEODRIVER=wayand
      export QT_QPA_PLATFORM=wayland-egl
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONREPARENTING=1

      export MOZ_ENABLE_WAYLAND=1
      export MOZ_WAYLAND_USE_VAAPI=1
      export MOZ_USE_XINPUT2=1
    '';

    wrapperFeatures.gtk = true;
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
  };
  xdg.userDirs.enable = true;
}
