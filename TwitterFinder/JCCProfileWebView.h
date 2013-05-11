//
//  JCCProfileWebView.h
//  TwitterContactFinder
//
//  Created by John Chase on 2/17/13.
//  Copyright (c) 2013 John Chase. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCCProfileWebView : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, weak) IBOutlet UIWebView *profileWebView;

#define CANCEL_KEY @"Cancel"
#define OK_KEY @"OK"

@end

