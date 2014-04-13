//
//  STBSocialViewController.m
//  SaveTheBall
//
//  Created by Kody Wu on 2014-03-23.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBSocialViewController.h"

@interface STBSocialViewController ()

@end

@implementation STBSocialViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)facebook:(id)sender {
    myFacebook = [[SLComposeViewController alloc]init];
    myFacebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [myFacebook setInitialText:@"STB is a great game!"];
    [self presentViewController:myFacebook animated:YES completion:nil];
}

- (IBAction)twitter:(id)sender {
    myTwitter = [[SLComposeViewController alloc]init];
    myTwitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [myTwitter setInitialText:@"STB is a great game!"];
    [self presentViewController:myTwitter animated:YES completion:nil];
}
@end
