import Graphics.X11.ExtraTypes.XF86

import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)

import System.Exit
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ desktopConfig
        {  modMask = mod4Mask
         , terminal    = "urxvt"
         , normalBorderColor  = "#707880"
         , focusedBorderColor = "#c5c8c6"
         , layoutHook  = avoidStruts $ smartBorders $ layoutHook def
         , logHook     = dynamicLogWithPP $ xmobarPP
         , startupHook = setWMName "LG3D"
         , manageHook  = manageDocks <+> manageHook def
        } `additionalKeys`
        [  ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
         , ((0, xF86XK_AudioLowerVolume), spawn "amixer set Master 2-")
         , ((0, xF86XK_AudioRaiseVolume), spawn "amixer set Master 2+")
        ]
