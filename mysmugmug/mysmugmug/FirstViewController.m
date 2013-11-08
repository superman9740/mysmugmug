//
//  FirstViewController.m
//  mysmugmug
//
//  Created by sdickson on 11/4/13.
//  Copyright (c) 2013 dickson. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    NSString* consumer_key = @"amUgkwNe4QUZMuAUxkiDz2xB4gUWBk8z";
    NSString* consumer_secret_key = @"141d0211d72720d9cb58fb63bee7e2d8";
    NSString* signature_method = @"PLAINTEXT";
    NSString* method = @"smugmug.categories.get";
    NSString* version = @"1.0";
    NSString* nonce = @"123458712454kjj";
    NSMutableString* signature = [NSMutableString stringWithString:@"141d0211d72720d9cb58fb63bee7e2d8%26"];
    [signature appendString:[[msAppController sharedInstance] authorizedAccessSecret]];
    
    int timeStamp = [[NSDate date] timeIntervalSince1970];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.smugmug.com/services/api/json/1.3.0/"]]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post = [NSString stringWithFormat:@"oauth_consumer_key=%@&oauth_token=%@&method=%@&oauth_signature_method=%@&oauth_version=%@&oauth_nonce=%@&oauth_signature=%@&oauth_timestamp=%d",consumer_key,[[msAppController sharedInstance] authorizedAccessTokenID], method, signature_method,version,nonce,signature, timeStamp];
    
    
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
             
                         
             
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
               
                 
                 
                 
             });
             
         }
         
         
     }];
    
    
    



}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
