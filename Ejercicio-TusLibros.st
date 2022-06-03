!classDefinition: #CartTest category: 'Ejercicio-TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:20:27'!
test01

	self assert: (Cart with: OrderedCollection new) isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:35:11'!
test02

	| cart |
	cart := Cart with: OrderedCollection new.
	
	self should: [ cart add: 1 copiesOf: Book new ] raise: Error withExceptionDo: [: anError | 
		self assert: cart bookIsNotValidErrorDescription equals: anError messageText.
		self assert: cart isEmpty.
	]! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:35:11'!
test03

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	cart add: 1 copiesOf: book.
	
	self deny: cart isEmpty! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:35:11'!
test04

	| cart book1 book2 |
	book1 := Book new.
	book2 := Book new.
	cart := Cart with: (OrderedCollection with: book1 with: book2).
	
	cart add: 1 copiesOf: book1.
	cart add: 1 copiesOf: book2.	
	
	self assert: 2 equals: cart size! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:35:11'!
test05

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	cart add: 1 copiesOf: book.
	cart add: 1 copiesOf: book.
	
	self assert: 2 equals: cart size.
	self assert: 2 equals: (cart copiesOf: book).! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:33:44'!
test06

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	
	self should: [ cart add: 0 copiesOf: book ] raise: Error withExceptionDo: [:anError|
		self assert: cart quantityOfCopiesToAddMustBePositiveErrorDescription equals: anError messageText.
		self assert: cart isEmpty
	]! !


!classDefinition: #Book category: 'Ejercicio-TusLibros'!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros'!


!classDefinition: #Cart category: 'Ejercicio-TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'book books catalogue orderedCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:36:16'!
add: aQuantityOfBooks copiesOf: aBook 
	
	aQuantityOfBooks <= 0 ifTrue: [ self error: self quantityOfCopiesToAddMustBePositiveErrorDescription ].
	self assertBookIsInCatalogue: aBook.
	books add: aBook! !

!Cart methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:15:25'!
assertBookIsInCatalogue: aBook

	^ (catalogue includes: aBook) ifFalse: [ self error: self bookIsNotValidErrorDescription. ]! !

!Cart methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:01:35'!
bookIsNotValidErrorDescription
	
	^ 'Book is not in catalogue'! !

!Cart methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:23:09'!
copiesOf: aBook 
	
	^ books occurrencesOf: aBook! !

!Cart methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:20:00'!
isEmpty
	
	^ books isEmpty ! !

!Cart methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:32:56'!
quantityOfCopiesToAddMustBePositiveErrorDescription
	
	^ 'Can not add a non positive number of books'! !

!Cart methodsFor: 'as yet unclassified' stamp: 'TO 6/2/2022 21:19:15'!
size
	
	^ books size! !


!Cart methodsFor: 'initialize' stamp: 'TO 6/2/2022 21:19:35'!
initializeWith: anOrderedCollection 

	catalogue := anOrderedCollection.
	books := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio-TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'TO 6/2/2022 21:14:17'!
with: anOrderedCollection

	^self new initializeWith: anOrderedCollection ! !
