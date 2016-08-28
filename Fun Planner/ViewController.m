//
//  ViewController.m
//  Fun Planner
//
//  Created by Steven Nguyen on 8/20/16.
//  Copyright © 2016 Steven Nguyen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setupx after loading the view, typically from a nib.
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.google.com"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapped {
    [self performSegueWithIdentifier:@"idSegue" sender:self];
    [self textFieldShouldReturn:_city];
    [self textFieldShouldReturn:_activity];
}

- (void)prepareForSegue:(UIStoryboardSegue *) segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"idSegue"])
    {
        SecondViewController *secondVC=(SecondViewController *)segue.destinationViewController;
        secondVC.cityRetrieved=self.city.text;
        secondVC.activityRetrieved=self.activity.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
