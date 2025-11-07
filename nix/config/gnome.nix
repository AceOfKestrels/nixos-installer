{ pkgs, ... }:
{
    environment.gnome.excludePackages = with pkgs; [
        atomix
        cheese
        geary
        gnome-tour
        hitori
        iagno
        tali
        gnome-calendar
        gnome-maps
        gnome-weather
        gnome-contacts
    ];
}
