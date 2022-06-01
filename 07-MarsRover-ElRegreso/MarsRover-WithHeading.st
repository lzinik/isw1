!classDefinition: #MarsRoverFollowerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverFollowerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverFollowerTest methodsFor: 'assertions' stamp: 'TO 5/31/2022 19:34:58'!
assertLogger: aMarsRoverLogger onlyHasLines: anArrayOfLines  

	| loggerStream |
	
	loggerStream := aMarsRoverLogger readStream.
	anArrayOfLines do: [ : aLine | 
		self deny: loggerStream atEnd.
		self assert: aLine equals: loggerStream nextLine
	].
	self assert: loggerStream atEnd! !

!MarsRoverFollowerTest methodsFor: 'assertions' stamp: 'TO 5/31/2022 19:35:20'!
assertWindow: aMarsRoverWindow positionFieldShows: aValueForPositionField headingFieldShows: aValueForHeadingField  

	self assert: aValueForPositionField equals: aMarsRoverWindow marsRoverPosition.
	self assert: aValueForHeadingField equals: aMarsRoverWindow marsRoverHeading! !


!MarsRoverFollowerTest methodsFor: 'mars rovers' stamp: 'TO 6/1/2022 16:52:02'!
send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading afterRunning: aClosureToBeRunBeforeProcessing
	
	| marsRover |
	marsRover := MarsRover at: aPosition heading: aHeading.
	
	aClosureToBeRunBeforeProcessing value: marsRover.
	
	marsRover process: aSequenceOfCommands.! !

!MarsRoverFollowerTest methodsFor: 'mars rovers' stamp: 'TO 6/1/2022 16:53:15'!
send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading whileFollowingHeadingWith: aMarsRoverFollower
	
	self send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading afterRunning: [ :aMarsRover | aMarsRover followHeadingWith: aMarsRoverFollower ]! !

!MarsRoverFollowerTest methodsFor: 'mars rovers' stamp: 'TO 6/1/2022 16:56:00'!
send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading whileFollowingPositionAndHeadingsWith: aMarsRoverFollower
	
	self send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading afterRunning: [ :aMarsRover | aMarsRover followPositionsAndHeadingsWith: aMarsRoverFollower ]! !

!MarsRoverFollowerTest methodsFor: 'mars rovers' stamp: 'TO 6/1/2022 16:56:49'!
send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading whileFollowingPositionAndHeadingsWith: aMarsRoverFollower and: anotherMarsRoverFollower
	
	self send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading afterRunning: [ :aMarsRover | 
		aMarsRover followPositionsAndHeadingsWith: aMarsRoverFollower. 
		aMarsRover followPositionsAndHeadingsWith: anotherMarsRoverFollower
	]! !

!MarsRoverFollowerTest methodsFor: 'mars rovers' stamp: 'TO 6/1/2022 16:52:42'!
send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading whileFollowingPositionWith: aMarsRoverFollower
	
	self send: aSequenceOfCommands toRoverStartingAt: aPosition heading: aHeading afterRunning: [ :aMarsRover | aMarsRover followPositionsWith: aMarsRoverFollower ]! !


!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:14:35'!
test01LoggerShouldBeEmptyIfNoCommandsAreProcessed

	| logger |
	logger := MarsRoverLogger new.
	
	self send: '' toRoverStartingAt: 1@1 heading: self north whileFollowingPositionWith: logger.
	
	self assert: logger readStream atEnd.! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:36:59'!
test02LoggerShouldLogPositionWhenMovingNorthFollowingPositions

	| logger |
	logger := MarsRoverLogger new.
	
	self send: 'f' toRoverStartingAt: 1@1 heading: self north whileFollowingPositionWith: logger.
	
	self assertLogger: logger onlyHasLines: #('1@2')! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:37:34'!
test03LoggerShouldLogPositionWhenMovingSouthFollowingPositions

	| logger |
	logger := MarsRoverLogger new.

	self send: 'b' toRoverStartingAt: 1@1 heading: self north whileFollowingPositionWith: logger.
	
	self assertLogger: logger onlyHasLines: #('1@0')! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:38:21'!
test04LoggerShouldLogPositionAllChangesWhenMovingInAnyDirectionFollowingPositions

	| logger |
	logger := MarsRoverLogger new.
	
	self send: 'fb' toRoverStartingAt: 1@1 heading: self east whileFollowingPositionWith: logger.
	
	self assertLogger: logger onlyHasLines: #(
		'2@1'
		'1@1'
	)! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:39:41'!
test05LoggerShouldLogHeadingWhenTurningEastFollowingHeadings

	| logger |
	logger := MarsRoverLogger new.
	
	self send: 'r' toRoverStartingAt: 1@1 heading: self north whileFollowingHeadingWith: logger.
	
	self assertLogger: logger onlyHasLines: (Array with: logger eastValue)! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 6/1/2022 16:57:46'!
test06LoggerShouldLogAllPositionsAndHeadingsWhenFollowingBoth

	| logger |
	logger := MarsRoverLogger new.
	
	self send: 'llfrr' toRoverStartingAt: 1@1 heading: self north whileFollowingPositionAndHeadingsWith: logger.
	
	self assertLogger: logger onlyHasLines: (Array 
		with: logger westValue 
		with: logger southValue 
		with: '1@0' 
		with: logger westValue 
		with: logger northValue
	)! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:16:30'!
test07WindowFieldsShouldBeEmptyIfNoCommandsAreProcessed

	| window |
	window := MarsRoverWindow new.
	
	self send: '' toRoverStartingAt: 1@1 heading: self north whileFollowingPositionWith: window.
	
	self assertWindow: window positionFieldShows: '' headingFieldShows: ''.! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:16:49'!
test08WindowPositionFieldShouldDisplayLastPositionWhenMovingNorthFollowingPositions

	| window |
	window := MarsRoverWindow new.
	
	self send: 'f' toRoverStartingAt: 1@1 heading: self north whileFollowingPositionWith: window.
	
	self assertWindow: window positionFieldShows: '1@2' headingFieldShows: ''.! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:17:21'!
test09WindowPositionFieldShouldDisplayLastPositionWhenMovingInAnyDirectionFollowingPositions

	| window |
	window := MarsRoverWindow new.
	
	self send: 'ffbrf' toRoverStartingAt: 1@1 heading: self east whileFollowingPositionWith: window.
	
	self assertWindow: window positionFieldShows: '2@0' headingFieldShows: ''.! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:30:42'!
test10WindowHeadingFieldShouldDisplayLastHeadingWhenTurningEastFollowingHeadings

	| window |
	window := MarsRoverWindow new.
	
	self send: 'r' toRoverStartingAt: 1@1 heading: self north whileFollowingHeadingWith: window.
	
	self assertWindow: window positionFieldShows: '' headingFieldShows: window headingFieldEastValue.! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:30:55'!
test11WindowHeadingFieldShouldDisplayLastHeadingWhenTurningWestFollowingHeadings

	| window |
	window := MarsRoverWindow new.
	
	self send: 'l' toRoverStartingAt: 1@1 heading: self north whileFollowingHeadingWith: window.
	
	self assertWindow: window positionFieldShows: '' headingFieldShows: window headingFieldWestValue ! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 5/31/2022 19:31:06'!
test12WindowHeadingFieldShouldDisplayLastHeadingWhenTurningSouthFollowingHeadings

	| window |
	window := MarsRoverWindow new.
	
	self send: 'r' toRoverStartingAt: 1@1 heading: self east whileFollowingHeadingWith: window.
	
	self assertWindow: window positionFieldShows: '' headingFieldShows: window headingFieldSouthValue ! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 6/1/2022 16:58:21'!
test13WindowFieldsShouldDisplayLastUpdatedValuesWhenFollowingPositionsAndHeadings

	| window |
	window := MarsRoverWindow new.
	
	self send: 'lf' toRoverStartingAt: 1@1 heading: self east whileFollowingPositionAndHeadingsWith: window.
	
	self assertWindow: window positionFieldShows: '1@2' headingFieldShows: window headingFieldNorthValue ! !

!MarsRoverFollowerTest methodsFor: 'tests' stamp: 'TO 6/1/2022 16:58:52'!
test14LoggerAndWindowShouldBeAbleToWorkSimultaneously

	| window logger |
	window := MarsRoverWindow new.
	logger := MarsRoverLogger new.
	
	self send: 'frff' toRoverStartingAt: 1@1 heading: self north whileFollowingPositionAndHeadingsWith: logger and: window.
	
	self assertWindow: window positionFieldShows: '3@2' headingFieldShows: window headingFieldEastValue.
	self assertLogger: logger onlyHasLines: (Array 
		with: '1@2' 
		with: logger eastValue 
		with: '2@2' 
		with: '3@2'
	)! !


!MarsRoverFollowerTest methodsFor: 'headings' stamp: 'TO 5/31/2022 18:16:51'!
east

	^ MarsRoverHeadingEast! !

!MarsRoverFollowerTest methodsFor: 'headings' stamp: 'TO 5/31/2022 18:12:55'!
north

	^ MarsRoverHeadingNorth! !


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
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'TO 5/31/2022 17:33:27'!
initializeAt: aPosition heading: aHeadingType

	position := MarsRoverChangesFollowerProxy for: aPosition with: self closureForPositionChange.
	head := MarsRoverChangesFollowerProxy for: (aHeadingType for: self) with: self closureForHeadingChange.! !


!MarsRover methodsFor: 'heading' stamp: 'TO 5/31/2022 17:27:13'!
headEast
	
	self heading: MarsRoverHeadingEast! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/31/2022 17:27:13'!
headNorth
	
	self heading: MarsRoverHeadingNorth! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/31/2022 17:27:13'!
headSouth
	
	self heading: MarsRoverHeadingSouth
	! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/31/2022 17:27:13'!
headWest
	
	self heading: MarsRoverHeadingWest! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/31/2022 17:25:57'!
rotateLeft
	
	self heading rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'TO 5/31/2022 17:25:57'!
rotateRight
	
	self heading rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'TO 5/31/2022 17:29:44'!
isAt: aPosition heading: aHeadingType

	^ self position = aPosition and: [ self heading isHeading: aHeadingType ]! !

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


!MarsRover methodsFor: 'moving' stamp: 'TO 5/31/2022 17:25:57'!
moveBackward
	
	self heading moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/31/2022 17:27:53'!
moveEast
	
	self addToPosition: 1@0
	! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/31/2022 17:25:57'!
moveForward
	
	self heading moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/31/2022 17:27:53'!
moveNorth
	
	self addToPosition: 0@1! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/31/2022 17:27:53'!
moveSouth
	
	self addToPosition: 0@-1! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/31/2022 17:27:53'!
moveWest
	
	self addToPosition: -1@0! !


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


!MarsRover methodsFor: 'followers' stamp: 'TO 5/31/2022 17:24:41'!
followHeadingWith: aMarsRoverFollower 
	
	head addFollower: aMarsRoverFollower ! !

!MarsRover methodsFor: 'followers' stamp: 'TO 6/1/2022 16:49:28'!
followPositionsAndHeadingsWith: aMarsRoverFollower 
	
	self followPositionsWith: aMarsRoverFollower.
	self followHeadingWith: aMarsRoverFollower ! !

!MarsRover methodsFor: 'followers' stamp: 'TO 5/31/2022 17:24:53'!
followPositionsWith: aMarsRoverFollower 
	
	position addFollower: aMarsRoverFollower ! !


!MarsRover methodsFor: 'moving - private' stamp: 'TO 5/31/2022 17:29:44'!
addToPosition: aPositionIndicatingHeading

	position value: self position + aPositionIndicatingHeading.! !

!MarsRover methodsFor: 'moving - private' stamp: 'TO 5/31/2022 17:29:44'!
position

	^ position value! !


!MarsRover methodsFor: 'followers - private' stamp: 'TO 5/31/2022 17:33:27'!
closureForHeadingChange

	^ [: newHeading : aMarsRoverFollower | aMarsRoverFollower headingChangedTo: newHeading ]! !

!MarsRover methodsFor: 'followers - private' stamp: 'TO 5/31/2022 17:33:07'!
closureForPositionChange

	^ [: newPosition : aMarsRoverFollower | aMarsRoverFollower positionChangedTo: newPosition ]! !


!MarsRover methodsFor: 'heading - private' stamp: 'TO 5/31/2022 17:25:57'!
heading

	^ head value! !

!MarsRover methodsFor: 'heading - private' stamp: 'TO 5/31/2022 17:27:13'!
heading: aMarsRoverHeadingClass

	head value: (aMarsRoverHeadingClass for: self).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverChangesFollowerProxy category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverChangesFollowerProxy
	instanceVariableNames: 'value updateClosure followers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverChangesFollowerProxy methodsFor: 'initialize' stamp: 'TO 5/31/2022 17:15:13'!
initializeFor: aValue with: aClosureToBeRunOnUpdateWithEachFollower 
	
	value := aValue.
	updateClosure := aClosureToBeRunOnUpdateWithEachFollower.
	followers := Set new.! !


!MarsRoverChangesFollowerProxy methodsFor: 'adding followers' stamp: 'TO 5/31/2022 17:15:45'!
addFollower: aFollower
	
	followers add: aFollower ! !


!MarsRoverChangesFollowerProxy methodsFor: 'accessing' stamp: 'TO 5/31/2022 17:16:17'!
value

	^ value! !


!MarsRoverChangesFollowerProxy methodsFor: 'change notification' stamp: 'TO 5/31/2022 17:49:55'!
notifyFollowersOfChange

	followers do: [: aFollower | self notifyOfChange: aFollower ]! !

!MarsRoverChangesFollowerProxy methodsFor: 'change notification' stamp: 'TO 5/31/2022 17:49:55'!
notifyOfChange: aFollower

	^ updateClosure value: value value: aFollower! !


!MarsRoverChangesFollowerProxy methodsFor: 'updating' stamp: 'TO 5/31/2022 17:35:00'!
value: aNewValue
	
	value := aNewValue.
	self notifyFollowersOfChange! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverChangesFollowerProxy class' category: 'MarsRover-WithHeading'!
MarsRoverChangesFollowerProxy class
	instanceVariableNames: ''!

!MarsRoverChangesFollowerProxy class methodsFor: 'instance creation' stamp: 'TO 5/31/2022 17:13:06'!
for: aValue with: aClosureToBeRunOnUpdateWithEachFollower

	^ self new initializeFor: aValue with: aClosureToBeRunOnUpdateWithEachFollower ! !


!classDefinition: #MarsRoverFollower category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverFollower
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverFollower methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 17:54:57'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 

	self subclassResponsibility ! !

!MarsRoverFollower methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 17:55:14'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 

	self subclassResponsibility ! !

!MarsRoverFollower methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 17:55:26'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 

	self subclassResponsibility ! !

!MarsRoverFollower methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 17:55:38'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest 

	self subclassResponsibility ! !


!MarsRoverFollower methodsFor: 'changes' stamp: 'TO 5/31/2022 19:45:38'!
headingChangedTo: aMarsRoverHeading
	
	aMarsRoverHeading accept: self! !

!MarsRoverFollower methodsFor: 'changes' stamp: 'TO 5/31/2022 17:51:02'!
positionChangedTo: aNewPosition

	self subclassResponsibility ! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
MarsRoverFollower subclass: #MarsRoverLogger
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 18:44:13'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	
	self logHeading: self eastValue! !

!MarsRoverLogger methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 18:44:41'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	
	self logHeading: self northValue! !

!MarsRoverLogger methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 18:44:59'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 
	
	self logHeading: self southValue
	! !

!MarsRoverLogger methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 18:45:12'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	self logHeading: self westValue! !


!MarsRoverLogger methodsFor: 'initialize' stamp: 'TO 5/30/2022 21:00:34'!
initialize
	
	log := WriteStream on: ''! !


!MarsRoverLogger methodsFor: 'changes' stamp: 'TO 5/31/2022 18:43:44'!
positionChangedTo: aNewPosition

	log print: aNewPosition.
	self newLine.
	
	! !


!MarsRoverLogger methodsFor: 'accessing' stamp: 'TO 5/30/2022 21:00:57'!
readStream
	
	^ ReadStream on: log contents ! !


!MarsRoverLogger methodsFor: 'heading values' stamp: 'TO 5/31/2022 18:44:13'!
eastValue

	^ 'East'! !

!MarsRoverLogger methodsFor: 'heading values' stamp: 'TO 5/31/2022 18:44:41'!
northValue

	^ 'North'! !

!MarsRoverLogger methodsFor: 'heading values' stamp: 'TO 5/31/2022 18:44:59'!
southValue

	^ 'South'! !

!MarsRoverLogger methodsFor: 'heading values' stamp: 'TO 5/31/2022 18:45:09'!
westValue

	^ 'West'! !


!MarsRoverLogger methodsFor: 'logging - private' stamp: 'TO 5/31/2022 18:43:44'!
logHeading: aHeadingValue

	log nextPutAll: aHeadingValue.
	self newLine! !

!MarsRoverLogger methodsFor: 'logging - private' stamp: 'TO 5/31/2022 18:43:53'!
newLine

	log newLine! !


!classDefinition: #MarsRoverWindow category: 'MarsRover-WithHeading'!
MarsRoverFollower subclass: #MarsRoverWindow
	instanceVariableNames: 'marsRoverPosition marsRoverHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'accessing' stamp: 'TO 5/31/2022 19:44:48'!
marsRoverHeading
	
	^marsRoverHeading! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'TO 5/30/2022 21:34:59'!
marsRoverPosition
	
	^ marsRoverPosition asString ! !


!MarsRoverWindow methodsFor: 'heading values' stamp: 'TO 5/31/2022 19:28:19'!
headingFieldEastValue

	^ self headingFieldValuePrefix, 'Este'! !

!MarsRoverWindow methodsFor: 'heading values' stamp: 'TO 5/31/2022 19:28:30'!
headingFieldNorthValue

	^ self headingFieldValuePrefix, 'Norte'! !

!MarsRoverWindow methodsFor: 'heading values' stamp: 'TO 5/31/2022 19:28:40'!
headingFieldSouthValue

	^ self headingFieldValuePrefix, 'Sur'! !

!MarsRoverWindow methodsFor: 'heading values' stamp: 'TO 5/31/2022 19:28:05'!
headingFieldValuePrefix

	^ 'Apuntando al '! !

!MarsRoverWindow methodsFor: 'heading values' stamp: 'TO 5/31/2022 19:28:52'!
headingFieldWestValue

	^ self headingFieldValuePrefix, 'Oeste'! !


!MarsRoverWindow methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 19:25:48'!
visitMarsRoverHeadingEast: aMarsRoverHeadingEast 
	
	marsRoverHeading := self headingFieldEastValue! !

!MarsRoverWindow methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 19:26:07'!
visitMarsRoverHeadingNorth: aMarsRoverHeadingNorth 
	
	marsRoverHeading := self headingFieldNorthValue! !

!MarsRoverWindow methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 19:27:00'!
visitMarsRoverHeadingSouth: aMarsRoverHeadingSouth 
	
	marsRoverHeading := self headingFieldSouthValue! !

!MarsRoverWindow methodsFor: 'heading specific changes' stamp: 'TO 5/31/2022 19:27:13'!
visitMarsRoverHeadingWest: aMarsRoverHeadingWest 
	
	marsRoverHeading := 	self headingFieldWestValue! !


!MarsRoverWindow methodsFor: 'initialize' stamp: 'TO 5/31/2022 15:02:01'!
initialize
	
	marsRoverPosition := ''.
	marsRoverHeading := ''! !


!MarsRoverWindow methodsFor: 'changes' stamp: 'TO 5/30/2022 21:34:39'!
positionChangedTo: aNewPosition

	marsRoverPosition := aNewPosition ! !


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


!MarsRoverHeading methodsFor: 'visiting' stamp: 'TO 5/31/2022 17:58:03'!
accept: aMarsRoverFollower

	self subclassResponsibility ! !

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


!MarsRoverHeadingEast methodsFor: 'visiting' stamp: 'TO 5/31/2022 17:58:35'!
accept: aMarsRoverFollower 
	
	aMarsRoverFollower visitMarsRoverHeadingEast: self! !


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


!MarsRoverHeadingNorth methodsFor: 'visiting' stamp: 'TO 5/31/2022 17:58:55'!
accept: aMarsRoverFollower 
	
	aMarsRoverFollower visitMarsRoverHeadingNorth: self! !


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


!MarsRoverHeadingSouth methodsFor: 'visiting' stamp: 'TO 5/31/2022 17:59:08'!
accept: aMarsRoverFollower 

	aMarsRoverFollower visitMarsRoverHeadingSouth: self! !


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


!MarsRoverHeadingWest methodsFor: 'visiting' stamp: 'TO 5/31/2022 17:59:21'!
accept: aMarsRoverFollower 
	
	aMarsRoverFollower visitMarsRoverHeadingWest: self! !
