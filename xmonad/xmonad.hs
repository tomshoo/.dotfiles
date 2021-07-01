-- IMPORTS

-- Default imports
import XMonad
import System.Exit
import Graphics.X11.ExtraTypes.XF86

-- Extra layout settings for xmonad
import XMonad.Layout.Grid
import XMonad.Layout.CenteredMaster
import XMonad.Layout.TwoPane
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Tabbed
import XMonad.Layout.StackTile

-- Layout Modifiers
import XMonad.Layout.NoBorders
import XMonad.Layout.Hidden
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.Renamed
import XMonad.Layout.ToggleLayouts
import qualified XMonad.Layout.Fullscreen as FS
import qualified XMonad.Layout.WindowNavigation as WN

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.Place

-- Actions
import XMonad.Actions.Promote
import XMonad.Actions.NoBorders
import qualified XMonad.Actions.TreeSelect as TS
import qualified XMonad.Actions.FlexibleResize as Flex
import qualified XMonad.Actions.FlexibleManipulate as FM

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
                  ]

myWorkspaceIndices :: M.Map [Char] Integer
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable :: [Char] -> [Char]
clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

-- Border colors for unfocused and focused windows, respectively.
--

myNormalBorderColor :: [Char]
myFocusedBorderColor :: [Char]
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@ XConfig {XMonad.modMask = modm} = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    -- , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- close focused window
    -- , ((modm .|. shiftMask, xK_c     ), kill)
    , ((modm, xK_x), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), promote)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn (myTerminal ++ " -e less /home/user/.xmonad/help.doc"))

    -- XF86 shortcut keys for xmonad
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ((0, xF86XK_MonBrightnessUp), spawn "light -A 5")
    , ((0, xF86XK_MonBrightnessDown), spawn "light -U 5")

    -- Resize vertical windows using ResizableTall
    , ((modm .|. controlMask .|. mod1Mask, xK_Up), sendMessage MirrorExpand)
    , ((modm .|. controlMask .|. mod1Mask, xK_Down), sendMessage MirrorShrink)
    , ((modm .|. controlMask .|. mod1Mask, xK_Left), sendMessage Shrink)
    , ((modm .|. controlMask .|. mod1Mask, xK_Right), sendMessage Expand)

    -- Lock screen using betterlockscreen
    , ((modm .|. shiftMask, xK_x), spawn "betterlockscreen --lock blur")

    -- rofi shortcuts my personal favorites
    , ((modm,               xK_d), spawn "rofi -show drun")
    , ((modm .|. controlMask, xK_c), spawn "rofi -show calc")

    -- Scratchpad Key bindings also uses rofi
    , ((modm .|. shiftMask, xK_minus), withFocused hideWindow)
    , ((modm .|. controlMask, xK_minus), popOldestHiddenWindow)
    , ((modm,           xK_minus), popNewestHiddenWindow)

    -- Screenshot keys in xmonad
    , ((0,              xK_Print), spawn "scrot 'screenshot_%Y%m%d_%H%M%S%T.png' -e 'mv $f ~/Pictures/ && xclip -selection clipboard -t image/png -i ~/Pictures`ls -1 -t ~/Pictures | head -1`'")
    , ((shiftMask,      xK_Print), spawn "scrot -s 'screenshot_select_%Y%m%d_%H%M%S%T.png' -e 'mv $f ~/Pictures && xclip -selection clipboard -t image/png -i ~/Pictures `ls -1 -t ~/Pictures | head -1`'")

    -- toggling gaps
    , ((modm, xK_g), sendMessage ToggleGaps)
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
    , ((modm .|. shiftMask, xK_a), TS.treeselectAction tsDefaultConfig myTreeConf)

    -- Launch Scratchpads
    , ((modm .|. shiftMask, xK_h), namedScratchpadAction scratchpads "HTop")
    , ((modm .|. shiftMask, xK_e), namedScratchpadAction scratchpads "FileManager")
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
    , ((modm,                xK_f), sendMessage (Toggle "Full"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings :: XConfig l -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> FM.mouseWindow FM.linear w)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> Flex.mouseResizeWindow w)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]


------------------------------------------------------------------------
-- Named Scratchpad Config

scratchpads :: [NamedScratchpad]
scratchpads =
  [
    NS "HTop" "alacritty -e htop" (resource =? "HTop") (customFloating $ W.RationalRect 0.9 0.9 0.8 0.8)
    , NS "FileManager" "nautilus" (title =? "FileManager") (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3))
  ]

------------------------------------------------------------------------
-- treeselect config

myTreeConf :: [Tree (TS.TSNode  (X ()))]
myTreeConf =
   [ Node (TS.TSNode "Lock Screen" "Lock the screen" (spawn "betterlockscreen --lock blur")) []
   , Node (TS.TSNode "Quit" "Exit the XMonad session" (io exitSuccess))[]
   , Node (TS.TSNode "Suspend" "Suspends the system" (spawn "systemctl suspend")) []
   , Node (TS.TSNode "Hibernate" "Send system to hibernation" (spawn "systemctl hibernate")) []
   , Node (TS.TSNode "Shutdown" "Poweroff the system" (spawn "poweroff")) []
   , Node (TS.TSNode "Restart"    "Restart the system"      (spawn "reboot")) []
   ]

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

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = smartBorders
  $ WN.windowNavigation
  $ toggleLayouts Full
  $ avoidStruts
  $ hiddenWindows
  $ gaps [ (U, 4), (D, 4), (R, 4), (L, 4) ]
  $ tiled
  ||| binary
  ||| tab
  ||| full
  ||| stack
  ||| grid
  ||| centerMaster cgrid
  ||| twoPane
  ||| flat

  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = renamed [Replace "[T]="]
       $ smartSpacing 4
       $ ResizableTall nmaster delta ratio []

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

     -- Grid for center master layout
     cgrid    = renamed [Replace "[+G]"]
       $ smartSpacing 4
       $ Grid

     grid = renamed [Replace "[+]G"]
       $ smartSpacing 4
       $ Grid

     -- Mirror tiled settings
     flat = renamed [Replace "[W]="]
       $ Mirror tiled

     -- Full settings
     full = renamed [Replace "[*]F"]
       $ noBorders Full

     -- TwoPane Settings
     twoPane = renamed [Replace "[TP]"]
       $ addTabsBottomAlways shrinkText myTabConfig
       $ smartSpacing 4
       $ TwoPane delta ratio

     binary = renamed [Replace "[1]0"]
       $ smartSpacing 4 emptyBSP

     tab = renamed [Replace "[_]T"]
       $ smartSpacing 4
       $ tabbedBottom shrinkText myTabConfig

     stack = renamed [Replace "[=]S"]
       $ smartSpacing 4
       $ StackTile 3 delta ratio

myTabConfig :: Theme
myTabConfig = def {
  activeColor = "#556064"
  , inactiveColor = "#2F3D44"
  , urgentColor = "#FDF6E3"
  , activeBorderColor = "#454948"
  , inactiveBorderColor = "#454948"
  , urgentBorderColor = "#268BD2"
  , activeTextColor = "#80FFF9"
  , inactiveTextColor = "#1ABC9C"
  , urgentTextColor = "#1ABC9C"
  , fontName = "xft:Source Code Pro:size=9"
  }

------------------------------------------------------------------------
-- Window rules:

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
myManageHook :: Query (Endo WindowSet)
myManageHook = composeAll
    [
      -- Rules by using class name
      className =? "MPlayer"                 --> doFloat
      , className =? "Gimp"                    --> doFloat
      , className =? "Org.gnome.Nautilus"      --> doFloat
      , className =? "armitage-ArmitageMain"   --> doFloat
      , className =? "Nitrogen"                --> doFloat
      , className =? "burp-StartBurp"          --> doFloat
      , className =? "Gnome-calculator"        --> doFloat
      , className =? "zoom"                    --> doFloat
      , className =? "Lxappearance"            --> doFloat
      , className =? "Gnome-sound-recorder"    --> doFloat
      , className =? "Pcmanfm"                 --> doFloat
      , className =? "Thunar"                  --> doFloat
      , className =? "BleachBit"               --> doFloat
      , className =? "Toolkit"                 --> doFloat
      , className =? "Org.gnome.Software"      --> doFloat
      , className =? "XTerm"                   --> doFloat
      , className =? "URxvt"                   --> doFloat
      , className =? "Xmessage"                --> doFloat

      -- Rules by using resource names
      , resource  =? "desktop_window"          --> doIgnore
      , resource  =? "kdesktop"                --> doIgnore

      -- Rules by using title names
      , title     =? "Picture-in-Picture"      --> doFloat

      , isFullscreen                           --> doFullFloat

      -- Workspace rules for windows
      , className =? "URxvt"                   --> doShift ( head myWorkspaces )
      , className =? "XTerm"                   --> doShift ( head myWorkspaces )
      , className =? "firefox"                 --> doShift ( myWorkspaces !! 1 )
      , className =? "Tor Browser"             --> doShift ( myWorkspaces !! 1 )
      , className =? "Emacs"                   --> doShift ( myWorkspaces !! 2 )
      , className =? "vlc"                     --> doShift ( myWorkspaces !! 3 )
      , className =? "obs"                     --> doShift ( myWorkspaces !! 3 )
      , className =? "Lxappearance"            --> doShift ( myWorkspaces !! 4 )
      , className =? "Nitrogen"                --> doShift ( myWorkspaces !! 4 )
      , className =? "Eog"                     --> doShift ( myWorkspaces !! 4 )
      , className =? "libreoffice"             --> doShift ( myWorkspaces !! 5 )
      , title     =? "Libreoffice"             --> doShift ( myWorkspaces !! 5 )
      , className =? "Evince"                  --> doShift ( myWorkspaces !! 5 )
      , className =? "Org.gnome.Nautilus"      --> doShift ( myWorkspaces !! 6 )
      , className =? "Rhythmbox"               --> doShift ( myWorkspaces !! 7 )
    ]
    <+> namedScratchpadManageHook scratchpads
    <+> FS.fullscreenManageHook
    <+> placeHook simpleSmart

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook :: Event -> X All
myEventHook = FS.fullscreenEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
  where
    fadeAmount = 0.8

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "picom &"
  spawnOnce "lxqt-policykit-agent &"
  spawnOnce "xsetroot -cursor_name left_ptr &"
  spawnOnce "xset r rate 300 50 &"
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
-- main = do
  -- xmproc <- spawnPipe "xmobar"
  -- xmonad $ docks defaults

myXmobarPP :: PP
myXmobarPP = xmobarPP {
  ppHiddenNoWindows = xmobarColor "#f4f3ed" "" . clickable,
  ppHidden = xmobarColor "#b4cfec" "" . clickable,
  ppCurrent = xmobarColor "#57feff" "" . wrap "=] " " [=" ,
  ppLayout = xmobarAction "xdotool key super+space" "1"
    . xmobarAction "xdotool key super+shift+space" "3" ,

  ppTitle = xmobarAction "xdotool key super+Tab" "1"
    . xmobarColor "#32cd32" ""
    . shorten 55,

  ppSep = " ][ "
  }

toggleStrutKey :: XConfig l -> (KeyMask, KeySym)
toggleStrutKey XConfig {XMonad.modMask = modm} = (modm, xK_b)

main :: IO ()
main = do
  xmonad =<< statusBar "xmobar" myXmobarPP toggleStrutKey defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
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
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = insertPosition Below Newer
          <+> myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
