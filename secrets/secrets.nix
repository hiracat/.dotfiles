let
  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO9X++QDuK2Uh5nV2X8P8ratkLV9U7CYLIUoj909tAHx forest@nixos-desktop";
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWnGWDG2ooTzY+PCnLWpib1Yn9il+FWOB0Kw0KorTn+ forest@nixos-laptop";
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFUxgeebT7z1hHD7b64eICy6G1IH2GNVQ/4ZHKJow1Me forest@nixos-server";
  users = [ desktop laptop server ];

  desktop_system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEeEb7+yX6ZaHLdLD1dr9CA8+ENbqJPBmI0ZEb3Bsdvp root@nixos-desktop";
  laptop_system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFYSEagIT91KYrW5IUvnLnrVT2VMkkJm7kuwZVhT2Pjs root@nixos-laptop";
  server_system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKsXnYhyXOP2V/mryVdeF7+zcl/dvx2/F2ARyMjhihS root@nixos-server";
  systems = [ desktop_system laptop_system server_system ];
in
{
  "ssh_config.age".publicKeys = users ++ systems;
}
