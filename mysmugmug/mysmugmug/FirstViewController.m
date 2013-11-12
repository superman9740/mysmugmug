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
                           
             
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
               
                 
                 
                 
             });
             
         }
         
         
     }];
    
    
    



}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[[ttAppController sharedInstance] trails] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    ttTrail* trail = [[[ttAppController sharedInstance] trails] objectAtIndex:indexPath.row];
    if(trail.images.count > 0)
    {
        [cell.imageView setImage:[trail.images objectAtIndex:0]];
        
    }
    
    cell.textLabel.text = trail.name;
    cell.detailTextLabel.text = trail.desc;
    
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ttTrail* trail = [[[ttAppController sharedInstance] trails] objectAtIndex:indexPath.row];
    
    [[ttAppController sharedInstance] setCurrentTrail:trail];
    [self performSegueWithIdentifier:@"showNewTrip" sender:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
