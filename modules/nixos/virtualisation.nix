{ pkgs, ... }:

{
  # Rootless Docker — daemon runs as ryan, no root socket exposed.
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true; # sets DOCKER_HOST in the user session
  };

  # KVM/QEMU via libvirt with virt-manager frontend.
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;  # TPM 2.0 emulation for Windows VMs
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = [ pkgs.distrobox ];

  # KVM kernel module — Lenovo Yoga 7-14ARH7 has an AMD Ryzen CPU.
  boot.kernelModules = [ "kvm-amd" ];

  users.users.ryan.extraGroups = [ "libvirtd" "kvm" ];
}
