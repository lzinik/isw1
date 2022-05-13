!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'east north south west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'assertions' stamp: 'TO 5/13/2022 15:42:16'!
should: marsRover beAt: aPosition pointingTowards: aMarsRoverDirection  

	self assert: marsRover position equals: aPosition.
	self assert: marsRover direction equals: aMarsRoverDirection! !


!MarsRoverTest methodsFor: 'set up' stamp: 'TO 5/13/2022 15:46:50'!
setUp

	east := MarsRoverDirectionEast new.
	north := MarsRoverDirectionNorth new.
	south := MarsRoverDirectionSouth new.
	west := MarsRoverDirectionWest new! !


!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/13/2022 15:47:04'!
test01MarsRoverShouldNotMoveWhenReceivesEmptyString

	| marsRover | 
	marsRover := MarsRover pointingToward: north at: 0@0.
	
	marsRover process: ''.
	self should: marsRover beAt: 0@0 pointingTowards: north
	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/13/2022 15:48:50'!
test02MarsRoverShouldMoveTowardHeadingWhenReceivesOneForward

	| marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingEast marsRoverPointingWest command | 
	marsRoverPointingNorth := MarsRover pointingToward: north at: 1@1.
	marsRoverPointingSouth := MarsRover pointingToward: south at: 7@3.
	marsRoverPointingEast := MarsRover pointingToward: east at: -5@-9.
	marsRoverPointingWest := MarsRover pointingToward: west at: -34@43.	
	
	command := 'f'.
	
	marsRoverPointingNorth process: command.
	marsRoverPointingSouth process: command.	
	marsRoverPointingEast process: command.	
	marsRoverPointingWest process: command.	
	
	self should: marsRoverPointingNorth beAt: 1@2 pointingTowards: north.
	self should: marsRoverPointingSouth beAt: 7@2 pointingTowards: south.
	self should: marsRoverPointingEast beAt: -4@-9 pointingTowards: east.
	self should: marsRoverPointingWest beAt: -35@43 pointingTowards: west	.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/13/2022 15:47:42'!
test03MarsRoverShouldMoveOppositeToDirectionWhenReceivesOneBackward

	| marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingEast marsRoverPointingWest command | 
	marsRoverPointingNorth := MarsRover pointingToward: north at: -8@7.
	marsRoverPointingSouth := MarsRover pointingToward: south at: 89@-45.
	marsRoverPointingEast := MarsRover pointingToward: east at: 4@4.
	marsRoverPointingWest := MarsRover pointingToward: west at: 56@-34.	
	
	command := 'b'.
	
	marsRoverPointingNorth process: command.
	marsRoverPointingSouth process: command.	
	marsRoverPointingEast process: command.	
	marsRoverPointingWest process: command.	
	
	self should: marsRoverPointingNorth beAt: -8@6 pointingTowards: north.
	self should: marsRoverPointingSouth beAt: 89@-44 pointingTowards: south.
	self should: marsRoverPointingEast beAt: 3@4 pointingTowards: east.
	self should: marsRoverPointingWest beAt: 57@-34 pointingTowards: west.! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/13/2022 15:47:56'!
test04MarsRoverShouldRotateLeftWhenReceivesOneLeft

	| marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingEast marsRoverPointingWest command | 
	marsRoverPointingNorth := MarsRover pointingToward: north at: 0@0.
	marsRoverPointingSouth := MarsRover pointingToward: south at: 0@0.
	marsRoverPointingEast := MarsRover pointingToward: east at: 0@0.
	marsRoverPointingWest := MarsRover pointingToward: west at: 0@0.	
	
	command := 'l'.
	
	marsRoverPointingNorth process: command.
	marsRoverPointingSouth process: command.	
	marsRoverPointingEast process: command.	
	marsRoverPointingWest process: command.	
	
	self should: marsRoverPointingNorth beAt: 0@0 pointingTowards: west.
	self should: marsRoverPointingSouth beAt: 0@0 pointingTowards: east.
	self should: marsRoverPointingEast beAt: 0@0 pointingTowards: north.
	self should: marsRoverPointingWest beAt: 0@0 pointingTowards: south.	
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/13/2022 15:48:17'!
test05MarsRoverShouldRotateRightWhenReceivesOneRight

	| marsRoverPointingNorth marsRoverPointingSouth marsRoverPointingEast marsRoverPointingWest command | 
	marsRoverPointingNorth := MarsRover pointingToward: north at: 0@0.
	marsRoverPointingSouth := MarsRover pointingToward: south at: 0@0.
	marsRoverPointingEast := MarsRover pointingToward: east at: 0@0.
	marsRoverPointingWest := MarsRover pointingToward: west at: 0@0.	
	
	command := 'r'.
	
	marsRoverPointingNorth process: command.
	marsRoverPointingSouth process: command.	
	marsRoverPointingEast process: command.	
	marsRoverPointingWest process: command.	
	
	self should: marsRoverPointingNorth beAt: 0@0 pointingTowards: east.
	self should: marsRoverPointingEast beAt: 0@0 pointingTowards: south.
	self should: marsRoverPointingSouth beAt: 0@0 pointingTowards: west.
	self should: marsRoverPointingWest beAt: 0@0 pointingTowards: north.
	! !

!MarsRoverTest methodsFor: 'tests' stamp: 'TO 5/13/2022 15:03:10'!
test06MarsRoverShouldProcessMultipleCommands

	"
	| marsRover | 
	marsRover := MarsRover pointingToward: #North.

	marsRover process: 'ffrf'.
	
	self should: marsRover beAt: 1@2 pointingTowards: #East"
	
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

!MarsRover methodsFor: 'moving' stamp: 'TO 5/13/2022 15:14:20'!
moveEast

	^ position := (position x + 1) @ position y! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/13/2022 15:30:48'!
moveForward

	direction moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/13/2022 15:13:37'!
moveNorth

	^ position := position x @ (position y + 1)! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/13/2022 15:14:06'!
moveSouth

	^ position := position x @ (position y - 1)! !

!MarsRover methodsFor: 'moving' stamp: 'TO 5/13/2022 15:14:33'!
moveWest

	^ position := (position x - 1) @ position y! !


!MarsRover methodsFor: 'turning' stamp: 'TO 5/13/2022 15:31:22'!
turnLeft

	direction := direction left! !

!MarsRover methodsFor: 'turning' stamp: 'TO 5/13/2022 15:31:33'!
turnRight

	direction := direction right! !


!MarsRover methodsFor: 'command processing' stamp: 'TO 5/12/2022 21:16:59'!
process: aCommand 
	
	aCommand = 'f' ifTrue: [ self moveForward ].
	aCommand = 'ff' ifTrue: [ self moveForward. self moveForward ].
	aCommand = 'b' ifTrue: [ self moveBackwards ].
	aCommand = 'l' ifTrue: [ self turnLeft ].
	aCommand = 'r' ifTrue: [ self turnRight ].! !


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


!MarsRoverDirection methodsFor: 'comparing' stamp: 'TO 5/13/2022 15:41:23'!
= anotherMarsRoverDirection

	^ anotherMarsRoverDirection isKindOf: self class! !


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
