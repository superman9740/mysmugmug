//
//  PopularCollectionViewCell.h
//  mysmugmug
//
//  Created by sdickson on 11/21/13.
//  Copyright (c) 2013 dickson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopularCollectionViewCell : UICollectionViewCell
{
    
    
}

@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) NSString* imageLink;


-(void)updateImageInBackground;

@end
