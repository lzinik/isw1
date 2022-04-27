!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'LZ 4/25/2022 21:35:26'!
initialize

	content := OOStackEmptyContent new! !


!OOStack methodsFor: 'testing' stamp: 'LZ 4/25/2022 21:35:26'!
isEmpty
	
	^ content isEmpty! !


!OOStack methodsFor: 'operations' stamp: 'LZ 4/25/2022 21:35:26'!
pop
	
	| top |
	top := content top.
	content := content pop.
	
	^ top! !

!OOStack methodsFor: 'operations' stamp: 'LZ 4/25/2022 21:35:26'!
push: anObject 
	
	content := content push: anObject! !


!OOStack methodsFor: 'accessing' stamp: 'LZ 4/25/2022 21:35:26'!
size

	^ content size! !

!OOStack methodsFor: 'accessing' stamp: 'LZ 4/25/2022 21:35:26'!
top
	
	^ content top! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackContent category: 'Stack-Exercise'!
Object subclass: #OOStackContent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackContent methodsFor: 'testing' stamp: 'LZ 4/25/2022 21:15:21'!
isEmpty
	
	self subclassResponsibility ! !


!OOStackContent methodsFor: 'accessing' stamp: 'LZ 4/25/2022 21:14:55'!
size
	
	self subclassResponsibility ! !

!OOStackContent methodsFor: 'accessing' stamp: 'LZ 4/25/2022 21:15:29'!
top
	
	self subclassResponsibility ! !


!OOStackContent methodsFor: 'operations' stamp: 'LZ 4/25/2022 21:15:42'!
pop
	
	self subclassResponsibility ! !

!OOStackContent methodsFor: 'operations' stamp: 'LZ 4/25/2022 21:15:51'!
push: anObject
	
	self subclassResponsibility ! !


!classDefinition: #OOStackEmptyContent category: 'Stack-Exercise'!
OOStackContent subclass: #OOStackEmptyContent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyContent methodsFor: 'testing' stamp: 'LZ 4/25/2022 20:57:50'!
isEmpty

	^ true.! !


!OOStackEmptyContent methodsFor: 'operations' stamp: 'LZ 4/25/2022 21:17:03'!
pop
	
	self error: OOStack stackEmptyErrorDescription ! !

!OOStackEmptyContent methodsFor: 'operations' stamp: 'LZ 4/25/2022 21:18:03'!
push: anObject
	
	^ OOStackWithContent with: anObject ! !


!OOStackEmptyContent methodsFor: 'accessing' stamp: 'LZ 4/25/2022 21:16:12'!
size
	
	^ 0! !

!OOStackEmptyContent methodsFor: 'accessing' stamp: 'LZ 4/25/2022 21:16:38'!
top
	
	self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackWithContent category: 'Stack-Exercise'!
OOStackContent subclass: #OOStackWithContent
	instanceVariableNames: 'top stackWithoutTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackWithContent methodsFor: 'accessing' stamp: 'LZ 4/25/2022 21:33:47'!
size

	^ stackWithoutTop size + 1.! !

!OOStackWithContent methodsFor: 'accessing' stamp: 'LZ 4/25/2022 21:13:30'!
top

	^ top! !


!OOStackWithContent methodsFor: 'operations' stamp: 'LZ 4/25/2022 21:33:47'!
pop

	^ stackWithoutTop ! !

!OOStackWithContent methodsFor: 'operations' stamp: 'LZ 4/25/2022 21:33:47'!
push: anObject

	stackWithoutTop := stackWithoutTop push: top.
	top := anObject.! !


!OOStackWithContent methodsFor: 'testing' stamp: 'LZ 4/25/2022 20:56:13'!
isEmpty

	^ false.! !


!OOStackWithContent methodsFor: 'initialization' stamp: 'LZ 4/25/2022 21:33:47'!
initializeWith: anObject

	top := anObject.
	stackWithoutTop := OOStackEmptyContent new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackWithContent class' category: 'Stack-Exercise'!
OOStackWithContent class
	instanceVariableNames: ''!

!OOStackWithContent class methodsFor: 'instance creation' stamp: 'LZ 4/25/2022 21:22:24'!
with: anObject

	^ self basicNew initializeWith: anObject ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
