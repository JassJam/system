{
  lib,
  config,
  pkgs,
  userName,
  ...
}:
let
  cfg-vesktop = config.chat.vesktop;
  cfg-catppuccin = config.essentials.theming.catppuccin;
in
{
  options.chat.vesktop = {
    enable = lib.mkEnableOption "Vesktop chat client";
  };

  config = lib.mkIf cfg-vesktop.enable {
    home-manager.users.${userName} = {
      programs.vesktop = {
        enable = true;

        settings = {
          autoUpdate = false;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          disableMinSize = true;
          enabledThemes = [ ];
          discordBranch = "stable";
          arRPC = "on";

          plugins = {
            AlwayaAnimate.enable = true;
            AnonymiseFileNames.enable = true;
            BetterFolders.enable = true;
            BiggerStreamPreview.enable = true;
            ClearURLs.enable = true;
            ConsoleJanitor.enable = true;
            CopyFileContents.enable = true;
            CopyStickerLinks.enable = true;
            CrashHandler.enable = true;
            FakeNitro.enable = true;
            FakeProfileThemes.enable = true;
            FixImageQuality.enable = true;
            FixSpotifyEmbeds.enable = true;
            FixYoutubeEmbeds.enable = true;
            ImageZoom.enable = true;
            LoadingQuotes.enable = true;
            MentionAvatars.enable = true;
            MessageLogger.enable = true;
            petpet.enable = true;
            PictureInPicture.enable = true;
            PreviewMessage.enable = true;
            ReverseImageSearch.enable = true;
            SilentTyping.enable = true;
            SpotifyControls.enable = true;
            SpotifyCrack.enable = true;
            SpotifyShareCommands.enable = true;
            StickerPaste.enable = true;
            Translate.enable = true;
            USRGB.enable = true;
            VoiceMessages.enable = true;
            VolumeBooster.enable = true;
            WenScreenShareFixes.enable = true;
            WebKeybinds.enable = true;
            YoutubeAdblock.enable = true;
          };
        };
      };

      catppuccin.vesktop = {
        enable = cfg-catppuccin.enable;
        flavor = cfg-catppuccin.flavor;
      };
    };
  };
}
