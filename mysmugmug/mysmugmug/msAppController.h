//
//  msAppController.h
//  

#import <Foundation/Foundation.h>



//static NSString* const kshowAvailableAppsNotification  = @"showAvailableAppsNotification";


@interface msAppController : NSObject
{

    
    
}
@property (nonatomic, strong) NSString* authorizedAccessTokenID;
@property (nonatomic, strong) NSString* authorizedAccessSecret;

+ (id)sharedInstance;

-(bool)checkForAuthorizedToken;

-(void)saveAuthorizedToken;



@end
