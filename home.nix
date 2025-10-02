{inputs, pkgs, ...}:
{
    home.username = "odnwum";
    home.homeDirectory = "/home/odnwum";
    home.stateVersion = "24.05";

    programs.home-manager.enable = true;

    programs.alacritty = {
        enable = true;
        settings = {
            window = {
                opacity = 1.0;
                position = {
                    x = 0;
                    y = 0;
                };
                padding = {
                    x = 2;
                    y = 2;
                };
                dynamic_padding = true;
                decorations = "None";
            };
       };
    };

    programs.git = {
        enable = true; 
        extraConfig = {
            init.defaultBranch = "main";
        };
    };

        # Notifications 
        services.mako = {
                enable = true;
                settings = {
                        default-timeout = 5000;
                        background-color = "#1e1e2e";
                        border-color = "#89b4fa";
                        text-color = "#cdd6f4";
                        border-size = 2;
                        font = "JetBrainsMono Nerd Font 10";
                        icons = true;

                };
        };
        
        home.packages = with pkgs; [
                libnotify
];

    programs.waybar = {
	enable = true;
	settings = {
	    mainBar = {
		layer = "top";
		position = "top";
		
		# modules in place 
		modules-left = ["battery" "network" "bluetooth" "tray"];
		modules-center = ["hyprland/workspaces"];
		modules-right = ["cpu" "memory" "clock"];


		# battery settings 
		"battery" = {
                states = {
                    good = 80;
                    warning = 30;
                    critical = 15;
                };
                format = "{capacity}% {icon}";
                format-charging = "{capacity}% 󰂉";
                format-plugged = "{capacity}% ";
                format-alt = "{time} {icon}";
                # format-good = ""; # An empty format will hide the module
                # f -full = "";
                format-icons = ["󰂎" "󰁼" "󰁾" "󰂀" "󰁹"];
                };

		# hyprland workspaces settings 
		"hyprland/workspaces" = {
			"persistent-workspaces" = {
				"*"= 5;
			};
			"format" = "{name}";
		};
	    };
        };
      style = ''
        * {
                border: none;
                padding: 0;
                margin: 2;
                font-family: "JetBrainsMono Nerd Font", sans-serif;
                font-size: 13px;
        }

        window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
        }

        #clock {
        padding: 0 10px;
        }
        '';
    };

    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable =true;
        settings = {
            bind = [
	    	# Overall hotkeys 
                "SUPER, T, exec, alacritty" # launch alacritty 
            	"SUPER, S, exec, rofi -show drun -show-icons"  # Launches rofi app launcher
	    	"SUPER, Q, killactive" # Kill active window 
		
		# Function keys 
                # Brightness
		", XF86MonBrightnessUp, exec, brightnessctl set +5%"
		", XF86MonBrightnessDown, exec, brightnessctl set 5%- -n 1"
	
                # Volume
                ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

		# Workspace 
		"SUPER, 1, workspace, 1" # Switch to workspace 1
		"SUPER, 2, workspace, 2" # Switch to workspace 2 
		"SUPER, 3, workspace, 3" # Switch to workspace 3
                "SUPER, 4, workspace, 4" 
                "SUPER, 5, workspace, 5"

		"SUPER_SHIFT, 1, movetoworkspace, 1" # Move active window to workspace 1
		"SUPER_SHIFT, 2, movetoworkspace, 2" # Move active window to workspace 2
		"SUPER_SHIFT, 3, movetoworkspace, 3" # Move active window to workspace 3
                "SUPER_SHIFT, 4, movetoworkspace, 4"
                "SUPER_SHIFT, 5, movetoworkspace, 5"

		"SUPER_SHIFT, H, movewindow, l"  # Move window left
    		"SUPER_SHIFT, L, movewindow, r"  # Move window right
   		"SUPER_SHIFT, K, movewindow, u"  # Move window up
   		"SUPER_SHIFT, J, movewindow, d"  # Move window down

		"SUPER_SHIFT, left, swapwindow, l"
    		"SUPER_SHIFT, right, swapwindow, r"
    		"SUPER_SHIFT, up, swapwindow, u"
  	  	"SUPER_SHIFT, down, swapwindow, d"

		# Configure screen shot 
		", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"

                # Lock screen via mod L 
                "SUPER, L, exec, hyprlock"

                # Sleep system via super shift L 
                "SUPER_SHIFT, L, exec, systemctl suspend" 

            
	    ];
            monitor = "eDP-1, 1920x1080@60, 0x0, 1";
	    input = {
		  touchpad = {
		  	natural_scroll = true;
			scroll_factor = 0.75;
	          };
	    };
	exec-once = "sh ./scripts/start.sh";
	};
    };
}
