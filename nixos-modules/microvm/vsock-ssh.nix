{ config, lib, pkgs, ... }:

let
  cfg = config.microvm.vsock;
in
{
  config = lib.mkIf cfg.ssh.enable {
    assertions = [{
      assertion = cfg.cid != null;
      message = "microvm.vsock.ssh.enable requires microvm.vsock.cid to be set";
    }];

    services.openssh.enable = true;

    # systemd's ssh-generator automatically creates sshd-vsock.socket when it detects VSOCK is available,
    # so we don't need to configure the socket manually. It will listen on vsock::22.
  };
}
