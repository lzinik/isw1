!classDefinition: #AlgoTest category: 'MarsRover-WithHeading'!
TestCase subclass: #AlgoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!AlgoTest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:02:17'!
test01

	| marsRover logger |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger new.
	marsRover followPositionsWith: logger.
	
	marsRover process: ''.
	
	self assert: logger readStream atEnd.! !

!AlgoTest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:01:15'!
test02

	| marsRover logger loggerStream |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger new.
	marsRover followPositionsWith: logger.
	
	marsRover process: 'f'.
	
	loggerStream := logger readStream.
	self assert: '1@2' equals: loggerStream nextLine.
	self assert: loggerStream atEnd.! !

!AlgoTest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:03:09'!
test03

	| marsRover logger loggerStream |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger new.
	marsRover followPositionsWith: logger.
	
	marsRover process: 'b'.
	
	loggerStream := logger readStream.
	self assert: '1@0' equals: loggerStream nextLine.
	self assert: loggerStream atEnd.! !

!AlgoTest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:04:43'!
test04

	| marsRover logger loggerStream |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	logger := MarsRoverLogger new.
	marsRover followPositionsWith: logger.
	
	marsRover process: 'fb'.
	
	loggerStream := logger readStream.
	self assert: '2@1' equals: loggerStream nextLine.
	self assert: '1@1' equals: loggerStream nextLine.
	self assert: loggerStream atEnd.! !

!AlgoTest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:09:13'!
test05

	| marsRover logger loggerStream |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger new.
	marsRover followHeadingWith: logger.
	
	marsRover process: 'r'.
	
	loggerStream := logger readStream.
	self assert: 'East' equals: loggerStream nextLine.
	self assert: loggerStream atEnd.! !

!AlgoTest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:15:59'!
test06

	| marsRover logger loggerStream |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	logger := MarsRoverLogger new.
	marsRover followHeadingWith: logger.
	
	marsRover process: 'llrr'.
	
	loggerStream := logger readStream.
	self assert: 'West' equals: loggerStream nextLine.
	self assert: 'South' equals: loggerStream nextLine.
	self assert: 'West' equals: loggerStream nextLine.
	self assert: 'North' equals: loggerStream nextLine.
	self assert: loggerStream atEnd.! !

!AlgoTest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:30:47'!
test07

	| marsRover window |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow new.
	marsRover withPositionWindow: window.
	
	marsRover process: ''.
	
	self assert: '' equals: window marsRoverPosition ! !

!AlgoTest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:33:06'!
test08

	| marsRover window |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	window := MarsRoverWindow new.
	marsRover withPositionWindow: window.
	
	marsRover process: 'f'.
	
	self assert: '1@2' equals: window marsRoverPosition ! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionFollower headingFollower positionWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:10:49'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self ! !


!MarsRover methodsFor: 'heading' stamp: 'TO 5/30/2022 21:22:44'!
headEast
	
	self headingFollowingChange: MarsRoverHeadingEast! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/30/2022 21:23:08'!
headNorth
	
	self headingFollowingChange: MarsRoverHeadingNorth! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/30/2022 21:23:17'!
headSouth
	
	self headingFollowingChange: MarsRoverHeadingSouth
	! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/30/2022 21:23:24'!
headWest
	
	self headingFollowingChange: MarsRoverHeadingWest! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/30/2022 21:22:44'!
headingFollowingChange: aMarsRoverHeadingClass

	head := aMarsRoverHeadingClass for: self.
	headingFollower ifNotNil: [ headingFollower headingChangedTo: head ]! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'TO 5/30/2022 21:08:17'!
addToPositionFollowingChanges: aPositionIndicatingHeading

	position := position + aPositionIndicatingHeading.
	positionFollower ifNotNil: [ positionFollower positionChangedTo: position ]! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/30/2022 21:08:17'!
moveEast
	
	self addToPositionFollowingChanges: 1@0! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/30/2022 21:36:32'!
moveNorth
	
	self addToPositionFollowingChanges: 0@1.
	positionWindow ifNotNil: [ positionWindow positionChangedTo: position ]! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/30/2022 21:08:17'!
moveSouth
	
	self addToPositionFollowingChanges: 0@-1! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/30/2022 21:08:17'!
moveWest
	
	self addToPositionFollowingChanges: -1@0! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:09:33'!
followHeadingWith: aMarsRoverLogger 
	
	headingFollower := aMarsRoverLogger ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 20:55:24'!
followPositionsWith: aMarsRoverLogger 
	
	positionFollower := aMarsRoverLogger! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:31:20'!
withPositionWindow: aMarsRoverWindow 
	
	positionWindow := aMarsRoverWindow ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:13:16'!
accept: aMarsRoverLogger 
	
	aMarsRoverLogger visitMarsRoverHeadingEast: self! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:20:24'!
accept: aMarsRoverLogger 
	
	aMarsRoverLogger visitMarsRoverHeadingNorth: self! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:19:09'!
accept: aMarsRoverLogger 

	aMarsRoverLogger visitMarsRoverHeadingSouth: self! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:17:06'!
accept: aMarsRoverLogger 
	
	aMarsRoverLogger visitMarsRoverHeadingWest: self! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:12:19'!
headingChangedTo: aMarsRoverHeading
	
	aMarsRoverHeading accept: self! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:00:34'!
initialize
	
	log := WriteStream on: ''! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 20:59:51'!
positionChangedTo: aNewPosition

	log print: aNewPosition.
	log newLine.
	
	! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:00:57'!
readStream
	
	^ ReadStream on: log contents ! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:14:06'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	
	log nextPutAll: 'East'.
	log newLine! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:20:51'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	
	log nextPutAll: 'North'.
	log newLine! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:19:34'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 
	
	log nextPutAll: 'South'.
	log newLine
	! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:17:30'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	log nextPutAll: 'West'.
	log newLine! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'marsRoverPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:32:33'!
initialize
	
	marsRoverPosition := ''! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:34:59'!
marsRoverPosition
	
	^ marsRoverPosition asString ! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'TO 5/30/2022 21:34:39'!
positionChangedTo: aNewPosition

	marsRoverPosition := aNewPosition ! !
