{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', system, ... }: {
    packages.myHiddify = import ../../packages/hiddify.nix { inherit pkgs; };
    packages.myNiri =
    let
      pkgsUnstable = import inputs.nixpkgs-unstable {
        inherit system;
      };
    in
    inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      package = lib.mkForce pkgsUnstable.niri;
      passthru = {
        providedSessions = [ "niri" ];
      };
      settings = {
        spawn-at-startup = [
          [ (lib.getExe self'.packages.myNoctalia) ]
          [ (lib.getExe self'.packages.myHiddify) ]
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
          keyboard.xkb.layout = "us,ru";
          keyboard.xkb.options = "grp:alt_shift_toggle,caps:escape";

          keyboard.repeat-rate = 40;
          keyboard.repeat-delay = 250;
        };

        layout = {
          gaps = 5;

          focus-ring = {
            width = 2;
            active-color = "#fe8019";
          };
        };

        binds = {
          "Mod+Shift+Slash".show-hotkey-overlay = null;
          "Mod+Return".spawn-sh = lib.getExe pkgs.alacritty;
          "Mod+Q".close-window = null;
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+D".spawn-sh = lib.getExe pkgs.fuzzel;
          "Ctrl+Alt+L".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call lockScreen lock";
          "Mod+O".toggle-overview = null;
          "Print".screenshot = null;

          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-";

          "Mod+F".maximize-column = null;
          "Mod+G".fullscreen-window = null;
          "Mod+V".toggle-window-floating = null;
          "Mod+C".center-column = null;
          "Mod+Ctrl+C".center-visible-columns = null;

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";

          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Mod+W".toggle-column-tabbed-display = null;

          "Mod+H".focus-column-left = null;
          "Mod+L".focus-column-right = null;
          "Mod+K".focus-window-up = null;
          "Mod+J".focus-window-down = null;

          "Mod+Left".focus-column-left = null;
          "Mod+Right".focus-column-right = null;
          "Mod+Up".focus-window-up = null;
          "Mod+Down".focus-window-down = null;

          "Mod+Ctrl+Left".move-column-left = null;
          "Mod+Ctrl+Down".move-window-down = null;
          "Mod+Ctrl+Up".move-window-up = null;
          "Mod+Ctrl+Right".move-column-right = null;
          "Mod+Ctrl+H".move-column-left = null;
          "Mod+Ctrl+J".move-window-down = null;
          "Mod+Ctrl+K".move-window-up = null;
          "Mod+Ctrl+L".move-column-right = null;

          "Mod+Home".focus-column-first = null;
          "Mod+End".focus-column-last = null;
          "Mod+Ctrl+Home".move-column-to-first = null;
          "Mod+Ctrl+End".move-column-to-last = null;


          "Mod+Page_Down".focus-workspace-down = null;
          "Mod+Page_Up".focus-workspace-up = null;
          "Mod+U".focus-workspace-down = null;
          "Mod+I".focus-workspace-up = null;
          "Mod+Ctrl+Page_Down".move-column-to-workspace-down = null;
          "Mod+Ctrl+Page_Up".move-column-to-workspace-up = null;
          "Mod+Ctrl+U".move-column-to-workspace-down = null;
          "Mod+Ctrl+I".move-column-to-workspace-up = null;

          "Mod+Shift+Page_Down".move-workspace-down = null;
          "Mod+Shift+Page_Up".move-workspace-up = null;
          "Mod+Shift+U".move-workspace-down = null;
          "Mod+Shift+I".move-workspace-up = null;

          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+6".focus-workspace = 6;
          "Mod+7".focus-workspace = 7;
          "Mod+8".focus-workspace = 8;
          "Mod+9".focus-workspace = 9;
          "Mod+0".focus-workspace = 10;

          "Mod+Ctrl+1".move-column-to-workspace = 1;
          "Mod+Ctrl+2".move-column-to-workspace = 2;
          "Mod+Ctrl+3".move-column-to-workspace = 3;
          "Mod+Ctrl+4".move-column-to-workspace = 4;
          "Mod+Ctrl+5".move-column-to-workspace = 5;
          "Mod+Ctrl+6".move-column-to-workspace = 6;
          "Mod+Ctrl+7".move-column-to-workspace = 7;
          "Mod+Ctrl+8".move-column-to-workspace = 8;
          "Mod+Ctrl+9".move-column-to-workspace = 9;
          "Mod+Ctrl+0".move-column-to-workspace = 10;
        };
      };
    };
  };
}
