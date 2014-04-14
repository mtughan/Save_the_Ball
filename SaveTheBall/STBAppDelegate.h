//
//  STBAppDelegate.h
//  SaveTheBall
//
//  Created by Michael Tughan on 2014-03-17.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STBAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSString *databaseName;
    NSString *databasePath;
    NSMutableArray *player;
    
    UIColor *ballColour;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *databaseName;
@property (strong, nonatomic) NSString *databasePath;
@property (strong, nonatomic) NSMutableArray *player;
@property (readonly, nonatomic) int highScore;

@property (setter = setBallColour:, nonatomic) UIColor *ballColour;

-(void)checkAndCreateDatabase;
-(void)readFromDatabase;
-(void)insertIntoDatabase:(NSString *)name andScore:(int)score;

@end
