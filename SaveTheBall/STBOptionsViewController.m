//
//  STBOptionsViewController.m
//  SaveTheBall
//
//  Created by Ricardo Chavez on 2014-03-24.
//  Copyright (c) 2014 Spiral Iris Software. All rights reserved.
//

#import "STBOptionsViewController.h"
#import "STBGameScene.h"

@interface STBOptionsViewController ()
    
@end

@implementation STBOptionsViewController


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
    self.array = [[NSArray alloc]initWithObjects:@"1", @"2", @"3", @"4",@"5",@"6", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if(indexPath.row == 0){
        cell.backgroundColor = [UIColor redColor];
        
    }
    else if(indexPath.row == 1){
        cell.backgroundColor = [UIColor blueColor];

    }
    else if(indexPath.row == 2){
        cell.backgroundColor = [UIColor purpleColor];
        
    }
    else if(indexPath.row == 3){
        cell.backgroundColor = [UIColor orangeColor];
        
    }
    else if(indexPath.row == 4){
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    else if(indexPath.row == 5){
        cell.backgroundColor = [UIColor magentaColor];
        
    }
    //cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    //cell.backgroundColor = [UIColor whiteColor];
    //cell.accessoryType = UITableViewCellAccessoryDetailButton;
    return cell;
}

//if you click on a cell what do you do
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //SKShapeNode *ball;
    STBGameScene *stbGame;
    stbGame = [[STBGameScene alloc]init];
    stbGame.ball.fillColor = [SKColor whiteColor];
    NSLog(@"CLICKED");
    
    //stbGame.ball = [[SKShapeNode alloc] init];
    //stbGame.ball.fillColor = [SKColor whiteColor];
    
    
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

@end
