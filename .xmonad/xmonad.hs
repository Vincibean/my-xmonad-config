import XMonad
import XMonad.Config.Desktop
import XMonad.Util.Run(spawnPipe)

import System.Exit
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad desktopConfig
        { terminal    = "urxvt"
        }
