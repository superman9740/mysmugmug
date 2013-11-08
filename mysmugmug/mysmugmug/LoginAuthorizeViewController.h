//
//  LoginAuthorizeViewController.h
//  mysmugmug
//
//  Created by sdickson on 11/4/13.
//  Copyright (c) 2013 dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "msAppController.h"

@interface LoginAuthorizeViewController : UIViewController<UIWebViewDelegate>

{
    
    
    NSString* requestTokenID;
    NSString* requestSecret;
    
    
    
    
}

@property (nonatomic, strong) IBOutlet UIWebView* webView;


@end
