//
//  STBMyScene.m
//  SaveTheBall
//
//  Created by Michael Tughan on 2014-03-17.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBGameScene.h"

static const int ballRadius = 10;

static const uint32_t ballCategory = 0x1 << 0;
static const uint32_t wallCategory = 0x1 << 1;
static const uint32_t paddleCategory = 0x1 << 2;
static const uint32_t bottomWallCategory = 0x1 << 3;

static NSString *ballName = @"ball";
static NSString *wallName = @"wall";
static NSString *paddleName = @"paddle";
static NSString *bottomWallName = @"bottom wall";

@implementation STBGameScene

@synthesize ball;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        
        SKPhysicsBody *borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        borderBody.friction = 0.0f;
        borderBody.categoryBitMask = wallCategory;
        borderBody.collisionBitMask = ballCategory;
        self.physicsBody = borderBody;
        
        self.name = wallName;
        
        self.ball = [[SKShapeNode alloc] init];
        self.ball.name = ballName;
        self.ball.fillColor = [SKColor whiteColor];
        
        CGPathRef circle = CGPathCreateWithEllipseInRect(CGRectMake(-ballRadius, -ballRadius, ballRadius * 2, ballRadius * 2), NULL);
        self.ball.path = circle;
        [self addChild:self.ball];
        CGPathRelease(circle);
        
        double x = CGRectGetMidX(self.frame);
        double y = CGRectGetMidY(self.frame);
        self.ball.position = CGPointMake(x, y);
        
        SKPhysicsBody *ballPhysics = [SKPhysicsBody bodyWithCircleOfRadius:ballRadius];
        ballPhysics.restitution = 1.0f;
        ballPhysics.linearDamping = 0.0f;
        ballPhysics.friction = 0.0f;
        ballPhysics.allowsRotation = NO;
        
        ballPhysics.categoryBitMask = ballCategory;
        ballPhysics.collisionBitMask = wallCategory | bottomWallCategory | paddleCategory;
        ballPhysics.contactTestBitMask = bottomWallCategory | paddleCategory;
        
        self.ball.physicsBody = ballPhysics;
        [self.ball.physicsBody applyImpulse:CGVectorMake(-3.0f, 3.0f)];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
//    for (UITouch *touch in touches) {
//        CGPoint location = [touch locationInNode:self];
//        
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
//        
//        sprite.position = location;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
//    }
    self.view.paused = NO;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"contact began between %@ and %@ at (%f, %f)", [contact.bodyA description], [contact.bodyB description], contact.contactPoint.x, contact.contactPoint.y);
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    NSLog(@"contact ended between %@ and %@ at (%f, %f)", [contact.bodyA description], [contact.bodyB description], contact.contactPoint.x, contact.contactPoint.y);
}

@end
