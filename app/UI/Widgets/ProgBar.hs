module UI.Widgets.ProgBar
  ( mkWidget
  , attrs
  ) where

import ClassyPrelude

import GHC.Float (double2Float)

import Lens.Micro.Platform ((^.))
import qualified Brick.Widgets.ProgressBar as ProgressBar
--import Brick.Types (Widget)
import UI.Types
import Network.MPD (Status(..))
--import Brick.AttrMap (AttrName)
import Brick.Util (on, fg, bg)
import Brick.Widgets.Core
import Brick.Types
import Brick.AttrMap
import qualified Graphics.Vty as V



attrs ∷ [(AttrName, V.Attr)]
attrs = [("progressComplete", bg V.red)]


mkWidget ∷ AppState n → Widget n
mkWidget state = withAttr "progbar" $ ProgressBar.progressBar Nothing prog
  where st = state^.status
        progTuple = stTime st
        prog = case progTuple of
                 Nothing → 0
                 Just (p,total) → double2Float $ p / (fromInteger total)



