//
//  JCCViewController.m
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import "JCCViewController.h"

@interface JCCViewController ()
@property (nonatomic, weak) IBOutlet UITextField *searchTextfield;
@end

@implementation JCCViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([@"presentUserList" isEqualToString:segue.identifier]) {
        JCCUserListViewController *userListViewController = segue.destinationViewController;
        userListViewController.searchText = self.searchTextfield.text;
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
