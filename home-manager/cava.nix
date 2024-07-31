{ config, ... }: {


  home.file.".config/cava/config" = {
    text = ''
      [general]
      framerate = 75
      # Bars' width and space between bars in number of characters.
      bars = 0
      bar_width = 2
      bar_spacing = 1

      [color]
      gradient = 1

      background = '#${config.colorScheme.palette.base00}'

      gradient_color_7 = '#${config.colorScheme.palette.base08}'
      gradient_color_6 = '#${config.colorScheme.palette.base09}'
      gradient_color_5 = '#${config.colorScheme.palette.base0A}'
      gradient_color_4 = '#${config.colorScheme.palette.base0B}'
      gradient_color_3 = '#${config.colorScheme.palette.base0C}'
      gradient_color_2 = '#${config.colorScheme.palette.base0D}'
      gradient_color_1 = '#${config.colorScheme.palette.base0E}'

      [smoothing]
      ; noise_reduction = 77
    '';
  };
}
