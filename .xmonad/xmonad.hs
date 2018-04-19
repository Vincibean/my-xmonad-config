import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)

import System.Exit
import System.IO

myWorkspaces = map show [0..9]

myLogHook = dynamicLogWithPP $ xmobarPP

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad desktopConfig
        { terminal    = "urxvt",
          layoutHook  = avoidStruts $ layoutHook def,
          logHook     = myLogHook,
          manageHook  = manageDocks <+> manageHook def
        }
