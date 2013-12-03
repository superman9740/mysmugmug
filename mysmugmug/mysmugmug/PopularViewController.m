//
//  PopularViewController.m
//  mysmugmug
//
//  Created by sdickson on 11/21/13.
//  Copyright (c) 2013 dickson. All rights reserved.
//

#import "PopularViewController.h"

@interface PopularViewController ()

@end

@implementation PopularViewController

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

     _feedItems = [[NSMutableArray alloc] init];
    
    NSString* urlString = @"http://api.smugmug.com/hack/feed.mg?Type=popular&Data=all&format=rss";
    
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    

    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
        
         NSString* strings = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
         NSArray* tempArray = [strings componentsSeparatedByString:@"\n"];
         
         NSMutableArray* lines = [NSMutableArray arrayWithArray:tempArray];
         
         [lines removeObjectAtIndex:0];
         NSMutableString* correctedXML = [[NSMutableString alloc] init];
         
         for (NSString* line in lines)
         {
             [correctedXML appendString:line];
             [correctedXML appendString:@"\n"];
             
         }
         
         
         NSData* correctedXMLData = [correctedXML dataUsingEncoding:NSUTF8StringEncoding];
         
         FPFeed* feed = [FPParser parsedFeedWithData:correctedXMLData error:&error];
         NSLog(@"Feed Name:  %@", feed.title);
         NSLog(@"Number of feed items:  %lu", (unsigned long)feed.items.count);
         for (FPItem* item in feed.items)
         {
         
             [_feedItems addObject:item];
             
             
         
         
         dispatch_async(dispatch_get_main_queue(), ^{
             
             
             [self.collectionView reloadData];
             
             
             
             
         });
         
         }
         
         
     }];

    
    
    
    
}
#pragma mark collection view delegate methods
-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    
    
    return _feedItems.count;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PopularCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    FPItem* feedItem = [_feedItems objectAtIndex:indexPath.row];
    cell.imageLink = feedItem.guid;
    UIColor* color = [UIColor blueColor];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell.imageView.image = image;
    
    [cell updateImageInBackground];
    
        
 
  
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
