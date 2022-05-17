!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/16/2022 20:56:31'!
test01PortfoliosHaveZeroBalanceWhenCreated
	
	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/16/2022 21:37:32'!
test02PortfolioWithOneAccountBalanceEqualsOneAccountBalance
	
	| portfolio |
	
	portfolio := self portfolioWithOneAccountWithADepositOf: 50.

	self assert: 50 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/16/2022 21:37:58'!
test03PortfolioWithOnePortfolioBalanceEqualsOnePortfolioBalance
	
	| mainPortfolio secondaryPortfolio |
	
	secondaryPortfolio := self portfolioWithOneAccountWithADepositOf: 50.
	
	mainPortfolio := Portfolio new.
	mainPortfolio addPortfolio: secondaryPortfolio.

	self assert: secondaryPortfolio balance equals: mainPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/16/2022 21:39:18'!
test04PorfolioWithOnePortfolioAndOneAccountBalanceIsSumOfBothBalances
	
	| mainPortfolio secondaryPortfolio |
	
	secondaryPortfolio := self portfolioWithOneAccountWithADepositOf: 50.
	
	mainPortfolio := self portfolioWithOneAccountWithADepositOf: 50.
	mainPortfolio addPortfolio: secondaryPortfolio.

	self assert: secondaryPortfolio balance + 50 equals: mainPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/16/2022 21:44:01'!
test05PorfolioWithManyPortfoliosAndOneAccountsBalanceIsSumOfAllBalances
	
	| mainPortfolio portfolio1 portfolio2 |
	
	portfolio1 := self portfolioWithOneAccountWithADepositOf: 50.	
	portfolio2 := self portfolioWithOneAccountWithADepositOf: 50 andAnotherWithADepositOf: 100.
	
	mainPortfolio := self portfolioWithOneAccountWithADepositOf: 50 andAnotherWithADepositOf: 150.
	mainPortfolio addPortfolio: portfolio1.
	mainPortfolio addPortfolio: portfolio2.

	self assert: portfolio1 balance + portfolio2 balance + 50 + 150 equals: mainPortfolio balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/16/2022 21:51:32'!
test06PortfolioWithNoAccountsHasNotRegisteredATranssaction
	
	| portfolio account |
	
	portfolio := Portfolio new.
	account := self receptiveAccountWithDepositOf: 50.

	self deny: (portfolio hasRegistered: account transactions first).! !

!PortfolioTest methodsFor: 'tests' stamp: 'TO 5/16/2022 21:54:13'!
test07PortfolioWithAccountsHasRegisteredAccountsTransactions
	
	| portfolio account secondDeposit |
	
	portfolio := Portfolio new.
	account := self receptiveAccountWithDepositOf: 50.
	secondDeposit := 	Deposit register: 100 on: account.
	portfolio addAccount: account.

	self assert: (portfolio hasRegistered: account transactions first).
	self assert: (portfolio hasRegistered: secondDeposit ).! !


!PortfolioTest methodsFor: 'receptive accounts' stamp: 'TO 5/16/2022 21:45:41'!
receptiveAccountWithDepositOf: aValue
	
	| account |
	account :=  ReceptiveAccount new.
	Deposit register: aValue on: account.
	
	^ account ! !


!PortfolioTest methodsFor: 'portfolios' stamp: 'TO 5/16/2022 21:45:51'!
portfolioWithOneAccountWithADepositOf: aValue

	| portfolio |
	
	portfolio := Portfolio new.
	portfolio addAccount: (self receptiveAccountWithDepositOf: aValue).
	
	^ portfolio ! !

!PortfolioTest methodsFor: 'portfolios' stamp: 'TO 5/16/2022 21:46:13'!
portfolioWithOneAccountWithADepositOf: aValueForFirstDeposit andAnotherWithADepositOf: aValueForSecondDeposit

	| portfolio |
	
	portfolio := self portfolioWithOneAccountWithADepositOf: aValueForFirstDeposit.
	portfolio addAccount: (self receptiveAccountWithDepositOf: aValueForSecondDeposit).
	
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'account balance' stamp: 'TO 5/16/2022 20:53:09'!
balanceAfterTransaction: previousBalance

	self subclassResponsibility 
	
	! !

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
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


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
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'TO 5/16/2022 21:32:53'!
accountsBalance

	^ accounts sum: [:anAccount| anAccount balance] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'balance' stamp: 'TO 5/16/2022 21:33:25'!
balance
	
	^ self portfoliosBalance + self accountsBalance! !

!Portfolio methodsFor: 'balance' stamp: 'TO 5/16/2022 21:33:43'!
portfoliosBalance

	^ portfolios sum: [: aPortfolio | aPortfolio balance] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'initialization' stamp: 'TO 5/16/2022 21:32:32'!
initialize
	
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new! !


!Portfolio methodsFor: 'adding' stamp: 'TO 5/16/2022 21:28:53'!
addAccount: aReceptiveAccount 
	
	accounts add: aReceptiveAccount! !

!Portfolio methodsFor: 'adding' stamp: 'TO 5/16/2022 21:32:16'!
addPortfolio: aPortfolio 
	
	portfolios add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'TO 5/16/2022 21:51:52'!
hasRegistered: aDeposit 
	
	^ false! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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
