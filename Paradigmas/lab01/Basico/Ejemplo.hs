module Basico.Ejemplo where
import Dibujo
import Interp

type Bas = ()

ejemplo :: Dibujo Bas
ejemplo = Basica ()

interpBas :: Output a
interpBas a = trian2
