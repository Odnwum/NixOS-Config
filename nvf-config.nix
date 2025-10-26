{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.nvf = {
    enable = true;

    settings.vim = {
      theme = {
        enable = true;
        style = "darker";
      };

      statusline.lualine.enable = true; # Status line
      telescope.enable = true; # Fuzzy finder
      git.enable = true; # Git integration

      snippets.luasnip.enable = true; # Snippets engine

      autocomplete."nvim-cmp".enable = true;

      languages = {
        enableTreesitter = true;
        nix.enable = true;
        python.enable = true;
      };

      lsp = {
        enable = true;
        servers = {
          pyright.enable = true; # Python LSP
        };
      };
    };
  };
}
