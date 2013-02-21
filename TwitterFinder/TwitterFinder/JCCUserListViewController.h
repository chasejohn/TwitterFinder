//
//  JCCUserListViewController.h
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JCCTwitterUserListDataSource.h"
#import "JCCTwitterUserSource.h"

@interface JCCUserListViewController : UITableViewController

@property(nonatomic, strong) id <JCCTwitterUserListDataSource> dataSource;

- (IBAction)done:(UIBarButtonItem *)sender;

@end
