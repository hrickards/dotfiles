import XMonad
import XMonad.Layout.Spiral
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.Script
import XMonad.Util.Run (spawnPipe)
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Gaps
import qualified Data.Map as M
import System.IO

main = do
    dzenLeftBar     <- spawnPipe myXmonadBar
    dzenRightBar    <- spawnPipe myStatusBar
    xmonad $ ewmh defaultConfig
        { terminal              = myTerminal
        , borderWidth           = myBorderWidth
        , modMask               = myModMask
        , normalBorderColor     = myNormalBorderColor
        , focusedBorderColor    = myFocusedBorderColor
        , workspaces            = myWorkspaces
        , keys                  = \c -> myKeys c `M.union` keys defaultConfig c
        , startupHook           = myStartupHook
        , layoutHook            = myLayoutHook
        , logHook               = myLogHook dzenLeftBar
        , manageHook            = myManageHook
        }

myTerminal      = "urxvt -e tmux"
myBorderWidth   = 1
myModMask       = mod1Mask

myNormalBorderColor = "#dddddd"
myFocusedBorderColor = "#ff0000"

myWorkspaces    = [ "1:web", "2:code", "3:fun"
                  , "4:music", "5:config", "6:video"
                  , "7:special"]

myStartupHook   = setWMName "LG3D"

myLayoutHook    = onWorkspace "4:music" musicLayout $ defaultLayouts

{-musicLayout     = (smartBorders . avoidStruts) $ gaps [(R,320)] Full-}
musicLayout     = defaultLayouts

defaultLayouts  = (smartBorders . avoidStruts) $ tiled ||| Mirror tiled ||| Full ||| spiral spiralRatio ||| Mirror (spiral spiralRatio)
    where
        tiled       = Tall nmaster delta ratio
        nmaster     = 1
        ratio       = 1/2
        delta       = 3/100
        spiralRatio = 6/7

myLogHook h = dynamicLogWithPP $ defaultPP
    { ppCurrent         = dzenColor "#ebac54" "#1B1D1E" . pad
    , ppVisible         = dzenColor "white" "#1B1D1E" . pad
    , ppHidden          = dzenColor "white" "#1B1D1E" . pad
    , ppHiddenNoWindows = dzenColor "#7b7b7b" "#1B1D1E" . pad
    , ppUrgent          = dzenColor "#ff0000" "#1B1D1E" . pad
    , ppWsSep           = " "
    , ppSep             = "    "
    , ppLayout          = dzenColor "#ebac54" "#1B1D1E" .
                          (\x -> case x of
                              "Tall"        -> "^i(" ++ myBitmapsDir ++ "/tall.xbm)"
                              "Mirror Tall" -> "^i(" ++ myBitmapsDir ++ "/mtall.xbm)"
                              "Full"        -> "^i(" ++ myBitmapsDir ++ "/full.xbm)"
                              _             -> x
                          )
    , ppOrder           = \(ws:lay:t:_) -> [ws, lay]
    , ppOutput          = hPutStrLn h
    }

myManageHook    = composeAll
    [ className =? "Xfce4-notifyd" --> doIgnore
    , isFullscreen --> doFullFloat
    ]

myKeys (XConfig {modMask = modm}) = M.fromList $
    [ ((modm, xK_x), spawn "xlock")
    , ((modm, xK_u), spawn "urxvt")
    , ((modm, xK_v), spawn "urxvt -e /home/harry/bin/cw_vim")
    , ((modm, xK_p), spawn "eval \"exec `yeganesh -x -- -fn 'xft:inconsolata:pixelsize=14'`\"") ]

myScreenWidth   = 1366
myStatusWidth   = 850
myXmonadWidth   = myScreenWidth - myStatusWidth

myXmonadBar     = "dzen2 -x '0' -y '0' -h '20' -w '" ++ show myXmonadWidth ++ "' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E' -fn 'xft:inconsolata:pixelsize=14'"
myStatusBar     = "/home/harry/bin/conky_ifnot -c /home/harry/.xmonad/conky | dzen2 -x '" ++ show myXmonadWidth ++ "' -y '0' -w '" ++ show myStatusWidth ++ "' -h '20' -ta 'r' -bg '#1B1D1E' -fg '#FFFFFF' -fn 'xft:inconsolata:pixelsize=14'"

myBitmapsDir    = "/home/harry/.xmonad/images"
