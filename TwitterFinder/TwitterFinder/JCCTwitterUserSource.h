//
//  JCCTwitterUserSource.h
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JCCTwitterUserListDataSource.h"
#import <Accounts/Accounts.h>

@interface JCCTwitterUserSource : NSObject <JCCTwitterUserListDataSource>

@property (nonatomic, retain) NSString * searchParameter;
@property (strong, nonatomic) IBOutlet UITableViewController *userListView;

@end
