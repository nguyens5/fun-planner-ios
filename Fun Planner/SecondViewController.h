//
//  SecondViewController.h
//  Fun Planner
//
//  Created by Steven Nguyen on 8/20/16.
//  Copyright © 2016 Steven Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "YPAPISample.h"

@interface SecondViewController : UIViewController

@property(strong,nonatomic)NSString *cityRetrieved;
@property(strong,nonatomic)NSString *activityRetrieved;
@property(strong,nonatomic)NSString *websiteURL;

@property (nonatomic, strong) IBOutlet UILabel *greetingId;
@property (nonatomic, strong) IBOutlet UILabel *greetingContent;

@property (nonatomic, strong) IBOutlet UILabel *name;
@property (nonatomic, strong) IBOutlet UILabel *reviewCount;

@property (weak, nonatomic) IBOutlet UIImageView *rating;
@property (weak, nonatomic) IBOutlet UIImageView *marquee;


-(IBAction) generateInformation;
-(IBAction) redirect;

@end
