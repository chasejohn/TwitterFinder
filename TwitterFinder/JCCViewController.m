//
//  JCCViewController.m
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import "JCCViewController.h"
#import "JCCTwitterUserSource.h"

@interface JCCViewController ()

@end

@implementation JCCViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"presentUserList" isEqualToString:segue.identifier]) {        
        UIViewController *topVC = [[segue destinationViewController]
                                   topViewController];
        JCCUserListViewController *userListViewController =
        (JCCUserListViewController *)topVC;
        JCCTwitterUserSource *userSource = [[JCCTwitterUserSource alloc] init];
        [userSource setSearchParameter:searchTextfield.text];
        [userListViewController setDataSource:userSource];
        [userSource setUserListView:userListViewController];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
