//
//  STBMyScene.h
//  SaveTheBall
//

//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface STBGameScene : SKScene <SKPhysicsContactDelegate>

@property (strong, nonatomic) SKShapeNode *ball;

@end
