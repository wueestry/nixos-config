{
  # Decrypt using the host's existing SSH key instead of managing a
  # separate age keypair per machine.
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # Once secrets/athena/secrets.yaml exists (see .sops.yaml), point at it
  # and declare secrets, e.g.:
  # sops.defaultSopsFile = ../../secrets/athena/secrets.yaml;
  # sops.secrets."example/key" = { };
}
