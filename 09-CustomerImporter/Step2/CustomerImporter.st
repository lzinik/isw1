!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 19:09:20'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: session.

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 20:18:40'!
test02ShouldRaiseErrorWhenFindingAnInvalidRecordType

	self shouldRaiseWhenImporting: self invalidRecordType havingImportedNoCustomersWithDescription: CustomerImporter invalidRecordTypeErrorDescription
	! !

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 20:19:56'!
test03ShouldRaiseErrorWhenProcessingAnInvalidRecordTypeSimilarToCustomerRecordType

	self shouldRaiseWhenImporting: self invalidCustomerRecordType havingImportedNoCustomersWithDescription: CustomerImporter invalidRecordTypeErrorDescription! !

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 20:23:30'!
test04ShouldRaiseErrorWhenProcessingAnInvalidRecordTypeSimilarToAddressRecordType

	self shouldRaiseWhenImporting: self invalidAddressRecordType havingImportedNoAddressesWithDescription: CustomerImporter invalidRecordTypeErrorDescription
	! !

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 20:24:22'!
test05ShouldRaiseErrorWhenTryingToImportAnAddressRecordNotBelongingToACustomer

	self shouldRaiseWhenImporting: self validAddressRecordType havingImportedNoAddressesWithDescription: CustomerImporter addressNotBelongingToCustomerErrorDescription
	! !

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 20:20:57'!
test06ShouldRaiseErrorWhenCustomerRecordHasMissingData
	
	self shouldRaiseWhenImporting: self invalidCustomerRecordMissingData havingImportedNoCustomersWithDescription: CustomerImporter recordDoesNotHaveExpectedNumberOfFieldsErrorDescription
	! !

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 20:24:44'!
test07ShouldRaiseErrorWhenAddressRecordHasMissingData

	self shouldRaiseWhenImporting: self dataWithAddressRecordMissingData havingImportedNoAddressesWithDescription: CustomerImporter recordDoesNotHaveExpectedNumberOfFieldsErrorDescription
	! !

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 20:21:22'!
test08ShouldRaiseErrorWhenACustomerRecordHasMoreDataThanExpected

	self shouldRaiseWhenImporting: self invalidCustomerRecordAdditionalData havingImportedNoCustomersWithDescription: CustomerImporter recordDoesNotHaveExpectedNumberOfFieldsErrorDescription
	! !

!ImportTest methodsFor: 'tests' stamp: 'To 6/23/2022 20:25:08'!
test09ShouldRaiseErrorWhenAnAddressRecordHasMoreDataThanExpected

	self shouldRaiseWhenImporting: self invalidAddressRecordAdditionalData havingImportedNoAddressesWithDescription: CustomerImporter recordDoesNotHaveExpectedNumberOfFieldsErrorDescription
	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/23/2022 19:19:38'!
assertImportedRightNumberOfCustomers

	self assertNumberOfImportedCustomersIs: 2.! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/23/2022 19:20:53'!
assertNumberOfImportedAddressesIs: aNumberOfImportedAddresses

	^ self assert: aNumberOfImportedAddresses equals: (session selectAllOfType: Address) size! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/23/2022 19:19:38'!
assertNumberOfImportedCustomersIs: aNumberOfImportedCustomers

	^ self assert: aNumberOfImportedCustomers equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/23/2022 20:28:52'!
shouldRaiseWhenImporting: aDataStream havingImportedNoAddressesWithDescription: anErrorMessage 

	^ self shouldRaiseWhenImporting: aDataStream withDescription: anErrorMessage asserting: [ self assertNumberOfImportedAddressesIs: 0. ]! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/23/2022 20:28:01'!
shouldRaiseWhenImporting: aDataStream havingImportedNoCustomersWithDescription: anErrorMessage 

	^ self shouldRaiseWhenImporting: aDataStream withDescription: anErrorMessage asserting: [ self assertNumberOfImportedCustomersIs: 0. ]! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/23/2022 20:28:07'!
shouldRaiseWhenImporting: aDataStream withDescription: anErrorMessage asserting: anAssertionBlock 

	^ self  should: [ CustomerImporter valueFrom: aDataStream into: session ]  
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anErrorMessage equals: anError messageText.
			anAssertionBlock value
		]! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'To 6/23/2022 19:39:33'!
dataWithAddressRecordMissingData
	
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'To 6/23/2022 20:07:34'!
invalidAddressRecordAdditionalData
	
	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'To 6/23/2022 19:24:29'!
invalidAddressRecordType
	
	^ ReadStream on: 'AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'To 6/23/2022 20:00:38'!
invalidCustomerRecordAdditionalData
	
	^ ReadStream on: 'C,Maria,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'To 6/23/2022 19:35:13'!
invalidCustomerRecordMissingData
	
	^ ReadStream on: 'C,Pepe,Sanchez,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'To 6/23/2022 19:21:44'!
invalidCustomerRecordType
	
	^ ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'To 6/23/2022 20:10:43'!
invalidRecordType
	
	^ ReadStream on: 'B,Pepe'! !

!ImportTest methodsFor: 'test data' stamp: 'To 6/23/2022 19:28:12'!
validAddressRecordType
	
	^ ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !


!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !


!Address methodsFor: 'initialization' stamp: 'To 6/23/2022 20:43:17'!
initializeAt: aStreetName number: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 
	
	streetName := aStreetName.
	streetNumber := aStreetNumber.
	town := aTown.
	zipCode := aZipCode.
	province := aProvince.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Address class' category: 'CustomerImporter'!
Address class
	instanceVariableNames: ''!

!Address class methodsFor: 'instance creation' stamp: 'To 6/23/2022 20:42:58'!
at: aStreetName number: aStreetNumber town: aTown zipCode: aZipCode province: aProvince 

	^self new initializeAt: aStreetName number: aStreetNumber town: aTown zipCode: aZipCode province: aProvince ! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !


!Customer methodsFor: 'initialization' stamp: 'To 6/23/2022 20:37:06'!
initializeNamed: aFirstName lastName: aLastName identifiedAs: anIdentificationType number: anIdentificationNumber 
	
	firstName := aFirstName.
	lastName := aLastName.
	identificationType := anIdentificationType.
	identificationNumber := anIdentificationNumber.
	addresses := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'instance creation' stamp: 'To 6/23/2022 20:35:39'!
named: aFirstName lastName: aLastName identifiedAs: anIdentificationType number: anIdentificationNumber 
	
	^ self new initializeNamed: aFirstName lastName: aLastName identifiedAs: anIdentificationType number: anIdentificationNumber  ! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'record creation - private' stamp: 'To 6/23/2022 19:08:33'!
createRecord

	^ record := line findTokens: $,! !


!CustomerImporter methodsFor: 'testing - private' stamp: 'To 6/23/2022 19:05:40'!
hasRecordToImport

	line := readStream nextLine.
	^ line notNil! !

!CustomerImporter methodsFor: 'testing - private' stamp: 'To 6/23/2022 19:25:09'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'testing - private' stamp: 'To 6/23/2022 19:22:22'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'assertions - private' stamp: 'To 6/23/2022 20:40:47'!
assertAddressRecordCanBeImported

	self assertCustomerWasImported.
	self assertRecordHasNumberOfFields: 6! !

!CustomerImporter methodsFor: 'assertions - private' stamp: 'To 6/23/2022 20:40:11'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class addressNotBelongingToCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'assertions - private' stamp: 'To 6/23/2022 20:01:01'!
assertRecordHasNumberOfFields: aNumberOfExpectedFields

	^ record size = aNumberOfExpectedFields ifFalse: [self error: self class recordDoesNotHaveExpectedNumberOfFieldsErrorDescription ]! !


!CustomerImporter methodsFor: 'importing - private' stamp: 'To 6/23/2022 20:42:09'!
importAddress

	| newAddress |
	self assertAddressRecordCanBeImported.
	
	newAddress := Address at: record second number: record third asNumber town: record fourth zipCode: record fifth asNumber province: record sixth.
	newCustomer addAddress: newAddress
	! !

!CustomerImporter methodsFor: 'importing - private' stamp: 'To 6/23/2022 20:34:45'!
importCustomer

	self assertRecordHasNumberOfFields: 5.
	
	newCustomer := Customer named: record second lastName: record third identifiedAs: record fourth number: record fifth.
	session persist: newCustomer! !

!CustomerImporter methodsFor: 'importing - private' stamp: 'To 6/23/2022 19:17:29'!
importRecord

	self isCustomerRecord ifTrue: [ ^ self importCustomer ].
	self isAddressRecord ifTrue: [ ^ self importAddress ].
	
	self error: self class invalidRecordTypeErrorDescription! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'To 6/23/2022 19:08:33'!
value

	[self hasRecordToImport ] whileTrue: [		 
		self createRecord.
		self importRecord.
		].

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error descriptions' stamp: 'To 6/23/2022 19:30:40'!
addressNotBelongingToCustomerErrorDescription
	
	^ 'A customer must be imported before an address'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'To 6/23/2022 19:17:19'!
invalidRecordTypeErrorDescription
	
	^ 'Invalid record type'! !

!CustomerImporter class methodsFor: 'error descriptions' stamp: 'To 6/23/2022 19:37:47'!
recordDoesNotHaveExpectedNumberOfFieldsErrorDescription
	
	^ 'Customer record has missing fields'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
