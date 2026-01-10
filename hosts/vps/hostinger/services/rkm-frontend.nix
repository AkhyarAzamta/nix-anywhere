{ acmeEmail, ... }:
{
  services.rkm-frontend = {
    enable = true;
    domain = "rajawalikaryamulya.co.id";
    extraDomains = [ "www.rajawalikaryamulya.co.id" ];
    enableSSL = true;
    acmeEmail = acmeEmail;
  };
}
