{config, pkgs, lib, ...}: 

{
  programs.nvf = {
	enable = true;
        
         settings = {
                vim = {
                        theme = {
                                enable = true;
                                # name = "gruvbox"; 
                                style = "dark";
                        };

                        statusline.lualine.enable = true; # Status line
                        telescope.enable = true; # Fuzzy finder 
                        autocomplete.nvim-cmp.enable = true; # Autocomplete

                        languages = {
                                enableTreesitter = true;

                                nix.enable =true;
                        };

                        lsp = {
                                enable = true;
                        };
                };
        };

  };
}
