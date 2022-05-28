!classDefinition: #AccountSummaryTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 11:34:52'!
test01
	
	| summary |
	summary := ReceptiveAccount new accountSummary.
	
	self assert: summary equals: 'Balance = 0'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 11:37:57'!
test02
	
	| summaryLines account |
	account := ReceptiveAccount new.
	Deposit register: 10 on: account.
	
	summaryLines := account accountSummary lines.
	
	self assert: summaryLines first equals: 'Depósito por 10.'.
	self assert: summaryLines second equals: 'Balance = 10'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 11:42:39'!
test03
	
	| summaryLines account |
	account := ReceptiveAccount new.
	Withdraw register: 10 on: account.
	
	summaryLines := account accountSummary lines.
	
	self assert: summaryLines first equals: 'Extracción por 10.'.
	self assert: summaryLines second equals: 'Balance = -10'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 11:46:29'!
test04
	
	| summaryLines account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	summaryLines := account accountSummary lines.
	
	self assert: summaryLines first equals: 'Salida por transferencia de 10.'.
	self assert: summaryLines second equals: 'Balance = -10'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 11:50:15'!
test05
	
	| summaryLines account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: account.
	summaryLines := account accountSummary lines.
	
	self assert: summaryLines first equals: 'Entrada por transferencia de 10.'.
	self assert: summaryLines second equals: 'Balance = 10'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 11:55:18'!
test06
	
	| summaryLines account |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer for: 20 from: account to: ReceptiveAccount new.
	Transfer for: 30 from: ReceptiveAccount new to: account.
	
	summaryLines := account accountSummary lines.
	
	self assert: summaryLines first equals: 'Depósito por 100.'.
	self assert: summaryLines second equals: 'Extracción por 50.'.
	self assert: summaryLines third equals: 'Salida por transferencia de 20.'.
	self assert: summaryLines fourth equals: 'Entrada por transferencia de 30.'.
	self assert: summaryLines fifth equals: 'Balance = 60'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 12:47:07'!
test07
	
	| portfolio |
	portfolio := Portfolio new.
	
	self assert: portfolio accountSummary equals: 'Balance = 0'.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 12:55:51'!
test08
	
	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer for: 20 from: account to: ReceptiveAccount new.
	Transfer for: 30 from: ReceptiveAccount new to: account.
	
	self assert: portfolio accountSummary equals: account accountSummary.! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:13:34'!
test09
	
	| mainPortfolio secondaryPortfolio mainPortfolioAccount secondaryPortfolioAccount summaryLines |
	mainPortfolio := Portfolio new.
	mainPortfolioAccount := ReceptiveAccount new.
	mainPortfolio add: mainPortfolioAccount.
	
	secondaryPortfolio := Portfolio new.
	secondaryPortfolioAccount := ReceptiveAccount new.
	secondaryPortfolio add: secondaryPortfolioAccount.
	mainPortfolio add: secondaryPortfolio.
	
	Deposit register: 100 on: mainPortfolioAccount.
	Transfer for: 20 from: mainPortfolioAccount to: secondaryPortfolioAccount.
	Transfer for: 20 from: ReceptiveAccount new to: secondaryPortfolioAccount.
	Withdraw register: 10 on: secondaryPortfolioAccount.
	
	summaryLines := mainPortfolio accountSummary lines.
	
	self assert: summaryLines first equals: 'Depósito por 100.'.
	self assert: summaryLines second equals: 'Salida por transferencia de 20.'.
	self assert: summaryLines third equals: 'Entrada por transferencia de 20.'.
	self assert: summaryLines fourth equals: 'Entrada por transferencia de 20.'.
	self assert: summaryLines fifth equals: 'Extracción por 10.'.
	self assert: summaryLines sixth equals: 'Balance = 110'.
	! !


!classDefinition: #PortfolioTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 12:18:54'!
test01
	
	| transferNet |
	transferNet := ReceptiveAccount new transferNet.
	
	self assert: transferNet equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 12:22:27'!
test02
	
	| transferNet account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	
	transferNet :=  account transferNet.
	
	self assert: transferNet equals: -10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 12:25:55'!
test03
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: account.
	
	self assert: account transferNet equals: 10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 12:30:42'!
test04
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: account.
	Deposit register: 10 on: account.
	
	self assert: account transferNet equals: 10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 12:33:41'!
test05
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: account.
	Withdraw register: 10 on: account.
	
	self assert: account transferNet equals: 10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 12:36:22'!
test06
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 20 from: ReceptiveAccount new to: account.
	Transfer for: 10 from: account to: ReceptiveAccount new.	
	Deposit register: 10 on: account.
	Withdraw register: 30 on: account.
	Transfer for: 15 from: ReceptiveAccount new to: account.
	
	self assert: account transferNet equals: 25.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:14:38'!
test07
	
	self assert: Portfolio new transferNet equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:17:09'!
test08	
	
	| portfolio account |	
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: 	account.
	Transfer for: 5 from: account to: 	ReceptiveAccount new.	
	
	portfolio := Portfolio new.
	portfolio add: account.

	self assert: portfolio transferNet equals: account transferNet.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:20:39'!
test09
	
	| mainPortfolio mainPortfolioAccount secondaryPortfolio secondaryPortfolioAccount |	
	secondaryPortfolioAccount := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: 	secondaryPortfolioAccount.
	
	secondaryPortfolio := Portfolio new.
	secondaryPortfolio add: secondaryPortfolioAccount.
	
	mainPortfolioAccount := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: 	mainPortfolioAccount.
	Transfer for: 5 from: mainPortfolioAccount to: 	ReceptiveAccount new.	
	
	mainPortfolio := Portfolio new.
	mainPortfolio add: mainPortfolioAccount.
	mainPortfolio add: secondaryPortfolio.

	self assert: mainPortfolio transferNet equals: mainPortfolioAccount transferNet + secondaryPortfolio transferNet.! !


!classDefinition: #TransferTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferTest methodsFor: 'assertions' stamp: 'TO 5/28/2022 14:34:28'!
shouldRaiseWhenTransferingNonPositiveWithoutAffectingBalances: aNonPositiveAmount from: aSenderAccount to: aReceiverAccount 

	self shouldRaiseWhenTransferingWithoutAffectingBalances: aNonPositiveAmount from: aSenderAccount to: aReceiverAccount withDescription: Transfer transferValueShouldBePositiveErrorDescription! !

!TransferTest methodsFor: 'assertions' stamp: 'TO 5/28/2022 14:33:45'!
shouldRaiseWhenTransferingWithoutAffectingBalances: anAmountOfMoney from: aSenderAccount to: aReceiverAccount withDescription: anErrorDescription

	self 
		should: [ Transfer for: anAmountOfMoney from: aSenderAccount to: aReceiverAccount ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anErrorDescription equals: anError messageText.
			self assert: aSenderAccount balance equals: 0.
			self assert: aReceiverAccount balance equals: 0. ]! !

!TransferTest methodsFor: 'assertions' stamp: 'TO 5/28/2022 14:36:17'!
shouldRaiseWhenTransferingWithoutAffectingBalances: anAmountOfMoney toSameAccountAsSender: aSenderAccount

	self shouldRaiseWhenTransferingWithoutAffectingBalances: anAmountOfMoney from: aSenderAccount to: aSenderAccount withDescription: Transfer canNotTransferToTheSameAccountErrorDescription ! !


!TransferTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:31:35'!
test01ShouldRaiseErrorWhenTransferingANegativeValue
	
	self shouldRaiseWhenTransferingNonPositiveWithoutAffectingBalances: -5 from: ReceptiveAccount new to: ReceptiveAccount new
	
	! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:31:35'!
test02ShouldRaiseErrorWhenTransferingZero

	self shouldRaiseWhenTransferingNonPositiveWithoutAffectingBalances: 0 from: ReceptiveAccount new to: ReceptiveAccount new
	
	! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:37:02'!
test03ShouldRaiseErrorWhenTransferingFromAnAccountToTheSameAccount

	self shouldRaiseWhenTransferingWithoutAffectingBalances: 10 toSameAccountAsSender: ReceptiveAccount new.
	! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/28/2022 10:52:40'!
test04TransferFromOneAccountToAnotherAffectBalancesCorrectly

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer for: 10 from: account1 to: account2.
	
	self assert: account1 balance equals: -10.
	self assert: account2 balance equals: 10.! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:40:58'!
test05ReceiverAccountHasRegisteredTransferDepositLeg

	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer for: 10 from: account1 to: account2.
	
	self assert: (account2 hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:41:09'!
test06SenderAccountHasRegisteredTransferWithdrawLeg

	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer for: 10 from: account1 to: account2.
	
	self assert: (account1 hasRegistered: transfer withdrawLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:41:21'!
test07TransferDepositLegKnowsOriginalTransfer

	| transfer depositLeg |
	transfer := Transfer for: 10 from: ReceptiveAccount new to: ReceptiveAccount new.
	
	depositLeg := transfer depositLeg.
	
	self assert: depositLeg transfer equals: transfer.! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/28/2022 14:41:26'!
test08TransferWithdrawLegKnowsOriginalTransfer

	| transfer withdrawLeg |
	transfer := Transfer for: 10 from: ReceptiveAccount new to: ReceptiveAccount new.
	
	withdrawLeg := transfer withdrawLeg.
	
	self assert: withdrawLeg transfer equals: transfer.! !


!classDefinition: #Account category: 'Portfolio2-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio2-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'TO 5/28/2022 14:12:29'!
accountSummary
	
	^ self transactionsSummary, 'Balance = ' , self balance asString.
	! !

!Portfolio methodsFor: 'reports' stamp: 'TO 5/28/2022 14:12:39'!
transactionsSummary
	
	^ accounts inject: '' into: [: summary :anAccount | summary, anAccount transactionsSummary ]! !

!Portfolio methodsFor: 'reports' stamp: 'TO 5/28/2022 14:21:37'!
transferNet
	
	^ accounts sum: [ : anAccount |anAccount transferNet ] ifEmpty: [ 0 ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'TO 5/28/2022 14:11:17'!
accountSummary

	^ self transactionsSummary, 'Balance = ' , self balance asString.! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'TO 5/28/2022 14:10:43'!
transactionsSummary

	^ transactions inject: '' into: [: summary :aTransaction | summary, aTransaction lineForAccountSummary, Character newLineCharacter asString.]! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'TO 5/28/2022 12:39:02'!
transferNet
	
	^ transactions sum: [ : aTransaction |aTransaction valueForTransferNet ] ifEmpty: [ 0 ].! !


!classDefinition: #AccountTransaction category: 'Portfolio2-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report' stamp: 'TO 5/28/2022 12:08:10'!
lineForAccountSummary
	
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'report' stamp: 'TO 5/28/2022 12:37:33'!
valueForTransferNet
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'report' stamp: 'TO 5/28/2022 12:12:33'!
lineForAccountSummary

	^ 'Depósito por ', value asString, '.'! !

!Deposit methodsFor: 'report' stamp: 'TO 5/28/2022 12:39:20'!
valueForTransferNet
	
	^ 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferLeg methodsFor: 'accessing' stamp: 'TO 5/28/2022 11:22:36'!
transfer

	self subclassResponsibility ! !


!classDefinition: #TransferDepositLeg category: 'Portfolio2-Ejercicio'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferDepositLeg methodsFor: 'initialize' stamp: 'TO 5/28/2022 12:06:10'!
initializeFor: aTransfer

	transfer := aTransfer.! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'TO 5/28/2022 12:14:07'!
affectBalance: aBalance 

	^ aBalance + self value ! !


!TransferDepositLeg methodsFor: 'value' stamp: 'TO 5/28/2022 11:51:37'!
value
	
	^ transfer value! !


!TransferDepositLeg methodsFor: 'report' stamp: 'TO 5/28/2022 12:14:00'!
lineForAccountSummary

	^ 'Entrada por transferencia de ', self value asString, '.'! !

!TransferDepositLeg methodsFor: 'report' stamp: 'TO 5/28/2022 12:39:48'!
valueForTransferNet

	^ self value! !


!TransferDepositLeg methodsFor: 'accessing' stamp: 'TO 5/28/2022 11:12:46'!
transfer

	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDepositLeg class' category: 'Portfolio2-Ejercicio'!
TransferDepositLeg class
	instanceVariableNames: ''!

!TransferDepositLeg class methodsFor: 'instance creation' stamp: 'TO 5/28/2022 12:05:29'!
for: aTransfer

	^ self new initializeFor: aTransfer.
! !


!classDefinition: #TransferWithdrawLeg category: 'Portfolio2-Ejercicio'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferWithdrawLeg methodsFor: 'initialize' stamp: 'TO 5/28/2022 12:06:10'!
initializeFor: aTransfer 
	
	transfer := aTransfer.! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'TO 5/28/2022 12:14:13'!
affectBalance: aBalance

	^ aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'value' stamp: 'TO 5/28/2022 11:48:54'!
value
	
	^ transfer value! !


!TransferWithdrawLeg methodsFor: 'report' stamp: 'TO 5/28/2022 12:13:40'!
lineForAccountSummary

	^ 'Salida por transferencia de ', self value asString, '.'! !

!TransferWithdrawLeg methodsFor: 'report' stamp: 'TO 5/28/2022 12:40:11'!
valueForTransferNet

	^ self value negated ! !


!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'TO 5/28/2022 11:17:16'!
transfer

	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdrawLeg class' category: 'Portfolio2-Ejercicio'!
TransferWithdrawLeg class
	instanceVariableNames: ''!

!TransferWithdrawLeg class methodsFor: 'instance creation' stamp: 'TO 5/28/2022 12:05:55'!
for: aTransfer

	^ self new initializeFor: aTransfer.! !


!classDefinition: #Withdraw category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'report' stamp: 'TO 5/28/2022 12:12:12'!
lineForAccountSummary

	^ 'Extracción por ', value asString, '.'! !

!Withdraw methodsFor: 'report' stamp: 'TO 5/28/2022 12:39:36'!
valueForTransferNet

	^ 0! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio2-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value senderReceptiveAccount receiverReceptiveAccount depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Transfer methodsFor: 'initialize' stamp: 'TO 5/28/2022 14:26:11'!
initializeFor: anAmountOfMoney from: aSenderReceptiveAccount to: aReceiverReceptiveAccount

	value := anAmountOfMoney.
	depositLeg := TransferDepositLeg register: self on: aReceiverReceptiveAccount.
	withdrawLeg := TransferWithdrawLeg register: self on: aSenderReceptiveAccount.! !


!Transfer methodsFor: 'accessing' stamp: 'TO 5/28/2022 10:55:39'!
depositLeg
	
	^ depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'TO 5/28/2022 11:12:11'!
value
	
	^ value! !

!Transfer methodsFor: 'accessing' stamp: 'TO 5/28/2022 10:56:57'!
withdrawLeg
	
	^ withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'TO 5/28/2022 14:24:13'!
for: anAmountOfMoney from: aSenderReceptiveAccount to: aReceiverReceptiveAccount

	self assertSender: aSenderReceptiveAccount isNotReceiver: aReceiverReceptiveAccount.
	self assertAmountToTransferIsPositive: anAmountOfMoney.
	
	^ self new initializeFor: anAmountOfMoney from: aSenderReceptiveAccount to: aReceiverReceptiveAccount ! !


!Transfer class methodsFor: 'assertions' stamp: 'TO 5/28/2022 14:25:31'!
assertAmountToTransferIsPositive: anAmountOfMoney

	^ anAmountOfMoney <= 0  ifTrue:[ self error: self transferValueShouldBePositiveErrorDescription ]! !

!Transfer class methodsFor: 'assertions' stamp: 'TO 5/28/2022 14:25:10'!
assertSender: aSenderReceptiveAccount isNotReceiver: aReceiverReceptiveAccount

	^ aSenderReceptiveAccount = aReceiverReceptiveAccount ifTrue: [ self error: self canNotTransferToTheSameAccountErrorDescription ]! !


!Transfer class methodsFor: 'error descriptions' stamp: 'TO 5/28/2022 14:25:10'!
canNotTransferToTheSameAccountErrorDescription

	^ 'Can not transfer to the same account'.! !

!Transfer class methodsFor: 'error descriptions' stamp: 'TO 5/28/2022 14:25:31'!
transferValueShouldBePositiveErrorDescription
	
	 ^ 'Transfer value should be positive'.! !
