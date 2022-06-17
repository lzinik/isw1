!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'assertions' stamp: 'To 6/16/2022 21:38:58'!
assert: aCustomer hasImported: anAddress      
	
	| address |
	address := aCustomer addressAt: anAddress streetName.
	self assert: anAddress streetName equals: address streetName.
	self assert: anAddress streetNumber equals: address streetNumber.
	self assert: anAddress town equals: address town.
	self assert: anAddress zipCode equals: address zipCode.
	self assert: anAddress province equals: address province.
	! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/16/2022 21:23:17'!
assert: aCustomerToBeTested sharesNameAndIdentificationWith: aCustomer     

	self assert: aCustomer firstName equals: aCustomerToBeTested firstName.
	self assert: aCustomer lastName equals: aCustomerToBeTested lastName.
	self assert: aCustomer identificationType equals: aCustomerToBeTested identificationType.
	self assert: aCustomer identificationNumber equals: aCustomerToBeTested identificationNumber! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/16/2022 21:48:51'!
assertHasImportedJuanPerez

	| importedCustomer |
	importedCustomer := self customerIdentifiedAs: self juanPerez identificationType number: self juanPerez identificationNumber.
	self assert: importedCustomer sharesNameAndIdentificationWith: self juanPerez.
	self assert: importedCustomer hasImported: self juanPerezAlemAddress.! !

!ImportTest methodsFor: 'assertions' stamp: 'To 6/16/2022 21:46:19'!
assertHasImportedPepeSanchez

	| importedCustomer |
	importedCustomer := self customerIdentifiedAs: self pepeSanchez identificationType number: self pepeSanchez identificationNumber.
	self assert: importedCustomer sharesNameAndIdentificationWith: self pepeSanchez.
	self assert: importedCustomer hasImported: self pepeSanchezSanMartinAddress.
	self assert: importedCustomer hasImported: self pepeSanchezMaipuAddress.! !


!ImportTest methodsFor: 'addresses' stamp: 'To 6/16/2022 21:27:14'!
address: aStreetName number: aStreetNumber town: aTown zipCode: aZipCode province: aProvince    

	^ Address new streetName:  aStreetName; streetNumber: aStreetNumber; town: aTown; zipCode: aZipCode; province: aProvince! !

!ImportTest methodsFor: 'addresses' stamp: 'To 6/16/2022 21:34:42'!
juanPerezAlemAddress

	^ self address: 'Alem' number: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'.
	! !

!ImportTest methodsFor: 'addresses' stamp: 'To 6/16/2022 21:33:38'!
pepeSanchezMaipuAddress

	^ self address: 'Maipu' number: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'! !

!ImportTest methodsFor: 'addresses' stamp: 'To 6/16/2022 21:30:50'!
pepeSanchezSanMartinAddress

	^ self address: 'San Martin' number: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'! !


!ImportTest methodsFor: 'customers' stamp: 'To 6/16/2022 21:14:59'!
customerNamed: aName lastName: aLastName identifiedAs: anIdentificationType number: anIdentificationNumber   

	^ Customer new firstName: aName;  lastName: aLastName;  identificationType: anIdentificationType; identificationNumber: anIdentificationNumber! !

!ImportTest methodsFor: 'customers' stamp: 'To 6/16/2022 21:35:03'!
juanPerez

	| juan |
	juan := self customerNamed: 'Juan' lastName: 'Perez' identifiedAs: 'C' number: '23-25666777-9'.
	juan addAddress: self juanPerezAlemAddress.
	
	^ juan! !

!ImportTest methodsFor: 'customers' stamp: 'To 6/16/2022 21:31:26'!
pepeSanchez

	| pepe |
	pepe := self customerNamed: 'Pepe' lastName: 'Sanchez' identifiedAs: 'D' number: '22333444'.
	pepe addAddress: self pepeSanchezSanMartinAddress.
	pepe addAddress: self pepeSanchezMaipuAddress.
	
	^ pepe! !


!ImportTest methodsFor: 'tests' stamp: 'To 6/16/2022 21:46:19'!
test01Import

	(CustomerImporter from: self validData into: session) value.
	
	self assert: 2 equals: (session selectAllOfType: Customer) size.
	self assertHasImportedPepeSanchez.
	self assertHasImportedJuanPerez.! !


!ImportTest methodsFor: 'set up / tear down' stamp: 'To 6/16/2022 19:42:28'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !

!ImportTest methodsFor: 'set up / tear down' stamp: 'To 6/16/2022 19:43:11'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'support' stamp: 'To 6/16/2022 20:28:29'!
customerIdentifiedAs: anIdentificationType number: anIdentificationNumber 

	^ (session select: [:aCustomer | 
		aCustomer identificationType = anIdentificationType and: [aCustomer identificationNumber = anIdentificationNumber]] 
		ofType: Customer) anyOne! !

!ImportTest methodsFor: 'support' stamp: 'To 6/16/2022 20:32:59'!
validData

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

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!Address methodsFor: 'testing' stamp: 'To 6/16/2022 19:59:49'!
isAt: aStreetName
	
	^ streetName  = aStreetName! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'To 6/16/2022 20:36:33'!
addressAt: aStreetName
	
	^ addresses detect: [ :anAddress | anAddress isAt: aStreetName ]! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Customer class' category: 'CustomerImporter'!
Customer class
	instanceVariableNames: ''!

!Customer class methodsFor: 'importing' stamp: 'HAW 5/22/2022 00:25:18'!
importCustomers

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := StandardFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData fourth ].

		line := inputStream nextLine. ].

	session commit.
	session close.

	inputStream close.
	! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'To 6/16/2022 20:34:30'!
initializeFrom: aStream into: aSession

	session := aSession.
	stream := aStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'To 6/16/2022 20:34:13'!
value

	"
	self importCustomers
	"
	| newCustomer line |

	line := stream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := stream nextLine. ].

	stream close.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'To 6/16/2022 20:34:24'!
from: aStream into: aSession

	^self new initializeFrom: aStream into: aSession! !


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
