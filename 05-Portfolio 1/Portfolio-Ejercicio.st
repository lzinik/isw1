!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'assertions' stamp: 'LZ 5/21/2022 20:42:35'!
assert: aPortfolio hasAllTransactionsOf: anAccount

	self assert: (anAccount transactions allSatisfy: [ : aTransaction | aPortfolio transactions includes: aTransaction ]	).
! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LZ 5/21/2022 20:47:44'!
assert: aPortfolio hasAllTransactionsOf: aTransactionRecord andAllTransactionsOf: aSecondTransactionRecord

	self assert: aPortfolio hasAllTransactionsOf: aTransactionRecord.
	self assert: aPortfolio hasAllTransactionsOf: aSecondTransactionRecord.
	
	self assert: aTransactionRecord transactions size + aSecondTransactionRecord transactions size equals: aPortfolio transactions size.
! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LZ 5/21/2022 20:11:47'!
assert: aPortfolio hasBalanceOf: aBalance

	self assert: aBalance equals: aPortfolio balance.! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LZ 5/21/2022 20:23:22'!
assert: aPortfolio hasRegistered: aTransaction

	self assert: (aPortfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LZ 5/21/2022 20:37:06'!
assert: aPortfolio hasRegistredAllTransactionsOf: anAccount

	anAccount transactions do:[ :anAccountTransaction | self assert: aPortfolio hasRegistered: anAccountTransaction].! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LZ 5/21/2022 20:23:52'!
deny: aPortfolio hasRegistered: aTransaction

	self deny: (aPortfolio hasRegistered: aTransaction).! !

!PortfolioTest methodsFor: 'assertions' stamp: 'LZ 5/21/2022 20:54:31'!
should: aPortfolio raiseWhenAddingDuplicated: aTransactionRecord
	
	self should: [aPortfolio add: aTransactionRecord] raise: Error withExceptionDo: [ : anError | anError messageText = aPortfolio duplicatedTransactionRecordErrorDescription ].! !


!PortfolioTest methodsFor: 'tests' stamp: 'LZ 5/21/2022 20:12:21'!
test01PortfoliosHaveZeroBalanceWhenCreated
	
	| portfolio |
	
	portfolio := Portfolio new.

	self assert: portfolio hasBalanceOf: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 11:58:26'!
test02PortfolioWithOneAccountBalanceEqualsOneAccountBalance
	
	| portfolio |
	
	portfolio := self portfolioWithOneAccountWithADepositOf50.

	self assert: portfolio hasBalanceOf: 50.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 11:58:26'!
test03PortfolioWithOnePortfolioBalanceEqualsOnePortfolioBalance
	
	| mainPortfolio secondaryPortfolio |
	
	secondaryPortfolio := self portfolioWithOneAccountWithADepositOf50.
	
	mainPortfolio := self portfolioWith: secondaryPortfolio.

	self assert: mainPortfolio hasBalanceOf: secondaryPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 11:58:26'!
test04PorfolioWithOnePortfolioAndOneAccountBalanceIsSumOfBothBalances
	
	| mainPortfolio secondaryPortfolio |
	
	secondaryPortfolio := self portfolioWithOneAccountWithADepositOf50.
	
	mainPortfolio := self portfolioWithOneAccountWithADepositOf50.
	mainPortfolio add: secondaryPortfolio.

	self assert: mainPortfolio hasBalanceOf: secondaryPortfolio balance  + 50.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:02:09'!
test05PorfolioWithManyPortfoliosAndAccountsBalanceIsSumOfAllBalances
	
	| mainPortfolio portfolio1 portfolio2 |
	
	portfolio1 := self portfolioWithOneAccountWithADepositOf50.	
	portfolio2 := self portfolioWithAccountWithADepositOf50AndAnotherAccountWithADepositOf100.
	
	mainPortfolio := self portfolioWithOneAccountWithADepositOf: 50 andAnotherWithADepositOf: 150.
	mainPortfolio add: portfolio1.
	mainPortfolio add: portfolio2.

	self assert: mainPortfolio hasBalanceOf: portfolio1 balance + portfolio2 balance + 50 + 150.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:03:12'!
test06PortfolioWithNoAccountsHasNotRegisteredATransaction
	
	| portfolio account |
	
	portfolio := Portfolio new.
	account := self receptiveAccountWithADepositOf50.

	self deny: portfolio hasRegistered: account transactions first.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:04:12'!
test07PortfolioWithAccountsHasRegisteredAccountsTransactions
	
	| portfolio account |
	
	account := self receptiveAccountWithDepositsOf50And100.
	
	portfolio := self portfolioWith: account.
	
	self assert: portfolio hasRegistredAllTransactionsOf: account.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:04:12'!
test08PortfolioWithPortfoliosWithAccountsHasRegisteredTransactions
	
	| mainPortfolio secondaryPortfolio account|
	
	account := self receptiveAccountWithDepositsOf50And100.
	
	secondaryPortfolio := self portfolioWith: account.
	
	mainPortfolio := self portfolioWith: secondaryPortfolio.

	self assert: mainPortfolio hasRegistredAllTransactionsOf: account.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/19/2022 20:33:22'!
test09EmptyPortfolioHasNoTransactions
	
	| portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:05:24'!
test10PortfolioHasInnerAccountsTransactions
	
	| portfolio account1 account2 |
	account1 := self receptiveAccountWithADepositOf50.
	account2 := self receptiveAccountWithDepositsOf50And100.	
	
	portfolio := self portfolioWith: account1 with: account2.
	
	self assert: portfolio hasAllTransactionsOf: account1 andAllTransactionsOf: account2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:06:10'!
test11PortfolioWithPortfoliosHasInnerAccountsTransactions
	
	| mainPortfolio portfolio1 portfolio2 |
	portfolio1 := self portfolioWithOneAccountWithADepositOf50.
	portfolio2 := self portfolioWithAccountWithADepositOf50AndAnotherAccountWithADepositOf100.
	
	mainPortfolio := self portfolioWith: portfolio1 with: portfolio2.
	
	self assert: mainPortfolio hasAllTransactionsOf: portfolio1 andAllTransactionsOf: portfolio2.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:06:39'!
test12PortfolioShouldRaiseErrorWhenAddingTransactionRecordTwice
	
	| portfolio account |
	account := self receptiveAccountWithADepositOf50.
	
	portfolio := self portfolioWith: account.
	
	self should: portfolio raiseWhenAddingDuplicated: account.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:07:28'!
test13PortfolioWithChildPortfolioShouldRaiseErrorWhenAddingAnAccountThatAlreadyExistsInChildPorfolio
	
	| mainPortfolio secondaryPortfolio account |
	account := self receptiveAccountWithADepositOf50.
	
	secondaryPortfolio := self portfolioWith: account.
	
	mainPortfolio := self portfolioWith: secondaryPortfolio.
	
	self should: mainPortfolio raiseWhenAddingDuplicated: account.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:08:08'!
test14PortfolioWithChildPortfolioShouldRaiseErrorWhenAddingAPortfolioThatAlreadyExistsInChildPorfolio
	
	| mainPortfolio secondaryPortfolio tertiaryPortfolio |
	tertiaryPortfolio := self portfolioWithOneAccountWithADepositOf50.
	
	secondaryPortfolio := self portfolioWith: tertiaryPortfolio.
	
	mainPortfolio := self portfolioWith: secondaryPortfolio.
	
	self should: mainPortfolio raiseWhenAddingDuplicated: tertiaryPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:08:26'!
test15PortfolioWithAccountShouldRaiseErrorWhenAddingAPortfolioAndSameAccountToThatPortfolio
	
	| mainPortfolio secondaryPortfolio account |
	
	account := self receptiveAccountWithADepositOf50.
	
	secondaryPortfolio := Portfolio new.
	
	mainPortfolio := self portfolioWith: account with: secondaryPortfolio.
	
	self should: secondaryPortfolio raiseWhenAddingDuplicated: account.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:09:34'!
test16PortfolioShouldRaiseErrorWhenAddingATransactionRecordThatExistsMoreThanOneLevelUpInTheTree
	
	| mainPortfolio secondaryPortfolio tertiaryPortfolio account |

	account := self receptiveAccountWithADepositOf50.
	
	tertiaryPortfolio := Portfolio new.
	
	secondaryPortfolio := self portfolioWith: tertiaryPortfolio.
	
	mainPortfolio := self portfolioWith: account with: secondaryPortfolio.
	
	self should: tertiaryPortfolio raiseWhenAddingDuplicated: account.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:10:12'!
test17PortfolioWithAccountShouldRaiseErrorWhenAddingAnotherPortfolioWithSameAccount
	
	| mainPortfolio secondaryPortfolio account |
	
	account := self receptiveAccountWithADepositOf50.
	
	mainPortfolio := self portfolioWith: account.
	
	secondaryPortfolio := self portfolioWith: account.
	
	self should: mainPortfolio raiseWhenAddingDuplicated: secondaryPortfolio.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/22/2022 12:10:22'!
test18PortfolioWithChildPortfolioWithAccountShouldRaiseErrorWhenAddingAThirdPortfolioWithSameAccount
	
	| mainPortfolio secondaryPortfolio tertiaryPortfolio account |

	account := self receptiveAccountWithADepositOf50.

	secondaryPortfolio := self portfolioWith: account.

	tertiaryPortfolio := self portfolioWith: account.
	
	mainPortfolio := self portfolioWith: secondaryPortfolio.
	
	self should: mainPortfolio raiseWhenAddingDuplicated: tertiaryPortfolio.! !


!PortfolioTest methodsFor: 'receptive accounts' stamp: 'TO 5/22/2022 12:03:12'!
receptiveAccountWithADepositOf50

	^ self receptiveAccountWithADepositOf: 50! !

!PortfolioTest methodsFor: 'receptive accounts' stamp: 'LZ 5/21/2022 20:32:57'!
receptiveAccountWithADepositOf: aValue
	
	| account |
	
	account :=  ReceptiveAccount new.
	self registerDepositOf: aValue on: account.
	
	^ account.! !

!PortfolioTest methodsFor: 'receptive accounts' stamp: 'LZ 5/21/2022 20:32:57'!
receptiveAccountWithADepositOf: aValueForFirstDeposit andAnotherDepositOf: aValueForSecondDeposit

	| account |
	
	account := self receptiveAccountWithADepositOf: aValueForFirstDeposit.
	self registerDepositOf: aValueForSecondDeposit on: account.
	
	^ account.
	! !

!PortfolioTest methodsFor: 'receptive accounts' stamp: 'TO 5/22/2022 12:04:12'!
receptiveAccountWithDepositsOf50And100

	^ self receptiveAccountWithADepositOf: 50 andAnotherDepositOf: 100! !

!PortfolioTest methodsFor: 'receptive accounts' stamp: 'LZ 5/21/2022 20:31:01'!
registerDepositOf: aValueForDeposit on: aReceptiveAccount

	^ Deposit register: aValueForDeposit on: aReceptiveAccount! !


!PortfolioTest methodsFor: 'portfolios' stamp: 'LZ 5/21/2022 20:17:01'!
portfolioWith: aTransactionRecord

	| portfolio |
	
	portfolio := Portfolio new.
	portfolio add: aTransactionRecord.
	
	^ portfolio ! !

!PortfolioTest methodsFor: 'portfolios' stamp: 'LZ 5/21/2022 20:50:20'!
portfolioWith: aTransactionRecord with: anotherTransactionRecord

	| portfolio |
	
	portfolio := self portfolioWith: aTransactionRecord.
	portfolio add: anotherTransactionRecord.
	
	^ portfolio ! !

!PortfolioTest methodsFor: 'portfolios' stamp: 'TO 5/22/2022 12:02:09'!
portfolioWithAccountWithADepositOf50AndAnotherAccountWithADepositOf100

	^ self portfolioWithOneAccountWithADepositOf: 50 andAnotherWithADepositOf: 100! !

!PortfolioTest methodsFor: 'portfolios' stamp: 'TO 5/22/2022 11:58:26'!
portfolioWithOneAccountWithADepositOf50

	^ self portfolioWithOneAccountWithADepositOf: 50! !

!PortfolioTest methodsFor: 'portfolios' stamp: 'LZ 5/21/2022 20:32:57'!
portfolioWithOneAccountWithADepositOf: aValue

	^ self portfolioWith: (self receptiveAccountWithADepositOf: aValue).! !

!PortfolioTest methodsFor: 'portfolios' stamp: 'LZ 5/21/2022 20:32:57'!
portfolioWithOneAccountWithADepositOf: aValueForFirstDeposit andAnotherWithADepositOf: aValueForSecondDeposit

	| portfolio |
	
	portfolio := self portfolioWithOneAccountWithADepositOf: aValueForFirstDeposit.
	portfolio add: (self receptiveAccountWithADepositOf: aValueForSecondDeposit).
	
	^ portfolio ! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:18:39'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/16/2022 16:19:11'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
	
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'LZ 5/21/2022 20:02:52'!
value 

	^ value.! !


!AccountTransaction methodsFor: 'account balance' stamp: 'TO 5/16/2022 20:53:09'!
balanceAfterTransaction: previousBalance

	self subclassResponsibility 
	
	! !


!AccountTransaction methodsFor: 'initialization' stamp: 'LZ 5/21/2022 20:02:25'!
initializeFor: aValue

	value := aValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'account balance' stamp: 'TO 5/16/2022 20:53:21'!
balanceAfterTransaction: previousBalance

	^ previousBalance + value
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'account balance' stamp: 'TO 5/16/2022 20:53:34'!
balanceAfterTransaction: previousBalance

	^ previousBalance - value
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransactionRecord category: 'Portfolio-Ejercicio'!
Object subclass: #TransactionRecord
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransactionRecord methodsFor: 'balance' stamp: 'TO 5/19/2022 21:32:22'!
balance
	
	self subclassResponsibility ! !


!TransactionRecord methodsFor: 'transactions' stamp: 'TO 5/19/2022 21:32:57'!
transactions

	self subclassResponsibility ! !


!TransactionRecord methodsFor: 'testing' stamp: 'TO 5/19/2022 21:32:42'!
hasRegistered: anAccountTransaction 

	self subclassResponsibility ! !


!TransactionRecord methodsFor: 'testing-private' stamp: 'LZ 5/21/2022 19:47:44'!
anySubtreeOverlapsWithSubtreeOf: aCollectionOfTransactionRecords

	self subclassResponsibility.! !

!TransactionRecord methodsFor: 'testing-private' stamp: 'LZ 5/21/2022 18:14:59'!
includes: aTransactionRecord

	self subclassResponsibility.! !


!TransactionRecord methodsFor: 'tree hierarchy' stamp: 'TO 5/22/2022 12:13:12'!
addParent: aTransactionRecord

	self subclassResponsibility! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
TransactionRecord subclass: #Portfolio
	instanceVariableNames: 'transactionRecords parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'TO 5/19/2022 21:34:42'!
balance
	
	^ transactionRecords sum: [: aTransactionRecord | aTransactionRecord balance] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'initialization' stamp: 'LZ 5/21/2022 18:36:28'!
initialize
	
	transactionRecords := OrderedCollection new.
	parents := Set new.! !


!Portfolio methodsFor: 'error signals' stamp: 'LZ 5/21/2022 19:29:51'!
signalDuplicatedTransactionRecord

	self error: self duplicatedTransactionRecordErrorDescription. ! !


!Portfolio methodsFor: 'adding' stamp: 'LZ 5/21/2022 19:28:22'!
add: aTransactionRecord 
	
	self assertNoSubtreeOfTransactionRecordIsIncludedInRecordTree: aTransactionRecord.
	
	aTransactionRecord addParent: self.
	
	transactionRecords add: aTransactionRecord! !


!Portfolio methodsFor: 'testing-private' stamp: 'LZ 5/21/2022 19:14:33'!
anyChildIncludes: aTransactionRecord

	^ transactionRecords anySatisfy: [:anIncludedTransactionRecord | anIncludedTransactionRecord includes: aTransactionRecord]! !

!Portfolio methodsFor: 'testing-private' stamp: 'LZ 5/21/2022 19:44:50'!
anySubtreeOverlapsWithSubtreeOf: aCollectionOfTransactionRecords

	^ aCollectionOfTransactionRecords anySatisfy: [ :aTransactionRecord | self hasOverlapWith: aTransactionRecord].! !

!Portfolio methodsFor: 'testing-private' stamp: 'LZ 5/21/2022 19:44:50'!
hasOverlapWith: aTransactionRecord

	^ (self includes: aTransactionRecord) or: [aTransactionRecord anySubtreeOverlapsWithSubtreeOf: transactionRecords].! !

!Portfolio methodsFor: 'testing-private' stamp: 'LZ 5/21/2022 19:02:32'!
includes: aTransactionRecord

	^ self = aTransactionRecord or:[ self anyChildIncludes: aTransactionRecord ].! !


!Portfolio methodsFor: 'testing' stamp: 'TO 5/19/2022 21:36:32'!
hasRegistered: aTransaction 
	
	^ transactionRecords anySatisfy: [ : aTransactionRecord | aTransactionRecord hasRegistered: aTransaction ]! !


!Portfolio methodsFor: 'transactions' stamp: 'LZ 5/21/2022 19:56:33'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	self addTransactionsInto: transactions.
	
	^ transactions! !


!Portfolio methodsFor: 'error descriptions' stamp: 'LZ 5/21/2022 19:55:44'!
duplicatedTransactionRecordErrorDescription

	^ 'There is a duplicated transaction record'.! !


!Portfolio methodsFor: 'adding asseritions' stamp: 'LZ 5/21/2022 19:54:16'!
assertNoSubtreeOfTransactionRecordIsIncludedInRecordChilds: aTransactionRecord

	(self hasOverlapWith: aTransactionRecord) ifTrue:[ self signalDuplicatedTransactionRecord ].! !

!Portfolio methodsFor: 'adding asseritions' stamp: 'LZ 5/21/2022 19:34:09'!
assertNoSubtreeOfTransactionRecordIsIncludedInRecordParents: aTransactionRecord

	^ parents do: [ :aParent | 		aParent	 assertNoSubtreeOfTransactionRecordIsIncludedInRecordTree: aTransactionRecord ].! !

!Portfolio methodsFor: 'adding asseritions' stamp: 'LZ 5/21/2022 19:33:43'!
assertNoSubtreeOfTransactionRecordIsIncludedInRecordTree: aTransactionRecord

	self assertNoSubtreeOfTransactionRecordIsIncludedInRecordChilds: aTransactionRecord.
	self assertNoSubtreeOfTransactionRecordIsIncludedInRecordParents: aTransactionRecord.! !


!Portfolio methodsFor: 'transactions-private' stamp: 'TO 5/19/2022 21:37:40'!
addTransactionsInto: aCollectionOfTransactions

	^ transactionRecords inject: aCollectionOfTransactions into:[: transactions : aTransactionRecord | transactions addAll: aTransactionRecord transactions. transactions ]! !


!Portfolio methodsFor: 'tree hierarchy' stamp: 'LZ 5/21/2022 18:40:43'!
addParent: aTransactionRecord
	
	parents add: aTransactionRecord.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
TransactionRecord subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'TO 5/16/2022 20:36:55'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'TO 5/16/2022 21:14:27'!
register: aTransaction

	transactions add: aTransaction
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'TO 5/16/2022 20:37:02'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'TO 5/16/2022 20:53:57'!
balance

	^ transactions inject: 0 into: [ : accumulatedBalance :  aTransaction | aTransaction balanceAfterTransaction: accumulatedBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'TO 5/16/2022 20:19:08'!
hasRegistered: aTransaction

	^ self transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'tree hierarchy' stamp: 'TO 5/22/2022 12:13:44'!
addParent: aTransactionRecord

	^ self! !


!ReceptiveAccount methodsFor: 'testing-private' stamp: 'LZ 5/21/2022 19:49:22'!
anySubtreeOverlapsWithSubtreeOf: aCollectionOfTransactionRecords

	^ aCollectionOfTransactionRecords includes: self.! !

!ReceptiveAccount methodsFor: 'testing-private' stamp: 'LZ 5/21/2022 18:15:50'!
includes: aTransactionRecord

	^ self = aTransactionRecord.! !
