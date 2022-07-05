!classDefinition: #LaddersAndSlides3DTest category: '2doParcial2022-1c'!
TestCase subclass: #LaddersAndSlides3DTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial2022-1c'!

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 19:07:53'!
test01ShouldRaiseWhenTryingToCreateGameWithoutStairs

	| startingPosition finalPosition |
	
	startingPosition := 2@2.
	finalPosition := 5@1.
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: OrderedCollection new 
								withSlides: self validSlides 
								startingFrom: startingPosition
								finishingAt: finalPosition
							]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlides3D canNotCreateGameWithoutStairsOrSlidesError ! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 19:08:08'!
test02ShouldRaiseWhenTryingToCreateGameWithoutSlides

	| startingPosition finalPosition |
	
	startingPosition := 2@2.
	finalPosition := 5@1.
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: self validStairs
								withSlides: OrderedCollection new
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlides3D canNotCreateGameWithoutStairsOrSlidesError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 19:08:29'!
test03ShouldRaiseWhenTryingToCreateGameWithAStairThatMatchesStartingPosition

	| startingPosition finalPosition stairs |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	stairs := OrderedCollection with: (Stair fromFloor: 1 toFloor: 2 startingFrom: startingPosition to: 3@2).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: stairs 
								withSlides: self validSlides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlides3D thereCanNotBeShortcutsAtStartOrFinishPositionError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 21:40:50'!
test04ShouldRaiseWhenTryingToCreateGameWithASlideThatMatchesFinishingPosition

	| startingPosition finalPosition slides |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	slides := OrderedCollection with: (Slide fromFloor: 3 toFloor: 2 startingFrom: finalPosition to: 3@2).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: self validStairs 
								withSlides: slides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlides3D thereCanNotBeShortcutsAtStartOrFinishPositionError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 19:09:04'!
test05ShouldRaiseWhenTryingToCreateGameWithTwoStairsStartingFromTheSamePosition

	| startingPosition finalPosition stairs |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	stairs := OrderedCollection 
				with: (Stair fromFloor: 1 toFloor: 2 startingFrom: 1@1 to: 3@2)
				with: (Stair fromFloor: 1 toFloor: 3 startingFrom: 1@1 to: 2@4).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: stairs 
								withSlides: self validSlides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlides3D thereCanNotBeShortcutsThatShareTheSameStartingPositionError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 19:04:16'!
test06ShouldRaiseWhenTryingToCreateGameWithTwoSlidesStartingFromTheSamePosition

	| startingPosition finalPosition slides |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	slides := OrderedCollection with: (Slide fromFloor: 3 toFloor: 2 startingFrom: 2@1 to: 3@2)
							with: (Slide fromFloor: 3 toFloor: 1 startingFrom: 2@1 to: 1@4).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: self validStairs 
								withSlides: slides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlides3D thereCanNotBeShortcutsThatShareTheSameStartingPositionError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 20:37:55'!
test07ShouldRaiseWhenTryingToCreateGameWithAStairThatStartsFromAnInexistentPosition

	| startingPosition finalPosition stairs |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	stairs := OrderedCollection with: (Stair fromFloor: 1 toFloor: 2 startingFrom: 100@100 to: 3@2).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: stairs
								withSlides: self validSlides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D shortcutIsOutOfBoundariesError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 20:37:42'!
test08ShouldRaiseWhenTryingToCreateGameWithAStairThatFinishesAtAnInexistentPosition

	| startingPosition finalPosition stairs |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	stairs := OrderedCollection with: (Stair fromFloor: 1 toFloor: 2 startingFrom: 1@3 to: 100@100).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: stairs
								withSlides: self validSlides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D shortcutIsOutOfBoundariesError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 20:44:49'!
test09ShouldRaiseWhenTryingToCreateGameWithAStairThatStartFromAnInexistentFloor

	| startingPosition finalPosition stairs |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	stairs := OrderedCollection with: (Stair fromFloor: 100 toFloor: 2 startingFrom: 1@3 to: 2@4).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: stairs
								withSlides: self validSlides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D shortcutFloorIsInvalidError ! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 20:47:06'!
test10ShouldRaiseWhenTryingToCreateGameWithAStairThatEndsAtAnInexistentFloor

	| startingPosition finalPosition stairs |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	stairs := OrderedCollection with: (Stair fromFloor: 1 toFloor: 100 startingFrom: 1@3 to: 2@4).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: stairs
								withSlides: self validSlides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D shortcutFloorIsInvalidError ! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 20:48:38'!
test11ShouldRaiseWhenTryingToCreateGameWithASlideThatStartsFromAnInexistentPosition

	| startingPosition finalPosition slides |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	slides := OrderedCollection with: (Slide fromFloor: 3 toFloor: 2 startingFrom: 100@100 to: 3@2).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: self validStairs
								withSlides: slides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D shortcutIsOutOfBoundariesError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 20:48:59'!
test12ShouldRaiseWhenTryingToCreateGameWithASlideThatEndsAtAnInexistentPosition

	| startingPosition finalPosition slides |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	slides := OrderedCollection with: (Slide fromFloor: 3 toFloor: 2 startingFrom: 2@4 to: 100@100).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: self validStairs
								withSlides: slides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D shortcutIsOutOfBoundariesError! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 20:49:40'!
test13ShouldRaiseWhenTryingToCreateGameWithASlideThatStartsAtAnInexistentFloor

	| startingPosition finalPosition slides |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	slides := OrderedCollection with: (Slide fromFloor: 1000 toFloor: 2 startingFrom: 2@4 to: 3@1).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: self validStairs
								withSlides: slides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D shortcutFloorIsInvalidError ! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 21:38:40'!
test14ShouldRaiseWhenTryingToCreateGameWithASlideThatEndsAtAnInexistentFloor

	| startingPosition finalPosition slides |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	slides := OrderedCollection with: (Slide fromFloor: 3 toFloor: 0 startingFrom: 2@4 to: 3@1).
	
	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: self validStairs
								withSlides: slides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D shortcutFloorIsInvalidError ! !

!LaddersAndSlides3DTest methodsFor: 'tests' stamp: 'LZ 7/4/2022 21:06:44'!
test15ShouldRaiseWhenTryingToCreateGameWithAStairThatStartsWhereASlideEnds

	| startingPosition finalPosition stairs slides |
	
	startingPosition := 2@2.
	finalPosition := 5@1.

	slides := OrderedCollection with: (Slide fromFloor: 2 toFloor: 1 startingFrom: 2@2 to: 3@1).
	stairs := OrderedCollection with: (Stair fromFloor: 1 toFloor: 3 startingFrom: 3@1 to: 2@3).

	self 
		should: [ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: stairs
								withSlides: slides
								startingFrom: startingPosition
								finishingAt: finalPosition
								]
		raise: Error - MessageNotUnderstood  
		withMessageText: LaddersAndSlides3D stairCannotStartWhereASlideFinishesError ! !


!LaddersAndSlides3DTest methodsFor: 'test data' stamp: 'LZ 7/4/2022 21:28:16'!
validFloors

	| floor1 floor2 floor3 |
	floor1 := Floor withColumns: 8 withRows: 3.
	floor2 := Floor withColumns: 5 withRows: 3.
	floor3 :=	 Floor withColumns: 5 withRows: 4.
	
	^ OrderedCollection with: floor1 with: floor2 with: floor3.! !

!LaddersAndSlides3DTest methodsFor: 'test data' stamp: 'LZ 7/4/2022 21:31:46'!
validGame

	^ LaddersAndSlides3D withFloors: self validFloors
							 	withQuantityOfPlayers: 3
								withStairs: self validStairs 
								withSlides: self validSlides
								startingFrom: 2@2
								finishingAt: 5@1
								! !

!LaddersAndSlides3DTest methodsFor: 'test data' stamp: 'LZ 7/4/2022 21:32:16'!
validSlides

	| slide1 slide2 |
	slide1 := Slide fromFloor: 3 toFloor: 2 startingFrom: 2@1 to: 1@3.
	slide2 := Slide fromFloor: 2 toFloor: 1 startingFrom: 1@4 to: 7@3.
	
	^ OrderedCollection with: slide1 with: slide2.! !

!LaddersAndSlides3DTest methodsFor: 'test data' stamp: 'LZ 7/4/2022 21:32:28'!
validStairs

	| stair1 stair2 |
	stair1 := Stair fromFloor: 1 toFloor: 2 startingFrom: 5@3 to: 3@2.
	stair2 := Stair fromFloor: 2 toFloor: 3 startingFrom: 2@3 to: 5@1.
	
	^ OrderedCollection with: stair1 with: stair2.! !


!classDefinition: #Floor category: '2doParcial2022-1c'!
Object subclass: #Floor
	instanceVariableNames: 'columns rows'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial2022-1c'!

!Floor methodsFor: 'initialization' stamp: 'LZ 7/4/2022 17:50:22'!
initializeWithColumns: aNumberOfColumns withRows: aNumberOfRows

	columns := aNumberOfColumns.
	rows := aNumberOfRows.! !


!Floor methodsFor: 'accesing' stamp: 'LZ 7/4/2022 17:50:43'!
columns

	^ columns.! !

!Floor methodsFor: 'accesing' stamp: 'LZ 7/4/2022 17:50:46'!
rows

	^ rows.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: '2doParcial2022-1c'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'instance creation' stamp: 'LZ 7/4/2022 17:49:35'!
withColumns: aNumberOfColumns withRows: aNumberOfRows

	^self new initializeWithColumns: aNumberOfColumns withRows: aNumberOfRows.! !


!classDefinition: #LaddersAndSlides3D category: '2doParcial2022-1c'!
Object subclass: #LaddersAndSlides3D
	instanceVariableNames: 'floors players stairs slides startingPoint finishingPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial2022-1c'!

!LaddersAndSlides3D methodsFor: 'initialization' stamp: 'LZ 7/4/2022 21:30:45'!
initializeWithFloors: aCollectionOfFloors withQuantityOfPlayers: aQuantityOfPlayers withStairs: aCollectionOfStairs withSlides: aCollectionOfSlides startingFrom: aStartingPoint finishingAt: aFinishingPoint

	floors := aCollectionOfFloors.
	players := aQuantityOfPlayers.
	stairs := aCollectionOfStairs.
	slides := aCollectionOfSlides.
	startingPoint := aStartingPoint.
	finishingPoint := aFinishingPoint.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LaddersAndSlides3D class' category: '2doParcial2022-1c'!
LaddersAndSlides3D class
	instanceVariableNames: ''!

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 19:19:05'!
assertAreNotEmptyStairs: aCollectionOfStairs orSlides: aCollectionOfSlides

	^ (aCollectionOfStairs isEmpty or: aCollectionOfSlides isEmpty) ifTrue: [ self canNotCreateGameWithoutStairsOrSlidesErrorSignal ]! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:54:45'!
assertAreValidSlides: aCollectionOfSlides andStairs: aCollectionOfStairs withFloors: aCollectionOfFloors startingFrom: aStartingPoint finishingAt: aFinishingPoint

	self assertAreNotEmptyStairs: aCollectionOfStairs orSlides: aCollectionOfSlides.
	self assertNoStairs: aCollectionOfStairs startAtGameStartingPosition: aStartingPoint.
	
	self assertNoSlides: aCollectionOfSlides startInGameFinishingPosition: aFinishingPoint.
	
	self assertNoStairs: aCollectionOfStairs orSlidesMatchEachOtherStartingPositions: aCollectionOfSlides.
	
	self assertNoStairs: aCollectionOfStairs orSlidesStartOrEndInInvalidFloors: aCollectionOfSlides ofFloors: aCollectionOfFloors.

	self assertNoStairs: aCollectionOfStairs orSlidesAreOutOfBoundaries: aCollectionOfSlides ofFloors: aCollectionOfFloors.
	
	self assertNoStairs: aCollectionOfStairs startWhereASlideEnds: aCollectionOfSlides.! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:28:11'!
assertFinishingPositionOf: aShortcut isOutOfBoundariesOf: aFloor

	^ self assertPosition: aShortcut finishingPosition isOutOfBoundariesOf: aFloor.
	! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:27:35'!
assertInitialPositionOf: aShortcut isOutOfBoundariesOf: aFloor

	^ self assertPosition: aShortcut startingPosition isOutOfBoundariesOf: aFloor.! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:43:59'!
assertNoShortcuts: aCollectionOfShortcuts areOutOfBoundariesOf: aCollectionOfFloors

	(aCollectionOfShortcuts anySatisfy: [ :aShortcut |
		(self assertInitialPositionOf: aShortcut isOutOfBoundariesOf: (aCollectionOfFloors at: aShortcut startingFloor)) or:
		(self assertFinishingPositionOf: aShortcut isOutOfBoundariesOf: (aCollectionOfFloors at: aShortcut finishingFloor))]) ifTrue: [ self shortcutIsOutOfBoundariesErrorSignal ].! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:46:43'!
assertNoShortcuts: aCollectionOfShortcuts startOrEndInInvalidFloors: aCollectionOfFloors

	(aCollectionOfShortcuts anySatisfy: [ :aShortcut |
		((aShortcut startingFloor < 1) or: (aShortcut startingFloor > aCollectionOfFloors size)) or:
		((aShortcut finishingFloor < 1) or: (aShortcut finishingFloor > aCollectionOfFloors size))]) ifTrue: [ self shortcutFloorIsInvalidErrorSignal ].! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 19:56:49'!
assertNoShortcutsMatchStartingPosition: aCollectionOfShortcuts

	| shortcutsStartingPositionsAndFloors |

	shortcutsStartingPositionsAndFloors := Set new.
	
	aCollectionOfShortcuts inject: shortcutsStartingPositionsAndFloors into: [ :startingPositions :aShortcut | 
		startingPositions add: (aShortcut startingFloor -> aShortcut startingPosition). startingPositions ].
	
	aCollectionOfShortcuts size = shortcutsStartingPositionsAndFloors size ifFalse: [ self thereCanNotBeShortcutsThatShareTheSameStartingPositionErrorSignal ].! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:06:40'!
assertNoSlides: aCollectionOfSlides startInGameFinishingPosition: aFinishingPosition

	(aCollectionOfSlides anySatisfy: [ :aSlide | aSlide startingPosition = aFinishingPosition ]) ifTrue: [self thereCanNotBeShortcutsAtStartOrFinishPositionErrorSignal ]! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 19:16:21'!
assertNoSlidesMatchStartingPosition: aCollectionOfSlides

	self assertNoShortcutsMatchStartingPosition: aCollectionOfSlides.! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:32:41'!
assertNoStairs: aCollectionOfStairs orSlidesAreOutOfBoundaries: aCollectionOfSlides ofFloors: aCollectionOfFloors

	self assertNoShortcuts: aCollectionOfStairs areOutOfBoundariesOf: aCollectionOfFloors.
	self assertNoShortcuts: aCollectionOfSlides areOutOfBoundariesOf: aCollectionOfFloors. ! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:04:40'!
assertNoStairs: aCollectionOfStairs orSlidesMatchEachOtherStartingPositions: aCollectionOfSlides

	self assertNoStairsMatchStartingPosition: aCollectionOfStairs.
	self assertNoSlidesMatchStartingPosition: aCollectionOfSlides ! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:42:08'!
assertNoStairs: aCollectionOfStairs orSlidesStartOrEndInInvalidFloors: aCollectionOfSlides ofFloors: aCollectionOfFloors

	self assertNoShortcuts: aCollectionOfStairs startOrEndInInvalidFloors: aCollectionOfFloors.
	self assertNoShortcuts: aCollectionOfSlides startOrEndInInvalidFloors: aCollectionOfFloors. ! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 20:03:30'!
assertNoStairs: aCollectionOfStairs startAtGameStartingPosition: aStartingPoint

	(aCollectionOfStairs anySatisfy: [ :aSlide | aSlide startingPosition = aStartingPoint ]) ifTrue: [self thereCanNotBeShortcutsAtStartOrFinishPositionErrorSignal ]! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 21:04:00'!
assertNoStairs: aCollectionOfStairs startWhereASlideEnds: aCollectionOfSlides

	| stairsStartingPositionsAndFloors slidesFinishingPositionsAndFloors |

	stairsStartingPositionsAndFloors := Set new.
	
	aCollectionOfStairs inject: stairsStartingPositionsAndFloors into: [ :startingPositions :aStair | 
		startingPositions add: (aStair startingFloor -> aStair startingPosition). startingPositions ].
	
	
	slidesFinishingPositionsAndFloors := Set new.
	
	aCollectionOfSlides inject: slidesFinishingPositionsAndFloors into: [ :finishingPositions :aSlide | 
		finishingPositions add: (aSlide finishingFloor -> aSlide startingPosition). finishingPositions ].
	
	(stairsStartingPositionsAndFloors intersection: slidesFinishingPositionsAndFloors) isEmpty ifTrue: [self stairCannotStartWhereASlideFinishesErrorSignal].
	! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 19:16:10'!
assertNoStairsMatchStartingPosition: aCollectionOfStairs

	self assertNoShortcutsMatchStartingPosition: aCollectionOfStairs.! !

!LaddersAndSlides3D class methodsFor: 'assertions' stamp: 'LZ 7/4/2022 21:34:25'!
assertPosition: aPosition isOutOfBoundariesOf: aFloor

	^ (aPosition x < 1) 
		or: aPosition x > (aFloor columns)
		or: aPosition y < 1
		or: aPosition y > (aFloor rows)! !


!LaddersAndSlides3D class methodsFor: 'instance creation' stamp: 'LZ 7/4/2022 21:46:39'!
withFloors: aCollectionOfFloors withQuantityOfPlayers: aQuantityOfPlayers withStairs: aCollectionOfStairs withSlides: aCollectionOfSlides startingFrom: aStartingPoint finishingAt: aFinishingPoint

	self assertAreValidSlides: aCollectionOfSlides andStairs: aCollectionOfStairs withFloors: aCollectionOfFloors startingFrom: aStartingPoint finishingAt: aFinishingPoint.
! !


!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 18:42:02'!
canNotCreateGameWithoutStairsOrSlidesError
	
	^ 'Can not create game without slides'.! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 18:41:44'!
canNotCreateGameWithoutStairsOrSlidesErrorSignal
	
	self error: self canNotCreateGameWithoutStairsOrSlidesError.! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 20:43:44'!
shortcutFloorIsInvalidError
	
	^ 'Shortcut floor is invalid'.! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 20:43:33'!
shortcutFloorIsInvalidErrorSignal
	
	self error: self shortcutFloorIsInvalidError.! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 19:11:00'!
shortcutIsOutOfBoundariesError
	
	^ 'Shortcut is out of boundaries'.! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 19:21:01'!
shortcutIsOutOfBoundariesErrorSignal
	
	self error: self shortcutIsOutOfBoundariesError.! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 20:54:07'!
stairCannotStartWhereASlideFinishesError
	
	^ 'To prevent a possible loop, a stair cannot start where a slide finishes'! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 21:01:44'!
stairCannotStartWhereASlideFinishesErrorSignal
	
	self error: self stairCannotStartWhereASlideFinishesError ! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 18:16:27'!
thereCanNotBeShortcutsAtStartOrFinishPositionError
	
	^ 'There can not be a shortcut on starting or finishing position'! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 18:26:33'!
thereCanNotBeShortcutsAtStartOrFinishPositionErrorSignal
	
	self error: self thereCanNotBeShortcutsAtStartOrFinishPositionError .! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 18:37:51'!
thereCanNotBeShortcutsThatShareTheSameStartingPositionError
	
	^ 'There cannot be shortcuts that share the starting position'.! !

!LaddersAndSlides3D class methodsFor: 'errors' stamp: 'LZ 7/4/2022 18:38:07'!
thereCanNotBeShortcutsThatShareTheSameStartingPositionErrorSignal
	
	self error: self thereCanNotBeShortcutsThatShareTheSameStartingPositionError.! !


!classDefinition: #Shortcut category: '2doParcial2022-1c'!
Object subclass: #Shortcut
	instanceVariableNames: 'startingFloor finishingFloor startingPoint finishingPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial2022-1c'!

!Shortcut methodsFor: 'accessing' stamp: 'LZ 7/4/2022 21:48:00'!
finishingFloor

	^ finishingFloor .! !

!Shortcut methodsFor: 'accessing' stamp: 'LZ 7/4/2022 21:48:13'!
finishingPosition

	^ finishingPoint ! !

!Shortcut methodsFor: 'accessing' stamp: 'LZ 7/4/2022 21:48:21'!
startingFloor

	^ startingFloor ! !

!Shortcut methodsFor: 'accessing' stamp: 'LZ 7/4/2022 21:48:28'!
startingPosition

	^ startingPoint ! !


!Shortcut methodsFor: 'initialization' stamp: 'LZ 7/4/2022 21:46:10'!
initializeFromFloor: aStartingFloorNumber toFloor: aFinishingFloorNumber startingFrom: aStartPosition to: aFinalPosition

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Shortcut class' category: '2doParcial2022-1c'!
Shortcut class
	instanceVariableNames: ''!

!Shortcut class methodsFor: 'instance creation' stamp: 'LZ 7/4/2022 17:56:57'!
fromFloor: aFloorNumber toFloor: anotherFloorNumber startingFrom: aStartPosition to: aFinalPosition

	^ self new initializeFromFloor: aFloorNumber toFloor: anotherFloorNumber startingFrom: aStartPosition to: aFinalPosition.! !


!classDefinition: #Slide category: '2doParcial2022-1c'!
Shortcut subclass: #Slide
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial2022-1c'!

!Slide methodsFor: 'initialization' stamp: 'LZ 7/4/2022 21:45:10'!
initializeFromFloor: aStartingFloorNumber toFloor: aFinishingFloorNumber startingFrom: aStartPosition to: aFinalPosition

	startingFloor := aStartingFloorNumber.
	finishingFloor := aFinishingFloorNumber.
	startingPoint := aStartPosition.
	finishingPoint := aFinalPosition.! !


!classDefinition: #Stair category: '2doParcial2022-1c'!
Shortcut subclass: #Stair
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial2022-1c'!

!Stair methodsFor: 'initialization' stamp: 'LZ 7/4/2022 21:45:20'!
initializeFromFloor: aStartingFloorNumber toFloor: aFinishingFloorNumber startingFrom: aStartPosition to: aFinalPosition

	startingFloor := aStartingFloorNumber.
	finishingFloor := aFinishingFloorNumber.
	startingPoint := aStartPosition.
	finishingPoint := aFinalPosition.! !
