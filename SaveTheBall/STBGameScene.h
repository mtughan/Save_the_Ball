//
//  STBMyScene.h
//  SaveTheBall
//

//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "STBGameViewController.h"

@interface STBGameScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) SKShapeNode *ball;
@property (strong, nonatomic) SKShapeNode *paddle;
@property (strong, nonatomic) SKShapeNode *bottomWall;
@property (strong, nonatomic) SKSpriteNode *pauseButton;
@property (nonatomic) BOOL touchPaddle;

@property (weak, nonatomic) STBGameViewController *delegate;

@end
