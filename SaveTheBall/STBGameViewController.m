//
//  STBViewController.m
//  SaveTheBall
//
//  Created by Michael Tughan on 2014-03-17.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBGameViewController.h"
#import "STBGameScene.h"
#import "STBAppDelegate.h"

@interface STBGameViewController ()
{
    SKView *skView;
    STBAppDelegate *appDelegate;
    
    int newHighScore;
}

@end

@implementation STBGameViewController

@synthesize pauseAlert, endAlert;

- (void)viewDidLoad
{
    appDelegate = (STBAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    // Configure the view.
    skView = (SKView *)self.view;
    if(!skView.scene) {
//        skView.showsFPS = YES;
//        skView.showsNodeCount = YES;
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
    
    self.pauseAlert = [[UIAlertView alloc] initWithTitle:@"Game Paused" message:nil delegate:self cancelButtonTitle:@"Resume" otherButtonTitles:@"Main Menu", nil];
    [self.pauseAlert show];
}

- (void)endGame:(int)score {
    skView.paused = YES;
    
    if(score > [appDelegate highScore]) {
        [self endGameWithHighScore:score];
    } else {
        self.endAlert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:[NSString stringWithFormat:@"Your score was %d.", score] delegate:self cancelButtonTitle:@"Main Menu" otherButtonTitles:nil];
        [self.endAlert show];
    }
}

- (void)endGameWithHighScore:(int)score {
    self.endHighScoreAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"New High Score: %d!", score] message:nil delegate:self cancelButtonTitle:@"Main Menu" otherButtonTitles:nil];
    self.endHighScoreAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [self.endHighScoreAlert textFieldAtIndex:0];
    textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textField.placeholder = @"Name";
    textField.delegate = self;
    [self.endHighScoreAlert show];
    newHighScore = score;
}

#pragma mark - UIAlertViewDelegate Methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView == self.endHighScoreAlert)
    {
        NSString *name = [[alertView textFieldAtIndex:0] text];
        [appDelegate insertIntoDatabase:name andScore:newHighScore];
    }
    
    if((alertView == self.pauseAlert && buttonIndex == 1) ||
       alertView == self.endAlert || alertView == self.endHighScoreAlert)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(alertView == self.pauseAlert && buttonIndex == 0) {
        skView.paused = NO;
    }
}

#pragma mark - UITextFieldDelegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.endHighScoreAlert dismissWithClickedButtonIndex:0 animated:YES];
    [self alertView:self.endHighScoreAlert clickedButtonAtIndex:0];
    return NO;
}

@end
