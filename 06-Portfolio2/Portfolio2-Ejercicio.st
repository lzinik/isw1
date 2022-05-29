!classDefinition: #AccountSummaryTest category: 'Portfolio2-Ejercicio'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:19:12'!
test01AccountWithNoTransactionsReportsOnlyEmptyBalance
	
	self assertSummaryFor: ReceptiveAccount new equals: #('Balance = 0')! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:21:37'!
test02AccountSummaryShouldReportDepositCorrectly
	
	| account |
	account := ReceptiveAccount new.
	Deposit register: 10 on: account.
	
	self assertSummaryFor: account equals: #(
		'Depósito por 10.'
		'Balance = 10'
	)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:39:56'!
test03AccountSummaryShouldReportWithdrawCorrectly
	
	| account |
	account := ReceptiveAccount new.
	Withdraw register: 10 on: account.
	
	self assertSummaryFor: account equals: #(
	 	'Extracción por 10.'
	 	'Balance = -10'
	)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:22:06'!
test04AccountSummaryShouldReportTransferWithdrawLegCorrectly
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	
	self assertSummaryFor: account equals: #(
		'Salida por transferencia de 10.'
		'Balance = -10'
	)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:22:41'!
test05AccountSummaryShouldReportTransferDepositLegCorrectly
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: account.
	
	self assertSummaryFor: account equals: #(
		'Entrada por transferencia de 10.'
		'Balance = 10'
	)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:23:29'!
test06AccountSummaryShouldReportAllTransactionsAndBalance
	
	| account |
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer for: 20 from: account to: ReceptiveAccount new.
	Transfer for: 30 from: ReceptiveAccount new to: account.
	
	self assertSummaryFor: account equals: #(
		'Depósito por 100.'
		'Extracción por 50.'
		'Salida por transferencia de 20.'
		'Entrada por transferencia de 30.'
		'Balance = 60'
	)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:24:10'!
test07PortfolioWithNoTransactionsReportsOnlyEmptyBalance
	
	self assertSummaryFor: Portfolio new equals: #(
		'Balance = 0'
	)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:29:15'!
test08PortfolioSummaryWithOneAccountShouldMatchSummaryOfAccount
	
	| portfolio account |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Transfer for: 20 from: account to: ReceptiveAccount new.
	Transfer for: 30 from: ReceptiveAccount new to: account.
	
	self assertSummaryFor: portfolio equals: (self accountSummaryLinesFor: account)! !

!AccountSummaryTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:26:19'!
test09PortfolioSummaryShouldReportAllTransactionsInTree
	
	| mainPortfolio secondaryPortfolio mainPortfolioAccount secondaryPortfolioAccount |
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
	
	self assertSummaryFor: mainPortfolio equals: #(
		 'Depósito por 100.'
		 'Salida por transferencia de 20.'
		 'Entrada por transferencia de 20.'
		 'Entrada por transferencia de 20.'
		 'Extracción por 10.'
		 'Balance = 110'
	)! !


!AccountSummaryTest methodsFor: 'assertions' stamp: 'TO 5/29/2022 12:29:02'!
assertSummaryFor: anAccount equals: aReportLines
	
	self assert: (self accountSummaryLinesFor: anAccount) equals: aReportLines! !


!AccountSummaryTest methodsFor: 'report' stamp: 'TO 5/29/2022 12:12:34'!
accountSummaryFor: anAccount

	^ (AccountSummary for: anAccount) report! !

!AccountSummaryTest methodsFor: 'report' stamp: 'TO 5/29/2022 12:28:50'!
accountSummaryLinesFor: anAccount

	^ (self accountSummaryFor: anAccount) lines! !


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

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:36:46'!
test01TransferNetForNewAccountShouldBeZero
	
	self assertTransferNetOf: ReceptiveAccount new equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:36:29'!
test02TransferNetShouldBeAffectedAfterATransferWhenAccountIsSender
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: account to: ReceptiveAccount new.
	
	self assertTransferNetOf: account equals: -10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:37:05'!
test03TransferNetShouldBeAffectedAfertATransferWhenAccountIsReceiver
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: account.
	
	self assertTransferNetOf: account equals: 10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:37:14'!
test04TransferNetShouldNotBeAffectedByDeposit
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: account.
	Deposit register: 10 on: account.
	
	self assertTransferNetOf: account equals: 10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:37:23'!
test05TransferNetShouldNotBeAffectedByWithdraw
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: account.
	Withdraw register: 10 on: account.
	
	self assertTransferNetOf: account equals: 10.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:37:32'!
test06ShouldReportTransferNetCorrectlyAfterMultipleTransactions
	
	| account |
	account := ReceptiveAccount new.
	Transfer for: 20 from: ReceptiveAccount new to: account.
	Transfer for: 10 from: account to: ReceptiveAccount new.	
	Deposit register: 10 on: account.
	Withdraw register: 30 on: account.
	Transfer for: 15 from: ReceptiveAccount new to: account.
	
	self assertTransferNetOf: account equals: 25.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:37:47'!
test07TransferNetForNewPortfolioShouldBeZero
	
	self assertTransferNetOf: Portfolio new equals: 0.! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:38:20'!
test08TransferNetOfPortfolioWithOneAccountShouldMatchAccountTransferNet	
	
	| portfolio account |	
	account := ReceptiveAccount new.
	Transfer for: 10 from: ReceptiveAccount new to: 	account.
	Transfer for: 5 from: account to: 	ReceptiveAccount new.	
	
	portfolio := Portfolio new.
	portfolio add: account.

	self assertTransferNetOf: portfolio equals: (self transferNetOf: account).! !

!TransferNetTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:38:47'!
test09TransferNetOfPortfolioShouldBeAffectedByAllInnerTransfers
	
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

	self assertTransferNetOf: mainPortfolio equals: (self transferNetOf: mainPortfolioAccount) + (self transferNetOf: secondaryPortfolio)! !


!TransferNetTest methodsFor: 'assertions' stamp: 'TO 5/29/2022 12:36:20'!
assertTransferNetOf: anAccount equals: anAmount 

	^ self assert: (self transferNetOf: anAccount) equals: anAmount! !


!TransferNetTest methodsFor: 'report' stamp: 'TO 5/29/2022 12:30:17'!
transferNetOf: account

	^ (TransferNet for: account) report! !


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

!TransferTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:07:22'!
test04TransferFromOneAccountToAnotherAffectBalancesCorrectly

	| senderAccount receiverAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer for: 10 from: senderAccount to: receiverAccount.
	
	self assert: senderAccount balance equals: -10.
	self assert: receiverAccount balance equals: 10.! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:07:44'!
test05ReceiverAccountHasRegisteredTransferDepositLeg

	| senderAccount receiverAccount transfer |
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer for: 10 from: senderAccount to: receiverAccount.
	
	self assert: (receiverAccount hasRegistered: transfer depositLeg).! !

!TransferTest methodsFor: 'tests' stamp: 'TO 5/29/2022 12:08:21'!
test06SenderAccountHasRegisteredTransferWithdrawLeg

	| senderAccount receiverAccount transfer |
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	transfer := Transfer for: 10 from: senderAccount to: receiverAccount.
	
	self assert: (senderAccount hasRegistered: transfer withdrawLeg).! !

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


!Account methodsFor: 'reports' stamp: 'TO 5/29/2022 11:34:49'!
reportOn: aReport

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


!Portfolio methodsFor: 'reports' stamp: 'TO 5/29/2022 11:34:28'!
reportOn: aReport
	
	accounts do: [: anAccount | anAccount reportOn: aReport ]! !

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


!ReceptiveAccount methodsFor: 'reports' stamp: 'TO 5/29/2022 11:33:58'!
reportOn: aReport 
	
	transactions do: [ : aTransaction | aTransaction reportOn: aReport ].! !


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


!AccountTransaction methodsFor: 'report' stamp: 'TO 5/29/2022 11:35:44'!
reportOn: aReport
	
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


!Deposit methodsFor: 'report' stamp: 'TO 5/29/2022 11:36:09'!
reportOn: aReport 
	
	aReport reportDeposit: self! !

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


!TransferDepositLeg methodsFor: 'report' stamp: 'TO 5/29/2022 11:36:37'!
reportOn: aReport 
	
	aReport reportTransferDepositLeg: self! !


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


!TransferWithdrawLeg methodsFor: 'report' stamp: 'TO 5/29/2022 11:36:58'!
reportOn: aReport 
	
	aReport reportTransferWithdrawLeg: self! !


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


!Withdraw methodsFor: 'report' stamp: 'TO 5/29/2022 11:37:20'!
reportOn: aReport 
	
	aReport reportWithdraw: self! !


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


!classDefinition: #Report category: 'Portfolio2-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Report methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:32:11'!
reportDeposit: aDeposit

	self subclassResponsibility ! !

!Report methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:32:38'!
reportTransferDepositLeg: aTransferDepositLeg

	self subclassResponsibility ! !

!Report methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:32:51'!
reportTransferWithdrawLeg: aTransferWithdrawLeg

	self subclassResponsibility ! !

!Report methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:32:21'!
reportWithdraw: aWithdraw

	self subclassResponsibility ! !


!Report methodsFor: 'report' stamp: 'TO 5/29/2022 11:31:25'!
report

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio2-Ejercicio'!
Report subclass: #AccountSummary
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummary methodsFor: 'initialize' stamp: 'TO 5/29/2022 10:52:39'!
initializeFor: anAccount 

	account := anAccount.! !


!AccountSummary methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:41:55'!
addLine: aLine
	
	report := report, aLine, self newLine! !

!AccountSummary methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:09:44'!
newLine

	^ Character newLineCharacter asString! !

!AccountSummary methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:44:50'!
reportDeposit: aDeposit
	
	self addLine: 'Depósito por ', (self transactionValueForSummary: aDeposit), '.'! !

!AccountSummary methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:45:07'!
reportTransferDepositLeg: aTransferDepositLeg 
	
	self addLine: 'Entrada por transferencia de ', (self transactionValueForSummary: aTransferDepositLeg), '.'! !

!AccountSummary methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:45:16'!
reportTransferWithdrawLeg: aTransferWithdrawLeg 
	
	self addLine: 'Salida por transferencia de ', (self transactionValueForSummary: aTransferWithdrawLeg), '.'! !

!AccountSummary methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:45:41'!
reportWithdraw: aWithdraw

	self addLine: 'Extracción por ', (self transactionValueForSummary: aWithdraw), '.'! !

!AccountSummary methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:44:50'!
transactionValueForSummary: aDeposit

	^ aDeposit value asString! !


!AccountSummary methodsFor: 'report' stamp: 'TO 5/29/2022 11:43:40'!
addBalanceToReport

	report := report, 'Balance = ' , account balance asString! !

!AccountSummary methodsFor: 'report' stamp: 'TO 5/29/2022 11:43:25'!
report
	
	report := ''.
	account reportOn: self.
	
	self addBalanceToReport.
	
	^ report! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio2-Ejercicio'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'TO 5/29/2022 10:52:24'!
for: anAccount 
	
	^ self new initializeFor: anAccount ! !


!classDefinition: #TransferNet category: 'Portfolio2-Ejercicio'!
Report subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!TransferNet methodsFor: 'initialize' stamp: 'TO 5/29/2022 11:19:58'!
initializeFor: anAccount 

	account := anAccount.! !


!TransferNet methodsFor: 'report' stamp: 'TO 5/29/2022 11:37:56'!
report
	
	transferNet := 0.
	account reportOn: self.
	
	^ transferNet ! !


!TransferNet methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:28:42'!
reportDeposit: aDeposit 
	
	! !

!TransferNet methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:28:04'!
reportTransferDepositLeg: aTransferDepositLeg 
	
	transferNet := transferNet + aTransferDepositLeg value! !

!TransferNet methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:27:12'!
reportTransferWithdrawLeg: aTransferWithdrawLeg 
	
	transferNet := transferNet - aTransferWithdrawLeg value! !

!TransferNet methodsFor: 'report - private' stamp: 'TO 5/29/2022 11:29:11'!
reportWithdraw: aWithdraw 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio2-Ejercicio'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'TO 5/29/2022 11:19:43'!
for: anAccount

	^ self new initializeFor: anAccount ! !


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
