//
//  STBHighScoreTableViewCell.h
//  SaveTheBall
//
//  Created by Michael Tughan on 2014-04-14.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STBHighScoreTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *score;

@end
