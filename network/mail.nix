{ pkgs, ... }: {
  programs.msmtp = {
    enable = true;
    accounts = {
      default = {
        auth = true;
        tls = true;
        from = "thled_inbox@web.de";
        host = "smtp.web.de";
        user = "thled_inbox";
        passwordeval = "cat ~/.inbox_pass";
      };
    };
  };
}
