//
//  FirstViewController.h
//  mysmugmug
//
//  Created by sdickson on 11/4/13.
//  Copyright (c) 2013 dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginAuthorizeViewController.h"
#import "msAppController.h"
@import AdSupport;
@import iAd;


@interface FirstViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    
    
    
}


@property (nonatomic, strong) IBOutlet UITableView* tableView;


@end
