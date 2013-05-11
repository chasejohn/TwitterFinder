//
//  JCCTwitterService.m
//  TwitterFinder
//
//  Created by John Chase on 3/24/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import "JCCTwitterService.h"
#import "JCCTwitterUser.h"
#import "Accounts/Accounts.h"
#import "Social/Social.h"

@implementation JCCTwitterService

@synthesize delegate;

- (NSArray *)getUsers:(NSString *)searchParameter {
    NSLog(@"loadUsers start");
    NSMutableArray* users = [[NSMutableArray alloc] init];
    // Request access to the Twitter accounts
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            // Check if the users has setup at least one Twitter account
            if ([accounts count] > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                NSURL *twitterAPIURL = [NSURL URLWithString:@"https://api.twitter.com/1.1/users/search.json"];
                NSDictionary *twitterParams = @ { @"q" : searchParameter , @"page" : @"1" , @"per_page" : @"5" };
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                        requestMethod:SLRequestMethodGET
                                                                  URL:twitterAPIURL
                                                           parameters:twitterParams];
                [request setAccount:twitterAccount];
                [request performRequestWithHandler:^(NSData *responseData,
                                                     NSHTTPURLResponse *urlResponse,
                                                     NSError *error) {
                    [self handleTwitterData:responseData
                                      users:users
                                urlResponse:urlResponse
                                      error:error];
                }];
            }
        } else {
            NSLog(@"No access granted");
        }
    }];
    return users;
}

- (void)handleTwitterData:(NSData *)data
                    users:(NSMutableArray *)users
              urlResponse:(NSHTTPURLResponse *)urlResponse
                    error:(NSError *)error {
    NSError *jsonError = nil;
    NSJSONSerialization *jsonResponse =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:0
                                      error:&jsonError];
    if (!jsonError &&
        [jsonResponse isKindOfClass:[NSArray class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *twits = (NSArray*) jsonResponse;
            twits = [twits sortedArrayWithOptions:NSSortConcurrent usingComparator:
                     ^NSComparisonResult(id obj1, id obj2) {
                         NSString *tweet1 = [obj1 valueForKey:@"screen_name"];
                         NSString *tweet2 = [obj2 valueForKey:@"screen_name"];
                         return [tweet1 compare:tweet2];
                     }];
            
            for (NSDictionary *userDict in twits) {
                NSString *name = [userDict objectForKey:@"name"];
                NSString *screenName = [userDict objectForKey:@"screen_name"];
                NSString *profileImageStringURL = [userDict objectForKey:@"profile_image_url_https"];
                NSURL *url = [NSURL URLWithString:profileImageStringURL];
                NSData *data = [NSData dataWithContentsOfURL:url];
                
                JCCTwitterUser *user = [[JCCTwitterUser alloc] init];
                user.name = name;
                user.screenName = screenName;
                user.image = [UIImage imageWithData:data];
                [users addObject:user];
            }
            
            /*NSLog(@"User array:");
             for (id logUser in users) {
             NSLog([logUser name]);
             } */
            
            if([self.delegate respondsToSelector:@selector(dataLoaded)])
            {
                [self.delegate dataLoaded];
            }
        });
    } else {
        NSLog(@"JSON error or invalid response.");
        NSLog(@"http response code: %i", [urlResponse statusCode]);
    }
}

@end
