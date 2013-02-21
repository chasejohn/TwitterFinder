//
//  JCCTwitterUser.m
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import "JCCTwitterUser.h"

@implementation JCCTwitterUser

-(id)init {
    self = [super init];
    if(self) {
        self.name = @"Unknown";
    }
    return self;
}

@end
