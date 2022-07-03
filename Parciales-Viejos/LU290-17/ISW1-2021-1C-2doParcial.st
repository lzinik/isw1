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

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 22:52:58'!
test06ManoEmpiezaJugando

	| rondaDeTruco |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	rondaDeTruco manoJuega: (CartaDeTruco espadaCon: 4).
	
	self assert: (rondaDeTruco cartasJugadasPorManoSon: (OrderedCollection with: (CartaDeTruco espadaCon:4)) )! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 23:00:38'!
test07NoPuedeJugarUnaCartaQueNoTiene

	| rondaDeTruco |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	self 
		should: [rondaDeTruco manoJuega: CartaDeTruco sieteDeOro]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: rondaDeTruco noPuedeJugarUnaCartaQueNoTieneError equals: anError messageText.
			self assert: (rondaDeTruco cartasJugadasPorManoSon: OrderedCollection new).
		]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 12:37:01'!
test08SeJugoLaCartaElegida

	| rondaDeTruco cartaDeMano |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaDeMano := CartaDeTruco espadaCon: 4.
	
	rondaDeTruco manoJuega: cartaDeMano.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: cartaDeMano))! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 23:07:59'!
test09NoPuedeJugarLaManoDespuesDeHaberJugado

	| rondaDeTruco |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	rondaDeTruco manoJuega: (CartaDeTruco espadaCon: 4).

	self 
		should: [rondaDeTruco manoJuega: CartaDeTruco anchoDeBasto]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: rondaDeTruco noEsElTurnoDelJugador equals: anError messageText.
			self assert: (rondaDeTruco cartasJugadasPorManoSon: (OrderedCollection with: (CartaDeTruco espadaCon: 4))).
		]! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 23:13:35'!
test10JuegaElPieDespuesDeQueJuegaLaManoPorPrimeraVez

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: cartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: cartaJugadaPorPie )).! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 23:19:03'!
test11JuegaElPieSiGanoElEnfrentamientoAnterior

	| rondaDeTruco cartaJugadaPorMano primeraCartaJugadaPorElPie segundaCartaJugadaPorElPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	primeraCartaJugadaPorElPie := CartaDeTruco oroCon: 2.
	segundaCartaJugadaPorElPie := CartaDeTruco oroCon: 5.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: primeraCartaJugadaPorElPie.
	rondaDeTruco pieJuega: segundaCartaJugadaPorElPie.	
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: cartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo:  (OrderedCollection with: primeraCartaJugadaPorElPie with: segundaCartaJugadaPorElPie )).! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 23:22:37'!
test12JuegaLaManoSiGanoElEnfrentamientoAnterior

	| rondaDeTruco primerCartaJugadaPorLaMano cartaJugadaPorPie segundaCartaJugadaPorLaMano |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primerCartaJugadaPorLaMano := CartaDeTruco anchoDeBasto .
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
	segundaCartaJugadaPorLaMano := CartaDeTruco espadaCon: 4.
		
	rondaDeTruco manoJuega: primerCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorLaMano.
	
	self assert: (rondaDeTruco manoJugo:  (OrderedCollection with: primerCartaJugadaPorLaMano with: segundaCartaJugadaPorLaMano)).
	self assert: (rondaDeTruco pieJugo:  (OrderedCollection with: cartaJugadaPorPie)).! !

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

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 15:50:07'!
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
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: cartaJugadaPorMano with: otraCartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: cartaJugadaPorPie with: otraCartaJugadaPorPie)).
	
	self assert: rondaDeTruco manoGanoLaRonda.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 15:50:24'!
test16PieGanaSiGanoDosEnfrentamientos

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie otraCartaJugadaPorMano otraCartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco espadaCon: 12 .
	otraCartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
	otraCartaJugadaPorPie := CartaDeTruco oroCon: 5.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	rondaDeTruco pieJuega: otraCartaJugadaPorPie.	
	rondaDeTruco manoJuega: otraCartaJugadaPorMano.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: cartaJugadaPorMano with: otraCartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: cartaJugadaPorPie with: otraCartaJugadaPorPie)).
	
	self assert: rondaDeTruco pieGanoLaRonda.! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 15:50:06'!
test17NoSePuedeSeguirJugandoSiYaGanoMano

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie otraCartaJugadaPorMano otraCartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco anchoDeBasto .
	otraCartaJugadaPorMano := CartaDeTruco espadaCon: 12.
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
	otraCartaJugadaPorPie := CartaDeTruco oroCon: 5.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	rondaDeTruco manoJuega: otraCartaJugadaPorMano.
	rondaDeTruco pieJuega: otraCartaJugadaPorPie.	
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: cartaJugadaPorMano with: otraCartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: cartaJugadaPorPie with: otraCartaJugadaPorPie)).
	self assert: rondaDeTruco manoGanoLaRonda.
	
	self 
		should: [rondaDeTruco manoJuega: (CartaDeTruco espadaCon: 4)]
		raise: Error - MessageNotUnderstood 
		withMessageText: rondaDeTruco noSePuedeJugarDespuesDeQueHayaUnGanadorError.
	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 15:50:25'!
test18NoSePuedeSeguirJugandoSiYaGanoPie

	| rondaDeTruco cartaJugadaPorMano cartaJugadaPorPie otraCartaJugadaPorMano otraCartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	cartaJugadaPorMano := CartaDeTruco espadaCon: 12 .
	otraCartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	cartaJugadaPorPie := CartaDeTruco oroCon: 2.
	otraCartaJugadaPorPie := CartaDeTruco oroCon: 5.
		
	rondaDeTruco manoJuega: cartaJugadaPorMano.
	rondaDeTruco pieJuega: cartaJugadaPorPie.
	rondaDeTruco pieJuega: otraCartaJugadaPorPie.	
	rondaDeTruco manoJuega: otraCartaJugadaPorMano .
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: cartaJugadaPorMano with: otraCartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: cartaJugadaPorPie with: otraCartaJugadaPorPie)).
	self assert: rondaDeTruco pieGanoLaRonda .
	
	self 
		should: [rondaDeTruco pieJuega: (CartaDeTruco copaCon: 4)]
		raise: Error - MessageNotUnderstood 
		withMessageText: rondaDeTruco noSePuedeJugarDespuesDeQueHayaUnGanadorError.
	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 23:28:56'!
test19JuegaLaManoSiElPieGanoElPrimerEnfrentamientoYLaManoGanoElSegundoEnfrentamiento

	| rondaDeTruco primerCartaJugadaPorLaMano primerCartaJugadaPorElPie segundaCartaJugadaPorLaMano segundaCartaJugadaPorElPie terceraCartaJugadaPorLaMano |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primerCartaJugadaPorLaMano := CartaDeTruco espadaCon: 4 .
	primerCartaJugadaPorElPie := CartaDeTruco oroCon: 2.
	segundaCartaJugadaPorElPie := CartaDeTruco oroCon: 5.
	segundaCartaJugadaPorLaMano := CartaDeTruco espadaCon: 12.
	terceraCartaJugadaPorLaMano := CartaDeTruco anchoDeBasto.
		
	rondaDeTruco manoJuega: primerCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: primerCartaJugadaPorElPie.
	rondaDeTruco pieJuega: segundaCartaJugadaPorElPie.	
	rondaDeTruco manoJuega: segundaCartaJugadaPorLaMano .
	rondaDeTruco manoJuega: terceraCartaJugadaPorLaMano .	
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primerCartaJugadaPorLaMano with: segundaCartaJugadaPorLaMano with: terceraCartaJugadaPorLaMano )).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: primerCartaJugadaPorElPie with: segundaCartaJugadaPorElPie)).
	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 23:30:24'!
test20JuegaElPieSiLaManoGanoElPrimerEnfrentamientoYElPieGanoElSegundoEnfrentamiento

	| rondaDeTruco primerCartaJugadaPorLaMano primerCartaJugadaPorElPie segundaCartaJugadaPorLaMano segundaCartaJugadaPorElPie terceraCartaJugadaPorElPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primerCartaJugadaPorLaMano := CartaDeTruco espadaCon: 12 .
	segundaCartaJugadaPorLaMano := CartaDeTruco espadaCon: 4.
	primerCartaJugadaPorElPie := CartaDeTruco oroCon: 5.
	segundaCartaJugadaPorElPie := CartaDeTruco oroCon: 2.
	terceraCartaJugadaPorElPie := CartaDeTruco copaCon: 4.
		
	rondaDeTruco manoJuega: primerCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: primerCartaJugadaPorElPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: segundaCartaJugadaPorElPie.	
	rondaDeTruco pieJuega: terceraCartaJugadaPorElPie.	
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primerCartaJugadaPorLaMano with: segundaCartaJugadaPorLaMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: primerCartaJugadaPorElPie with: segundaCartaJugadaPorElPie with: terceraCartaJugadaPorElPie )).
	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 16:14:48'!
test21GanaLaManoSiGanoElPrimerYTercerEnfrentamiento
	
	| rondaDeTruco primeraCartaJugadaPorMano primeraCartaJugadaPorPie segundaCartaJugadaPorMano segundaCartaJugadaPorPie terceraCartaJugadaPorMano terceraCartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primeraCartaJugadaPorMano := CartaDeTruco espadaCon: 12.
	segundaCartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	terceraCartaJugadaPorMano := CartaDeTruco anchoDeBasto.
	
	primeraCartaJugadaPorPie := CartaDeTruco oroCon: 5.
	segundaCartaJugadaPorPie := CartaDeTruco oroCon: 2.
	terceraCartaJugadaPorPie := CartaDeTruco copaCon: 4.
		
	rondaDeTruco manoJuega: primeraCartaJugadaPorMano.
	rondaDeTruco pieJuega: primeraCartaJugadaPorPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorMano.	
	rondaDeTruco pieJuega: segundaCartaJugadaPorPie.
	rondaDeTruco pieJuega: terceraCartaJugadaPorPie.
	rondaDeTruco manoJuega: terceraCartaJugadaPorMano.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primeraCartaJugadaPorMano with: segundaCartaJugadaPorMano with: terceraCartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: primeraCartaJugadaPorPie with: segundaCartaJugadaPorPie with: terceraCartaJugadaPorPie)).
	
	self assert: rondaDeTruco manoGanoLaRonda.
	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 16:16:24'!
test22GanaElPieSiGanoElPrimerYTercerEnfrentamiento
	
	| rondaDeTruco primeraCartaJugadaPorMano primeraCartaJugadaPorPie segundaCartaJugadaPorMano segundaCartaJugadaPorPie terceraCartaJugadaPorMano terceraCartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primeraCartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	segundaCartaJugadaPorMano := CartaDeTruco anchoDeBasto.
	terceraCartaJugadaPorMano := CartaDeTruco espadaCon: 12.
	
	primeraCartaJugadaPorPie := CartaDeTruco oroCon: 5.
	segundaCartaJugadaPorPie := CartaDeTruco copaCon: 4.
	terceraCartaJugadaPorPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: primeraCartaJugadaPorMano.
	rondaDeTruco pieJuega: primeraCartaJugadaPorPie.
	rondaDeTruco pieJuega: segundaCartaJugadaPorPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorMano.	
	rondaDeTruco manoJuega: terceraCartaJugadaPorMano.
	rondaDeTruco pieJuega: terceraCartaJugadaPorPie.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primeraCartaJugadaPorMano with: segundaCartaJugadaPorMano with: terceraCartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: primeraCartaJugadaPorPie with: segundaCartaJugadaPorPie with: terceraCartaJugadaPorPie)).
	
	self assert: rondaDeTruco pieGanoLaRonda.
	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 16:18:13'!
test23GanaElPieSiPerdioElPrimerEnfrentamientoPeroGanoElSegundoYTercero
	
	| rondaDeTruco primeraCartaJugadaPorMano primeraCartaJugadaPorPie segundaCartaJugadaPorMano segundaCartaJugadaPorPie terceraCartaJugadaPorMano terceraCartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primeraCartaJugadaPorMano := CartaDeTruco anchoDeBasto.
	segundaCartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	terceraCartaJugadaPorMano := CartaDeTruco espadaCon: 12.
	
	primeraCartaJugadaPorPie := CartaDeTruco copaCon: 4.
	segundaCartaJugadaPorPie := CartaDeTruco oroCon: 5.
	terceraCartaJugadaPorPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: primeraCartaJugadaPorMano.
	rondaDeTruco pieJuega: primeraCartaJugadaPorPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorMano.	
	rondaDeTruco pieJuega: segundaCartaJugadaPorPie.
	rondaDeTruco pieJuega: terceraCartaJugadaPorPie.
	rondaDeTruco manoJuega: terceraCartaJugadaPorMano.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primeraCartaJugadaPorMano with: segundaCartaJugadaPorMano with: terceraCartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: primeraCartaJugadaPorPie with: segundaCartaJugadaPorPie with: terceraCartaJugadaPorPie)).
	
	self assert: rondaDeTruco pieGanoLaRonda.
	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 16:18:21'!
test24GanaLaManoSiPerdioElPrimerEnfrentamientoPeroGanoElSegundoYTercero
	
	| rondaDeTruco primeraCartaJugadaPorMano primeraCartaJugadaPorPie segundaCartaJugadaPorMano segundaCartaJugadaPorPie terceraCartaJugadaPorMano terceraCartaJugadaPorPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primeraCartaJugadaPorMano := CartaDeTruco espadaCon: 4.
	segundaCartaJugadaPorMano := CartaDeTruco anchoDeBasto.
	terceraCartaJugadaPorMano := CartaDeTruco espadaCon: 12.
	
	primeraCartaJugadaPorPie := CartaDeTruco oroCon: 2.
	segundaCartaJugadaPorPie := CartaDeTruco copaCon: 4.
	terceraCartaJugadaPorPie := CartaDeTruco oroCon: 5.
		
	rondaDeTruco manoJuega: primeraCartaJugadaPorMano.
	rondaDeTruco pieJuega: primeraCartaJugadaPorPie.
	rondaDeTruco pieJuega: segundaCartaJugadaPorPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorMano.	
	rondaDeTruco manoJuega: terceraCartaJugadaPorMano.
	rondaDeTruco pieJuega: terceraCartaJugadaPorPie.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primeraCartaJugadaPorMano with: segundaCartaJugadaPorMano with: terceraCartaJugadaPorMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: primeraCartaJugadaPorPie with: segundaCartaJugadaPorPie with: terceraCartaJugadaPorPie)).
	
	self assert: rondaDeTruco manoGanoLaRonda.
	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 23:31:35'!
test25JuegaLaManoSiEmpardaronElPrimerEnfrentamiento
	
	| rondaDeTruco primerCartaJugadaPorLaMano cartaJugadaPorElPie segundaCartaJugadaPorLaMano |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primerCartaJugadaPorLaMano := CartaDeTruco espadaCon: 4.
	cartaJugadaPorElPie := CartaDeTruco copaCon: 4.
	segundaCartaJugadaPorLaMano := CartaDeTruco anchoDeBasto.
		
	rondaDeTruco manoJuega: primerCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: cartaJugadaPorElPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorLaMano.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primerCartaJugadaPorLaMano with: segundaCartaJugadaPorLaMano)).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: cartaJugadaPorElPie )).
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 17:24:55'!
test26GanaLaManoSiEmpardaronElPrimerEnfrentamientoYGanaElSegundo

	| rondaDeTruco primeraCartaJugadaPorLaMano segundaCartaJugadaPorLaMano primeraCartaJugadaPorElPie segundaCartaJugadaPorElPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primeraCartaJugadaPorLaMano := CartaDeTruco espadaCon: 4.
	segundaCartaJugadaPorLaMano := CartaDeTruco anchoDeBasto.	
	primeraCartaJugadaPorElPie := CartaDeTruco copaCon: 4.
	segundaCartaJugadaPorElPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: primeraCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: primeraCartaJugadaPorElPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: segundaCartaJugadaPorElPie.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primeraCartaJugadaPorLaMano with: segundaCartaJugadaPorLaMano )).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: primeraCartaJugadaPorElPie with: segundaCartaJugadaPorElPie )).
	
	self assert: rondaDeTruco manoGanoLaRonda.	
	
	! !

!RondaDeTrucoTest methodsFor: 'tests' stamp: 'LZ 7/2/2022 18:17:03'!
test27GanaElPieSiEmpardaronElPrimerEnfrentamientoYGanaElSegundo

	| rondaDeTruco primeraCartaJugadaPorLaMano segundaCartaJugadaPorLaMano primeraCartaJugadaPorElPie segundaCartaJugadaPorElPie |
	
	rondaDeTruco := RondaDeTruco conMano: self manoValida conPie: self otraManoValida.
	
	primeraCartaJugadaPorLaMano := CartaDeTruco espadaCon: 4.
	segundaCartaJugadaPorLaMano := CartaDeTruco espadaCon: 12.	
	primeraCartaJugadaPorElPie := CartaDeTruco copaCon: 4.
	segundaCartaJugadaPorElPie := CartaDeTruco oroCon: 2.
		
	rondaDeTruco manoJuega: primeraCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: primeraCartaJugadaPorElPie.
	rondaDeTruco manoJuega: segundaCartaJugadaPorLaMano.
	rondaDeTruco pieJuega: segundaCartaJugadaPorElPie.
	
	self assert: (rondaDeTruco manoJugo: (OrderedCollection with: primeraCartaJugadaPorLaMano with: segundaCartaJugadaPorLaMano )).
	self assert: (rondaDeTruco pieJugo: (OrderedCollection with: primeraCartaJugadaPorElPie with: segundaCartaJugadaPorElPie )).
	
	self assert: rondaDeTruco pieGanoLaRonda.	! !


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
	instanceVariableNames: 'cartasDeLaMano cartasDelPie turno cartasJugadasPorElPie cartasJugadasPorLaMano turnosGanadosPorMano turnosGanadosPorPie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaDeTruco methodsFor: 'initialization' stamp: 'LZ 7/2/2022 21:03:26'!
initializeConMano: unaManoDeCartas conPie: otraManoDeCartas 

	cartasDeLaMano := unaManoDeCartas.
	cartasDelPie := otraManoDeCartas.
	
	cartasJugadasPorLaMano := OrderedCollection new.
	cartasJugadasPorElPie := OrderedCollection new.
	
	turnosGanadosPorMano := 0.
	turnosGanadosPorPie := 0.
	
	turno := EmpiezaMano en: self.! !


!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 7/2/2022 23:14:22'!
alguienGano

	^ self manoGanoLaRonda or: self pieGanoLaRonda.! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 7/2/2022 21:43:27'!
assert: unaManoDeCartas jugoUnaCartaQueTiene: unaCartaDeTruco

	^ (unaManoDeCartas includes: unaCartaDeTruco) ifFalse: [ self error: self noPuedeJugarUnaCartaQueNoTieneError ].! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 7/2/2022 20:52:18'!
manoGanoLaRonda
	
	^ turnosGanadosPorMano = 2.! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 7/2/2022 20:48:11'!
manoJugo: unaColeccionDeCartasDeTruco
	
	^ cartasJugadasPorLaMano = unaColeccionDeCartasDeTruco.
	! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 7/2/2022 20:52:24'!
pieGanoLaRonda
	
	^ turnosGanadosPorPie = 2.! !

!RondaDeTruco methodsFor: 'assertions' stamp: 'LZ 7/2/2022 20:48:35'!
pieJugo: unaColeccionDeCartasDeTruco
	
	^ cartasJugadasPorElPie = unaColeccionDeCartasDeTruco .! !


!RondaDeTruco methodsFor: 'error descriptions' stamp: 'LZ 6/30/2022 21:03:25'!
noEsElTurnoDelJugador
	
	^ 'No es el turno del jugador'.! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'LZ 7/2/2022 22:04:19'!
noEsElTurnoDelJugadorSignal
	
	self error: self noEsElTurnoDelJugador.! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'LZ 6/30/2022 20:41:29'!
noPuedeJugarUnaCartaQueNoTieneError
	
	^ 'No puede jugar una carta que no tiene'.! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'LZ 7/2/2022 22:04:36'!
noPuedeJugarUnaCartaQueNoTieneErrorSignal
	
	self error: self noPuedeJugarUnaCartaQueNoTieneError .! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'LZ 7/2/2022 12:49:45'!
noSePuedeJugarDespuesDeQueHayaUnGanadorError
	
	^ 'No se puede seguir jugando despues de que haya un ganador'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'LZ 7/2/2022 22:05:00'!
noSePuedeJugarDespuesDeQueHayaUnGanadorErrorSignal
	
	self error: self noSePuedeJugarDespuesDeQueHayaUnGanadorError.! !


!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 21:31:37'!
empardarEnfrentamiento

	turnosGanadosPorMano := turnosGanadosPorMano + 1. 
	turnosGanadosPorPie := turnosGanadosPorPie + 1.
	turno := EmpiezaMano en: self.! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 21:30:36'!
enfrentar: unaCartaDeLaMano con: unaCartaDelPie 

	(unaCartaDeLaMano empardaCon: unaCartaDelPie) ifTrue: [
			self empardarEnfrentamiento.
			turno := EmpiezaMano en: self.
	] ifFalse: [ (unaCartaDeLaMano mataA: unaCartaDelPie ) ifTrue: [
			self manoGanaEnfrentamiento.
		] ifFalse: [
			self pieGanaEnfrentamiento .
		]
	]! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 23:12:33'!
manoEmpiezaEnfrentamientoCon: unaCartaDeTruco

	turno := TerminaPie en: self.

! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 21:42:44'!
manoGanaEnfrentamiento

	turnosGanadosPorMano := turnosGanadosPorMano + 1.
	turno := EmpiezaMano en: self.! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 23:26:23'!
manoTerminaEnfrentamientoCon: unaCartaDeTruco

	self resultadoEnfrentamientoDeMano: unaCartaDeTruco con: cartasJugadasPorElPie last.! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 23:12:42'!
pieEmpiezaEnfrentamientoCon: unaCartaDeTruco

	turno := TerminaMano en: self.

! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 21:44:29'!
pieGanaEnfrentamiento

	turnosGanadosPorPie := turnosGanadosPorPie + 1.
	turno := EmpiezaPie en: self.! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 22:07:03'!
pieTerminaEnfrentamientoCon: unaCartaDeTruco

	^ self resultadoEnfrentamientoDeMano: cartasJugadasPorLaMano last con: unaCartaDeTruco.

! !

!RondaDeTruco methodsFor: 'enfrentar' stamp: 'LZ 7/2/2022 23:20:00'!
resultadoEnfrentamientoDeMano: unaCartaDeLaMano con: unaCartaDelPie
	
	self enfrentar: unaCartaDeLaMano con: unaCartaDelPie.
	
	self alguienGano ifTrue: [ turno := RondaTerminada en: self ].

! !


!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'LZ 7/2/2022 22:54:55'!
cartasJugadas: unaColeccionDeCartasJugadas son: otraColeccionDeCartas

	^ unaColeccionDeCartasJugadas = otraColeccionDeCartas.! !

!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'LZ 7/2/2022 22:55:47'!
cartasJugadasPorManoSon: unaColeccionDeCartasJugadas

	^ self cartasJugadas: unaColeccionDeCartasJugadas son: cartasJugadasPorLaMano.! !

!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'LZ 7/2/2022 22:55:07'!
cartasJugadasPorPieSon: unaColeccionDeCartasJugadas

	self cartasJugadas: unaColeccionDeCartasJugadas son: cartasJugadasPorElPie .! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'LZ 7/2/2022 23:11:07'!
jugar: unaCartaDeTruco de: unConjuntoDeCartasPorJugar hacia: unConjuntoDeCartasJugadas con: unaAccionDeJuego

	self assert: unConjuntoDeCartasPorJugar jugoUnaCartaQueTiene: unaCartaDeTruco.
	
	unaAccionDeJuego value.
	
	unConjuntoDeCartasPorJugar remove: unaCartaDeTruco.
	unConjuntoDeCartasJugadas add: unaCartaDeTruco.
! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'LZ 7/2/2022 22:15:02'!
manoJuega: unaCartaDeTruco

	self jugar: unaCartaDeTruco de: cartasDeLaMano hacia: cartasJugadasPorLaMano con: [ turno manoJuega: unaCartaDeTruco ].! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'LZ 7/2/2022 22:19:12'!
pieJuega: unaCartaDeTruco

	self jugar: unaCartaDeTruco de: cartasDelPie hacia: cartasJugadasPorElPie con: [ turno pieJuega: unaCartaDeTruco ].! !

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


!classDefinition: #Turno category: 'ISW1-2021-1C-2doParcial'!
Object subclass: #Turno
	instanceVariableNames: 'rondaDeTruco'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!Turno methodsFor: 'initialization' stamp: 'LZ 7/2/2022 21:01:10'!
initializeEn: unaRondaDeTruco

	rondaDeTruco := unaRondaDeTruco.! !


!Turno methodsFor: 'jugar' stamp: 'LZ 7/2/2022 21:21:41'!
manoJuega: unaCartaDeTruco

	self subclassResponsibility.! !

!Turno methodsFor: 'jugar' stamp: 'LZ 7/2/2022 21:21:25'!
pieJuega: unaCartaDeTruco

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Turno class' category: 'ISW1-2021-1C-2doParcial'!
Turno class
	instanceVariableNames: ''!

!Turno class methodsFor: 'instance creation' stamp: 'LZ 7/2/2022 21:00:26'!
en: unaRondaDeTruco

	^ self new initializeEn: unaRondaDeTruco.! !


!classDefinition: #EmpiezaMano category: 'ISW1-2021-1C-2doParcial'!
Turno subclass: #EmpiezaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EmpiezaMano methodsFor: 'jugar' stamp: 'LZ 7/2/2022 22:16:01'!
manoJuega: unaCartaDeTruco

	rondaDeTruco manoEmpiezaEnfrentamientoCon: unaCartaDeTruco.! !

!EmpiezaMano methodsFor: 'jugar' stamp: 'LZ 7/2/2022 23:05:30'!
pieJuega: unaCartaDeTruco

	rondaDeTruco noEsElTurnoDelJugadorSignal .! !


!classDefinition: #EmpiezaPie category: 'ISW1-2021-1C-2doParcial'!
Turno subclass: #EmpiezaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!EmpiezaPie methodsFor: 'jugar' stamp: 'LZ 7/2/2022 23:05:35'!
manoJuega: unaCartaDeTruco

	rondaDeTruco noEsElTurnoDelJugadorSignal .! !

!EmpiezaPie methodsFor: 'jugar' stamp: 'LZ 7/2/2022 23:20:56'!
pieJuega: unaCartaDeTruco

	rondaDeTruco pieEmpiezaEnfrentamientoCon: unaCartaDeTruco.! !


!classDefinition: #RondaTerminada category: 'ISW1-2021-1C-2doParcial'!
Turno subclass: #RondaTerminada
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!RondaTerminada methodsFor: 'jugar' stamp: 'LZ 7/2/2022 23:24:33'!
manoJuega: unaCartaDeTruco

	rondaDeTruco noSePuedeJugarDespuesDeQueHayaUnGanadorErrorSignal.! !

!RondaTerminada methodsFor: 'jugar' stamp: 'LZ 7/2/2022 23:24:39'!
pieJuega: unaCartaDeTruco

	rondaDeTruco noSePuedeJugarDespuesDeQueHayaUnGanadorErrorSignal.! !


!classDefinition: #TerminaMano category: 'ISW1-2021-1C-2doParcial'!
Turno subclass: #TerminaMano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TerminaMano methodsFor: 'jugar' stamp: 'LZ 7/2/2022 21:25:33'!
manoJuega: unaCartaDeTruco

	rondaDeTruco manoTerminaEnfrentamientoCon: unaCartaDeTruco.! !

!TerminaMano methodsFor: 'jugar' stamp: 'LZ 7/2/2022 23:05:38'!
pieJuega: unaCartaDeTruco

	rondaDeTruco noEsElTurnoDelJugadorSignal .! !


!classDefinition: #TerminaPie category: 'ISW1-2021-1C-2doParcial'!
Turno subclass: #TerminaPie
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-2doParcial'!

!TerminaPie methodsFor: 'jugar' stamp: 'LZ 7/2/2022 23:05:21'!
manoJuega: unaCartaDeTruco

	rondaDeTruco noEsElTurnoDelJugadorSignal .! !

!TerminaPie methodsFor: 'jugar' stamp: 'LZ 7/2/2022 21:25:46'!
pieJuega: unaCartaDeTruco

	rondaDeTruco pieTerminaEnfrentamientoCon: unaCartaDeTruco.! !
