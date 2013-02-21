//
//  JCCTwitterUserSource.m
//  TwitterContactFinder
//
//  Created by John Chase on 2/12/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import "JCCTwitterUserSource.h"
#import "JCCTwitterUser.h"
#import "Social/Social.h"

@interface JCCTwitterUserSource()

-(void) loadUsers;
-(void) handleTwitterData: (NSData*) data
              urlResponse: (NSHTTPURLResponse*) urlResponse
                    error: (NSError*) error;

@property(nonatomic, strong) NSMutableArray *users;

@end


@implementation JCCTwitterUserSource

@synthesize searchParameter;
@synthesize userListView;

- (NSArray *)users {
    if(!_users) {
        self.users = [NSMutableArray array];
        [self loadUsers];
    }
    return _users;
}

- (NSInteger)userCount {
    return [self.users count];
}

- (JCCTwitterUser *)userAtIndex:(NSInteger)index {
    return [self.users objectAtIndex:index];
}

-(void) loadUsers {self.users = [NSMutableArray array];
    NSLog(@"loadUsers start");
    // Request access to the Twitter accounts
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            // Check if the users has setup at least one Twitter account
            if (accounts.count > 0)
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
                                urlResponse:urlResponse
                                      error:error];
                    }];
            }
        } else {
            NSLog(@"No access granted");
        }
    }];
}

-(void) handleTwitterData: (NSData*) data
              urlResponse: (NSHTTPURLResponse*) urlResponse
                    error: (NSError*) error {        
    NSError *jsonError = nil;
    NSJSONSerialization *jsonResponse =
    [NSJSONSerialization JSONObjectWithData:data
                                    options:0
                                      error:&jsonError];
    if (!jsonError &&
        [jsonResponse isKindOfClass:[NSArray class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *users = (NSArray*) jsonResponse;
            users = [users sortedArrayWithOptions:NSSortConcurrent usingComparator:
                      ^NSComparisonResult(id obj1, id obj2) {
                          NSString *tweet1 = [obj1 valueForKey:@"screen_name"];
                          NSString *tweet2 = [obj2 valueForKey:@"screen_name"];
                          return [tweet1 compare:tweet2];
                      }];
            
            for (NSDictionary *userDict in users) {
                NSString *name = [userDict objectForKey:@"name"];
                NSString *screenName = [userDict objectForKey:@"screen_name"];
                NSString *profileImageStringURL = [userDict objectForKey:@"profile_image_url_https"];
                NSURL *url = [NSURL URLWithString:profileImageStringURL];
                NSData *data = [NSData dataWithContentsOfURL:url];
                
                JCCTwitterUser *user = [[JCCTwitterUser alloc] init];
                user.name = name;
                user.screenName = screenName;
                user.image = [UIImage imageWithData:data];
                [self.users addObject:user];
            }            
            
            /*NSLog(@"User array:");
            for (id logUser in self.users) {
                NSLog([logUser name]);
            } */

            [self.userListView.tableView reloadData];
        });
    } else {
        NSLog(@"JSON error or invalid response.");
        NSLog(@"http response code: %i", [urlResponse statusCode]);
    }
}


@end
