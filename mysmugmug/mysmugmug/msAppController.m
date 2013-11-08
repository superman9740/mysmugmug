//
//  msAppController.m


#import "msAppController.h"


static msAppController *sharedInstance = nil;



@implementation msAppController


+ (msAppController *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}


- (id)init
{
    self = [super init];
    
    if (self) {
        
        
    }
    
    return self;
}



-(bool)checkForAuthorizedToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _authorizedAccessTokenID  = [defaults objectForKey:@"authorizedTokenID"];
    _authorizedAccessSecret   = [defaults objectForKey:@"authorizedSecret"];
    
    if(_authorizedAccessTokenID != nil)
        return true;
    else
        return false;
    
    
}

-(void)saveAuthorizedToken
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_authorizedAccessTokenID forKey:@"authorizedTokenID"];
    [defaults setObject:_authorizedAccessSecret forKey:@"authorizedSecret"];
    [defaults synchronize];
    

    
}


@end
