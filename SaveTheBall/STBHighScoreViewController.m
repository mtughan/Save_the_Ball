//
//  STBHighScoreViewController.m
//  SaveTheBall
//
//  Created by Ricardo Chavez on 2014-03-24.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBHighScoreViewController.h"
#import "STBHighScoreTableViewCell.h"
#import "STBAppDelegate.h"
#import "STBData.h"

@interface STBHighScoreViewController ()
{
    NSArray *highScores;
}
@end

@implementation STBHighScoreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    STBAppDelegate *appDelegate = (STBAppDelegate *)[[UIApplication sharedApplication] delegate];
    highScores = [appDelegate player];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [highScores count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    STBHighScoreTableViewCell *cell = (STBHighScoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HighScore"];
    
    STBData *highScore = [highScores objectAtIndex:indexPath.row];
    cell.name.text = highScore.name;
    cell.score.text = [NSString stringWithFormat:@"%d", highScore.score];
    
    return cell;
}

@end
