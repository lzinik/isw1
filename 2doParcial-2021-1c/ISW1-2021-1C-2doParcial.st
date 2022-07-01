!classDefinition: #CartaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #CartaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test01SonIgualesConMismoPaloYNumero

	self assert: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test02SonDistintasConDistintoPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco oroCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test03SonDistintasConNumeroAunqueIgualPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 2) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test04CartasIgualesTienenElMismoHash

	self assert: (CartaDeTruco bastoCon: 1) hash equals: (CartaDeTruco bastoCon: 1) hash

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test05UnaCartaEsDistintaACualquierObjetoQueNoSeaCarta

	self deny: (CartaDeTruco bastoCon: 1) = 1! !


!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test07NoHayCartaDeTrucoConNumeroOcho

	self 
		should: [ CartaDeTruco oroCon: 8 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test08NoHayCartaDeTrucoConNumeroNueve

	self 
		should: [ CartaDeTruco oroCon: 9 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:12'!
test09LosPalosDeLaCartaDeTrucoSonBastoOroEspadaYCopa

	self 
		should: [ CartaDeTruco palo: #otro numero: 1 ]
		raise: Error
		withMessageText: CartaDeTruco paloInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test10NoSePuedeCrearCartaConNumeroMenorAUno

	self 
		should: [ CartaDeTruco espadaCon: 0 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test11NoSePuedeCrearCartaConNumeroMayorADoce

	self 
		should: [ CartaDeTruco espadaCon: 13 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test12ElNumeroDeLaCartaDebeSerEntero

	self 
		should: [ CartaDeTruco espadaCon: 1.1 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !


!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:55:30'!
test13LaTablaDeValoresEsCorrecta

	self assert: (CartaDeTruco anchoDeEspada mataA: CartaDeTruco anchoDeBasto).
	self assert: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco sieteDeEspada).
	self assert: (CartaDeTruco sieteDeEspada mataA: CartaDeTruco sieteDeOro).
	self assert: (CartaDeTruco sieteDeOro mataA: (CartaDeTruco espadaCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) empardaCon: (CartaDeTruco oroCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) mataA: (CartaDeTruco espadaCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) empardaCon: (CartaDeTruco oroCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) mataA: (CartaDeTruco oroCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) empardaCon: (CartaDeTruco copaCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) mataA: (CartaDeTruco espadaCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) empardaCon: (CartaDeTruco oroCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) mataA: (CartaDeTruco espadaCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) empardaCon: (CartaDeTruco oroCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) mataA: (CartaDeTruco espadaCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) empardaCon: (CartaDeTruco oroCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) mataA: (CartaDeTruco copaCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) empardaCon: (CartaDeTruco bastoCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) mataA: (CartaDeTruco espadaCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) empardaCon: (CartaDeTruco oroCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) mataA: (CartaDeTruco espadaCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) empardaCon: (CartaDeTruco oroCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) mataA: (CartaDeTruco espadaCon: 4)).
	self assert: ((CartaDeTruco espadaCon: 4) empardaCon: (CartaDeTruco oroCon: 4)).

	{ 3. 2. 12. 11. 10. 6. 5. 4 } do: [ :unNumero |
		CartaDeTruco palos do: [ :unPalo | 
			self assert: ((CartaDeTruco espadaCon: unNumero) empardaCon: (CartaDeTruco palo: unPalo numero: unNumero)) ]]
	! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:49:51'!
test14HayCartasQueNoSonPardas

	self deny: (CartaDeTruco anchoDeEspada empardaCon: CartaDeTruco anchoDeBasto)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:49:59'!
test15HayCartasQuePierdenConOtras

	self deny: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco anchoDeEspada)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:53:21'!
test16SieteDeCopasYDeBastoEsSieteFalso

	self assert: (CartaDeTruco copaCon: 7) esSieteFalso.
	self assert: (CartaDeTruco bastoCon: 7) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:54:57'!
test17SieteDeOroYDeEspadaNoSonSieteFalso

	self deny: (CartaDeTruco sieteDeOro) esSieteFalso.
	self deny: (CartaDeTruco sieteDeEspada) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:55:53'!
test18AnchoDeOroYDeCopaSonAnchoFalsos

	self assert: (CartaDeTruco oroCon: 1) esAnchoFalso.
	self assert: (CartaDeTruco copaCon: 1) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:56:28'!
test19AnchoDeEspadaYDeBastosNoSonAnchoFalsos

	self deny: (CartaDeTruco anchoDeEspada) esAnchoFalso.
	self deny: (CartaDeTruco anchoDeBasto) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 11:58:24'!
test20FallaBuscandoValorDeCartaInválida

	"Creo una carta de manera inválida para probar la correctitud del la tabla de valores - Hernan"
	self 
		should: [ CartaDeTruco new initializePalo: #invalido numero: 1; valor ]
		raise: Error 
		withMessageText: CartaDeTruco tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!classDefinition: #RondaDeTrucoTest category: 'ISW1-2021-1C-2doParcial'!
TestCase subclass: #RondaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 20:07:17'!
test01LaManoNoPuedeTenerMenosDe3Cartas
	
	self 
		should: [RondaDeTruco conMano: self manoConMenosDe3Cartas conPie: self manoValida]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 20:07:36'!
test02ElPieNoPuedeTenerMenosDe3Cartas
	
	self 
		should: [RondaDeTruco conMano: self manoConMenosDe3Cartas conPie: self manoValida]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 20:07:47'!
test03LaManoNoPuedeTenerMasDe3Cartas
	
	self 
		should: [RondaDeTruco conMano: self manoConMasDe3Cartas conPie: self manoValida]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 20:08:03'!
test04ElPieNoPuedeTenerMasDe3Cartas
	
	self 
		should: [RondaDeTruco conMano: self manoValida conPie: self manoConMasDe3Cartas]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 20:08:41'!
test05NoPuedeHaberCartasRepetidasEntreLasManos
	
	self 
		should: [RondaDeTruco conMano: self manoValida conPie: self manoConCartasRepetidas]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco manoInvalidaErrorDescription.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 20:40:58'!
test06EmpiezaJugandoLaMano

	| rondaDeTruco |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	self assert: rondaDeTruco juegaLaMano.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 20:41:29'!
test07NoPuedeJugarUnaCartaQueNoTiene

	| rondaDeTruco |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	self 
		should: [rondaDeTruco manoJuega: CartaDeTruco sieteDeOro]
		raise: Error - MessageNotUnderstood
		withMessageText: rondaDeTruco noPuedeJugarUnaCartaQueNoTieneError! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 20:53:06'!
test08SeJugoLaCartaElegida

	| rondaDeTruco cartaDeMano |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaDeMano := CartaDeTruco espadaCon: 4.
	
	rondaDeTruco manoJuega: cartaDeMano.
	
	self assert: (rondaDeTruco manoJugo: cartaDeMano)! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 21:25:49'!
test09NoPuedeJugarLaManoDespuesDeHaberJugado

	| rondaDeTruco |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	rondaDeTruco manoJuega: (CartaDeTruco espadaCon: 4).
	
	self 
		should: [rondaDeTruco manoJuega: (CartaDeTruco anchoDeBasto )]
		raise: Error - MessageNotUnderstood
		withMessageText: rondaDeTruco noEsElTurnoDelJugador! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 21:42:06'!
test10JuegaElPieDespuesDeQueJuegaLaManoPorPrimeraVez

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	
	self assert: (rondaDeTruco manoJugo: cartaJugadaPorMano).
	self assert: (rondaDeTruco pieJugo: cartaJugadaPorPie).! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 21:42:17'!
test11JuegaElPieSiGanoElEnfrentamientoAnterior

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	
	self assert: (rondaDeTruco manoJugo: cartaJugadaPorMano).
	self assert: (rondaDeTruco pieJugo: cartaJugadaPorPie).
	self assert: rondaDeTruco juegaElPie.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 21:42:48'!
test12JuegaLaManoSiGanoElEnfrentamientoAnterior

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco anchoDeBasto .
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	
	self assert: (rondaDeTruco manoJugo: cartaJugadaPorMano).
	self assert: (rondaDeTruco pieJugo: cartaJugadaPorPie).
	self assert: rondaDeTruco juegaLaMano.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 21:49:49'!
test13ManoNoPuedeVolverAJugarUnaCartaQueYaJugo

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco anchoDeBasto .
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	
	self 
		should: [rondaDeTruco manoJuega: cartaJugadaPorMano]
		raise: Error - MessageNotUnderstood
		withMessageText: rondaDeTruco noPuedeJugarUnaCartaQueNoTieneError.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 21:51:10'!
test14PieNoPuedeVolverAJugarUnaCartaQueYaJugo

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie otraCartaJugadaPorMano |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco anchoDeBasto .
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
	otraCartaJugadaPorMano := CartaDeTruco espadaCon: 4.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	rondaDeTruco manoJuega: otraCartaJugadaPorMano.
	
	self 
		should: [rondaDeTruco pieJuega: cartaJugadaPorPie]
		raise: Error - MessageNotUnderstood
		withMessageText: rondaDeTruco noPuedeJugarUnaCartaQueNoTieneError.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 6/30/2022 21:57:01'!
test15ManoGanaSiGanoDosEnfrentamientos

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie otraCartaJugadaPorMano otraCartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco anchoDeBasto .
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
	otraCartaJugadaPorMano := CartaDeTruco espadaCon: 12.
	otraCartaJugadaPorPie := CartaDeTruco oroCon: 5.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	rondaDeTruco manoJuega: otraCartaJugadaPorMano.
	rondaDeTruco pieJuega: otraCartaJugadaPorPie.
	
	"ASERTAR QUE MANO JUGO ANCHO Y 12, Y PIE JUGO 2 Y 5"! !


!RondaDeTrucoTest methodsFor: 'test data' stamp: 'LZ 6/30/2022 20:17:35'!
manoConCartasRepetidas
	
	^ Set with: (CartaDeTruco espadaCon: 4) with: (CartaDeTruco bastoCon: 5) with: (CartaDeTruco oroCon: 6). ! !

!RondaDeTrucoTest methodsFor: 'test data' stamp: 'LZ 6/30/2022 21:25:00'!
manoConMasDe3Cartas
	
	^ Set with: (CartaDeTruco bastoCon: 12) with: (CartaDeTruco bastoCon: 2) with: (CartaDeTruco bastoCon: 3) with: (CartaDeTruco bastoCon: 4) ! !

!RondaDeTrucoTest methodsFor: 'test data' stamp: 'LZ 6/30/2022 19:57:18'!
manoConMenosDe3Cartas
	
	^ Set with: (CartaDeTruco copaCon: 4) with: (CartaDeTruco copaCon: 5). ! !

!RondaDeTrucoTest methodsFor: 'test data' stamp: 'LZ 6/30/2022 21:22:41'!
manoValida
	
	^ Set with: (CartaDeTruco espadaCon: 4) with: (CartaDeTruco anchoDeBasto ) with: (CartaDeTruco espadaCon: 12). ! !

!RondaDeTrucoTest methodsFor: 'test data' stamp: 'LZ 6/30/2022 21:54:47'!
otraManoValida
	
	^ Set with: (CartaDeTruco oroCon: 2) with: (CartaDeTruco copaCon: 4) with: (CartaDeTruco oroCon: 5)! !


!classDefinition: #CartaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #CartaDeTruco
	instanceVariableNames: 'palo numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!CartaDeTruco methodsFor: 'initialization' stamp: 'HAW 7/3/2021 15:27:51'!
initializePalo: unPalo numero: unNumero 
	
	palo := unPalo.
	numero := unNumero.! !


!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:44:36'!
= unaCarta 
	
	^(unaCarta isKindOf: self class) and: [(unaCarta paloEs: palo) and: [ unaCarta numeroEs: numero ]]! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/5/2021 10:49:51'!
empardaCon: cartaParda

	^self valor = cartaParda valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:43:24'!
hash
	
	^palo hash bitXor: numero hash ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/5/2021 10:49:59'!
mataA: cartaPerdedora

	^self valor < cartaPerdedora valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:41:53'!
numeroEs: unNumero

	^numero = unNumero ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:41:39'!
paloEs: unPalo

	^palo = unPalo ! !


!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:20'!
esAncho

	^ self numeroEs: 1! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:31'!
esAnchoDeBasto
	
	^self esAncho and: [ self esDeBasto ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:41'!
esAnchoDeEspada
	
	^self esAncho and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:20'!
esAnchoFalso
	
	^self esAncho and: [ self esDeOro or: [ self esDeCopa ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:32'!
esCaballo
	
	^self numeroEs: 11! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:25:29'!
esDeBasto
	
	^self paloEs: self basto! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:09'!
esDeCopa
	
	^self paloEs: self copa! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:18'!
esDeEspada
	
	^self paloEs: self espada ! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:35'!
esDeOro
	
	^self paloEs: self oro! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:22'!
esRey
	
	^self numeroEs: 12! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:16:57'!
esSiete
	
	^self numeroEs: 7! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:27:00'!
esSieteDeEspadas
	
	^self esSiete and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:27:15'!
esSieteDeOro
	
	^self esSiete and: [ self esDeOro ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:09'!
esSieteFalso
	
	^self esSiete and: [ self esDeCopa or: [ self esDeBasto ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:43'!
esSota
	
	^self numeroEs: 10! !


!CartaDeTruco methodsFor: 'printing' stamp: 'HAW 7/3/2021 15:14:43'!
printOn: aStream

	aStream 
		print: numero;
		nextPutAll: ' de ';
		nextPutAll: 	palo ! !


!CartaDeTruco methodsFor: 'valor' stamp: 'HAW 7/3/2021 14:51:09'!
valor
	
	^self class valorDe: self! !


!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:33'!
basto
	
	^self class basto! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:44'!
copa

	^ self class copa! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:08'!
espada
	
	^self class espada! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:26:27'!
oro

	^ self class oro! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
CartaDeTruco class
	instanceVariableNames: 'ordenDePrioridad'!

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 17:49:37'!
anchoDeBasto
	
	^self bastoCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 17:49:57'!
anchoDeEspada
	
	^self espadaCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:03'!
bastoCon: unNumero

	^self palo: self basto numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:08'!
copaCon: unNumero

	^self palo: self copa numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:16'!
espadaCon: unNumero

	^self palo: self espada numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:34'!
oroCon: unNumero

	^self palo: self oro numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 18:06:08'!
palo: unPalo numero: unNumero 
	
	self assertNúmeroEsVálido: unNumero.
	self assertPaloEsVálido: unPalo.
	
	^self new initializePalo: unPalo numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 15:12:50'!
sieteDeEspada
	
	^self espadaCon: 7! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 15:17:44'!
sieteDeOro
	
	^self oroCon: 7! !


!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:56:25'!
basto
	
	^#basto! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:57:25'!
copa
	
	^#copa! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:55:44'!
espada
	
	^#espada! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:57:43'!
oro
	
	^#oro! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/4/2021 18:07:36'!
palos

	"No se puede acceder a self en backtick, por eso se usa CartaDeTruco como receiver - Hernan"
	^ `{CartaDeTruco espada. CartaDeTruco basto. CartaDeTruco oro. CartaDeTruco copa }`! !


!CartaDeTruco class methodsFor: 'initialization' stamp: 'HAW 7/5/2021 10:52:07'!
initializeOrdenDePrioridad
	
	"Cuanto más chico sea el índice de la carta en esta colección, más valor tiene - Hernan"
	ordenDePrioridad := OrderedCollection new.
	
	ordenDePrioridad 
		add: [ :carta | carta esAnchoDeEspada ];
		add: [ :carta | carta esAnchoDeBasto ];
		add: [ :carta | carta esSieteDeEspadas ];
		add: [ :carta | carta esSieteDeOro ];
		add: [ :carta | carta numeroEs: 3 ];
		add: [ :carta | carta numeroEs: 2 ];
		add: [ :carta | carta esAnchoFalso ];
		add: [ :carta | carta esRey ];
		add: [ :carta | carta esCaballo ];
		add: [ :carta | carta esSota ];
		add: [ :carta | carta esSieteFalso ];
		add: [ :carta | carta numeroEs: 6 ];
		add: [ :carta | carta numeroEs: 5 ];
		add: [ :carta | carta numeroEs: 4 ];
		yourself.
	
	! !


!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 7/3/2021 14:54:01'!
ordenDePrioridad
	
	^ordenDePrioridad ifNil: [ self initializeOrdenDePrioridad ] ! !

!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 7/5/2021 11:58:24'!
valorDe: unaCarta 
	
	self ordenDePrioridad withIndexDo: [ :bloqueDeVerificacion :index |
		(bloqueDeVerificacion value: unaCarta) ifTrue: [ ^index ]].
	
	self error: self tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:02'!
numeroDeCartaInvalidoErrorDescription
	
	^'El truco no se puede jugar con ochos ni con nueves'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:12'!
paloInvalidoErrorDescription
	
	^'Los palos de la carta solo pueden ser espada, basto, oro y copa'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:24'!
tablaDeValoresIncorrectaOCartaInvalidaErrorDescription
	
	^'Error de programación: Tabla de valores incorrecta o carta inválida'! !


!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:02'!
assertNúmeroEsVálido: unNumero

	unNumero < 1 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero > 12 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	(unNumero between: 8 and: 9) ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero isInteger ifFalse: [ self error: self numeroDeCartaInvalidoErrorDescription ]! !

!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:12'!
assertPaloEsVálido: unPalo

	^ (self palos includes: unPalo) ifFalse: [ self error: self paloInvalidoErrorDescription ]! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'manoDeCartas otraManoDeCartas_CHANGE_ME cartasDeJugadorMano cartasDeJugadorPie turno ultimaCartaJugadaPorMano ultimaCartaJugadaPorPie cartasJugadasPorPie cartasJugadasPorMano'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialization' stamp: 'LZ 6/30/2022 21:39:47'!
initializeConMano: unaManoDeCartas conPie: otraManoDeCartas 

	turno := #Mano.
	cartasDeJugadorMano := unaManoDeCartas.
	cartasDeJugadorPie := otraManoDeCartas.
	cartasJugadasPorMano := OrderedCollection new.
	cartasJugadasPorPie := OrderedCollection new.! !


!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 6/30/2022 21:03:01'!
assert: unaManoDeCartas jugoUnaCartaQueTiene: unaCartaDeTruco

	^ (unaManoDeCartas includes: unaCartaDeTruco) ifFalse:[self error: self noPuedeJugarUnaCartaQueNoTieneError ].! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 6/30/2022 21:06:20'!
assertEsTurnoDe: unJugador

	^ turno = unJugador ifFalse:[ self error: self noEsElTurnoDelJugador ].! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 6/30/2022 21:44:45'!
juegaElPie
	
	^ turno = #Pie.! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 6/30/2022 21:27:33'!
juegaLaMano
	
	^ turno = #Mano.! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 6/30/2022 21:01:53'!
manoJugo: unaCartaDeTruco 
	
	^ ultimaCartaJugadaPorMano = unaCartaDeTruco.
	! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 6/30/2022 21:14:35'!
pieJugo: unaCartaDeTruco 
	
	^ ultimaCartaJugadaPorPie = unaCartaDeTruco.! !


!RondaDeTruco methodsFor: 'error descriptions' stamp: 'LZ 6/30/2022 21:03:25'!
noEsElTurnoDelJugador
	
	^ 'No es el turno del jugador'.! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'LZ 6/30/2022 20:41:29'!
noPuedeJugarUnaCartaQueNoTieneError
	
	^ 'No puede jugar una carta que no tiene'.! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'LZ 6/30/2022 21:46:36'!
manoJuega: unaCartaDeTruco

	self assert: cartasDeJugadorMano jugoUnaCartaQueTiene: unaCartaDeTruco.
	self assertEsTurnoDe: #Mano.
	
	ultimaCartaJugadaPorMano := unaCartaDeTruco.
	
	cartasJugadasPorMano add: unaCartaDeTruco.
	cartasDeJugadorMano remove: unaCartaDeTruco.
	
	turno := #Pie.! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'LZ 6/30/2022 21:43:56'!
pieJuega: unaCartaDeTruco

	self assert: cartasDeJugadorPie jugoUnaCartaQueTiene: unaCartaDeTruco.
	self assertEsTurnoDe: #Pie.

	ultimaCartaJugadaPorPie := unaCartaDeTruco.
	
	cartasJugadasPorPie add: unaCartaDeTruco.
	cartasDeJugadorPie remove: unaCartaDeTruco.
	
	(cartasJugadasPorMano size + cartasJugadasPorPie size) even ifTrue: [
		(ultimaCartaJugadaPorPie mataA: ultimaCartaJugadaPorMano) ifTrue: [
			turno := #Pie
		].
		(ultimaCartaJugadaPorMano mataA: ultimaCartaJugadaPorPie) ifTrue: [
			turno := #Mano
		].
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-2doParcial'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'LZ 6/30/2022 19:59:56'!
conMano: unaManoDeCartas conPie: otraManoDeCartas

	self assertEsValida: unaManoDeCartas yEsValida: otraManoDeCartas.

	^ self new initializeConMano: unaManoDeCartas conPie: otraManoDeCartas.! !


!RondaDeTruco class methodsFor: 'assertions' stamp: 'LZ 6/30/2022 20:12:01'!
assertEsValida: unaManoDeCartas yEsValida: otraManoDeCartas

	(unaManoDeCartas union: otraManoDeCartas) size = 6 ifFalse:[self error: self manoInvalidaErrorDescription ].
	
	! !


!RondaDeTruco class methodsFor: 'error descriptions' stamp: 'LZ 6/30/2022 19:48:10'!
manoInvalidaErrorDescription
	
	^ 'La mano es invalida'.! !
