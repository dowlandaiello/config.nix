{ pkgs, ... }:

{
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavour = "mocha";
      accent = "yellow";
      size = "standard";
      tweaks = [ "normal" ];      
    };
  };
}