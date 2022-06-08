!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'supportFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'TO 6/7/2022 16:57:40'!
test01NewCartsAreCreatedEmpty

	self assert: supportFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'TO 6/7/2022 16:59:44'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := supportFactory createCart.
	
	self 
		should: [ cart add: supportFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'TO 6/7/2022 17:00:19'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := supportFactory createCart.
	
	cart add: supportFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'TO 6/7/2022 17:00:28'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := supportFactory createCart.
	
	self 
		should: [cart add: 0 of: supportFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'TO 6/7/2022 17:00:38'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := supportFactory createCart.
	
	self 
		should: [cart add: 2 of: supportFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'TO 6/7/2022 17:00:53'!
test06CartRemembersAddedItems

	| cart |
	
	cart := supportFactory createCart.
	
	cart add: supportFactory itemSellByTheStore.
	self assert: (cart includes: supportFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'TO 6/7/2022 17:01:00'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := supportFactory createCart.
	
	self deny: (cart includes: supportFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'TO 6/7/2022 17:01:07'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := supportFactory createCart.
	
	cart add: 2 of: supportFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: supportFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'set up' stamp: 'TO 6/7/2022 16:57:18'!
setUp
	
	supportFactory := TestSupportFactory new! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'supportFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'set up' stamp: 'TO 6/7/2022 17:02:06'!
setUp

 	supportFactory := TestSupportFactory new! !


!CashierTest methodsFor: 'tests' stamp: 'TO 6/8/2022 15:56:46'!
test01ShouldRaiseAndShouldNotRegisterSaleWhenTryingToCheckOutAnEmptyCart

	| cashier salesBook merchantProcessor |
	salesBook := supportFactory createSalesBook.
	merchantProcessor := supportFactory defaultMerchantProcessor.
	cashier := Cashier with: merchantProcessor registeringSalesIn: salesBook.
	
	self
		should: cashier 
		raiseWhenCheckingOut: supportFactory createCartWithEmptyCatalog
		with: supportFactory defaultCard 
		beforeRegisteringSalesIn: salesBook 
		andProcessingDebitWith: merchantProcessor 
		withErrorMessage: cashier cartIsEmptyErrorMessage.! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:17:59'!
test02SaleIsRegisteredInSaleBookAfterCheckingOutOneItem

	| cashier cart salesBook |
	salesBook := supportFactory createSalesBook.
	cashier := Cashier with: supportFactory defaultMerchantProcessor registeringSalesIn: salesBook.
	cart := supportFactory createCartWithCopiesOfDefaultItem: 1.
	
	self assertHasRegisteredSaleIn: salesBook of: 1 when: cashier checksOut: cart 
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:17:59'!
test03SaleIsRegisteredInSaleBookAfterCheckingOutManyItems

	| cashier cart salesBook |
	salesBook := supportFactory createSalesBook.
	cashier := Cashier with: supportFactory defaultMerchantProcessor registeringSalesIn: salesBook.
	cart := supportFactory createCartWithCopiesOfDefaultItem: 3.
	
	self assertHasRegisteredSaleIn: salesBook of: 3 when: cashier checksOut: cart.
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:17:59'!
test04ShouldRaiseAndShouldNotRegisterSaleWhenTryingToCheckOutWithAnExpiredCard

	| cashier cart salesBook merchantProcessor |
	salesBook := supportFactory createSalesBook.
	merchantProcessor := supportFactory defaultMerchantProcessor.
	cashier := Cashier with: merchantProcessor registeringSalesIn: salesBook.
	cart := supportFactory createCartWithCopiesOfDefaultItem: 3.
	
	self
		should: cashier 
		raiseWhenCheckingOut: cart
		with: supportFactory expiredCard 
		beforeRegisteringSalesIn: salesBook 
		andProcessingDebitWith: merchantProcessor 
		withErrorMessage: cashier creditCardIsExpiredErrorMessage.
	self deny: cart isEmpty.
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:17:59'!
test05ShouldNotRegisterSaleWhenMerchantProcessorRaisesCardStolenError

	| cashier cart salesBook merchantProcessor |
	salesBook := supportFactory createSalesBook.
	merchantProcessor := MerchantProcessorSimulator for: [ :aMerchantProcessor| aMerchantProcessor signalCardWasReportedStolen ].
	cashier := Cashier with: merchantProcessor registeringSalesIn: salesBook.
	cart := supportFactory createCartWithCopiesOfDefaultItem: 3.
	
	self 
		should: cashier 
		raiseWhenCheckingOut: cart 
		beforeRegisteringSalesIn: salesBook 
		becauseOf: merchantProcessor 
		withErrorMessage: merchantProcessor cardWasReportedStolenErrorMessage.
	
	
	! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:17:59'!
test06ShouldNotRegisterSaleWhenMerchantProcessorRaisesCardWithInsufficientFundsError

	| cashier cart salesBook merchantProcessor |
	salesBook := supportFactory createSalesBook.
	merchantProcessor := MerchantProcessorSimulator for: [ :aMerchantProcessor| aMerchantProcessor signalCardHasInsufficientFunds ].
	cashier := Cashier with: merchantProcessor registeringSalesIn: salesBook.
	cart := supportFactory createCartWithCopiesOfDefaultItem: 3.
	
	self 
		should: cashier 
		raiseWhenCheckingOut: cart 
		beforeRegisteringSalesIn: salesBook 
		becauseOf: merchantProcessor 
		withErrorMessage: merchantProcessor cardHasInsufficientFundsErrorMessage.
	! !

!CashierTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:17:59'!
test07ShouldRegisterSaleWhenMerchantProcessorCompletesDebitOperationSuccessfully

	| cashier cart merchantProcessor salesBook |
	salesBook := supportFactory createSalesBook.
	merchantProcessor := MerchantProcessorSimulator for: [ :aMerchantProcessor| aMerchantProcessor countSuccessfulRequest ].
	cashier := Cashier with: merchantProcessor registeringSalesIn: salesBook.
	cart := supportFactory createCartWithCopiesOfDefaultItem: 3.
	
	
	self assertHasUsedSuccessfuly: merchantProcessor registeringSaleIn: salesBook of: 3 when: cashier checksOut: cart
	
	! !


!CashierTest methodsFor: 'assertions' stamp: 'TO 6/8/2022 16:14:36'!
assertHasRegisteredSaleIn: aSalesBook of: aQuantityOfDefaultItemsAddedToCart when: aCashier checksOut: aCart

	| salePrice |
	salePrice := aCashier checkout: aCart with: supportFactory defaultCard.
	
	self deny: aSalesBook isEmpty.
	self assert: salePrice equals: aSalesBook last.
	self assert: aCart isEmpty.
	self assert: supportFactory priceOfItemSellByTheStore * aQuantityOfDefaultItemsAddedToCart equals: salePrice.! !

!CashierTest methodsFor: 'assertions' stamp: 'TO 6/8/2022 16:15:30'!
assertHasUsedSuccessfuly: aMerchantProcessor registeringSaleIn: aSalesBook of: aQuantityOfDefaultItemsAddedToCart when: aCashier checksOut: aCart

	self assertHasRegisteredSaleIn: aSalesBook of: aQuantityOfDefaultItemsAddedToCart when: aCashier checksOut: aCart.
	self assert: 1 equals: aMerchantProcessor totalRequests.
	self assert: 1 equals: aMerchantProcessor totalSuccessfulRequests.! !

!CashierTest methodsFor: 'assertions' stamp: 'TO 6/8/2022 16:15:13'!
should: aCashier raiseWhenCheckingOut: aCart beforeRegisteringSalesIn: aSalesBook becauseOf: aMerchantProcessor withErrorMessage: anErrorMessage

	self 
		should: [ aCashier checkout: aCart with: supportFactory defaultCard ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [: anError | 
			self assert: anErrorMessage equals: anError messageText.
			self assert: aSalesBook isEmpty.
			self deny: aCart isEmpty.
			self assert: 1 equals: aMerchantProcessor totalRequests.
			self assert: 0 equals: aMerchantProcessor totalSuccessfulRequests.
		]! !

!CashierTest methodsFor: 'assertions' stamp: 'TO 6/7/2022 17:43:12'!
should: aCashier raiseWhenCheckingOut: aCart with: aCreditCard beforeRegisteringSalesIn: aSalesBook andProcessingDebitWith: aMerchantProcessor withErrorMessage: anErrorMessage

	self 
		should: [ aCashier checkout: aCart with: aCreditCard ] 
		raise: Error - MessageNotUnderstood  
		withExceptionDo: [:anError| 
			self assert: anErrorMessage equals: anError messageText.
			self assert: aSalesBook isEmpty.
			self assert: 0 equals: aMerchantProcessor totalRequests.
		]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierTest class' category: 'TusLibros'!
CashierTest class
	instanceVariableNames: ''!

!CashierTest class methodsFor: 'as yet unclassified' stamp: 'TO 6/7/2022 15:46:38'!
itemSellByTheStore
	self shouldBeImplemented.! !


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:19:43'!
test01ShouldRaiseWhenCardNumberIsNot16DigitsLong
	
	self 
		should: [CreditCard for: 4444 owner: 'Jorge'  expiresOnMonthOfYear: GregorianMonthOfYear current next ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard cardNumberMustHave16DigitsErrorMessage.! !

!CreditCardTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:20:09'!
test02ShouldRaiseWhenCardOwnerNameIsEmpty

	self 
		should: [CreditCard for: 4444555566667777 owner: ''  expiresOnMonthOfYear: GregorianMonthOfYear current next ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard ownerNameCanNotBeEmptyErrorMessage! !

!CreditCardTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:20:41'!
test03ShouldRaiseWhenCardOwnerNameHasOnlyBlanks

	self 
		should: [CreditCard for: 4444555566667777 owner: '   '  expiresOnMonthOfYear: GregorianMonthOfYear current next ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard ownerNameCanNotBeEmptyErrorMessage! !

!CreditCardTest methodsFor: 'tests' stamp: 'TO 6/8/2022 16:21:19'!
test04ShouldRaiseWhenCardOwnerNameIsLongerThan30Characters

	self 
		should: [CreditCard for: 4444555566667777 owner: 'Jorge Jorge Jorge Jorge Jorge Jorge Jorge Jorge'  expiresOnMonthOfYear: GregorianMonthOfYear current next ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard ownerNameCanNotBeLongerThan30CharactersErrorMessage! !

!CreditCardTest methodsFor: 'tests' stamp: 'TO 6/7/2022 17:27:26'!
test05CardIsNotExpiredWhenDateComesBeforeThanExpirationDate

	| card |
	card := CreditCard for: 4444555566667777 owner: 'Pedro Perez'  expiresOnMonthOfYear: GregorianMonthOfYear current next.
	
	self deny: (card isExpiredOn: Date today)! !

!CreditCardTest methodsFor: 'tests' stamp: 'TO 6/7/2022 17:27:37'!
test06CardIsExpiredWhenDateComesAfterExpirationDate

	| card |
	card := CreditCard for: 4444555566667777 owner: 'Pedro Perez'  expiresOnMonthOfYear: GregorianMonthOfYear current previous.
	
	self assert: (card isExpiredOn: Date today)! !


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


!Cart methodsFor: 'assertions' stamp: 'TO 6/7/2022 15:50:15'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'TO 6/7/2022 16:06:31'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	self emptyCart.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'TO 6/7/2022 15:51:54'!
totalAmount
	
	^ items sum: [:anItem| catalog at: anItem ]! !


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


!Cart methodsFor: 'emptying' stamp: 'TO 6/7/2022 16:06:20'!
emptyCart

	items := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'TO 6/7/2022 15:42:40'!
assertCardIsNotExpired: aCreditCard 
	
	(aCreditCard isExpiredOn: Date today) ifTrue: [ self error: self creditCardIsExpiredErrorMessage ]! !

!Cashier methodsFor: 'assertions' stamp: 'TO 6/7/2022 15:54:20'!
assertCartIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [ self error: self cartIsEmptyErrorMessage ]! !


!Cashier methodsFor: 'checkout' stamp: 'TO 6/7/2022 16:54:58'!
checkout: aCart with: aCreditCard
	
	| sale |
	self assertCartIsNotEmpty: aCart.
	self assertCardIsNotExpired: aCreditCard.
	
	sale := aCart totalAmount.
	merchantProcessor debit: sale from: aCreditCard.
	salesBook add: sale.
	aCart emptyCart.
	
	^ sale
	! !


!Cashier methodsFor: 'error messages' stamp: 'TO 6/7/2022 15:54:36'!
cartIsEmptyErrorMessage
	
	^ 'Cart is empty'! !

!Cashier methodsFor: 'error messages' stamp: 'TO 6/6/2022 19:01:46'!
creditCardIsExpiredErrorMessage
	
	^ 'Credit card is expired'! !


!Cashier methodsFor: 'initialization' stamp: 'TO 6/7/2022 16:54:58'!
initializeWith: aMerchantProcessor registeringSalesIn: aSalesBook 

	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'TO 6/7/2022 16:54:44'!
with: aMerchantProcessor registeringSalesIn: aSalesBook 

	^self new initializeWith: aMerchantProcessor registeringSalesIn: aSalesBook ! !


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


!CreditCard methodsFor: 'testing' stamp: 'TO 6/7/2022 15:38:34'!
isExpiredOn: aDate 
	
	^ aDate > expiration lastDate asSmalltalkDate! !

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


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'closureToBeExecutedOnDebitOperation successfulRequests requests'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'initialization' stamp: 'TO 6/7/2022 16:51:37'!
initializeFor: aClosureToBeExecutedOnDebitOperation 

	closureToBeExecutedOnDebitOperation := aClosureToBeExecutedOnDebitOperation.
	requests := 0.
	successfulRequests := 0.! !


!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'TO 6/7/2022 16:52:20'!
debit: anAmount from: aCreditCard 
	
	requests := requests + 1.
	^ closureToBeExecutedOnDebitOperation value: self! !


!MerchantProcessorSimulator methodsFor: 'signals' stamp: 'TO 6/7/2022 16:36:05'!
signalCardHasInsufficientFunds
	
	self error: self cardHasInsufficientFundsErrorMessage! !

!MerchantProcessorSimulator methodsFor: 'signals' stamp: 'TO 6/7/2022 16:30:28'!
signalCardWasReportedStolen
	
	self error: self cardWasReportedStolenErrorMessage! !


!MerchantProcessorSimulator methodsFor: 'error messages' stamp: 'TO 6/7/2022 16:36:25'!
cardHasInsufficientFundsErrorMessage
	
	^ 'Card has insufficient funds'! !

!MerchantProcessorSimulator methodsFor: 'error messages' stamp: 'TO 6/7/2022 16:30:51'!
cardWasReportedStolenErrorMessage
	
	^ 'The card was reported stolen'
	! !


!MerchantProcessorSimulator methodsFor: 'request simulation' stamp: 'TO 6/7/2022 16:51:31'!
countSuccessfulRequest
	
	successfulRequests := successfulRequests + 1! !


!MerchantProcessorSimulator methodsFor: 'accessing' stamp: 'TO 6/7/2022 16:51:56'!
totalRequests
	
	^ requests ! !

!MerchantProcessorSimulator methodsFor: 'accessing' stamp: 'TO 6/7/2022 16:51:31'!
totalSuccessfulRequests
	
	^ successfulRequests ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'TO 6/7/2022 16:26:38'!
for: aClosureToBeExecutedOnDebitOperation 

	^self new initializeFor: aClosureToBeExecutedOnDebitOperation ! !


!classDefinition: #TestSupportFactory category: 'TusLibros'!
Object subclass: #TestSupportFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TestSupportFactory methodsFor: 'sales book' stamp: 'TO 6/8/2022 15:56:23'!
createSalesBook
	
	^ OrderedCollection new! !


!TestSupportFactory methodsFor: 'cart' stamp: 'TO 6/7/2022 16:58:19'!
createCart
	
	^ Cart acceptingItemsOf: self defaultCatalog! !

!TestSupportFactory methodsFor: 'cart' stamp: 'TO 6/8/2022 16:17:59'!
createCartWithCopiesOfDefaultItem: aQuantity
	
	| cart |
	cart := self createCart.
	cart add: aQuantity of: self itemSellByTheStore.
	
	^ cart! !

!TestSupportFactory methodsFor: 'cart' stamp: 'TO 6/8/2022 15:54:23'!
createCartWithEmptyCatalog
	
	^ Cart acceptingItemsOf: self emptyCatalog! !


!TestSupportFactory methodsFor: 'catalog' stamp: 'TO 6/8/2022 15:54:42'!
defaultCatalog
	
	| catalog |
	catalog := self emptyCatalog.
	catalog at: self itemSellByTheStore put: self priceOfItemSellByTheStore.
	
	^ catalog! !

!TestSupportFactory methodsFor: 'catalog' stamp: 'TO 6/8/2022 15:55:03'!
emptyCatalog
	
	^ Dictionary new! !


!TestSupportFactory methodsFor: 'items' stamp: 'TO 6/7/2022 17:00:03'!
itemNotSellByTheStore
	
	^ 'invalidBook'! !

!TestSupportFactory methodsFor: 'items' stamp: 'TO 6/7/2022 16:59:09'!
itemSellByTheStore
	
	^ 'validBook'! !

!TestSupportFactory methodsFor: 'items' stamp: 'TO 6/7/2022 16:59:22'!
priceOfItemSellByTheStore
	
	^ 10! !


!TestSupportFactory methodsFor: 'merchant processors simulators' stamp: 'TO 6/7/2022 17:31:31'!
defaultMerchantProcessor
	
	^ MerchantProcessorSimulator for: [:aMerchantProcessor|]! !


!TestSupportFactory methodsFor: 'credit cards' stamp: 'TO 6/7/2022 17:04:14'!
defaultCard
	
	^  CreditCard for: 4444555566667777 owner: 'Card Owner' expiresOnMonthOfYear: GregorianMonthOfYear current next! !

!TestSupportFactory methodsFor: 'credit cards' stamp: 'TO 6/7/2022 17:05:43'!
expiredCard
	
	^ CreditCard for: 4444555566667777 owner: 'Card Owner' expiresOnMonthOfYear: GregorianMonthOfYear current previous ! !
