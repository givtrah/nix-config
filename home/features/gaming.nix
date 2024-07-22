{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
  # Emulation

  rpcs3 # PS3
  dosbox # Dos games
  cemu # Wii
  xemu # original xbox 
  pcsxr # PS1
  lime3ds # Nintendo 3DS
  dgen-sdl # Sega Genesis / Megadrive
  desmume # Nintendo DS
  stella # Atari 2600
  openmsx # MSX
  melonDS # Nintendo DS
  mgba # Nintendo Gameboy Advance
  fsuae # Amiga
  uae # Amiga
  mednafen # multisystem emulator
  mednaffe # frontend for mednafen
  sameboy # Gameboy, Gameboy color, Super Gameboy
  zsnes # Super Nintendo 
  fceux # NES
  vice # C-64
  ryujinx # Switch
  nanoboyadvance # Nintendo Gameboy Advance

  dolphin-emu # Gamecube / Wii / trifoce

  duckstation # PS1

  ppsspp-sdl-wayland # Playstation portable (wayland)

  flycast # Sega Dreamcast, Naomi and Atomiswave emulator
  snes9x-gtk # SNES
  punes-qt6 # NES

  retroarchFull # multi system with all cores

  emulationstation # Frontend

  maxcso # compression from iso to cso for psp and ps2 emus

  heroic
  gogdl



  ]



  ++
   
    (if (pkgs.system == "aarch64-linux")
    then [ ]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ i

        mupen64plus # Nintendo 64
        pcsx2 # PS2

      ]
      else []));


















}
