import XMonad
import XMonad.Config.Desktop

import System.Exit
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad desktopConfig
        { terminal    = "urxvt"
        }
