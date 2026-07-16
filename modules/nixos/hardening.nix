{ pkgs, ... }:

{
  # Mandatory access control. NixOS' SELinux support isn't usable yet
  # (unmerged/experimental, see nixpkgs PR #396177) so AppArmor is the
  # practical MAC layer for now — swap this out if/when SELinux lands.
  security.apparmor = {
    enable = true;
    killUnconfinedConfinables = true;
    packages = [ pkgs.apparmor-profiles ];
  };

  networking.firewall.enable = true;

  # Only members of "wheel" may use sudo, even if listed elsewhere.
  security.sudo.execWheelOnly = true;

  security.protectKernelImage = true;

  systemd.coredump.enable = false;

  boot.kernel.sysctl = {
    "kernel.kptr_restrict" = 2;
    "kernel.dmesg_restrict" = 1;
    "kernel.yama.ptrace_scope" = 1;

    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
  };
}
