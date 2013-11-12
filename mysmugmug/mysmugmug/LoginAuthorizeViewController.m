//
//  LoginAuthorizeViewController.m
//  mysmugmug
//
//  Created by sdickson on 11/4/13.
//  Copyright (c) 2013 dickson. All rights reserved.
//

#import "LoginAuthorizeViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface LoginAuthorizeViewController ()

@end

@implementation LoginAuthorizeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString* consumer_key = @"amUgkwNe4QUZMuAUxkiDz2xB4gUWBk8z";
    
    NSString* signature_method = @"PLAINTEXT";
    NSString* method = @"smugmug.auth.getRequestToken";
    NSString* version = @"1.0";
    NSString* nonce = @"123458712454kjj";
    NSString* signature = @"141d0211d72720d9cb58fb63bee7e2d8%26&";
    int timeStamp = [[NSDate date] timeIntervalSince1970];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.smugmug.com/services/api/json/1.3.0/"]]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [NSString stringWithFormat:@"oauth_consumer_key=%@&method=%@&oauth_signature_method=%@&oauth_version=%@&oauth_nonce=%@&oauth_signature=%@&oauth_timestamp=%d",consumer_key,method, signature_method,version,nonce,signature, timeStamp];
    //post = [post stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    [request setHTTPBody:postData];

    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if ([data length] > 0 && error == nil)
         {
             NSString* string = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
             NSLog(@"Request return value:  %@", string);
             NSDictionary* dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
         
             NSDictionary* auth = [dict valueForKey:@"Auth"];
             NSDictionary* token = [auth valueForKey:@"Token"];
             requestTokenID = token[@"id"];
             requestSecret  = token[@"Secret"];
             
             
             
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 NSString* authorizeURL = [NSString stringWithFormat:@"https://api.smugmug.com/services/oauth/authorize.mg?oauth_token=%@&Access=Full&Permissions=Add",requestTokenID];
                 NSURL *url = [NSURL URLWithString:authorizeURL];
                  NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
                  [_webView loadRequest:requestObj];
                 
                 
             });

         }
         
    
     }];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    NSString *html = [webView stringByEvaluatingJavaScriptFromString:
                      @"document.body.innerHTML"];
    NSLog(@"Load finished.  %@",html);
    //was not authorized
    //was added to your Authorized Applications
    
    if([html rangeOfString:@"was not authorized"].location != NSNotFound)
    {
        //We were not authorized
    }
    else if([html rangeOfString:@"was added"].location != NSNotFound)
    {
        NSString* consumer_key = @"amUgkwNe4QUZMuAUxkiDz2xB4gUWBk8z";
        NSString* signature_method = @"PLAINTEXT";
        NSString* method = @"smugmug.auth.getAccessToken";
        NSString* version = @"1.0";
        NSString* nonce = @"123458712454kjj";
        NSMutableString* signature = [NSMutableString stringWithString:@"141d0211d72720d9cb58fb63bee7e2d8%26"];
        [signature appendString:requestSecret];
        int timeStamp = [[NSDate date] timeIntervalSince1970];
        
        
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.smugmug.com/services/api/json/1.3.0/"]]];
        [request setHTTPMethod:@"POST"];
        
        NSString *post = [NSString stringWithFormat:@"oauth_consumer_key=%@&oauth_token=%@&method=%@&oauth_signature_method=%@&oauth_version=%@&oauth_nonce=%@&oauth_signature=%@&oauth_timestamp=%d",consumer_key,requestTokenID, method, signature_method,version,nonce,signature, timeStamp];
        
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
        [request setHTTPBody:postData];
        
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             
             if ([data length] > 0 && error == nil)
             {
                 NSString* string = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
                 NSLog(@"Request return value:  %@", string);
                 NSDictionary* dict =  [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                 
                 NSDictionary* auth = [dict valueForKey:@"Auth"];
                 NSDictionary* token = [auth valueForKey:@"Token"];
                 NSString* temp1 = token[@"id"];
                 NSString* temp2 = token[@"Secret"];
                 
                 [[msAppController sharedInstance] setAuthorizedAccessTokenID:temp1];
                 [[msAppController sharedInstance] setAuthorizedAccessSecret:temp2];
                 
                 [[msAppController sharedInstance] saveAuthorizedToken];
                 
                                 
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                    
                     [self performSegueWithIdentifier:@"showMain" sender:self];

                     
                     
                 });
                 
             }
             
             
         }];
        

        
    }
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
