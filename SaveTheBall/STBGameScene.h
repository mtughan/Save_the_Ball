//
//  STBMyScene.h
//  SaveTheBall
//

//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "STBOptionsViewController.h"

@interface STBGameScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) SKShapeNode *ball;
@property (strong, nonatomic) SKShapeNode *paddle;
@property (strong, nonatomic) SKShapeNode *bottomWall;
@property (nonatomic) BOOL touchPaddle;

@end
