//
//  STBOptionsViewController.h
//  SaveTheBall
//
//  Created by Ricardo Chavez on 2014-03-24.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBGameScene.h"

@interface STBOptionsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SKPhysicsContactDelegate>

@property (strong, nonatomic) NSArray *array;

@end
