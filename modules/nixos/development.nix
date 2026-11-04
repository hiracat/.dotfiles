{ pkgs, pkgs-stable, ... }: {
  environment.etc."jdks/bellsoft-25".source = pkgs.bellsoft-jdk;
  environment.systemPackages = with pkgs; [
    gh

    go
    perf
    rustup
    stylua
    nixpkgs-fmt
    nixd
    lua
    clang-tools
    vulkan-tools
    glsl_analyzer
    tree-sitter
    lua-language-server
    gopls
    astro-language-server
    shader-slang
    prettier
    nodejs
    gdb
    lldb
    vscode-extensions.vadimcn.vscode-lldb
    cmake
    cmake-language-server

    jetbrains.pycharm
    jetbrains.idea

    bellsoft-jdk
    (python3.withPackages (ps: with ps; [ tkinter matplotlib typer ]))
  ] ++ [
    pkgs-stable.typescript-language-server
  ];
}
