package.path = package.path .. ";../../?.lua"


require("../../src/core/LuaNa")


local doc = Document:create()

-- doc:loadNcl("../../docs/comerciaisproview/ComerciaisProview.ncl")
-- doc:loadNcl("../../docs/comerciaisproview/regionBase.reg")

-- doc:loadNcl("../../docs/gingahero/connectorBase.ncl")
-- doc:loadNcl("../../docs/gingahero/main.ncl")

-- doc:loadNcl("../../docs/hackerteen/main.ncl")

-- doc:loadNcl("../../docs/jogovelha_Peta5/main.ncl")

-- doc:loadNcl("../../docs/luaRocks/main.ncl")

-- load this file
   doc:loadNcl("../../docs/nclcd/exemplo01.ncl")

-- doc:loadNcl("../../docs/nclcd/composerConnectorBase.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo02.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo02.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo02.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo03.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo03.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo04.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo04.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo05.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo05.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo06.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo06.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo07.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo07.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo08.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo08.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo09.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo09.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo10.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo10.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo11.conn")
-- doc:loadNcl("../../docs/nclcd/exemplo11.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo12.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo13.ncl")
-- doc:loadNcl("../../docs/nclcd/exemplo14.ncl")
-- doc:loadNcl("../../docs/nclcd/exercicio01.ncl")

-- Error! Document with invalid syntax!
-- doc:loadNcl("../../docs/nclcd/exercicio02.ncl")
-- doc:loadNcl("../../docs/nclcd/exercicio03.ncl")

-- Error! Unknown  component associated to port element!
-- doc:loadNcl("../../docs/nclcd/exercicio04.ncl"

-- doc:loadNcl("../../docs/nclcd/exercicio05.ncl")

-- doc:loadNcl("../../docs/primeirojoao/00syncProp.ncl")
-- doc:loadNcl("../../docs/primeirojoao/01sync.ncl")
-- doc:loadNcl("../../docs/primeirojoao/02syncInt.ncl")
-- doc:loadNcl("../../docs/primeirojoao/03context.ncl")
-- doc:loadNcl("../../docs/primeirojoao/04reuse.ncl")
-- doc:loadNcl("../../docs/primeirojoao/05return.ncl")
-- doc:loadNcl("../../docs/primeirojoao/06switch.ncl")
-- doc:loadNcl("../../docs/primeirojoao/07transition.ncl")
-- doc:loadNcl("../../docs/primeirojoao/08animation.ncl")
-- doc:loadNcl("../../docs/primeirojoao/09settings.ncl")
-- doc:loadNcl("../../docs/primeirojoao/10menu.ncl")
-- doc:loadNcl("../../docs/primeirojoao/11nclua.ncl")
-- doc:loadNcl("../../docs/primeirojoao/12embNCL.ncl")
-- doc:loadNcl("../../docs/primeirojoao/advert.ncl")
-- doc:loadNcl("../../docs/primeirojoao/causalConnBase.ncl")

-- doc:loadNcl("../../docs/raiderOfTheLostVideogame/RaiderOfTheLostVideogame.ncl")

-- doc:loadNcl("../../docs/sultan/sultan.ncl")
-- doc:loadNcl("../../docs/sultan/sultan.ncl~")

-- doc:loadNcl("../../docs/tvdigitalsocial/calPagamento.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/central135.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/conectores.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/descritores.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/localizarAgencia.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/main.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/regioes.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/tabelaContribuicao.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/twitterDataprev.ncl")
-- doc:loadNcl("../../docs/tvdigitalsocial/twitterPrevidencia.ncl")

doc:writeNcl()
