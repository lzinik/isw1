!classDefinition: #I category: 'Numeros-Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros-Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next & previous' stamp: 'TO 3/31/2022 20:54:15'!
next
	
	^ II! !

!I class methodsFor: 'next & previous' stamp: 'TO 3/31/2022 21:16:13'!
previous
	
	self error: 'No tiene anterior.'! !

!I class methodsFor: 'next & previous' stamp: 'TO 3/31/2022 21:18:12'!
previous: unNumeroNatural
	
	self error: 'No tiene anterior.'! !


!I class methodsFor: 'errors' stamp: 'TO 4/8/2022 15:23:55'!
canNotDivideByBiggerNumberErrorDescription

	^ 'No es posible dividir por un numero mayor'! !

!I class methodsFor: 'errors' stamp: 'TO 4/8/2022 14:50:07'!
negativeNumbersNotSupportedErrorDescription

	^ 'No se soportan números negativos.'! !


!I class methodsFor: 'operaciones' stamp: 'TO 4/4/2022 20:39:57'!
* multiplicador
	
	^ multiplicador! !

!I class methodsFor: 'operaciones' stamp: 'TO 3/31/2022 20:56:07'!
+ unNumeroNatural
	
	^ unNumeroNatural next! !

!I class methodsFor: 'operaciones' stamp: 'TO 4/8/2022 14:50:33'!
- unNumeroNatural
	self error: self negativeNumbersNotSupportedErrorDescription ! !

!I class methodsFor: 'operaciones' stamp: 'TO 4/8/2022 14:51:38'!
/ divisor
	
	self = divisor ifTrue:  [ ^ self ].
	
	self error: self canNotDivideByBiggerNumberErrorDescription.! !

!I class methodsFor: 'operaciones' stamp: 'TO 4/8/2022 15:20:48'!
sustraeteDe: minuendo

	^ minuendo previous! !


!I class methodsFor: 'comparaciones' stamp: 'TO 4/8/2022 15:39:28'!
< unNumero
	
	unNumero = self ifTrue: [^ false].
	
	^ true! !


!classDefinition: #II category: 'Numeros-Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros-Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'next & previous' stamp: 'TO 4/4/2022 20:52:39'!
next
	next ifNotNil: [^ next. ].
	
	next := II createChildNamed: self nameOfNext.
	next previous: self.
	
	^ next.! !

!II class methodsFor: 'next & previous' stamp: 'TO 3/31/2022 21:18:37'!
previous
	^ previous ! !

!II class methodsFor: 'next & previous' stamp: 'TO 3/31/2022 21:07:21'!
previous: unNumero
	previous := unNumero! !


!II class methodsFor: 'operaciones' stamp: 'TO 4/4/2022 20:35:04'!
* multiplicador
	
	^ previous * multiplicador + multiplicador! !

!II class methodsFor: 'operaciones' stamp: 'TO 3/31/2022 21:34:23'!
+ unNumeroNatural

	^ I + (previous + unNumeroNatural)! !

!II class methodsFor: 'operaciones' stamp: 'TO 4/8/2022 15:21:08'!
- sustraendo
	
	^ sustraendo sustraeteDe: self.! !

!II class methodsFor: 'operaciones' stamp: 'TO 4/8/2022 15:40:00'!
/ divisor

	divisor = self ifTrue: [^ I].
	divisor = I ifTrue: [^ self].
	(self < divisor) ifTrue: [^ self error: self canNotDivideByBiggerNumberErrorDescription ].
	
	^ I + ((self - divisor) / divisor)! !

!II class methodsFor: 'operaciones' stamp: 'TO 4/4/2022 20:29:53'!
sustraeteDe: minuendo
	
	^ minuendo previous - self previous! !


!II class methodsFor: 'private' stamp: 'TO 4/4/2022 21:24:29'!
borrarTodosSiguientes
	
	next ifNotNil: [
		next borrarTodosSiguientes.
		next removeFromSystem .
		next := nil.
	].! !

!II class methodsFor: 'private' stamp: 'TO 4/8/2022 14:57:48'!
ifNumberEnds: endOfNumberName value: closureToValue
	
	(self name endsWith: endOfNumberName) ifTrue: [ closureToValue value ].! !

!II class methodsFor: 'private' stamp: 'TO 4/8/2022 15:46:03'!
nameOfNext
	
	self ifNumberEnds: 'DCCCXCIX' value: [^ self replaceNameSuffix: 'DCCCXCIX' with: 'CM' ].
	self ifNumberEnds: 'CMXCIX' value: [^ self replaceNameSuffix: 'CMXCIX' with: 'M' ].
	self ifNumberEnds: 'CCCXCIX' value: [^ self replaceNameSuffix: 'CCCXCIX' with: 'CD' ].
	self ifNumberEnds: 'CDXCIX' value: [^ self replaceNameSuffix: 'CDXCIX' with: 'D' ].
	self ifNumberEnds: 'LXXXIX' value: [^ self replaceNameSuffix: 'LXXXIX' with: 'XC' ].
	self ifNumberEnds: 'XCIX' value: [^ self replaceNameSuffix: 'XCIX' with: 'C' ].
	self ifNumberEnds: 'XXXIX' value: [^ self replaceNameSuffix: 'XXXIX' with: 'XL' ].
	self ifNumberEnds: 'XLIX' value: [^ self replaceNameSuffix: 'XLIX' with: 'L' ].
	self ifNumberEnds: 'IX' value: [^ self replaceNameSuffix: 'IX' with: 'X' ].
	self ifNumberEnds: 'VIII' value: [^ self replaceNameSuffix: 'VIII' with: 'IX' ].
	self ifNumberEnds: 'IV' value: [^ self replaceNameSuffix: 'IV' with: 'V' ].
	self ifNumberEnds: 'III' value: [^ self replaceNameSuffix: 'III' with: 'IV' ].
	
	^ self name, 'I'! !

!II class methodsFor: 'private' stamp: 'TO 4/8/2022 15:46:03'!
replaceNameSuffix: suffix with: newSuffix
	
	^ (self name withoutSuffix: suffix), newSuffix ! !


!II class methodsFor: 'errors' stamp: 'TO 4/8/2022 15:44:24'!
canNotDivideByBiggerNumberErrorDescription

	^ previous canNotDivideByBiggerNumberErrorDescription! !


!II class methodsFor: 'comparaciones' stamp: 'TO 4/8/2022 15:39:46'!
< unNumero

	unNumero = I ifTrue: [ ^ false ].
	^ previous < unNumero previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'TO 4/8/2022 15:46:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros-Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros-Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'TO 4/8/2022 15:46:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IV.
	previous := II.! !


!classDefinition: #IV category: 'Numeros-Naturales'!
II subclass: #IV
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros-Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IV class' category: 'Numeros-Naturales'!
IV class
	instanceVariableNames: ''!

!IV class methodsFor: '--** private fileout/in **--' stamp: 'TO 4/8/2022 15:46:56'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IV initializeAfterFileIn!