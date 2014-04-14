//
//  STBNavigationViewController.m
//  SaveTheBall
//
//  Created by Michael Tughan on 2014-04-14.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBNavigationController.h"

@implementation STBNavigationController

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
