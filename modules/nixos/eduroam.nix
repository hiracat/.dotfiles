{ config, ... }: {
  age.secrets.eduroam-password = {
    file = ../../secrets/eduroam_password.age;
  };
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.age.secrets.eduroam-password.path ];
    profiles = {
      eduroam = {
        connection = {
          id = "eduroam";
          type = "wifi";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "eduroam";
        };
        wifi-security = {
          key-mgmt = "wpa-eap";
        };
        "802-1x" = {
          eap = "tls";
          anonymous-identity = "anonymous@rit.edu";
          identity = "frl4915@rit.edu";
          client-cert = "/etc/NetworkManager/certs/eduroam-cert.p12";
          private-key = "/etc/NetworkManager/certs/eduroam-cert.p12";
          ca-cert = "/etc/NetworkManager/certs/eduroam-ca.cer";
          private-key-password-flags = 0;

          private-key-password = "$EDUROAM_KEY_PASSWORD";
        };
        ipv4.method = "auto";
        ipv6.method = "auto";
      };
    };
  };
}
