import XMonad hiding (Tall)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.LayoutHints
import XMonad.Layout.ResizableTile
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)

import System.Exit
import System.IO
import Data.Monoid

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces = map show [1..9]

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt"). You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList

------------------------------------------------------------------------
-- Mouse bindings
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook
           $ defaultConfig {
                terminal           = "urxvt",
                workspaces         = myWorkspaces,
                normalBorderColor  = "#333333",
                focusedBorderColor = "#3399cc",
                manageHook         = myManageHook,
                keys               = myKeys,
                mouseBindings      = myMouseBindings,
                layoutHook         = myLayout,
                logHook            = dynamicLogWithPP $ xmobarPP { 
                                         ppOutput = hPutStrLn xmproc,
                                         ppTitle = xmobarColor "green" "" . shorten 50
                                     }
    }

myLayout = avoidStruts $ layoutHints (tall ||| Mirror tall ||| Full)
  where
     tall = ResizableTall nmaster delta ratio []
     nmaster = 1
     delta   = 3/100
     ratio   = 1/2

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Pidgin"    --> doShift "1:Chat"
    , className =? "Shiretoko" --> doShift "2:Web"]
