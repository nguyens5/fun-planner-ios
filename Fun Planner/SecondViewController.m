//
//  SecondViewController.m
//  Fun Planner
//
//  Created by Steven Nguyen on 8/20/16.
//  Copyright © 2016 Steven Nguyen. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"data string is %@", self.dataString);
    //_dataShowLabel.text=self.dataString;
    [_marquee.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_marquee.layer setBorderWidth: 2.0];
    [self generateInformation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction) generateInformation {
    @autoreleasepool {
        
        NSString *defaultTerm = @"dinner";
        NSString *defaultLocation = @"Los Angeles, CA";
        if ([_activityRetrieved length] != 0) {
            defaultTerm = _activityRetrieved;
        }
        if ([_cityRetrieved length] != 0) {
            defaultLocation = _cityRetrieved;
        }
        
        //Get the term and location from the command line if there were any, otherwise assign default values.
        NSString *term = [[NSUserDefaults standardUserDefaults] valueForKey:@"term"] ?: defaultTerm;
        NSString *location = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"] ?: defaultLocation;
        
        YPAPISample *APISample = [[YPAPISample alloc] init];
        
        dispatch_group_t requestGroup = dispatch_group_create();
        
        dispatch_group_enter(requestGroup);
        [APISample queryTopBusinessInfoForTerm:term location:location completionHandler:^(NSDictionary *topBusinessJSON, NSError *error) {
            
            if (error) {
                NSLog(@"An error happened during the request: %@", error);
            } else if (topBusinessJSON) {
                NSLog(@"Top business info: \n %@", topBusinessJSON);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.name.text = topBusinessJSON[@"name"];
                    self.reviewCount.text = [topBusinessJSON[@"review_count"] stringValue];
                    _websiteURL = topBusinessJSON[@"mobile_url"];
                });
                
                
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: topBusinessJSON[@"image_url"]]];
                    if ( data == nil )
                        return;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // WARNING: is the cell still using the same data by this point??
                        _marquee.image = [UIImage imageWithData: data];
                    });
                    //[data release];
                });
                
                
                dispatch_async(dispatch_get_global_queue(0,0), ^{
                    NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: topBusinessJSON[@"rating_img_url"]]];
                    if ( data == nil )
                        return;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // WARNING: is the cell still using the same data by this point??
                        _rating.image = [UIImage imageWithData: data];
                    });
                    //[data release];
                });
            } else {
                NSLog(@"No business was found");
            }
            
            dispatch_group_leave(requestGroup);
        }];
        
        dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.
    }
    
}

-(IBAction)redirect {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: _websiteURL]];
}

@end
