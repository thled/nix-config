import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.MultiColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns

import XMonad.Util.EZConfig

main :: IO()
main = xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar /etc/config/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig

myConfig = def
        { modMask = mod4Mask
        , terminal = "alacritty"
        , focusedBorderColor = "#0066FF"
        , layoutHook = smartBorders $ myLayouts
        }
        `additionalKeysP`
        [ ("M-x", spawn "slock")
        , ("M-s", spawn "import ~/screenshots/$(date +\"%Y-%m-%d_%H-%M-%S\").png")
        , ("M-C-1", spawn "xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off")
        , ("M-C-2", spawn "xrandr --output eDP-1 --off --output DP-1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off")
        ]

myLayouts = layoutMulti ||| layoutCenter ||| layoutTall
    where
        layoutMulti = multiCol [1] 1 0.01 (-0.5)
        layoutCenter = ThreeColMid 1 (3/100) (1/2)
        layoutTall = Tall 1 (3/100) (1/2)

myXmobarPP :: PP
myXmobarPP = def
    { ppCurrent = xmobarColor "black" "grey" . wrap "[" "]"
    , ppHidden = xmobarColor "grey" "black" . wrap "(" ")"
    , ppHiddenNoWindows = xmobarColor "grey" "black"
    , ppSep = " | "
    , ppTitle = xmobarColor "#00AAFF" "" . shorten 100
    }

