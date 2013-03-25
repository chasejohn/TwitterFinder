//
//  JCCUserListViewController.h
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JCCTwitterService.h"

@interface JCCUserListViewController : UITableViewController <JCCTwitterDataLoaded>

@property(nonatomic, strong) NSString *searchText;

- (IBAction)done:(UIBarButtonItem *)sender;

@end
