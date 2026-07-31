# NIXOS
cd /etc/nixos/
git clone https://github.com/kuntvvdakwsyn/NIXOS
cd NIXOS
cp configuration.nix flake.nix home.nix ../
cd ..
rm -rf NIXOS
git add -A 
sudo nixos-rebuild switch
