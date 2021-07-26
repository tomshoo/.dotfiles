-- used in case statement for showing layout in xmobar
{-# LANGUAGE LambdaCase #-}

-- IMPORTS

-- Default imports
import XMonad
import System.Exit
import Graphics.X11.ExtraTypes.XF86

-- Extra layout settings for xmonad
import XMonad.Layout.Grid
import XMonad.Layout.TwoPane
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Tabbed
import XMonad.Layout.StackTile
import XMonad.Layout.ResizableTile
import XMonad.Layout.MouseResizableTile

-- Layout Modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Hidden
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.Renamed
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Maximize
import XMonad.Layout.Reflect
import XMonad.Layout.TrackFloating
import XMonad.Layout.Minimize
import XMonad.Layout.TabBarDecoration
import qualified XMonad.Layout.MultiToggle as MT
import qualified XMonad.Layout.Fullscreen as FS
import qualified XMonad.Layout.WindowNavigation as WN

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.Place

-- Prompts
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt

-- Actions
import XMonad.Actions.Promote
import XMonad.Actions.NoBorders
import XMonad.Actions.Minimize
import XMonad.Actions.WithAll
import qualified XMonad.Actions.ConstrainedResize as CNT
import qualified XMonad.Actions.TreeSelect as TS
import qualified XMonad.Actions.FlexibleResize as Flex

-- Data
import Data.Tree
import Data.Monoid
import Data.Maybe (fromJust)
import qualified Data.Map        as M

-- Utils
import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad
import qualified XMonad.StackSet as W

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal :: [Char]
myTerminal      = "alacritty"

myFileManager :: [Char]
myFileManager = "pcmanfm"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask :: KeyMask
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces :: [[Char]]
myWorkspaces    = ["\xf120"
                  ,"\xf269"
                  ,"\xf19d"
                  ,"\xf144"
                  ,"\xf1fb"
                  ,"\xf040"
                  ,"\xf07c"
                  ,"\xf001"
                  ,"\xf086"
                  ,"\xf109"
                  ]

myWorkspaceIndices :: M.Map [Char] Integer
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1, 2, 3, 4, 5, 6, 7, 8, 9, 0] -- (,) == \x y -> (x,y)

clickable :: [Char] -> [Char]
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

-- Border colors for unfocused and focused windows, respectively.
--

myNormalBorderColor :: [Char]
myFocusedBorderColor :: [Char]
myNormalBorderColor  = "#434c5e"
myFocusedBorderColor = "#188b77"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@ XConfig {XMonad.modMask = modm} = M.fromList $
    [ --deleted KeyBindings from the default config
      ((modm .|. shiftMask, xK_c), return())
    , ((modm .|. shiftMask, xK_j), return())
    , ((modm .|. shiftMask, xK_k), return())
    , ((modm,               xK_h), return())
    , ((modm,               xK_l), return())
    , ((modm,               xK_j), return())
    , ((modm,               xK_k), return())

    , ((modm .|. shiftMask, xK_t), sinkAll)

    , ((modm .|. shiftMask, xK_q), confirmPrompt myXPConfirmationConfig "logout?" $ io exitSuccess)

    , ((modm .|. shiftMask, xK_period), sendMessage ExpandSlave)
    , ((modm .|. shiftMask, xK_comma),  sendMessage ShrinkSlave)

    -- Kill focused window
    , ((modm, xK_x), kill)

    -- Swap master window
    , ((modm,               xK_Return), promote)

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), namedScratchpadAction scratchpads "Helper")

    -- XF86 shortcut keys for xmonad
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((0, xF86XK_MonBrightnessUp), spawn "light -A 5")
    , ((0, xF86XK_MonBrightnessDown), spawn "light -U 5")

    -- Resize vertical windows using ResizableTall
    , ((modm .|. controlMask, xK_Up), sendMessage MirrorExpand)
    , ((modm .|. controlMask, xK_Down), sendMessage MirrorShrink)
    , ((modm .|. controlMask, xK_Left), sendMessage Shrink)
    , ((modm .|. controlMask, xK_Right), sendMessage Expand)

    -- Lock screen using betterlockscreen
    , ((modm,               xK_l), confirmPrompt myXPConfirmationConfig "lockscreen?" $ spawn "betterlockscreen --lock blur")

    -- rofi shortcuts my personal favorites
    , ((modm,               xK_d), spawn "rofi -show drun")
    , ((modm .|. controlMask, xK_c), spawn "rofi -show calc")

    -- Scratchpad Key bindings also uses rofi
    , ((modm .|. shiftMask, xK_minus), withFocused minimizeWindow)
    , ((modm,               xK_minus), withLastMinimized maximizeWindowAndFocus)
    , ((modm .|. controlMask, xK_minus), withFirstMinimized maximizeWindowAndFocus)

    -- Minimize Maximize currently focused window
    , ((modm,               xK_m), withFocused (sendMessage . maximizeRestore))

    -- Screenshot keys in xmonad
    , ((0,                  xK_Print), spawn "scrot 'screenshot_%Y%m%d_%H%M%S%T.png' -e 'mv $f ~/Pictures/ && xclip -selection clipboard -t image/png -i ~/Pictures`ls -1 -t ~/Pictures | head -1`'")
    , ((shiftMask,          xK_Print), spawn "scrot -s 'screenshot_select_%Y%m%d_%H%M%S%T.png' -e 'mv $f ~/Pictures && xclip -selection clipboard -t image/png -i ~/Pictures `ls -1 -t ~/Pictures | head -1`'")

    -- toggling gaps
    , ((modm,               xK_g), sendMessage ToggleGaps)
    , ((modm .|. shiftMask, xK_g), withFocused toggleBorder)

    -- window navigation bindings
    , ((modm,               xK_Right), sendMessage $ WN.Go R)
    , ((modm,               xK_Left ), sendMessage $ WN.Go L)
    , ((modm,               xK_Up   ), sendMessage $ WN.Go U)
    , ((modm,               xK_Down ), sendMessage $ WN.Go D)
    , ((modm .|. shiftMask, xK_Right), sendMessage $ WN.Swap R)
    , ((modm .|. shiftMask, xK_Left ), sendMessage $ WN.Swap L)
    , ((modm .|. shiftMask, xK_Up   ), sendMessage $ WN.Swap U)
    , ((modm .|. shiftMask, xK_Down ), sendMessage $ WN.Swap D)

    -- TreeSelect bindings
    , ((modm .|. shiftMask, xK_a), TS.treeselectAction tsDefaultConfig myTreeActionConf)

    -- Launch Scratchpads
    , ((modm .|. shiftMask, xK_h), namedScratchpadAction scratchpads "bPyTop")
    , ((modm .|. shiftMask, xK_e), namedScratchpadAction scratchpads "Ranger")
    , ((modm,               xK_e), spawn myFileManager)
    , ((modm .|. shiftMask, xK_w), spawn "firefox")
    -- bsp layout controls
    , ((modm .|. mod1Mask,    xK_Right), sendMessage $ ExpandTowards R)
    , ((modm .|. mod1Mask,    xK_Left ), sendMessage $ ExpandTowards L)
    , ((modm .|. mod1Mask,    xK_Down ), sendMessage $ ExpandTowards D)
    , ((modm .|. mod1Mask,    xK_Up   ), sendMessage $ ExpandTowards U)
    , ((modm,                 xK_r    ), sendMessage Rotate)
    , ((modm,                 xK_s    ), sendMessage Swap)
    , ((modm,                 xK_n    ), sendMessage FocusParent)
    , ((modm .|. controlMask, xK_n    ), sendMessage SelectNode)
    , ((modm .|. shiftMask,   xK_n    ), sendMessage MoveNode)

    -- Toggle Full screen mode
    , ((modm,                xK_f), sendMessage (Toggle "Full") <+> sendMessage ToggleStruts)

    -- Rotate layouts horizontally and vertically
    , ((modm .|. shiftMask, xK_backslash), sendMessage $ MT.Toggle REFLECTX)
    , ((modm, xK_backslash), sendMessage $ MT.Toggle REFLECTY)
    ]
    ++

    --
    -- mod-[1..0], Switch to workspace N
    -- mod-shift-[1..0], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9, xK_0]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> Flex.mouseResizeWindow w)
    , ((modm .|. shiftMask, button3), \w -> focus w >> CNT.mouseResizeWindow w True)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Named Scratchpad Config

scratchpads :: [NamedScratchpad]
scratchpads =
  [
    NS "bPyTop" "alacritty -t bPyTop -e bpytop" (title =? "bPyTop") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  , NS "Ranger" "alacritty -t Ranger -e ranger" (title =? "Ranger") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  , NS "Helper" "alacritty -t Helper -e less /home/user/.xmonad/help.doc" (title =? "Helper") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  ]

------------------------------------------------------------------------

-- TreeSelect Actions Config

myTreeActionConf :: [Tree (TS.TSNode  (X ()))]
myTreeActionConf =
   [ Node (TS.TSNode "Lock Screen" "Lock the screen"            (confirmPrompt myXPConfirmationConfig "lockscreen?" $ spawn "betterlockscreen --lock blur")) []
   , Node (TS.TSNode "Quit"        "Exit the XMonad session"    (confirmPrompt myXPConfirmationConfig "logout?" $ io exitSuccess))[]
   , Node (TS.TSNode "Suspend"     "Suspends the system"        (confirmPrompt myXPConfirmationConfig "suspend?" $ spawn "systemctl suspend")) []
   , Node (TS.TSNode "Hibernate"   "Send system to hibernation" (confirmPrompt myXPConfirmationConfig "hibernate?" $ spawn "systemctl hibernate")) []
   , Node (TS.TSNode "Shutdown"    "Poweroff the system"        (confirmPrompt myXPConfirmationConfig "shutdown?" $ spawn "poweroff")) []
   , Node (TS.TSNode "Restart"     "Restart the system"         (confirmPrompt myXPConfirmationConfig "Restart?" $ spawn "reboot")) []
   ]

-- TreeSelect Appearance config
tsDefaultConfig :: TS.TSConfig a
tsDefaultConfig = TS.TSConfig { TS.ts_hidechildren = True
                           , TS.ts_background   = 0xda3b3131
                           , TS.ts_font         = "xft:Source Code Pro-8"
                           , TS.ts_node         = (0xffe5e4e2, 0xff202331)
                           , TS.ts_nodealt      = (0xffe5e4e2, 0xff292d3e)
                           , TS.ts_highlight    = (0xffffffff, 0xfff87431)
                           , TS.ts_extra        = 0xffe5e4e2
                           , TS.ts_node_width   = 200
                           , TS.ts_node_height  = 20
                           , TS.ts_originX      = 0
                           , TS.ts_originY      = 0
                           , TS.ts_indent       = 80
                           , TS.ts_navigate     = TS.defaultNavigation
                           }

-----------------------------------------------------------------------
-- XMonad Prompt config

myXPConfirmationConfig :: XPConfig
myXPConfirmationConfig = def {
  font = "xft:Source Code Pro:size=10",
  bgColor = "#2f3d44",
  fgColor = "#70c4c1",
  promptBorderWidth = 1,
  borderColor = "#228e7c",
  position = CenteredAt 0.5 0.3,
  height = 30
                 }

------------------------------------------------------------------------
-- Layouts:

myLayout = smartBorders
  $ MT.mkToggle (MT.single REFLECTX)
  $ MT.mkToggle (MT.single REFLECTY)
  $ minimize
  $ maximizeWithPadding 25
  $ WN.windowNavigation
  $ toggleLayouts Full
  $ avoidStruts
  $ hiddenWindows
  $ trackFloating
  $ gaps [ (U, 4), (D, 4), (R, 4), (L, 4) ]
  $ tiled
  ||| binary
  ||| tab
  ||| full
  ||| stack
  ||| stackmirr
  ||| grid
  ||| twoPane
  ||| flat

  where
     tiled   = renamed [Replace "[T]="]
       $ mySpacing
       $ ResizableTall no_master delta ratio []

     no_master = 1

     ratio   = 1/2

     delta   = 3/100

     grid = renamed [Replace "[+]G"]
       $ mySpacing Grid

     flat = renamed [Replace "[W]="]
       $ Mirror tiled

     full = renamed [Replace "[*]F"]
       $ noBorders Full

     twoPane = renamed [Replace "[TP]"]
       $ mySpacing
       $ TwoPane delta ratio

     binary = renamed [Replace "[1]0"]
       $ mySpacing emptyBSP

     tab = renamed [Replace "[_]T"]
       $ mySpacing
       $ tabbedBottom shrinkText myTabConfig

     stack = renamed [Replace "[=]S"]
       $ mySpacing
       $ StackTile 1 delta ratio

     stackmirr = renamed [Replace "[|]S"]
       $ Mirror stack

-- use spacingRaw instead of smartSpacing
mySpacing :: l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing = spacingRaw True (Border 0 0 0 0) False (Border 4 4 4 4) True

-- Theme settings for the tabbed layout
myTabConfig :: Theme
myTabConfig = def {
  activeColor           = "#556064"
  , inactiveColor       = "#2f3d44"
  , urgentColor         = "#fdf6e3"
  , activeBorderColor   = "#454948"
  , inactiveBorderColor = "#454948"
  , urgentBorderColor   = "#268bd2"
  , activeTextColor     = "#80fff9"
  , inactiveTextColor   = "#1abc9c"
  , urgentTextColor     = "#1abc9c"
  , fontName            = "xft:Source Code Pro:size=9:antialias=true"
  }

------------------------------------------------------------------------
-- Window rules:

myManageHook :: Query (Endo WindowSet)
myManageHook = composeOne
    [
      -- Rules by using class name
      className =? "MPlayer"                 -?> insertPosition Above Newer <+> doFloat
      , className =? "armitage-ArmitageMain"   -?> insertPosition Above Newer <+> doCenterFloat
      , className =? "burp-StartBurp"          -?> insertPosition Above Newer <+> doCenterFloat
      , className =? "Gnome-calculator"        -?> insertPosition Above Newer <+> doFloat
      , className =? "zoom"                    -?> insertPosition Above Newer <+> doFloat
      , className =? "Gnome-sound-recorder"    -?> insertPosition Above Newer <+> doFloat
      , className =? "Thunar"                  -?> insertPosition Above Newer <+> doCenterFloat
      , className =? "BleachBit"               -?> insertPosition Above Newer <+> doCenterFloat
      , className =? "Toolkit"                 -?> insertPosition Above Newer <+> doFloat
      , className =? "Org.gnome.Software"      -?> insertPosition Above Newer <+> doFloat
      , className =? "Xmessage"                -?> insertPosition Above Newer <+> doFloat
      , className =? "lxqt-policykit-agent"    -?> insertPosition Above Newer <+> doCenterFloat

      -- Rules by using resource names
      , resource  =? "desktop_window"          -?> doIgnore
      , resource  =? "kdesktop"                -?> doIgnore

      -- Rules by using title names
      , title     =? "Picture-in-Picture"      -?> insertPosition Above Newer <+> doFloat
      , title     =? "Firefox — Sharing Indicator" -?> doHideIgnore
      , title     =? "Enter name of file to save to..." -?> insertPosition Above Newer <+> doCenterFloat

      , isFullscreen                           -?> insertPosition Above Newer <+> doFullFloat

      -- Workspace rules for tiled windows
      , className =? "XTerm"                   -?> insertPosition Above Newer <+> doCenterFloat
          <+> doShift ( head myWorkspaces )
          <+> doF (W.greedyView ( head myWorkspaces ))

      , className =? "URxvt"                   -?> insertPosition Above Newer <+> doCenterFloat
          <+> doShift ( head myWorkspaces )
          <+> doF (W.greedyView ( head myWorkspaces ))

      , className =? "firefox"                 -?> doShift ( myWorkspaces !! 1 )
          <+> doF (W.greedyView ( myWorkspaces !! 1 ))

      , className =? "Brave-browser"           -?> doShift ( myWorkspaces !! 1 )
          <+> doF (W.greedyView ( myWorkspaces !! 1 ))

      , className =? "Tor Browser"             -?> insertPosition Above Newer <+> doCenterFloat
          <+>  doShift ( myWorkspaces !! 1 )
          <+> doF (W.greedyView ( myWorkspaces !! 1 ))

      , className =? "VSCodium"                -?> doShift ( myWorkspaces !! 2 )
          <+> doF (W.greedyView ( myWorkspaces !! 2 ))

      , className =? "Emacs"                   -?> doShift ( myWorkspaces !! 2 )
          <+> doF (W.greedyView ( myWorkspaces !! 2 ))

      , className =? "Gedit"                   -?> doShift ( myWorkspaces !! 2 )
          <+> doF (W.greedyView ( myWorkspaces !! 2 ))

      , className =? "Gvim"                    -?> doShift ( myWorkspaces !! 2 )
          <+> doF (W.greedyView ( myWorkspaces !! 2 ))

      , className =? "neovide"                 -?> doShift ( myWorkspaces !! 2 )
          <+> doF (W.greedyView ( myWorkspaces !! 2 ))

      , className =? "vlc"                     -?> doShift ( myWorkspaces !! 3 )
          <+> doF (W.greedyView ( myWorkspaces !! 3 ))

      , className =? "Totem"                   -?> doShift ( myWorkspaces !! 3 )
          <+> doF (W.greedyView ( myWorkspaces !! 3 ))

      , className =? "obs"                     -?> insertPosition Above Newer <+> doCenterFloat
          <+>  doShift ( myWorkspaces !! 3 )
          <+> doF (W.greedyView ( myWorkspaces !! 3 ))

      , className =? "Grub-customizer"         -?> doShift ( myWorkspaces !! 4 )
          <+> doF (W.greedyView ( myWorkspaces !! 4 ))

      , className =? "Nitrogen"                -?> insertPosition Above Newer <+> doFloat
          <+> doShift ( myWorkspaces !! 4 )
          <+> doF (W.greedyView ( myWorkspaces !! 4 ))

      , className =? "Variety"                 -?> insertPosition Above Newer <+> doCenterFloat
          <+> doShift ( myWorkspaces !! 4 )
          <+> doF (W.greedyView ( myWorkspaces !! 4 ))

      , className =? "Lxappearance"            -?> insertPosition Above Newer <+> doFloat
          <+> doShift ( myWorkspaces !! 4 )
          <+> doF (W.greedyView ( myWorkspaces !! 4 ))

      , className =? "Eog"                     -?> doShift ( myWorkspaces !! 4 )
          <+> doF (W.greedyView ( myWorkspaces !! 4 ))

      , className =? "Gimp-2.10"               -?> insertPosition Above Newer <+> doFloat
          <+> doShift ( myWorkspaces !! 4 )
          <+> doF (W.greedyView ( myWorkspaces !! 4))

      , title     =? "LibreOffice"             -?> doShift ( myWorkspaces !! 5 )
          <+> doF (W.greedyView ( myWorkspaces !! 5 ))

      , title     =? "DesktopEditors"          -?> doShift ( myWorkspaces !! 5 )
          <+> doF (W.greedyView ( myWorkspaces !! 5 ))

      , className =? "Evince"                  -?> doShift ( myWorkspaces !! 5 )
          <+> doF (W.greedyView ( myWorkspaces !! 5 ))

      , className =? "Org.gnome.Nautilus"      -?> insertPosition Above Newer <+> insertPosition Above Newer <+> doCenterFloat
          <+> doShift ( myWorkspaces !! 6 )
          <+> doF (W.greedyView ( myWorkspaces !! 6 ))

      , className =? "Pcmanfm"                 -?> insertPosition Above Newer <+> insertPosition Above Newer <+> doCenterFloat
          <+> doShift ( myWorkspaces !! 6 )
          <+> doF (W.greedyView ( myWorkspaces !! 6 ))

      , className =? "Rhythmbox"               -?> doShift ( myWorkspaces !! 7 )
          <+> doF (W.greedyView ( myWorkspaces !! 7 ))

      , className =? "discord"                 -?> doShift ( myWorkspaces !! 8 )
          <+> doF (W.greedyView ( myWorkspaces !! 8 ))

      , className =? "qBittorrent"             -?> doShift ( myWorkspaces !! 4 )
          <+> doF (W.greedyView ( myWorkspaces !! 4 ))

      , className =? "Xephyr"                  -?> insertPosition Above Newer <+> doCenterFloat
          <+> doShift ( myWorkspaces !! 9 )

      , className =? "Warpinator"              -?> insertPosition Above Newer <+> doCenterFloat <+> doShift ( myWorkspaces !! 9 )
          <+> doF (W.greedyView( myWorkspaces !! 9 ))

      , className =? "VirtualBox Manager"      -?> insertPosition Above Newer <+> doCenterFloat
          <+> doShift ( myWorkspaces !! 9 )
          <+> doF (W.greedyView( myWorkspaces !! 9 ))
    ]
    <+> namedScratchpadManageHook scratchpads
    <+> FS.fullscreenManageHook
    <+> placeHook simpleSmart

------------------------------------------------------------------------
-- Event handling

myEventHook :: Event -> X All
myEventHook = FS.fullscreenEventHook
  <+> ewmhDesktopsEventHook

------------------------------------------------------------------------
-- Status bars and logging

myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount <+> ewmhDesktopsLogHook
  where
    fadeAmount = 0.70

------------------------------------------------------------------------
-- Startup Applications

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"
  spawnOnce "lxqt-policykit-agent &"
  spawnOnce "xsetroot -cursor_name left_ptr &"
  spawnOnce "xset r rate 300 50 &"
  spawnOnce "ulauncher --hide-window &"
  spawnOnce "numlockx &"
------------------------------------------------------------------------
-- Status configuration

myXmobarPP :: PP
myXmobarPP = xmobarPP {
  ppHiddenNoWindows = xmobarColor "#f4f3ed" "" . clickable,
  ppHidden          = xmobarColor "#b4cfec" "" . clickable,
  ppCurrent         = xmobarColor "#57feff" "#4c566a" . wrap "=] " " [=" ,
  ppLayout          = xmobarAction "xdotool key super+space" "1"
                      . xmobarAction "xdotool key super+shift+space" "3"
                      . (\case
                          "Minimize Maximize Hidden [T]="                   -> "[T]="
                          "Minimize Maximize Hidden [1]0"                   -> "[1]0"
                          "Minimize Maximize Hidden [_]T"                   -> "[_]T"
                          "Minimize Maximize Hidden [*]F"                   -> "[*]F"
                          "Minimize Maximize Hidden [=]S"                   -> "[=]S"
                          "Minimize Maximize Hidden [+]G"                   -> "[+]G"
                          "Minimize Maximize Hidden [TP]"                   -> "[TP]"
                          "Minimize Maximize Hidden [W]="                   -> "[W]="
                          "Minimize Maximize Hidden [|]S"                   -> "[|]S"
                          "Minimize Maximize Hidden [M]R"                   -> "[M]R"
                          "ReflectX Minimize Maximize Hidden [T]="          -> "[x][T]="
                          "ReflectX Minimize Maximize Hidden [1]0"          -> "[x][1]0"
                          "ReflectX Minimize Maximize Hidden [_]T"          -> "[x][_]T"
                          "ReflectX Minimize Maximize Hidden [*]F"          -> "[x][*]F"
                          "ReflectX Minimize Maximize Hidden [=]S"          -> "[x][=]S"
                          "ReflectX Minimize Maximize Hidden [+]G"          -> "[x][+]G"
                          "ReflectX Minimize Maximize Hidden [TP]"          -> "[x][TP]"
                          "ReflectX Minimize Maximize Hidden [W]="          -> "[x][W]="
                          "ReflectX Minimize Maximize Hidden [T]="          -> "[x][T]="
                          "ReflectX Minimize Maximize Hidden [M]R"          -> "[x][M]R"
                          "ReflectY Minimize Maximize Hidden [T]="          -> "[y][T]="
                          "ReflectY Minimize Maximize Hidden [1]0"          -> "[y][1]0"
                          "ReflectY Minimize Maximize Hidden [_]T"          -> "[y][_]T"
                          "ReflectY Minimize Maximize Hidden [*]F"          -> "[y][*]F"
                          "ReflectY Minimize Maximize Hidden [=]S"          -> "[y][=]S"
                          "ReflectY Minimize Maximize Hidden [+]G"          -> "[y][+]G"
                          "ReflectY Minimize Maximize Hidden [TP]"          -> "[y][TP]"
                          "ReflectY Minimize Maximize Hidden [W]="          -> "[y][W]="
                          "ReflectY Minimize Maximize Hidden [|]S"          -> "[y][|]S"
                          "ReflectY Minimize Maximize Hidden [M]R"          -> "[y][M]R"
                          "ReflectX ReflectY Minimize Maximize Hidden [T]=" -> "[xy][T]="
                          "ReflectX ReflectY Minimize Maximize Hidden [1]0" -> "[xy][1]0"
                          "ReflectX ReflectY Minimize Maximize Hidden [_]T" -> "[xy][_]T"
                          "ReflectX ReflectY Minimize Maximize Hidden [*]F" -> "[xy][*]F"
                          "ReflectX ReflectY Minimize Maximize Hidden [=]S" -> "[xy][=]S"
                          "ReflectX ReflectY Minimize Maximize Hidden [+]G" -> "[xy][+]G"
                          "ReflectX ReflectY Minimize Maximize Hidden [TP]" -> "[xy][TP]"
                          "ReflectX ReflectY Minimize Maximize Hidden [W]=" -> "[xy][W]="
                          "ReflectX ReflectY Minimize Maximize Hidden [|]S" -> "[xy][|]S"
                          "ReflectY ReflectY Minimize Maximize Hidden [M]R" -> "[xy][M]R"
                          "Minimize Maximize Full"                          -> "Full"

                        ),
  ppTitle           = xmobarAction "xdotool key super+Tab" "1"
                      . xmobarColor "#57feff" ""
                      . shorten 55,
  ppSep             = " ][ "
  }

toggleStrutKey :: XConfig l -> (KeyMask, KeySym)
toggleStrutKey XConfig {XMonad.modMask = modm} = (modm, xK_b)
---------------------------------------------------------------------------------
-- Main Function call for XMonad
main :: IO ()
main = do
  xmonad =<< statusBar "xmobar" myXmobarPP toggleStrutKey defaults

---------------------------------------------------------------------------------
-- Custom settings override for XMonad
defaults = ewmh
  $ FS.fullscreenSupport
  $ def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys <+> keys def,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook <+> insertPosition Below Newer,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
