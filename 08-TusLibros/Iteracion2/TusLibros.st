!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
defaultCatalog
	
	^ Array with: self itemSellByTheStore! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'TO 6/6/2022 19:36:23'!
createCart

	^ Cart acceptingItemsOf: (Array with: 'validBook')! !

!CashierTest methodsFor: 'support' stamp: 'TO 6/6/2022 21:46:58'!
defaultCard

	^ CreditCard for: 4444555566667777 owner: 'Card Owner' expiresOnMonthOfYear: May, 2024! !

!CashierTest methodsFor: 'support' stamp: 'TO 6/6/2022 21:46:58'!
expiredCard

	^ CreditCard for: 4444555566667777 owner: 'Card Owner' expiresOnMonthOfYear: February, 2021! !


!CashierTest methodsFor: 'tests' stamp: 'TO 6/6/2022 19:44:10'!
test01

	| cashier purchases |
	purchases := OrderedCollection new.
	cashier := Cashier lookingPricesIn: Dictionary new registeringPurchasesIn: purchases.
	
	self 
		should: [ cashier checkout: (Cart acceptingItemsOf: OrderedCollection new) with: self defaultCard ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ : anError | 
			self assert: Purchase cartIsEmptyErrorMessage equals: anError messageText.
			self assert: purchases isEmpty 
		]! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/6/2022 19:40:15'!
test02

	| cashier cart purchase prices purchases |
	prices := Dictionary new.
	prices at: 'validBook'  put: 10.
	purchases := OrderedCollection new.
	cashier := Cashier lookingPricesIn: prices registeringPurchasesIn: purchases.
	cart := self createCart.
	cart add: 'validBook'.
	
	purchase := cashier checkout: cart with: self defaultCard.
	
	self assert: 10 equals: purchase totalAmount.
	self deny: purchases isEmpty.
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/6/2022 19:38:52'!
test03

	| cashier cart purchase prices purchases |
	prices := Dictionary new.
	prices at: 'validBook'  put: 10.
	purchases := OrderedCollection new.
	cashier := Cashier lookingPricesIn: prices registeringPurchasesIn: purchases.
	cart := self createCart.
	cart add: 3 of: 'validBook'.
	
	purchase := cashier checkout: cart with: self defaultCard.
	
	self assert: 30 equals: purchase totalAmount.
	self deny: purchases isEmpty.
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/6/2022 19:40:04'!
test04

	| cashier cart prices purchases |
	prices := Dictionary new.
	prices at: 'validBook'  put: 10.
	purchases := OrderedCollection new.
	cashier := Cashier lookingPricesIn: prices registeringPurchasesIn: purchases.
	cart := self createCart.
	cart add: 3 of: 'validBook'.
	
	self 
		should: [ cashier checkout: cart with: self expiredCard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [: anError | 
			self assert: cashier creditCardIsExpiredErrorMessage equals: anError messageText.
			self assert: purchases isEmpty
		]
	
	
	! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'TO 6/6/2022 21:46:58'!
test01

	self should: [CreditCard for: 4444 owner: 'Jorge'  expiresOnMonthOfYear: GregorianMonthOfYear current next ] raise: Error - MessageNotUnderstood withExceptionDo: [:anError|
		self assert: CreditCard cardNumberMustHave16DigitsErrorMessage equals: anError messageText.
	]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'TO 6/6/2022 21:46:58'!
test02

	self should: [CreditCard for: 4444555566667777 owner: ''  expiresOnMonthOfYear: GregorianMonthOfYear current next ] raise: Error - MessageNotUnderstood withExceptionDo: [:anError|
		self assert: CreditCard ownerNameCanNotBeEmptyErrorMessage equals: anError messageText.
	]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'TO 6/6/2022 21:46:58'!
test03

	self should: [CreditCard for: 4444555566667777 owner: ' '  expiresOnMonthOfYear: GregorianMonthOfYear current next ] raise: Error - MessageNotUnderstood withExceptionDo: [:anError|
		self assert: CreditCard ownerNameCanNotBeEmptyErrorMessage equals: anError messageText.
	]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'TO 6/6/2022 21:46:58'!
test04

	self should: [CreditCard for: 4444555566667777 owner: 'Jorge Jorge Jorge Jorge Jorge Jorge Jorge Jorge'  expiresOnMonthOfYear: GregorianMonthOfYear current next ] raise: Error - MessageNotUnderstood withExceptionDo: [:anError|
		self assert: CreditCard ownerNameCanNotBeLongerThan30CharactersErrorMessage equals: anError messageText.
	]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidItem: anItem

	(catalog includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accessing' stamp: 'TO 6/6/2022 18:46:25'!
items
	
	^ items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog purchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'TO 6/6/2022 19:08:04'!
assertCardIsNotExpired: aCreditCard 
	
	aCreditCard expired ifTrue: [ self error: self creditCardIsExpiredErrorMessage ]! !


!Cashier methodsFor: 'checkout' stamp: 'TO 6/6/2022 20:20:00'!
checkout: aCart with: aCreditCard  
	
	| purchase |
	self assertCardIsNotExpired: aCreditCard.
	
	purchase := Purchase from: aCart lookingPricesIn: catalog.
	"purchase := self createPurchaseFrom: aCart basedOnPricesOf: catalog"
	
	self debit: purchase totalAmount from: aCreditCard.
	
	purchases add: purchase.
	
	^ purchase
	! !


!Cashier methodsFor: 'error messages' stamp: 'TO 6/6/2022 19:01:46'!
creditCardIsExpiredErrorMessage
	
	^ 'Credit card is expired'! !


!Cashier methodsFor: 'checkout - private' stamp: 'TO 6/6/2022 19:25:26'!
debit: anAmount from: aCreditCard 
	
	! !


!Cashier methodsFor: 'initialization' stamp: 'TO 6/6/2022 19:20:53'!
initializeLookingPricesIn: aCatalog registeringPurchasesIn: aCollectionOfPurchases  

	catalog := aCatalog.
	purchases := aCollectionOfPurchases ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'TO 6/6/2022 19:20:26'!
lookingPricesIn: aCatalog registeringPurchasesIn: aCollectionOfPurchases 

	^self new initializeLookingPricesIn: aCatalog registeringPurchasesIn: aCollectionOfPurchases! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber name expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'TO 6/6/2022 21:45:25'!
initializeFor: aCreditCardNumber owner: aName expiresOnMonthOfYear: aMonthOfYear 

	creditCardNumber := aCreditCardNumber.
	name := aName.
	expiration := aMonthOfYear.! !


!CreditCard methodsFor: 'testing' stamp: 'TO 6/6/2022 19:11:02'!
expired
	
	^ GregorianMonthOfYear current > expiration ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'assertions' stamp: 'TO 6/6/2022 21:54:17'!
assertCardOwnerNameHasValidLength: trimmedName

	trimmedName isEmpty ifTrue: [self error: self ownerNameCanNotBeEmptyErrorMessage].
	trimmedName size > 30 ifTrue: [self error: self ownerNameCanNotBeLongerThan30CharactersErrorMessage]! !

!CreditCard class methodsFor: 'assertions' stamp: 'TO 6/6/2022 21:48:13'!
assertCreditCardNumberIs16DigitsLong: aCreditCardNumber

	^ (aCreditCardNumber numberOfDigitsInBase: 10) = 16 ifFalse: [self error: self cardNumberMustHave16DigitsErrorMessage ]! !


!CreditCard class methodsFor: 'instance creation' stamp: 'TO 6/6/2022 21:54:34'!
for: aCreditCardNumber owner: aName expiresOnMonthOfYear: aMonthOfYear
	
	| trimmedName |
	trimmedName := aName withBlanksTrimmed.
	self assertCreditCardNumberIs16DigitsLong: aCreditCardNumber.
	self assertCardOwnerNameHasValidLength: trimmedName.
	
	^self new initializeFor: aCreditCardNumber owner: trimmedName expiresOnMonthOfYear: aMonthOfYear ! !


!CreditCard class methodsFor: 'error messages' stamp: 'TO 6/6/2022 21:34:37'!
cardNumberMustHave16DigitsErrorMessage
	
	^ 'The card number must have 16 digits'.! !

!CreditCard class methodsFor: 'error messages' stamp: 'TO 6/6/2022 21:36:32'!
ownerNameCanNotBeEmptyErrorMessage
	
	^ 'Owner name can not be empty'! !

!CreditCard class methodsFor: 'error messages' stamp: 'TO 6/6/2022 21:41:46'!
ownerNameCanNotBeLongerThan30CharactersErrorMessage
	
	^ 'Owner name can not be longer than 30 characters'! !


!classDefinition: #Purchase category: 'TusLibros'!
Object subclass: #Purchase
	instanceVariableNames: 'cart catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Purchase methodsFor: 'initialization' stamp: 'TO 6/6/2022 19:27:16'!
initializeFrom: aCart lookingPricesIn: aCatalog 

	cart := aCart.
	catalog := aCatalog.! !


!Purchase methodsFor: 'amount' stamp: 'TO 6/6/2022 19:28:19'!
totalAmount
	
	^ cart items sum: [ :anItem | catalog at: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Purchase class' category: 'TusLibros'!
Purchase class
	instanceVariableNames: ''!

!Purchase class methodsFor: 'instance creation' stamp: 'TO 6/6/2022 19:41:34'!
from: aCart lookingPricesIn: aCatalog

	self assertIsNotEmpty: aCart.
	^self new initializeFrom: aCart lookingPricesIn: aCatalog! !


!Purchase class methodsFor: 'assertions' stamp: 'TO 6/6/2022 19:43:01'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [ self error: self cartIsEmptyErrorMessage ]! !


!Purchase class methodsFor: 'error messages' stamp: 'TO 6/6/2022 19:43:19'!
cartIsEmptyErrorMessage
	
	^ 'Cart is empty'! !
