//
//  STBData.m
//  SaveTheBall
//
//  Created by Kody Wu on 2014-04-11.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBData.h"

@implementation STBData
@synthesize name, score;
-(id)initWithData:(NSString *)name_data andScore: (NSString *)score_data
{
    if(self=[self init])
    {
        [self setName:name_data];
        [self setScore:score_data];
    }
    return self;
}

@end
