{inputs,...}:
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
                    # good = 95;
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
				"*"= 3;
			};
			"format" = "{name}";
		};
	};
      };
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
		", XF86MonBrightnessUp, exec, brightnessctl set +5%"
		", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
	
		# Workspace 
		"SUPER, 1, workspace, 1" # Switch to workspace 1
		"SUPER, 2, workspace, 2" # Switch to workspace 2 
		"SUPER, 3, workspace, 3" # Switch to workspace 3

		"SUPER_SHIFT, 1, movetoworkspace, 1" # Move active window to workspace 1
		"SUPER_SHIFT, 2, movetoworkspace, 2" # Move active window to workspace 2
		"SUPER_SHIFT, 3, movetoworkspace, 3" # Move active window to workspace 3

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

            
	    ];
            monitor = "eDP-1, 1920x1080@60, 0x0, 1";
	    input = {
		  touchpad = {
		  	natural_scroll = true;
			scroll_factor = 0.75;
	          };
	    };
	exec-once = "sh ~/programConfig/start.sh";
	};
    };
}
