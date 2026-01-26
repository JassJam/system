{
  inputs,
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-nixcord = config.chat.nixcord;
  cfg-catppuccin = config.essentials.theming.catppuccin;

  any-enabled = lib.any (x: x) [
    cfg-nixcord.vesktop.enable
  ];
in
{
  options.chat.nixcord = {
    vesktop = {
      enable = lib.mkEnableOption "Enable Nixcord vesktop client.";
    };
  };

  config = lib.mkIf any-enabled {
    home-manager.sharedModules = [ inputs.nixcord.homeModules.nixcord ];
    home-manager.users.${userName} = {
      programs.nixcord = {
        enable = true;
        vesktop = {
          enable = true;
          package = pkgs.vesktop;
          settings = {
            arRPC = true;
          };
        };

        config.plugins = {
          alwaysAnimate.enable = true;
          anonymiseFileNames.enable = true;
          betterFolders.enable = true;
          biggerStreamPreview.enable = true;
          ClearURLs.enable = true;
          CustomRPC.enable = true;
          consoleJanitor.enable = true;
          copyFileContents.enable = true;
          copyStickerLinks.enable = true;
          crashHandler.enable = true;
          fakeNitro.enable = true;
          fakeProfileThemes.enable = true;
          fixImagesQuality.enable = true;
          fixSpotifyEmbeds.enable = true;
          fixYoutubeEmbeds.enable = true;
          imageZoom.enable = true;
          loadingQuotes.enable = true;
          mentionAvatars.enable = true;
          messageLogger.enable = true;
          petpet.enable = true;
          pictureInPicture.enable = true;
          previewMessage.enable = true;
          reverseImageSearch.enable = true;
          silentTyping.enable = true;
          spotifyControls.enable = true;
          spotifyCrack.enable = true;
          spotifyShareCommands.enable = true;
          stickerPaste.enable = true;
          translate.enable = true;
          voiceMessages.enable = true;
          volumeBooster.enable = true;
          webScreenShareFixes.enable = true;
          webKeybinds.enable = true;
          youtubeAdblock.enable = true;
        };
      };
    };

    # catppuccin.vesktop = {
    #   enable = cfg-catppuccin.enable;
    #   flavor = cfg-catppuccin.flavor;
    # };
  };
}
