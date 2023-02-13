{ pkgs, ... }: {
  services.openvpn.servers = {
    protonVPN = {
      config = '' config /etc/vpn/protonVPN.conf '';
      autoStart = false;
      updateResolvConf = true;
    };
    officeVPN = {
      config = '' config /etc/vpn/officeVPN.conf '';
      autoStart = false;
      updateResolvConf = true;
    };
  };
  environment.etc."vpn/protonVPN.conf".source = ./nl-free-05.protonvpn.com.udp.ovpn;
  environment.etc."vpn/officeVPN.conf".source = ./office.ovpn;
}

