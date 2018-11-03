import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)

import System.Exit
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad desktopConfig
        { terminal   = "urxvt",
          layoutHook = avoidStruts  $  layoutHook def,
          logHook    = dynamicLogWithPP $ xmobarPP,
          manageHook = manageDocks <+> manageHook def
        }
