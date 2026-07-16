# Fallback sandbox for natively-packaged (non-Flatpak) apps that don't
# have a Flatpak available. Wrap the binary so the normal command name
# transparently runs inside a firejail profile, e.g.:
#
#   wrappedBinaries.mpv = {
#     executable = "${pkgs.mpv}/bin/mpv";
#     profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
#   };
{
  programs.firejail = {
    enable = true;
    wrappedBinaries = { };
  };
}
