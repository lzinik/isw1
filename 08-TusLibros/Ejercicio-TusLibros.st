!classDefinition: #CartTest category: 'Ejercicio-TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:30:06'!
test01CartIsEmptyAfterBeingCreated

	self assert: (Cart with: OrderedCollection new) isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:31:38'!
test02ShouldRaiseWhenTryingToAddABookThatIsNotIncludedInCatalogue

	| cart |
	cart := Cart with: OrderedCollection new.
	
	self should: [ cart add: 1 copiesOf: Book new ] raise: Error withExceptionDo: [: anError | 
		self assert: cart bookIsNotInCatalogueErrorDescription equals: anError messageText.
		self assert: cart isEmpty.
	]! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:38:03'!
test03CartIsNotEmptyAfterAddingBooks

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	cart add: 1 copiesOf: book.
	
	self deny: cart isEmpty.
	self assert: 1 equals: cart size.! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:48:03'!
test04CanAddDifferentBooks

	| cart book1 book2 |
	book1 := Book new.
	book2 := Book new.
	cart := Cart with: (OrderedCollection with: book1 with: book2).
	
	cart add: 1 copiesOf: book1.
	cart add: 1 copiesOf: book2.	
	
	self assert: 2 equals: cart size! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:48:15'!
test05CanAddManyCopiesOfABook

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	cart add: 2 copiesOf: book.
	
	self assert: 2 equals: cart size.
	self assert: 2 equals: (cart copiesOf: book).! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:41:25'!
test06ShouldRaiseWhenTryingToAddANonPositiveQuantityOfBooks

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	self should: [ cart add: 0 copiesOf: book ] raise: Error withExceptionDo: [:anError|
		self assert: cart quantityOfCopiesToAddMustBePositiveErrorDescription equals: anError messageText.
		self assert: cart isEmpty
	]! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:42:49'!
test07ShouldRaiseWhenTryingToRemoveMoreBooksThanPresent

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	cart add: 2 copiesOf: book.
	
	self should: [ cart remove: 3 copiesOf: book ] raise: Error withExceptionDo: [:anError|
		self assert: cart quantityOfCopiesToRemoveMustExistOnCartErrorDescription equals: anError messageText.
		self assert: 2 equals: (cart copiesOf: book).
	]! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:43:13'!
test08ShouldRaiseWhenTryingToRemoveANonPositiveQuantityOfBooks

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	cart add: 1 copiesOf: book.
	
	self should: [ cart remove: 0 copiesOf: book ] raise: Error withExceptionDo: [:anError|
		self assert: cart quantityOfCopiesToRemoveMustBePositiveErrorDescription equals: anError messageText.
		self assert: 1 equals: (cart copiesOf: book).
	]! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/4/2022 16:50:29'!
test09RemovingCopiesOfBookAffectsBookQuantityOnCart

	| cart book |
	book := Book new.
	cart := Cart with: (OrderedCollection with: book).
	
	cart add: 3 copiesOf: book.
	
	cart remove: 2 copiesOf: book.
	
	self assert: 1 equals: (cart copiesOf: book).! !


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

!Cart methodsFor: 'adding' stamp: 'LZ 6/4/2022 16:27:31'!
add: aQuantityOfBooksToBeAdded copiesOf: aBook 
	
	self assertBookIsInCatalogue: aBook.
	self assertQuantityToBeAddedIsPositive: aQuantityOfBooksToBeAdded.
	
	aQuantityOfBooksToBeAdded timesRepeat: [
		books add: aBook
	]
! !


!Cart methodsFor: 'removing' stamp: 'LZ 6/4/2022 16:27:19'!
remove: aQuantityOfBooksToBeRemoved copiesOf: aBook 
	
	self assertCopiesToBeRemovedOf: aBook isGreaterThan: aQuantityOfBooksToBeRemoved.
	self assertQuantityToBeRemovedIsPositive: aQuantityOfBooksToBeRemoved.
	
	aQuantityOfBooksToBeRemoved timesRepeat: [
		books remove: aBook.
	]! !


!Cart methodsFor: 'assertions' stamp: 'LZ 6/4/2022 16:29:16'!
assertBookIsInCatalogue: aBook

	^ (catalogue includes: aBook) ifFalse: [ self error: self bookIsNotInCatalogueErrorDescription. ]! !

!Cart methodsFor: 'assertions' stamp: 'LZ 6/4/2022 16:28:05'!
assertCopiesToBeRemovedOf: aBook isGreaterThan: aQuantityOfBooksToBeRemoved

	^ aQuantityOfBooksToBeRemoved > (self copiesOf: aBook) ifTrue: [ self error: self quantityOfCopiesToRemoveMustExistOnCartErrorDescription ]! !

!Cart methodsFor: 'assertions' stamp: 'LZ 6/4/2022 16:19:39'!
assertIsPositive: aQuantityOfBooks ifFalseSignalWith: anErrorDescription

	^ aQuantityOfBooks <= 0 ifTrue: [ self error: anErrorDescription ].! !

!Cart methodsFor: 'assertions' stamp: 'LZ 6/4/2022 16:28:16'!
assertQuantityToBeAddedIsPositive: aQuantityOfBooksToBeAdded

	^ self assertIsPositive: aQuantityOfBooksToBeAdded ifFalseSignalWith: self quantityOfCopiesToAddMustBePositiveErrorDescription.! !

!Cart methodsFor: 'assertions' stamp: 'LZ 6/4/2022 16:28:21'!
assertQuantityToBeRemovedIsPositive: aQuantityOfBooksToBeRemoved

	^ self assertIsPositive: aQuantityOfBooksToBeRemoved ifFalseSignalWith: self quantityOfCopiesToRemoveMustBePositiveErrorDescription.! !


!Cart methodsFor: 'initialize' stamp: 'LZ 6/4/2022 15:35:47'!
initializeWith: anOrderedCollection 

	catalogue := anOrderedCollection.
	books := OrderedCollection new.! !


!Cart methodsFor: 'error descriptions' stamp: 'LZ 6/4/2022 16:29:16'!
bookIsNotInCatalogueErrorDescription
	
	^ 'Book is not in catalogue'! !

!Cart methodsFor: 'error descriptions' stamp: 'TO 6/2/2022 21:32:56'!
quantityOfCopiesToAddMustBePositiveErrorDescription
	
	^ 'Can not add a non positive number of books'! !

!Cart methodsFor: 'error descriptions' stamp: 'LZ 6/4/2022 15:48:16'!
quantityOfCopiesToRemoveMustBePositiveErrorDescription
	
	^ 'Quantity of copies to remove must be positive'! !

!Cart methodsFor: 'error descriptions' stamp: 'LZ 6/4/2022 15:44:39'!
quantityOfCopiesToRemoveMustExistOnCartErrorDescription
	
	^ 'Can not remove more copies of a book that cart has'! !


!Cart methodsFor: 'testing' stamp: 'TO 6/2/2022 21:20:00'!
isEmpty
	
	^ books isEmpty ! !


!Cart methodsFor: 'accessing' stamp: 'TO 6/2/2022 21:23:09'!
copiesOf: aBook 
	
	^ books occurrencesOf: aBook! !

!Cart methodsFor: 'accessing' stamp: 'TO 6/2/2022 21:19:15'!
size
	
	^ books size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'Ejercicio-TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'TO 6/2/2022 21:14:17'!
with: anOrderedCollection

	^self new initializeWith: anOrderedCollection ! !
