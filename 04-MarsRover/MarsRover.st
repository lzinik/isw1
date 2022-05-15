!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'east north south west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'TO 5/14/2022 16:34:32'!
allRoversShouldBeAt: finalPositions pointingTowards: finalDirections afterReceiving: aSequenceOfCommands whenStartingAt: startingPositions

	self roverShouldBeAt: (finalPositions at: 1) pointingTowards: (finalDirections at: 1) afterReceiving: aSequenceOfCommands whenStartingAt: (startingPositions at: 1) pointingTowards: north.
	self roverShouldBeAt: (finalPositions at: 2) pointingTowards: (finalDirections at: 2) afterReceiving: aSequenceOfCommands whenStartingAt: (startingPositions at: 2) pointingTowards: south.
	self roverShouldBeAt: (finalPositions at: 3) pointingTowards: (finalDirections at: 3) afterReceiving: aSequenceOfCommands whenStartingAt: (startingPositions at: 3) pointingTowards: east.
	self roverShouldBeAt: (finalPositions at: 4) pointingTowards: (finalDirections at: 4) afterReceiving: aSequenceOfCommands whenStartingAt: (startingPositions at: 4) pointingTowards: west.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'TO 5/14/2022 16:21:08'!
allRoversShouldPointTo: finalDirections afterTurning: aTurningCommand

	| marsRoverStartingPositions |
	marsRoverStartingPositions := OrderedCollection with: 0@0  with: 0@0 with: 0@0 with: 0@0.
	
	self allRoversShouldBeAt: marsRoverStartingPositions pointingTowards: finalDirections afterReceiving: aTurningCommand whenStartingAt: marsRoverStartingPositions.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'TO 5/14/2022 16:28:53'!
roverShouldBeAt: finalPosition pointingTowards: finalDirection afterReceiving: aSequenceOfCommands whenStartingAt: startingPosition pointingTowards: startingDirection    

	| marsRover commands | 
	marsRover := MarsRover pointingToward: startingDirection at: startingPosition.
	
	commands := aSequenceOfCommands.
	
	marsRover process: commands.
	
	self should: marsRover beAt: finalPosition pointingTowards: finalDirection.! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'TO 5/15/2022 10:09:55'!
should: marsRover beAt: aPosition pointingTowards: aMarsRoverDirection  

	self assert: marsRover position equals: aPosition.
	self should: marsRover pointTowards: aMarsRoverDirection! !

!MarsRoverTest methodsFor: 'assertions' stamp: 'TO 5/15/2022 10:09:39'!
should: marsRover pointTowards: aMarsRoverDirection

	^ self assert: (marsRover direction isKindOf: aMarsRoverDirection class)! !


!MarsRoverTest methodsFor: 'set up' stamp: 'TO 5/14/2022 14:19:45'!
setUp
	
	east := MarsRoverDirectionEast new.
	north := MarsRoverDirectionNorth new.
	south := MarsRoverDirectionSouth new.
	west := MarsRoverDirectionWest new! !


!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/14/2022 16:29:26'!
test01MarsRoverShouldNotMoveWhenReceivesEmptyString

	self roverShouldBeAt: 0@0 pointingTowards: north afterReceiving: '' whenStartingAt: 0@0 pointingTowards: north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/14/2022 16:18:13'!
test02MarsRoverShouldMoveTowardHeadingWhenReceivesOneForward

       | marsRoverStartingPositions marsRoverFinalPositions marsRoverFinalDirections |
	marsRoverStartingPositions := OrderedCollection with: 1@1  with: 7@3 with: -5@-9 with: -34@43.
	marsRoverFinalPositions := OrderedCollection with: 1@2 with: 7@2 with: -4@-9 with: -35@43.
	marsRoverFinalDirections := OrderedCollection with: north with: south with: east with: west.
	
	self allRoversShouldBeAt: marsRoverFinalPositions pointingTowards: marsRoverFinalDirections afterReceiving: 'f' whenStartingAt: marsRoverStartingPositions.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/14/2022 16:18:27'!
test03MarsRoverShouldMoveOppositeToDirectionWhenReceivesOneBackward

	| marsRoverStartingPositions marsRoverFinalPositions marsRoverFinalDirections |
	marsRoverStartingPositions := OrderedCollection with: -8@7  with: 89@-45 with: 4@4 with: 56@-34.
	marsRoverFinalPositions := OrderedCollection with: -8@6 with: 89@-44 with: 3@4 with: 57@-34.
	marsRoverFinalDirections := OrderedCollection with: north with: south with: east with: west.
	
	self allRoversShouldBeAt: marsRoverFinalPositions pointingTowards: marsRoverFinalDirections afterReceiving: 'b' whenStartingAt: marsRoverStartingPositions.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/14/2022 16:21:22'!
test04MarsRoverShouldRotateLeftWhenReceivesOneLeft

	| marsRoverFinalDirections |
	marsRoverFinalDirections := OrderedCollection with: west with: east with: north with: south.
	
	self allRoversShouldPointTo: marsRoverFinalDirections afterTurning: 'l'.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/14/2022 16:21:34'!
test05MarsRoverShouldRotateRightWhenReceivesOneRight

	| marsRoverFinalDirections |
	marsRoverFinalDirections := OrderedCollection with: east with: west with: south with: north.
	
	self allRoversShouldPointTo: marsRoverFinalDirections afterTurning: 'r'.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/14/2022 16:26:26'!
test06MarsRoverShouldProcessMultipleCommands

	self roverShouldBeAt: 1@1 pointingTowards: west afterReceiving: 'ffrfflblf' whenStartingAt: 0@0 pointingTowards: north.
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/14/2022 16:32:25'!
test07MarsRoverShouldStopProcessingCommandsIfReceivesInvalidCommand

	self roverShouldBeAt: 11@3 pointingTowards: east afterReceiving: 'fflfgfff' whenStartingAt: 10@5 pointingTowards: south.
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'moving' stamp: 'TO 5/13/2022 15:31:06'!
moveBackwards

	direction moveBackwards: self! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/14/2022 14:14:07'!
moveEast

	position := (position x + 1) @ position y! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/13/2022 15:30:48'!
moveForward

	direction moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/14/2022 14:14:12'!
moveNorth

	position := position x @ (position y + 1)! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/14/2022 14:14:17'!
moveSouth

	position := position x @ (position y - 1)! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/14/2022 14:14:22'!
moveWest

	position := (position x - 1) @ position y! !


!MarsRover methodsFor: 'turning' stamp: 'TO 5/13/2022 15:31:22'!
turnLeft

	direction := direction left! !

!MarsRover methodsFor: 'turning' stamp: 'TO 5/13/2022 15:31:33'!
turnRight

	direction := direction right! !


!MarsRover methodsFor: 'command processing - private' stamp: 'TO 5/14/2022 15:47:49'!
copy: aSequenceOfCommands upTo: invalidCommand

	^ aSequenceOfCommands copyFrom: 1 to: (aSequenceOfCommands indexOf: invalidCommand ) - 1! !

!MarsRover methodsFor: 'command processing - private' stamp: 'TO 5/14/2022 15:46:44'!
validCommandsUpToFirstInvalid: aSequenceOfCommands

	^ aSequenceOfCommands detect: [ : aPossiblyInvalidCommand | MarsRoverCommand  isInvalid: aPossiblyInvalidCommand ] ifFound: [ : invalidCommand | 
		self copy: aSequenceOfCommands upTo: invalidCommand ] ifNone: aSequenceOfCommands! !


!MarsRover methodsFor: 'command processing' stamp: 'TO 5/14/2022 15:42:48'!
process: aSequenceOfCommands 
	
	| sequenceOfValidCommandsUpToFirstInvalid |
	sequenceOfValidCommandsUpToFirstInvalid := self validCommandsUpToFirstInvalid: aSequenceOfCommands.
	
	sequenceOfValidCommandsUpToFirstInvalid do: [ : aCommand |
		(MarsRoverCommand for: aCommand) sendCommand: self.
	].
	! !


!MarsRover methodsFor: 'initialization' stamp: 'TO 5/13/2022 15:05:37'!
initializePointingToward: aDirection at: aPosition 

	position := aPosition.
	direction := aDirection! !


!MarsRover methodsFor: 'accessing' stamp: 'TO 5/12/2022 21:01:55'!
direction
	
	^ direction! !

!MarsRover methodsFor: 'accessing' stamp: 'TO 5/12/2022 20:49:52'!
position
	
	^ position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'TO 5/13/2022 15:06:17'!
pointingToward: aDirection at: aPosition 
	
	^ self new initializePointingToward: aDirection at: aPosition! !


!classDefinition: #MarsRoverCommand category: 'MarsRover'!
Object subclass: #MarsRoverCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverCommand methodsFor: 'command sending' stamp: 'TO 5/14/2022 15:34:50'!
sendCommand: aMarsRoverWaitingForACommand
	
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverCommand class' category: 'MarsRover'!
MarsRoverCommand class
	instanceVariableNames: ''!

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'TO 5/14/2022 15:40:49'!
for: aCommand
	
	^ (self allSubclasses detect: [ : aMarsRoverCommandClass | aMarsRoverCommandClass isFor: aCommand ]) new.! !

!MarsRoverCommand class methodsFor: 'instance creation' stamp: 'TO 5/14/2022 15:40:49'!
isFor: aCommand
	
	self subclassResponsibility ! !


!MarsRoverCommand class methodsFor: 'command validation' stamp: 'TO 5/14/2022 15:45:00'!
isInvalid: aCommand
	
	^ self allSubclasses noneSatisfy: [: aMarsRoverCommandClass | aMarsRoverCommandClass isFor: aCommand ].! !


!classDefinition: #MarsRoverBackwardsCommand category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverBackwardsCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverBackwardsCommand methodsFor: 'command sending' stamp: 'TO 5/14/2022 15:36:07'!
sendCommand: aMarsRoverWaitingForACommand
	
	aMarsRoverWaitingForACommand moveBackwards! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverBackwardsCommand class' category: 'MarsRover'!
MarsRoverBackwardsCommand class
	instanceVariableNames: ''!

!MarsRoverBackwardsCommand class methodsFor: 'instance creation' stamp: 'TO 5/14/2022 15:40:49'!
isFor: aCommand
	
	^ aCommand = $b! !


!classDefinition: #MarsRoverForwardCommand category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverForwardCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverForwardCommand methodsFor: 'command sending' stamp: 'TO 5/14/2022 15:36:23'!
sendCommand: aMarsRoverWaitingForACommand
	
	aMarsRoverWaitingForACommand moveForward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverForwardCommand class' category: 'MarsRover'!
MarsRoverForwardCommand class
	instanceVariableNames: ''!

!MarsRoverForwardCommand class methodsFor: 'instance creation' stamp: 'TO 5/14/2022 15:40:49'!
isFor: aCommand
	
	^ aCommand = $f! !


!classDefinition: #MarsRoverTurnLeftCommand category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverTurnLeftCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTurnLeftCommand methodsFor: 'command sending' stamp: 'TO 5/14/2022 15:36:38'!
sendCommand: aMarsRoverWaitingForACommand
	
	aMarsRoverWaitingForACommand turnLeft ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverTurnLeftCommand class' category: 'MarsRover'!
MarsRoverTurnLeftCommand class
	instanceVariableNames: ''!

!MarsRoverTurnLeftCommand class methodsFor: 'instance creation' stamp: 'TO 5/14/2022 15:40:49'!
isFor: aCommand
	
	^ aCommand = $l! !


!classDefinition: #MarsRoverTurnRightCommand category: 'MarsRover'!
MarsRoverCommand subclass: #MarsRoverTurnRightCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTurnRightCommand methodsFor: 'command sending' stamp: 'TO 5/14/2022 15:36:51'!
sendCommand: aMarsRoverWaitingForACommand
	
	aMarsRoverWaitingForACommand turnRight ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverTurnRightCommand class' category: 'MarsRover'!
MarsRoverTurnRightCommand class
	instanceVariableNames: ''!

!MarsRoverTurnRightCommand class methodsFor: 'instance creation' stamp: 'TO 5/14/2022 15:40:49'!
isFor: aCommand
	
	^ aCommand = $r! !


!classDefinition: #MarsRoverDirection category: 'MarsRover'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirection methodsFor: 'moving' stamp: 'TO 5/13/2022 15:21:02'!
moveBackwards: aMarsRoverMovingBackwards

	self subclassResponsibility! !

!MarsRoverDirection methodsFor: 'moving' stamp: 'TO 5/13/2022 15:21:27'!
moveForward: aMarsRoverMovingForward

	self subclassResponsibility 
	! !


!MarsRoverDirection methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:37:20'!
left
	
	self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:37:26'!
right
	
	self subclassResponsibility ! !


!classDefinition: #MarsRoverDirectionEast category: 'MarsRover'!
MarsRoverDirection subclass: #MarsRoverDirectionEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirectionEast methodsFor: 'moving' stamp: 'TO 5/13/2022 15:36:35'!
moveBackwards: aMarsRoverMovingBackwards

	aMarsRoverMovingBackwards moveWest! !

!MarsRoverDirectionEast methodsFor: 'moving' stamp: 'TO 5/13/2022 15:36:16'!
moveForward: aMarsRoverMovingForward

	aMarsRoverMovingForward moveEast! !


!MarsRoverDirectionEast methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:37:48'!
left 

	^ MarsRoverDirectionNorth new! !

!MarsRoverDirectionEast methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:37:59'!
right 

	^ MarsRoverDirectionSouth new! !


!classDefinition: #MarsRoverDirectionNorth category: 'MarsRover'!
MarsRoverDirection subclass: #MarsRoverDirectionNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirectionNorth methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:38:19'!
left

	^ MarsRoverDirectionWest new! !

!MarsRoverDirectionNorth methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:38:58'!
right

	^ MarsRoverDirectionEast new! !


!MarsRoverDirectionNorth methodsFor: 'moving' stamp: 'TO 5/13/2022 15:19:09'!
moveBackwards: aMarsRoverMovingBackwards

	aMarsRoverMovingBackwards moveSouth 
	! !

!MarsRoverDirectionNorth methodsFor: 'moving' stamp: 'TO 5/13/2022 15:17:48'!
moveForward: aMarsRoverMovingForward

	aMarsRoverMovingForward moveNorth
	! !


!classDefinition: #MarsRoverDirectionSouth category: 'MarsRover'!
MarsRoverDirection subclass: #MarsRoverDirectionSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirectionSouth methodsFor: 'moving' stamp: 'TO 5/13/2022 15:34:15'!
moveBackwards: aMarsRoverMovingBackwards

	aMarsRoverMovingBackwards moveNorth! !

!MarsRoverDirectionSouth methodsFor: 'moving' stamp: 'TO 5/13/2022 15:32:47'!
moveForward: aMarsRoverMovingForward

	aMarsRoverMovingForward moveSouth! !


!MarsRoverDirectionSouth methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:39:36'!
left
	
	^ MarsRoverDirectionEast new! !

!MarsRoverDirectionSouth methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:39:48'!
right
	
	^ MarsRoverDirectionWest new! !


!classDefinition: #MarsRoverDirectionWest category: 'MarsRover'!
MarsRoverDirection subclass: #MarsRoverDirectionWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverDirectionWest methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:40:07'!
left 

	^ MarsRoverDirectionSouth new! !

!MarsRoverDirectionWest methodsFor: 'directions position' stamp: 'TO 5/13/2022 15:40:17'!
right 

	^ MarsRoverDirectionNorth new! !


!MarsRoverDirectionWest methodsFor: 'moving' stamp: 'TO 5/13/2022 15:35:38'!
moveBackwards: aMarsRoverMovingBackwards

	aMarsRoverMovingBackwards moveEast! !

!MarsRoverDirectionWest methodsFor: 'moving' stamp: 'TO 5/13/2022 15:35:56'!
moveForward: aMarsRoverMovingForward

	aMarsRoverMovingForward moveWest! !
