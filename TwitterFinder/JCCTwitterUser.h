//
//  JCCTwitterUser.h
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JCCTwitterUser : NSObject


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *screenName;
@property (nonatomic, strong) UIImage *image;


@end
