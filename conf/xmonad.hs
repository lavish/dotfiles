import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Actions.CycleRecentWS
import XMonad.Util.Run
import XMonad.Hooks.UrgencyHook
import Text.Printf(printf)
import XMonad.Hooks.SetWMName
import XMonad.Layout.Circle
import XMonad.Hooks.FadeInactive
import XMonad.Actions.Warp

font	     = "-artwiz-snap-*-*-*-*-*-*-*-*-*-*-*-*"
normBgCol    = "#00020f"
normFgCol    = "#769cb2"
selBgCol     = "#64aed9"
selFgCol     = "#cccccc"
normBordCol  = "#d3d9db"
focusBordCol = "#0055ff"
layFgCol     = "#999999"
myWorkspaces = [ "0x1", "0x2", "0x3", "0x4", "0x5", "0x6", "0x7", "0x8", "0x9" ]
myManageHook = composeAll
	       [ className =? "Chrome"      --> doShift "0x2"
               ]
myLayoutHook =  avoidStruts $ layoutHook defaultConfig
myLogHook xmproc = fadeInactiveLogHook fadeAmount >> myDynamicLogWithPP
	           where fadeAmount = 0xcccccccc
                         myDynamicLogWithPP = dynamicLogWithPP $ xmobarPP
			 	{ ppOutput = hPutStrLn xmproc
				, ppTitle = shorten 65
				, ppCurrent = xmobarColor selFgCol ""
				, ppLayout  = xmobarColor layFgCol "" .
					(\x -> case x of
						"Tall" -> "V"
						"Mirror Tall" -> "H"
						"Full" -> "W"
					)
				, ppUrgent = xmobarColor "" selBgCol
				}
	
main = do
	xmproc <- spawnPipe "xmobar"
	xmonad $ withUrgencyHook NoUrgencyHook
               $ defaultConfig
		{ borderWidth        = 1
		, terminal           = "urxvtc"
		, modMask	     = mod4Mask
		, startupHook = setWMName "LG3D"
		, normalBorderColor  = normBordCol
		, focusedBorderColor = focusBordCol
		, workspaces         = myWorkspaces
		, manageHook         = manageDocks <+> myManageHook <+> manageHook defaultConfig
		, layoutHook         = myLayoutHook
		, logHook            = myLogHook xmproc
		}
                `additionalKeys`
		[ ((mod4Mask, xK_p), spawn (printf "dmenu_run -i -l 10 -fn \"%s\" -nb \"%s\" -nf \"%s\" -sb \"%s\" -sf \"%s\""
			font normBgCol normFgCol normBgCol selFgCol))
		, ((mod4Mask, xK_backslash), cycleRecentWS [xK_backslash] xK_backslash xK_backslash)
		-- XF86AudioNext
		, ((0 , 0x1008ff17), spawn "audtool playlist-advance")
		-- XF86AudioPlay
		, ((0 , 0x1008ff14), spawn "audtool playback-playpause")
		-- XF86AudioStop
		, ((0 , 0x1008ff15), spawn "audtool playback-stop")
		-- XF86AudioPrev
		, ((0 , 0x1008ff16), spawn "audtool playlist-reverse")
		-- XF86ScreenSaver
		, ((0 , 0x1008ff2d), spawn "slock")
		-- XF86AudioMute
		, ((0 , 0x1008ff12), spawn "amixer -q set PCM toggle")
		-- XF86AudioLowerVolume
		, ((0 , 0x1008ff11), spawn "amixer set PCM 5- unmute | dzen2 -fn -*-snap-*-*-*-*-*-*-*-*-*-*-*-* -bg '#00020f' -fg '#64aed9' -ta r -w 500 -h 20 -x 880 -y 0 -p 3")
		-- XF86AudioRaiseVolume
		, ((0 , 0x1008ff13), spawn "amixer set PCM 5+ unmute | dzen2 -fn -*-snap-*-*-*-*-*-*-*-*-*-*-*-* -bg '#00020f' -fg '#64aed9' -ta r -w 500 -h 20 -x 880 -y 0 -p 3")
		]
