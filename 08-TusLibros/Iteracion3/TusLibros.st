!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 14:57:12'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 14:57:15'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 14:57:19'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 18:00:59'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			for: testObjectsFactory defaultCustomer
			charging: testObjectsFactory notExpiredCreditCard 
			through: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 18:01:08'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		for: testObjectsFactory defaultCustomer
		charging: testObjectsFactory notExpiredCreditCard 
		through: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 18:01:14'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				for: testObjectsFactory defaultCustomer 
				charging: testObjectsFactory expiredCreditCard 
				through: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 18:01:20'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		for: testObjectsFactory defaultCustomer
		charging: testObjectsFactory notExpiredCreditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 18:01:25'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		for: testObjectsFactory defaultCustomer 
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 18:01:30'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		for: testObjectsFactory defaultCustomer
		charging: creditCard
		through: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'testObjectsFactory authorizationBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'authorization protocol' stamp: 'LZ 6/11/2022 13:31:14'!
authorize: aClientId with: aPassword

	^ authorizationBehavior value: aClientId value: aPassword.! !


!RestInterfaceTest methodsFor: 'set up' stamp: 'LZ 6/11/2022 14:55:37'!
setUp

	authorizationBehavior := [ :aClientId :aPassword | true ].
	testObjectsFactory := StoreTestObjectsFactory new.! !


!RestInterfaceTest methodsFor: 'support - time tracking' stamp: 'TO 6/12/2022 10:13:29'!
addToCartCreationTime: aQuantityOfMinutes

	^ self cartCreationTime + (Duration minutes: aQuantityOfMinutes)! !

!RestInterfaceTest methodsFor: 'support - time tracking' stamp: 'TO 6/12/2022 10:10:27'!
cartCreationTime

	^ testObjectsFactory today.! !

!RestInterfaceTest methodsFor: 'support - time tracking' stamp: 'TO 6/12/2022 10:13:53'!
fortyMinutesAfterCartWasCreated

	^ self addToCartCreationTime: 40! !

!RestInterfaceTest methodsFor: 'support - time tracking' stamp: 'TO 6/12/2022 10:13:48'!
tenMinutesAfterCartWasCreated

	^ self addToCartCreationTime: 10! !

!RestInterfaceTest methodsFor: 'support - time tracking' stamp: 'TO 6/12/2022 10:13:59'!
thirtyMinutesAfterCartWasCreated

	^ self addToCartCreationTime: 30! !


!RestInterfaceTest methodsFor: 'support' stamp: 'LZ 6/11/2022 17:48:32'!
anotherValidClientId

	^ 'anotherValidClientId'.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'LZ 6/11/2022 14:43:56'!
correctPassword

	^ 'Correct password'.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'LZ 6/11/2022 16:57:46'!
defaultRestInterface

	^ RestInterface with: self acceptingItemsOf: 	testObjectsFactory defaultCatalog through: self.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'LZ 6/11/2022 14:43:07'!
incorrectPassword

	^ 'Incorrect password'.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'LZ 6/11/2022 15:00:52'!
invalidCartId

	^ nil.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'LZ 6/11/2022 14:42:52'!
invalidClientId

	^ nil.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'LZ 6/11/2022 14:43:47'!
validClientId

	^ 'validClientId'.! !


!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:10:27'!
test01ShouldRaiseWhenTryingToCreateACartWithAnInvalidClientId

	| restInterface |
	
	restInterface := self defaultRestInterface.
	authorizationBehavior := [ :aClientId :aPassword | false ].

	self
		should: [restInterface createCartFor: self invalidClientId withPassword: self correctPassword on: self cartCreationTime ]
		raise: Error - MessageNotUnderstood 
		withMessageText: restInterface invalidClientOrPasswordErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:10:27'!
test02ShouldRaiseWhenTryingToCreateACartWithAnIncorrectPassword

	| restInterface |
	
	restInterface := self defaultRestInterface.
	authorizationBehavior := [ :aClientId :aPassword | false ].

	self
		should: [restInterface createCartFor: self validClientId withPassword: self incorrectPassword on: self cartCreationTime ]
		raise: Error - MessageNotUnderstood 
		withMessageText: restInterface invalidClientOrPasswordErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:10:27'!
test03ListCartShouldBeEmptyAfterCreatingCart

	| restInterface cartId |
	
	restInterface := self defaultRestInterface.

	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	self assert: (restInterface listCart: cartId on: self cartCreationTime) isEmpty.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:10:27'!
test04TwoDifferentCartsShouldHaveDifferentIds

	| restInterface firstCartId secondCartId |
	
	restInterface := self defaultRestInterface.

	firstCartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	secondCartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	self deny: firstCartId = secondCartId.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:10:27'!
test05ShouldRaiseWhenTryingToAddAnInvalidBookToCart

	| restInterface cartId |
	
	restInterface := self defaultRestInterface.

	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	self 
		should: [ restInterface add: 1 of: testObjectsFactory itemNotSellByTheStore to: cartId on: self cartCreationTime ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (restInterface listCart: cartId on: self cartCreationTime) isEmpty.
			self assert: Cart invalidItemErrorMessage equals: anError messageText.
		]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:10:27'!
test06ShouldRaiseWhenTryingToAddANonPositiveQuantityOfBooksToCart

	| restInterface cartId |
	
	restInterface := self defaultRestInterface.

	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	self 
		should: [ restInterface add: 0 of: testObjectsFactory itemSellByTheStore to: cartId on: self cartCreationTime ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: (restInterface listCart: cartId on: self cartCreationTime) isEmpty.
			self assert: Cart invalidQuantityErrorMessage equals: anError messageText.
		]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:11:08'!
test07ShouldRaiseWhenTryingToAddWithAnInvalidCartId

	| restInterface |
	
	restInterface := self defaultRestInterface.
	
	self 
		should: [ restInterface add: 1 of: testObjectsFactory itemSellByTheStore to: self invalidCartId on: self thirtyMinutesAfterCartWasCreated ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: restInterface invalidCartIdErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:10:27'!
test08ShouldRaiseWhenTryingToListCartWithAnInvalidCartId

	| restInterface |
	
	restInterface := self defaultRestInterface.

	self 
		should: [ restInterface listCart: self invalidCartId on: self cartCreationTime ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: restInterface invalidCartIdErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:10:27'!
test09AddingBooksAffectsListCart

	| restInterface cartId cartItems |
	
	restInterface := self defaultRestInterface.
	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	restInterface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId on: self cartCreationTime.
	
	cartItems := restInterface listCart: cartId on: self cartCreationTime.

	self assert: 2 equals: (cartItems occurrencesOf: testObjectsFactory itemSellByTheStore).! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test10ShouldRaiseWhenTryingToCheckoutWithAnInvalidCartId

	| restInterface |
	
	restInterface := self defaultRestInterface.
	
	self 
		should: [ restInterface checkout: self invalidCartId
				withCreditCardNumber: testObjectsFactory validCreditCardNumber 
				withCreditCardName: testObjectsFactory validCreditCardName
				withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear on: self cartCreationTime ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: restInterface invalidCartIdErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test11ShouldRaiseWhenTryingToCheckoutWithAnInvalidCreditCardNumber

	| restInterface cartId |
	
	restInterface := self defaultRestInterface.
	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	self 
		should: [ restInterface checkout: cartId
				withCreditCardNumber: testObjectsFactory invalidCreditCardNumber 
				withCreditCardName: testObjectsFactory validCreditCardName
				withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear on: self cartCreationTime ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidCardNumberErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test12ShouldRaiseWhenTryingToCheckoutWithAnEmptyCardName

	| restInterface cartId |
	
	restInterface := self defaultRestInterface.
	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	self 
		should: [ restInterface checkout: cartId
				withCreditCardNumber: testObjectsFactory validCreditCardNumber
				withCreditCardName: testObjectsFactory emptyCreditCardName
				withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear on: self cartCreationTime ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidCardNameErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test13ShouldRaiseWhenTryingToCheckoutWithATooLongCardName

	| restInterface cartId |
	
	restInterface := self defaultRestInterface.
	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	self 
		should: [ restInterface checkout: cartId
				withCreditCardNumber: testObjectsFactory validCreditCardNumber
				withCreditCardName: testObjectsFactory tooLongCreditCardName
				withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear on: self cartCreationTime ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CreditCard invalidCardNameErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test14ShouldRaiseWhenTryingToCheckoutWithAnExpiredCard

	| restInterface cartId clientId password |
	
	restInterface := self defaultRestInterface.
	
	clientId := self validClientId.
	password := self correctPassword.
	
	cartId := restInterface createCartFor: clientId withPassword: password on: self cartCreationTime.
	
	restInterface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId on: self cartCreationTime.
	
	self 
		should: [ restInterface checkout: cartId
				withCreditCardNumber: testObjectsFactory validCreditCardNumber
				withCreditCardName: testObjectsFactory validCreditCardName
				withCreditCardExpireDate: testObjectsFactory currentMonthOfPreviousYear on: self cartCreationTime ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
				self assert: (restInterface listPurchasesOf: clientId authenticatingWith: password) isEmpty.
				self assert: Cashier canNotChargeAnExpiredCreditCardErrorMessage equals: anError messageText.
			].! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test15PurchasesListIsAffectedAfterCheckingOut

	| restInterface cartId clientId password purchasesList |
	
	restInterface := self defaultRestInterface.
	
	clientId := self validClientId.
	password := self correctPassword.
	
	cartId := restInterface createCartFor: clientId withPassword: password on: self cartCreationTime.
	
	restInterface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId on: self cartCreationTime.
	
	restInterface checkout: cartId
				withCreditCardNumber: testObjectsFactory validCreditCardNumber
				withCreditCardName: testObjectsFactory validCreditCardName
				withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear on: self cartCreationTime.
	
	purchasesList := restInterface listPurchasesOf: clientId authenticatingWith: password.
		
	self assert: 2 equals: (purchasesList first occurrencesOf: testObjectsFactory itemSellByTheStore) .! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'LZ 6/11/2022 17:31:59'!
test16ShouldRaiseWhenTryingToListPurchasesWithAnInvalidClientIdOrPassword

	| restInterface |
	
	restInterface := self defaultRestInterface.
	authorizationBehavior := [ :aClientId :aPassword | false ].

	self
		should: [restInterface listPurchasesOf: self invalidClientId authenticatingWith: self incorrectPassword ]
		raise: Error - MessageNotUnderstood 
		withMessageText: restInterface invalidClientOrPasswordErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test17PurchasesListOnlyShowsClientPurchases

	| restInterface cartId clientId password anotherClientId purchasesList |
	
	restInterface := self defaultRestInterface.
	
	clientId := self validClientId.
	password := self correctPassword.
	
	anotherClientId := self anotherValidClientId.
	
	cartId := restInterface createCartFor: clientId withPassword: password on: self cartCreationTime.
	
	restInterface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId on: self cartCreationTime.
	
	restInterface checkout: cartId
				withCreditCardNumber: testObjectsFactory validCreditCardNumber
				withCreditCardName: testObjectsFactory validCreditCardName
				withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear on: self cartCreationTime.

	purchasesList := restInterface listPurchasesOf: anotherClientId authenticatingWith: password.
		
	self assert: purchasesList isEmpty.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test18ShouldRaiseWhenTryingToUseACartAfterBeingCheckedOut

	| restInterface cartId clientId password |
	
	restInterface := self defaultRestInterface.
	
	clientId := self validClientId.
	password := self correctPassword.
	
	cartId := restInterface createCartFor: clientId withPassword: password on: self cartCreationTime.
	
	restInterface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId on: self cartCreationTime.
	
	restInterface checkout: cartId
				withCreditCardNumber: testObjectsFactory validCreditCardNumber
				withCreditCardName: testObjectsFactory validCreditCardName
				withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear on: self cartCreationTime.
				
	self
		should: [ restInterface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId on: self thirtyMinutesAfterCartWasCreated ]
	 	raise: Error - MessageNotUnderstood
		withMessageText: restInterface invalidCartIdErrorMessage.! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:14:35'!
test19ShouldRaiseWhenTryingToAddABookToACartThatWasUsedMoreThan30MinutesAgo

	| restInterface cartId |
	restInterface := self defaultRestInterface.
	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.

	self
		should: [ restInterface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId on: self thirtyMinutesAfterCartWasCreated ]
	 	raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: restInterface cartIsNoLongerValidErrorMessage equals: anError messageText.
			self assert: (restInterface listCart: cartId on: self cartCreationTime) isEmpty.
		]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:11:08'!
test20ShouldRaiseWhenTryingToListACartThatWasUsedMoreThan30MinutesAgo

	| restInterface cartId |
	restInterface := self defaultRestInterface.
	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.

	self
		should: [ restInterface listCart: cartId on: self thirtyMinutesAfterCartWasCreated ]
	 	raise: Error - MessageNotUnderstood
		withMessageText: restInterface cartIsNoLongerValidErrorMessage ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test21ShouldRaiseWhenTryingToCheckOutACartThatWasUsedMoreThan30MinutesAgo

	| restInterface cartId |
	restInterface := self defaultRestInterface.
	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	restInterface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId on: self cartCreationTime.

	self
		should: [ restInterface 
					checkout: cartId 
					withCreditCardNumber: testObjectsFactory validCreditCardNumber 
					withCreditCardName:  testObjectsFactory validCreditCardName 
					withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear
					on: self thirtyMinutesAfterCartWasCreated ]
	 	raise: Error - MessageNotUnderstood
		withExceptionDo: [:anError| 
			self assert: restInterface cartIsNoLongerValidErrorMessage equals: anError messageText.
			self assert: (restInterface listPurchasesOf: self validClientId authenticatingWith: self correctPassword) isEmpty.
		]! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:56:19'!
test22AddingToCartShouldAffectLastUsedTime

	| restInterface cartId |
	restInterface := self defaultRestInterface.	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	restInterface add: 1 of: testObjectsFactory itemSellByTheStore to: cartId on: self tenMinutesAfterCartWasCreated.
	restInterface 
		checkout: cartId 
		withCreditCardNumber: testObjectsFactory validCreditCardNumber 
		withCreditCardName:  testObjectsFactory validCreditCardName 
		withCreditCardExpireDate: testObjectsFactory currentMonthOfNextYear
		on: self thirtyMinutesAfterCartWasCreated.
		
	self deny: (restInterface listPurchasesOf: self validClientId authenticatingWith: self correctPassword) isEmpty ! !

!RestInterfaceTest methodsFor: 'tests' stamp: 'TO 6/12/2022 10:25:55'!
test23ListingCartShouldAffectLastUsedTime

	| restInterface cartId cartItems |
	restInterface := self defaultRestInterface.	
	cartId := restInterface createCartFor: self validClientId withPassword: self correctPassword on: self cartCreationTime.
	
	restInterface listCart: cartId on: 	self tenMinutesAfterCartWasCreated.	
	restInterface add: 2 of: testObjectsFactory itemSellByTheStore to: cartId on: self thirtyMinutesAfterCartWasCreated.
	
	cartItems := restInterface listCart: cartId on: self fortyMinutesAfterCartWasCreated.
	self assert: 2 equals: (cartItems occurrencesOf: testObjectsFactory itemSellByTheStore).! !


!RestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'LZ 6/11/2022 16:58:16'!
debit: anAmount from: aCreditCard 
	
	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'assertions' stamp: 'LZ 6/11/2022 14:58:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'LZ 6/11/2022 14:58:23'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


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


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'accesing' stamp: 'LZ 6/11/2022 14:54:33'!
items

	^ items copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'LZ 6/11/2022 14:56:43'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'LZ 6/11/2022 14:56:48'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total customer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'LZ 6/11/2022 18:33:51'!
createSale

	^ Sale of: total for: cart items to: customer.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'LZ 6/11/2022 17:59:19'!
initializeToCheckout: aCart for: aCustomer charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	customer := aCustomer.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'LZ 6/11/2022 17:59:07'!
toCheckout: aCart for: aCustomer charging: aCreditCard through: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart for: aCustomer charging: aCreditCard through: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClientAuthorizator category: 'TusLibros'!
Object subclass: #ClientAuthorizator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientAuthorizator methodsFor: 'as yet unclassified' stamp: 'LZ 6/11/2022 13:30:57'!
authorize: aClientId with: aPassword

	self subclassResponsibility.! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'LZ 6/11/2022 15:58:03'!
initializeFor: aNumber owner: aName expiringOn: aMonthOfYear
	
	expiration := aMonthOfYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LZ 6/11/2022 16:10:13'!
for: aNumber owner: aName expiringOn: aMonthOfYear 

	| trimmedName |
	trimmedName := aName withBlanksTrimmed.

	self assertCreditCardNumberIs16DigitsLong: aNumber.
	self assertCardOwnerNameHasValidLength: trimmedName.
	
	^ self new initializeFor: aNumber owner: trimmedName expiringOn: aMonthOfYear.! !


!CreditCard class methodsFor: 'assertions' stamp: 'LZ 6/11/2022 16:06:32'!
assertCardOwnerNameHasValidLength: aName

	(aName isEmpty or: [aName size > 30]) ifTrue: [self error: self invalidCardNameErrorMessage ].! !

!CreditCard class methodsFor: 'assertions' stamp: 'LZ 6/11/2022 15:59:34'!
assertCreditCardNumberIs16DigitsLong: aCreditCardNumber

	^ (aCreditCardNumber numberOfDigitsInBase: 10) = 16 ifFalse: [
		self error: self invalidCardNumberErrorMessage
		]! !


!CreditCard class methodsFor: 'error messages' stamp: 'LZ 6/11/2022 15:45:56'!
invalidCardNameErrorMessage
	
	^ 'Card name cannot be blank'.! !

!CreditCard class methodsFor: 'error messages' stamp: 'LZ 6/11/2022 15:33:30'!
invalidCardNumberErrorMessage
	
	^ 'Card number must be 16 digits long'.! !


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'clientAuthorizator timeTrackingCarts nextCartId catalog merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'add to cart' stamp: 'TO 6/12/2022 11:11:25'!
add: aQuantityOfBooks of: aBook to: aCartId on: aDateAndTime 

	self 
		do: [ :aTimeTrackingCartWrapper| aTimeTrackingCartWrapper add: aQuantityOfBooks of: aBook ] 
		ifCartIdentifiedBy: aCartId 
		isStillValidOn: aDateAndTime! !


!RestInterface methodsFor: 'authorization - private' stamp: 'TO 6/12/2022 11:02:37'!
do: aBlock afterAuthenticating: aClientId with: aPassword

	self assertCanAuthorize: aClientId with: aPassword.
	
	^ aBlock value! !


!RestInterface methodsFor: 'assertions' stamp: 'TO 6/12/2022 10:50:16'!
assertCanAuthorize: aClientId with: aPassword

	(clientAuthorizator authorize: aClientId with: aPassword) ifFalse: [
		self error: self invalidClientOrPasswordErrorMessage.
	].! !


!RestInterface methodsFor: 'cart time tracking - private' stamp: 'TO 6/12/2022 11:16:26'!
cartIdentifiedBy: aCartId

	^ timeTrackingCarts 
		detect: [:aTimeTrackingCartWrapper | aTimeTrackingCartWrapper identifiedBy: aCartId ]
		ifNone: [ self error: self invalidCartIdErrorMessage ].! !

!RestInterface methodsFor: 'cart time tracking - private' stamp: 'TO 6/12/2022 11:11:53'!
do: aBlock ifCartIdentifiedBy: aCartId isStillValidOn: aDateAndTime

	| timeTrackingCartWrapper |
	timeTrackingCartWrapper := self cartIdentifiedBy: aCartId.
	
	^ timeTrackingCartWrapper 
		do: aBlock 
		ifMinutesSinceLastUsedIsLessThan: 30 
		on: aDateAndTime 
		ifNot: [ self error: self cartIsNoLongerValidErrorMessage ]	
	! !


!RestInterface methodsFor: 'checkout cart - private' stamp: 'TO 6/12/2022 11:15:51'!
cashierToCheckout: aTimeTrackingCartWrapper charging: aCreditCard on: aDateAndTime 

	^ Cashier 
		toCheckout: aTimeTrackingCartWrapper
		for: aTimeTrackingCartWrapper customer
		charging: aCreditCard 
		through: merchantProcessor 
		on: aDateAndTime
		registeringOn: salesBook! !

!RestInterface methodsFor: 'checkout cart - private' stamp: 'TO 6/12/2022 11:15:11'!
checkout: aTimeTrackingCartWrapper charging: aCreditCard  on: aDateAndTime

	^ (self cashierToCheckout: aTimeTrackingCartWrapper charging: aCreditCard on: aDateAndTime) checkOut! !

!RestInterface methodsFor: 'checkout cart - private' stamp: 'TO 6/12/2022 11:16:58'!
remove: aCartId

	^ timeTrackingCarts removeAllSuchThat: [ :aTimeTrackingCartWrapperToBeTestedForRemoval | aTimeTrackingCartWrapperToBeTestedForRemoval identifiedBy: aCartId ]! !


!RestInterface methodsFor: 'checkout cart' stamp: 'TO 6/12/2022 11:17:13'!
checkout: aCartId withCreditCardNumber: aCardNumber withCreditCardName: aName withCreditCardExpireDate: anExpireDate on: aDateAndTime 

	| creditCard |
	self 
		do: [ :aTimeTrackingCartWrapper | 
			creditCard := CreditCard for: aCardNumber owner: aName expiringOn: anExpireDate.
	
			self checkout: aTimeTrackingCartWrapper charging: creditCard on: aDateAndTime.
		
			self remove: aCartId
		] 
		ifCartIdentifiedBy: aCartId 
		isStillValidOn: aDateAndTime.! !


!RestInterface methodsFor: 'create cart' stamp: 'TO 6/12/2022 11:05:14'!
createCartFor: aClientId withPassword: aPassword on: aDateAndTime 

	^ self 
		do: [ self createCartOwnedBy: aClientId on: aDateAndTime ] 
		afterAuthenticating: aClientId 
		with: aPassword.! !


!RestInterface methodsFor: 'create cart - private' stamp: 'LZ 6/11/2022 18:45:23'!
calculateNextId
	
	nextCartId := nextCartId + 1! !

!RestInterface methodsFor: 'create cart - private' stamp: 'TO 6/12/2022 11:16:26'!
createCartOwnedBy: aClientId on: aDateAndTime

	| cart |
	self calculateNextId.	
	cart := (Cart acceptingItemsOf: catalog).
	timeTrackingCarts add: (TimeTrackingCartWrapper for: cart 
						identifiedBy: nextCartId 
						ownedBy: aClientId 
						createdOn: aDateAndTime).

	^ nextCartId! !


!RestInterface methodsFor: 'error messages' stamp: 'LZ 6/11/2022 19:20:14'!
cartIsNoLongerValidErrorMessage
	
	^ 'Cart is no longer valid'.! !

!RestInterface methodsFor: 'error messages' stamp: 'LZ 6/11/2022 13:25:48'!
invalidCartIdErrorMessage

	^ 'Invalid cart id'.! !

!RestInterface methodsFor: 'error messages' stamp: 'LZ 6/11/2022 14:45:00'!
invalidClientOrPasswordErrorMessage
	
	^ 'Invalid client id or password'! !


!RestInterface methodsFor: 'initialization' stamp: 'TO 6/12/2022 11:16:26'!
initializeWith: aClientAuthorizator acceptingItemsOf: aCatalog through: aMerchantProcessor   
	
	clientAuthorizator := aClientAuthorizator.
	nextCartId := 1.
	timeTrackingCarts := OrderedCollection new.
	catalog := aCatalog.
	salesBook := OrderedCollection new.
	merchantProcessor := aMerchantProcessor .! !


!RestInterface methodsFor: 'list cart' stamp: 'TO 6/12/2022 11:17:51'!
listCart: aCartId on: aDateAndTime  
	
	^ self 
		do: [ :aTimeTrackingCartWrapper| aTimeTrackingCartWrapper items ] 
		ifCartIdentifiedBy: aCartId 
		isStillValidOn: aDateAndTime! !


!RestInterface methodsFor: 'list purchases - private' stamp: 'TO 6/12/2022 11:07:47'!
salesTo: aClientId

	^ salesBook select: [:aSale | aSale toClient: aClientId ]! !


!RestInterface methodsFor: 'list purchases' stamp: 'TO 6/12/2022 11:07:47'!
listPurchasesOf: aClientId authenticatingWith: aPassword

	^ self 
		do: [ self salesTo: aClientId ] 
		afterAuthenticating: aClientId 
		with: aPassword.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'LZ 6/11/2022 16:56:12'!
with: aClientAuthorizator acceptingItemsOf: aCatalog through: aMerchantProcessor  

	^ self new initializeWith: aClientAuthorizator acceptingItemsOf: aCatalog through: aMerchantProcessor.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items customer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'LZ 6/11/2022 18:34:52'!
initializeTotal: aTotal for: aCollectionOfBooks to: aCustomer 

	total := aTotal.
	items := aCollectionOfBooks.
	customer := aCustomer.! !


!Sale methodsFor: 'occurrences' stamp: 'LZ 6/11/2022 17:42:16'!
occurrencesOf: aBook

	^ items occurrencesOf: aBook.! !


!Sale methodsFor: 'testing' stamp: 'LZ 6/11/2022 18:14:31'!
toClient: aCustomer

	^ customer = aCustomer.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'LZ 6/11/2022 18:34:43'!
of: aTotal for: aCollectionOfItems to: aCustomer 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal for: aCollectionOfItems to: aCustomer.! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 15:25:28'!
currentMonthOfNextYear

	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 15:53:17'!
currentMonthOfPreviousYear

	^ Month month: today monthIndex year: today yearNumber - 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 16:08:39'!
emptyCreditCardName

	^ ''.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 15:53:26'!
expiredCreditCard
	
	^ CreditCard for: self validCreditCardNumber owner: 'Jorge' expiringOn: self currentMonthOfPreviousYear.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 15:31:24'!
invalidCreditCardNumber

	^ 0.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 15:53:40'!
notExpiredCreditCard
	
	^ CreditCard for: self validCreditCardNumber owner: 'Jorge' expiringOn: self currentMonthOfNextYear.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 16:09:25'!
tooLongCreditCardName
	
	^ 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 16:07:38'!
validCreditCardName

	^ 'Jorge'.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'LZ 6/11/2022 15:44:33'!
validCreditCardNumber

	^ 4444555566667777.! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'customer' stamp: 'LZ 6/11/2022 18:00:53'!
defaultCustomer
	
	^ 'default customer'! !


!classDefinition: #TimeTrackingCartWrapper category: 'TusLibros'!
ProtoObject subclass: #TimeTrackingCartWrapper
	instanceVariableNames: 'cart cartId customer lastUsedOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TimeTrackingCartWrapper methodsFor: 'accessing' stamp: 'LZ 6/11/2022 19:49:04'!
customer

	^ customer.! !


!TimeTrackingCartWrapper methodsFor: 'testing' stamp: 'LZ 6/11/2022 19:45:11'!
identifiedBy: aCartId

	^ cartId = aCartId.! !


!TimeTrackingCartWrapper methodsFor: 'initialization' stamp: 'LZ 6/11/2022 19:39:23'!
initializeFor: aCart identifiedBy: aCartId ownedBy: aCustomer createdOn: aDateAndTime

	cart := aCart.
	cartId := aCartId.
	customer := aCustomer.
	lastUsedOn := aDateAndTime.! !


!TimeTrackingCartWrapper methodsFor: 'does not understand' stamp: 'TO 6/12/2022 09:28:37'!
doesNotUnderstand: aMessage

	^ aMessage sendTo: cart ! !


!TimeTrackingCartWrapper methodsFor: 'time tracking' stamp: 'TO 6/12/2022 10:53:03'!
do: aBlockToBeExecutedIfWithinTimeLimit ifMinutesSinceLastUsedIsLessThan: aQuantityOfMinutes on: aDateAndTime ifNot: aBlockToBeExecutedIfTimeLimitWasExceeded
	
	(self minutesSinceLastUsed: aDateAndTime lessThan: aQuantityOfMinutes)
		ifTrue: [ | resultOfBlock | 
			resultOfBlock := aBlockToBeExecutedIfWithinTimeLimit value: self.
			self lastUsedOn: aDateAndTime.
	
			^ resultOfBlock 
		]
		ifFalse: aBlockToBeExecutedIfTimeLimitWasExceeded 
	
	
	! !

!TimeTrackingCartWrapper methodsFor: 'time tracking' stamp: 'TO 6/12/2022 10:21:16'!
lastUsedOn: aDateAndTime

	lastUsedOn := aDateAndTime ! !

!TimeTrackingCartWrapper methodsFor: 'time tracking' stamp: 'TO 6/12/2022 10:53:11'!
minutesSinceLastUsed: aDateAndTime lessThan: aQuantityOfMinutes 

	^ (aDateAndTime - lastUsedOn) totalMinutes < aQuantityOfMinutes! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TimeTrackingCartWrapper class' category: 'TusLibros'!
TimeTrackingCartWrapper class
	instanceVariableNames: ''!

!TimeTrackingCartWrapper class methodsFor: 'instance creation' stamp: 'LZ 6/11/2022 19:53:33'!
for: aCart identifiedBy: aCartId ownedBy: aCustomer createdOn: aDateAndTime
	
	^ self new initializeFor: aCart identifiedBy: aCartId ownedBy: aCustomer createdOn: aDateAndTime.! !
