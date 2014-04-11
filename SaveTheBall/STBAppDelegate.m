//
//  STBAppDelegate.m
//  SaveTheBall
//
//  Created by Michael Tughan on 2014-03-17.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBAppDelegate.h"
#import <sqlite3.h>
#import "STBData.h"

@implementation STBAppDelegate
@synthesize databaseName, databasePath, player;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.databaseName = @"STB.DB";
    self.player = [[NSMutableArray alloc] init];
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    // check if databae is created
    [self checkAndCreateDatabase];
    
    // read data from the database
    [self readFromDatabase];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Database Methods

// Check and Create Database
-(void)checkAndCreateDatabase
{
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:self.databasePath];
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

// Read Users in Database
-(void)readFromDatabase
{
    [self.player removeAllObjects];
    sqlite3 *database;
    
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sqlStatement = "SELECT * FROM players";
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare(database, sqlStatement, -1, &compiledStatement, NULL)==SQLITE_OK)
        {
            while(sqlite3_step(compiledStatement)==SQLITE_ROW)
            {
                NSString *name = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledStatement, 1)];
                NSString *score = [NSString stringWithUTF8String:(char*)sqlite3_column_text(compiledStatement, 2)];
                STBData *data = [[STBData alloc] initWithData:name andScore:score];
                [self.player addObject:data];
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

// Insert Users into Database
-(void)insertIntoDatabase:(NSString *)name andScore:(NSString *)score;
{
    sqlite3 *database;
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        const char *sqlStatement = "INSERT INTO user (name, score) VALUES (?, ?);";
        sqlite3_stmt *compiledStatement;
        int retval = sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL);
        if (retval == SQLITE_OK)
        {
            sqlite3_bind_text(compiledStatement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 2, [score UTF8String], -1, SQLITE_TRANSIENT);
            
            // For debugging
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SQL Insert" message:@"Score added" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        
        if(sqlite3_step(compiledStatement) != SQLITE_DONE)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SQL Insert" message:@"Error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            
            [alert show];
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

@end
