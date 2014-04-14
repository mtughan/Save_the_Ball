//
//  STBViewController.m
//  SaveTheBall
//
//  Created by Michael Tughan on 2014-03-17.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBGameViewController.h"
#import "STBGameScene.h"

@interface STBGameViewController ()
{
    SKView *skView;
}

@end

@implementation STBGameViewController

@synthesize pauseAlert, endAlert;

- (void)viewDidLoad
{
    self.pauseAlert = [[UIAlertView alloc] initWithTitle:@"Game Paused" message:nil delegate:self cancelButtonTitle:@"Resume" otherButtonTitles:@"Main Menu", nil];
    self.endAlert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:nil delegate:self cancelButtonTitle:@"Main Menu" otherButtonTitles:nil];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    // Configure the view.
    skView = (SKView *)self.view;
    if(!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        skView.paused = YES;
        
        // Create and configure the scene.
        STBGameScene * scene = [STBGameScene sceneWithSize:skView.bounds.size];
        [scene setDelegate:self];
        scene.scaleMode = SKSceneScaleModeAspectFit;
        
        // Present the scene.
        [skView presentScene:scene];
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)pauseGame {
    skView.paused = YES;
    
    [self.pauseAlert show];
}

- (void)endGame:(int)score {
    skView.paused = YES;
    
    self.endAlert.message = [NSString stringWithFormat:@"Your score: %d", score];
    [self.endAlert show];
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button clicked: %d", buttonIndex);
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView == self.pauseAlert) {
        skView.paused = NO;
    }
}

@end
