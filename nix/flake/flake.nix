{
    description = "flake to create a live usb, including a graphical installer and useful tools";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    outputs =
        inputs@{
            self,
            nixpkgs,
            ...
        }:
        let
            hostname = "nixos";
        in
        {
            nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ../config/programs.nix
                    ../config/gnome.nix
                    ../config/locale.nix
                    {
                        networking.hostName = hostname;
                        nix.settings.experimental-features = [
                            "nix-command"
                            "flakes"
                        ];

                        # GUI installer with Gnome DE
                        imports = [
                            (nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix")
                        ];

                        # QoL
                        services.getty.autologinUser = nixpkgs.lib.mkDefault "nixos";
                        users.users.nixos.extraGroups = nixpkgs.lib.mkAfter [ "wheel" ];
                    }
                ];
            };
        };
}
