module UI.Views.Main
( draw
) where

import ClassyPrelude

import Brick.Widgets.Center (vCenter, hCenter)
import Brick.Widgets.Border (hBorder)

import Brick.Types (Widget, Padding(..))
import Brick.Widgets.Core (vBox, hLimit, str, padLeft, padRight, (<=>), (<+>))

import Lens.Micro.Platform ((^.))

import qualified UI.Widgets.Status as Status
import qualified UI.Widgets.Help as Help
import qualified UI.Widgets.Notification as Notification
import UI.Widgets.Playlist (playingSongL)
import qualified UI.Widgets.ProgBar as ProgBar

import Network.MPD (Status(..))

import UI.Types

draw :: AppState n -> Widget n -> [Widget n]
draw state widget = [ui]
    where
        {-total = str $ show $ Vec.length $ mails^.(L.listElementsL)-}
        ui = vCenter $ vBox widgets
        -- Cheap centering
        view = hBorder <=> (bitrate state <+> hCenter activeViewWidget <+> str "?: Help")
        activeViewWidget = str $ show (state^.activeView)
        widgets = [--Help.mkWidget
                   Status.mkWidget state (state^.playlistStateL.playingSongL)
                  , hBorder
                  , hCenter widget
                  , hBorder
                  , ProgBar.mkWidget state
                  , view
                  , Notification.mkWidget (state^.notificationState)
                  ]


bitrate ∷ AppState n → Widget n
bitrate state = b
  where br = (stBitrate (state^.status))
        b = case br of
          Nothing → str "   "
          Just x → str $ (show x) ++ " kbps"
