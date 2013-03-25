//
//  JCCTwitterService.h
//  TwitterFinder
//
//  Created by John Chase on 3/24/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Accounts/Accounts.h>

@protocol JCCTwitterDataLoaded <NSObject>
@optional
-(void)dataLoaded;

@end

@interface JCCTwitterService : NSObject

-(NSMutableArray*) getUsers: (NSString*) searchParameter;

@property (nonatomic, assign) id  <JCCTwitterDataLoaded> delegate;

@end
