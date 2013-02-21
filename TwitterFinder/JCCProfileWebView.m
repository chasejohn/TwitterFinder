//
//  JCCProfileWebView.m
//  TwitterContactFinder
//
//  Created by John Chase on 2/17/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import "JCCProfileWebView.h"

@implementation JCCProfileWebView

@synthesize profileWebView;
@synthesize screenName;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.twitter.com/%@", screenName]];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.profileWebView loadRequest:requestURL];
    self.navigationItem.title = screenName;
}

- (IBAction)followUser:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:screenName message:@"Really Follow?" delegate:self cancelButtonTitle:CANCEL_KEY otherButtonTitles:OK_KEY, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:CANCEL_KEY])
    {
        NSLog(@"Cancel was selected.");
    }
    else if([title isEqualToString:OK_KEY])
    {
        NSLog(@"OK was selected.");
        //TODO call https://api.twitter.com/1.1/friendships/create.json
        // https://dev.twitter.com/docs/api/1.1/post/friendships/create
        //TODO centralize all twitter api calls to one class
    }
}

@end
