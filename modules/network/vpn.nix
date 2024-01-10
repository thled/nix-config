_: {
  services.openvpn.servers = {
    officeVPN = {
      config = '' config /home/thled/office.ovpn'';
      autoStart = false;
      updateResolvConf = true;
    };
  };
}

