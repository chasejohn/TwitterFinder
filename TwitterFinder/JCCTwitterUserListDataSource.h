//
//  JCCTwitterUserListDataSource.h
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JCCTwitterUser;

@protocol JCCTwitterUserListDataSource <NSObject>
- (NSInteger)userCount;
- (JCCTwitterUser *)userAtIndex:(NSInteger)index;

@end
