//
//  STBData.h
//  SaveTheBall
//
//  Created by Kody Wu on 2014-04-11.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STBData : NSObject
{
    NSString *name;
    NSString *score;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *score;

-(id)initWithData:(NSString *)name_data andScore: (NSString *)score_data;

@end
