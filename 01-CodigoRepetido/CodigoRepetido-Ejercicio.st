!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:17:03'!
assert: aCustomerBook onlyHasCustomer: aCustomer
	
	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aCustomer)
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:32:01'!
assert: aCustomerBook onlyHasSuspendedCustomer: aCustomer
	
	self assert: 0 equals: aCustomerBook numberOfActiveCustomers.
	self assert: 1 equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aCustomerBook onlyHasCustomer: aCustomer.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:38:46'!
assert: aCustomerBook shouldHaveRemovedCustomer: aCustomer
	
	self assert: 0 equals: aCustomerBook numberOfActiveCustomers.
	self assert: 0 equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: 0 equals: aCustomerBook numberOfCustomers.
	self deny: (aCustomerBook includesCustomerNamed: aCustomer )
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/17/2022 16:03:05'!
assert: aBlockClosure shouldNotTakeMoreThan: aTimeMeasure

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (aTimeMeasure convertTo: millisecond)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/17/2022 16:09:17'!
assert: aBlockClosure shouldThrow: anError

	[ aBlockClosure value ] on: anError do: [ ^ self ].
	
	self fail! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/17/2022 16:12:16'!
assert: aBlockClosure shouldThrow: anError withMessageText: aMessage
	
	[ aBlockClosure value ] on: anError do: [ :error | self assert: error messageText = aMessage. ^ self ].
	
	self fail! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:26:47'!
newCustomerBookWith: aCustomer

	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomer.
	
	^ customerBook ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:30:03'!
newCustomerBookWithSuspended: aCustomer

	| customerBook |
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCustomer.
	customerBook suspendCustomerNamed: aCustomer.
	
	^ customerBook ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:18:03'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	customerBook := CustomerBook new.
	self assert: [ customerBook addCustomerNamed: self johnLennon. ] shouldNotTakeMoreThan: 50 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:39:27'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook  |
	customerBook := self newCustomerBookWith: self paulMcCartney.
	  
	self assert: [ customerBook removeCustomerNamed: self paulMcCartney ] shouldNotTakeMoreThan: 100 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/17/2022 16:11:45'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assert: [ customerBook addCustomerNamed: ''. ] shouldThrow: Error withMessageText: CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/17/2022 16:13:07'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook |
			
	customerBook := self newCustomerBookWith: self johnLennon.
	
	self assert: [ customerBook removeCustomerNamed: self paulMcCartney ] shouldThrow: NotFound.
	self assert: customerBook onlyHasCustomer: self johnLennon! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:32:22'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self newCustomerBookWithSuspended: self paulMcCartney.
	
	self assert: customerBook onlyHasSuspendedCustomer: self paulMcCartney
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/11/2022 21:38:16'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook |
	
	customerBook := self newCustomerBookWithSuspended: self paulMcCartney.
	customerBook removeCustomerNamed: self paulMcCartney.
	
	self assert: customerBook shouldHaveRemovedCustomer: self paulMcCartney 


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/17/2022 16:14:08'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook  |
			
	customerBook := self newCustomerBookWith: self johnLennon.
	
	self assert: [ customerBook suspendCustomerNamed: self georgeHarrison ] shouldThrow: CantSuspend.
	self assert: customerBook onlyHasCustomer: self johnLennon
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'TO 4/17/2022 16:15:45'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook |
			
	customerBook := self newCustomerBookWithSuspended: self johnLennon.
	
	self assert: [ customerBook suspendCustomerNamed: self johnLennon ] shouldThrow: CantSuspend.
	self assert: customerBook onlyHasCustomer: self johnLennon
! !


!CustomerBookTest methodsFor: 'customers' stamp: 'TO 4/11/2022 21:36:44'!
georgeHarrison

	^ 'George Harrison'! !

!CustomerBookTest methodsFor: 'customers' stamp: 'TO 4/11/2022 21:17:52'!
johnLennon
	
	^ 'John Lennon'! !

!CustomerBookTest methodsFor: 'customers' stamp: 'TO 4/11/2022 21:18:35'!
paulMcCartney

	^ 'Paul McCartney'! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'TO 4/17/2022 16:19:06'!
includesActiveCustomerNamed: aName

	^ active includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'TO 4/17/2022 16:20:19'!
includesCustomerNamed: aName

	^ (self includesActiveCustomerNamed: aName) or: [ self includesSuspendedCustomerNamed: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'TO 4/17/2022 16:19:58'!
includesSuspendedCustomerNamed: aName

	^ suspended includes: aName! !

!CustomerBook methodsFor: 'testing' stamp: 'TO 4/11/2022 21:43:08'!
isEmpty
	
	^ active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'TO 4/11/2022 21:43:46'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].

	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'TO 4/11/2022 21:43:58'!
numberOfActiveCustomers
	
	^ active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TO 4/11/2022 21:41:52'!
numberOfCustomers
	
	^ self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'TO 4/11/2022 21:41:42'!
numberOfSuspendedCustomers
	
	^ suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'TO 4/17/2022 16:22:49'!
removeActiveCustomerNamed: aName ifAbsent: aBlockClosure
 
	active remove: aName ifAbsent: [ aBlockClosure value ].
	
	^ aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'TO 4/17/2022 16:25:51'!
removeCustomerNamed: aName 
 
	^ self removeActiveCustomerNamed: aName ifAbsent: [ ^ self removeSuspendedCustomerNamed: aName ifAbsent: [^ NotFound signal.] ].! !

!CustomerBook methodsFor: 'customer management' stamp: 'TO 4/17/2022 16:23:18'!
removeSuspendedCustomerNamed: aName ifAbsent: aBlockClosure
 
	suspended remove: aName ifAbsent: [ aBlockClosure value ].
	
	^ aName! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'TO 4/17/2022 16:25:17'!
suspendCustomerNamed: aName 
	
	self removeActiveCustomerNamed: aName ifAbsent: [^CantSuspend signal].
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:12'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/11/2022 07:18:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
