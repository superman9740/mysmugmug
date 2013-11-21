//
//  PopularCollectionViewCell.m
//  mysmugmug
//
//  Created by sdickson on 11/21/13.
//  Copyright (c) 2013 dickson. All rights reserved.
//

#import "PopularCollectionViewCell.h"

@implementation PopularCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)updateImageInBackground
{
    
    NSURL *imageURL = [NSURL URLWithString:_imageLink];
    NSURLRequest* request = [NSURLRequest requestWithURL:imageURL];
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
    
         dispatch_async(dispatch_get_main_queue(), ^{

             UIImage* image = [UIImage imageWithData:data];
             _imageView.image = image;

             
             
             
         });

         
         
         }];
    
     
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
