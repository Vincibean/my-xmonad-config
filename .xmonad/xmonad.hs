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
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook :: ManageHook
myManageHook = manageDocks <+> manageHook defaultConfig

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
