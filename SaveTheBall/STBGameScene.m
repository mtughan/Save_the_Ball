//
//  STBMyScene.m
//  SaveTheBall
//
//  Created by Michael Tughan on 2014-03-17.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBGameScene.h"
#import "STBAppDelegate.h"

static const int ballRadius = 10;
static const int paddleLength = 50, paddleHeight = 10;

static const uint32_t ballCategory = 0x1 << 0;
static const uint32_t wallCategory = 0x1 << 1;
static const uint32_t paddleCategory = 0x1 << 2;
static const uint32_t bottomWallCategory = 0x1 << 3;

static NSString *ballName = @"ball";
static NSString *wallName = @"wall";
static NSString *paddleName = @"paddle";
static NSString *bottomWallName = @"bottom wall";

@interface STBGameScene ()
{
    int score;
}
@end

@implementation STBGameScene

@synthesize ball, paddle, bottomWall, pauseButton, touchPaddle;
@synthesize delegate;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor blackColor];
        
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        
        // Border
        SKPhysicsBody *borderBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        borderBody.friction = 0.0f;
        borderBody.categoryBitMask = wallCategory;
        borderBody.collisionBitMask = ballCategory;
        self.physicsBody = borderBody;
        
        self.name = wallName;
        
        // Ball
        self.ball = [[SKShapeNode alloc] init];
        self.ball.name = ballName;
        self.ball.strokeColor = self.ball.fillColor = [(STBAppDelegate *)[[UIApplication sharedApplication] delegate] ballColour];
        
        CGPathRef circle = CGPathCreateWithEllipseInRect(CGRectMake(-ballRadius, -ballRadius, ballRadius * 2, ballRadius * 2), NULL);
        self.ball.path = circle;
        [self addChild:self.ball];
        CGPathRelease(circle);
        
        double x = CGRectGetMidX(self.frame);
        double y = CGRectGetMidY(self.frame);
        self.ball.position = CGPointMake(x, y);
        
        // Ball Physics
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
        
        //Paddle
        self.paddle = [[SKShapeNode alloc] init];
        self.paddle.name = paddleName;
        self.paddle.fillColor = [SKColor yellowColor];
        
        CGPathRef rect = CGPathCreateWithRect(CGRectMake(-(paddleLength / 2.), -(paddleHeight / 2.), paddleLength, paddleHeight), NULL);
        self.paddle.path = rect;
        [self addChild:self.paddle];
        CGPathRelease(rect);
        
        self.paddle.position = CGPointMake(x, 30 + (paddleHeight / 2.));
        
        //Paddle Physics
        SKPhysicsBody *paddlePhysics = [SKPhysicsBody bodyWithRectangleOfSize:paddle.frame.size];
        paddlePhysics.restitution = 0.1f;
        paddlePhysics.friction = 0.4f;
        paddlePhysics.dynamic = NO;
        
        paddlePhysics.categoryBitMask = paddleCategory;
        paddlePhysics.collisionBitMask = wallCategory | ballCategory;
        paddlePhysics.contactTestBitMask = ballCategory;
        
        self.paddle.physicsBody = paddlePhysics;
        
        // Bottom wall (game ending wall)
        self.bottomWall = [[SKShapeNode alloc] init];
        self.bottomWall.name = bottomWallName;
        [self addChild:self.bottomWall];
        
        // Bottom wall physics (for collision detection)
        SKPhysicsBody *bottomWallPhysics = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, 0) toPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
        bottomWallPhysics.categoryBitMask = bottomWallCategory;
        bottomWallPhysics.collisionBitMask = ballCategory;
        bottomWallPhysics.contactTestBitMask = ballCategory;
        self.bottomWall.physicsBody = bottomWallPhysics;
        
        // Pause button
        self.pauseButton = [SKSpriteNode spriteNodeWithImageNamed:@"pause"];
        [self addChild:pauseButton];
        self.pauseButton.anchorPoint = CGPointMake(1, 1);
        self.pauseButton.position = CGPointMake(CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame) - 10);
        
        score = 0;
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    self.view.paused = NO;
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInNode:self.paddle];
    int margin = paddleHeight / 2 + 30;
    if(touchLocation.y > -margin && touchLocation.y < margin)
    {
        self.touchPaddle = YES;
    }
    
    touchLocation = [touch locationInNode:self.pauseButton];
    margin = self.pauseButton.size.width + 10;
    NSLog(@"x = %f, y = %f", touchLocation.x, touchLocation.y);
    if(touchLocation.x > -margin && touchLocation.x < 10 &&
       touchLocation.y > -margin && touchLocation.y < 10) {
        // pause touched
        [self.delegate pauseGame];
        self.touchPaddle = NO;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.touchPaddle)
    {
        UITouch *touch = [touches anyObject];
        CGPoint touchPosition = [touch locationInNode:self];
        CGPoint previousPosition = [touch previousLocationInNode:self];
        self.paddle.name = paddleName;
        // Set paddle position
        int newPaddleX = paddle.position.x + (touchPosition.x - previousPosition.x);
        paddle.position = CGPointMake(newPaddleX, paddle.position.y);
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchPaddle = NO;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    NSLog(@"contact began between %@ and %@ at (%f, %f)", [contact.bodyA description], [contact.bodyB description], contact.contactPoint.x, contact.contactPoint.y);
    if(contact.bodyA.node == self.bottomWall || contact.bodyB.node == self.bottomWall)
    {
        [self.delegate endGame:score];
    }
    else if (contact.bodyA.node == self.paddle || contact.bodyB.node == self.paddle)
    {
        score++;
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact {
    NSLog(@"contact ended between %@ and %@ at (%f, %f)", [contact.bodyA description], [contact.bodyB description], contact.contactPoint.x, contact.contactPoint.y);
}

@end
