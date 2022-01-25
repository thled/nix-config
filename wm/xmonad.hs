import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Layout.MultiColumns
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Util.EZConfig

main :: IO()
main = launch 
    . ewmh
  =<< statusBar "xmobar /etc/xmobarrc" myXmobarPP toggleStrutsKey myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

myConfig = def
        { startupHook = setWMName "LG3D"
        , manageHook = manageDocks
        , handleEventHook = docksEventHook
        , modMask = mod4Mask
        , terminal = "alacritty"
        , focusedBorderColor = "#0066FF"
        , layoutHook = avoidStruts $ smartBorders $ myLayouts
        }
        `additionalKeysP`
        [ ("M-x", spawn "slock")
        , ("M-C-1", spawn "xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off")
        , ("M-C-2", spawn "xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --primary --mode 3840x1080 --pos 0x0 --rotate normal")
        , ("M-C-3", spawn "xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal")
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

