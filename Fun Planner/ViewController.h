//
//  ViewController.h
//  Fun Planner
//
//  Created by Steven Nguyen on 8/20/16.
//  Copyright © 2016 Steven Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewController.h"

@interface ViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate>

-(IBAction)tapped;

@property (weak, nonatomic) IBOutlet UITextField *inputDataTextField;


@property (weak, nonatomic) IBOutlet UITextField *city;

@property (weak, nonatomic) IBOutlet UITextField *activity;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end

