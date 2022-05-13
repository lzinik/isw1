!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'TO 5/12/2022 20:57:57'!
should: marsRover beAt: aPosition pointingTowards: aDirection  

	self assert: marsRover position equals: aPosition.
	self assert: marsRover direction equals: aDirection! !


!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/12/2022 21:43:36'!
test01MarsRoverShouldNotMoveWhenReceivesEmptyString

	| marsRover | 
	marsRover := MarsRover pointingToward: #North.
	
	marsRover process: ''.
	self should: marsRover beAt: 0@0 pointingTowards: #North
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/12/2022 21:43:36'!
test02MarsRoverShouldMoveTowardHeadingWhenReceivesOneForward

	| marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingEast marsRoverPointingWest command | 
	marsRoverPointingNorth := MarsRover pointingToward: #North.
	marsRoverPointingSouth := MarsRover pointingToward: #South.
	marsRoverPointingEast := MarsRover pointingToward: #East.
	marsRoverPointingWest := MarsRover pointingToward: #West.	
	
	command := 'f'.
	
	marsRoverPointingNorth process: command.
	marsRoverPointingSouth process: command.	
	marsRoverPointingEast process: command.	
	marsRoverPointingWest process: command.	
	
	self should: marsRoverPointingNorth beAt: 0@1 pointingTowards: #North.
	self should: marsRoverPointingSouth beAt: 0@-1 pointingTowards: #South	.
	self should: marsRoverPointingEast beAt: 1@0 pointingTowards: #East.
	self should: marsRoverPointingWest beAt: -1@0 pointingTowards: #West	.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/12/2022 21:43:36'!
test03MarsRoverShouldMoveOppositeToDirectionWhenReceivesOneBackward

	| marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingEast marsRoverPointingWest command | 
	marsRoverPointingNorth := MarsRover pointingToward: #North.
	marsRoverPointingSouth := MarsRover pointingToward: #South.
	marsRoverPointingEast := MarsRover pointingToward: #East.
	marsRoverPointingWest := MarsRover pointingToward: #West.	
	
	command := 'b'.
	
	marsRoverPointingNorth process: command.
	marsRoverPointingSouth process: command.	
	marsRoverPointingEast process: command.	
	marsRoverPointingWest process: command.	
	
	self should: marsRoverPointingNorth beAt: 0@-1 pointingTowards: #North.
	self should: marsRoverPointingSouth beAt: 0@1 pointingTowards: #South.
	self should: marsRoverPointingEast beAt: -1@0 pointingTowards: #East.
	self should: marsRoverPointingWest beAt: 1@0 pointingTowards: #West.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/12/2022 21:43:36'!
test04MarsRoverShouldRotateLeftWhenReceivesOneLeft

	| marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingEast marsRoverPointingWest command | 
	marsRoverPointingNorth := MarsRover pointingToward: #North.
	marsRoverPointingSouth := MarsRover pointingToward: #South.
	marsRoverPointingEast := MarsRover pointingToward: #East.
	marsRoverPointingWest := MarsRover pointingToward: #West.	
	
	command := 'l'.
	
	marsRoverPointingNorth process: command.
	marsRoverPointingSouth process: command.	
	marsRoverPointingEast process: command.	
	marsRoverPointingWest process: command.	
	
	self should: marsRoverPointingNorth beAt: 0@0 pointingTowards: #West.
	self should: marsRoverPointingSouth beAt: 0@0 pointingTowards: #East.
	self should: marsRoverPointingEast beAt: 0@0 pointingTowards: #North.
	self should: marsRoverPointingWest beAt: 0@0 pointingTowards: #South.	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/12/2022 21:47:29'!
test05MarsRoverShouldRotateRightWhenReceivesOneRight

	| marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingEast marsRoverPointingWest command | 
	marsRoverPointingNorth := MarsRover pointingToward: #North.
	marsRoverPointingSouth := MarsRover pointingToward: #South.
	marsRoverPointingEast := MarsRover pointingToward: #East.
	marsRoverPointingWest := MarsRover pointingToward: #West.	
	
	command := 'r'.
	
	marsRoverPointingNorth process: command.
	marsRoverPointingSouth process: command.	
	marsRoverPointingEast process: command.	
	marsRoverPointingWest process: command.	
	
	self should: marsRoverPointingNorth beAt: 0@0 pointingTowards: #East.
	self should: marsRoverPointingEast beAt: 0@0 pointingTowards: #South.
	self should: marsRoverPointingSouth beAt: 0@0 pointingTowards: #West.
	self should: marsRoverPointingWest beAt: 0@0 pointingTowards: #North.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/12/2022 21:49:09'!
test06MarsRoverShouldProcessMultipleCommands

	| marsRover | 
	marsRover := MarsRover pointingToward: #North.

	marsRover process: 'ffrf'.
	
	self should: marsRover beAt: 1@2 pointingTowards: #East
	
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'moving' stamp: 'TO 5/12/2022 21:43:36'!
moveBackwards

	direction = #North ifTrue: [ position := 0 @ -1 ].
	direction = #South ifTrue: [ position := 0 @ 1].
	direction = #East ifTrue: [ position := -1 @ 0 ].
	direction = #West ifTrue: [ position := 1 @ 0 ].! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/12/2022 21:43:36'!
moveForward

	direction = #North ifTrue: [ position := 0 @ (position y + 1)].
	direction = #South ifTrue: [ position := 0 @ (position y - 1)].
	direction = #East ifTrue: [ position := (position x + 1) @ 0 ].
	direction = #West ifTrue: [ position := (position x - 1) @ 0 ].! !


!MarsRover methodsFor: 'turning' stamp: 'TO 5/12/2022 21:45:29'!
turnLeft

	direction = #North ifTrue: [ direction := #West. ^ self ].
	direction = #South ifTrue: [ direction := #East. ^ self ].
	direction = #East ifTrue: [ direction := #North. ^ self ].
	direction = #West ifTrue: [ direction := #South. ^ self ].
	! !

!MarsRover methodsFor: 'turning' stamp: 'TO 5/12/2022 21:48:05'!
turnRight

	direction = #North ifTrue: [ direction := #East. ^ self ].
	direction = #East ifTrue: [ direction := #South. ^ self ].
	direction = #South ifTrue: [ direction := #West. ^ self ].
	direction = #West ifTrue: [ direction := #North. ^ self ].! !


!MarsRover methodsFor: 'command processing' stamp: 'TO 5/12/2022 21:16:59'!
process: aCommand 
	
	aCommand = 'f' ifTrue: [ self moveForward ].
	aCommand = 'ff' ifTrue: [ self moveForward. self moveForward ].
	aCommand = 'b' ifTrue: [ self moveBackwards ].
	aCommand = 'l' ifTrue: [ self turnLeft ].
	aCommand = 'r' ifTrue: [ self turnRight ].! !


!MarsRover methodsFor: 'initialization' stamp: 'TO 5/12/2022 21:22:13'!
initializePointingToward: aDirection

	position := 0@0.
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

!MarsRover class methodsFor: 'instance creation' stamp: 'TO 5/12/2022 21:21:24'!
pointingToward: aDirection
	
	^ self new initializePointingToward: aDirection! !


!classDefinition: #MarsRoverNorthDirection category: 'MarsRover'!
Object subclass: #MarsRoverNorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!
