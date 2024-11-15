{ lib, config, ... }: {
  options = {
    periferals.drawingTablet.enable = lib.mkEnableOption "enable drawing tablet support";
  };
  config = {
    hardware = {
      opentabletdriver.enable = config.periferals.drawingTablet.enable;
    };
  };
}
