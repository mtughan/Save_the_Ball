//
//  STBViewController.h
//  SaveTheBall
//

//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface STBGameViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) UIAlertView *pauseAlert;
@property (strong, nonatomic) UIAlertView *endAlert;

- (void)pauseGame;
- (void)endGame:(int)score;

@end
