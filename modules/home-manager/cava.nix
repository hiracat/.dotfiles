{ config, ... }: {

  xdg.configFile."cava/config" = {
    text = ''
      [general]
      framerate = 75
      # Bars' width and space between bars in number of characters.
      bars = 0
      bar_width = 2
      bar_spacing = 1

      [color]
      gradient = 1

      background = '#${config.scheme.base00}'

      gradient_color_7 = '#${config.scheme.base08}'
      gradient_color_6 = '#${config.scheme.base09}'
      gradient_color_5 = '#${config.scheme.base0A}'
      gradient_color_4 = '#${config.scheme.base0B}'
      gradient_color_3 = '#${config.scheme.base0C}'
      gradient_color_2 = '#${config.scheme.base0D}'
      gradient_color_1 = '#${config.scheme.base0E}'

      [smoothing]
      ; noise_reduction = 77
    '';
  };
}
