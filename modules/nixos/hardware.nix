{ lib, config }: {
  options = {
    hardware.enableDrawingTablet = lib.mkEnableOption "enable drawing tablet support";
  };
  config = {
    hardware = {
      opentabletdriver.enable = config.hardware.enableDrawingTablet;
    };
  };
}
