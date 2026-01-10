{ acmeEmail, ... }:
{
  services.rkm-frontend = {
    enable = true;
    port = 3100;
    host = "127.0.0.1";
    domain = "rajawalikaryamulya.co.id";
    extraDomains = [ "www.rajawalikaryamulya.co.id" ];
    enableSSL = true;
    acmeEmail = acmeEmail;
  };
}
