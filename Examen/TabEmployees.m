//
//  TabEmployees.m
//  Examen
//
//  Created by Agustin Castaneda on 21/05/15.
//  Copyright (c) 2015 Agustin Castaneda. All rights reserved.
//

#import "TabEmployees.h"
#import "cellEmployees.h"
#import "Declarations.h"

@interface TabEmployees ()

@end

@implementation TabEmployees

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initController
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(Tab01Active:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    mUserDefaults   = [NSUserDefaults standardUserDefaults];
    
    
    if (!(nil == [mUserDefaults objectForKey:@"permNames"]) && !([@"" isEqual:[mUserDefaults objectForKey:@"permNames"]]))
    {//Case when varaibel has some value in permanent phone memory
        maNames    = [mUserDefaults objectForKey:@"permNames"];
    }
    else
    {//No info has been stored before
        maNames        = [NSMutableArray arrayWithObjects: nInitialNames];
    }
    //-----------------------------------------
    if (!(nil == [mUserDefaults objectForKey:@"permImages"]) && !([@"" isEqual:[mUserDefaults objectForKey:@"permImages"]]))
    {//Case when varaibel has some value in permanent phone memory
        maImages    = [mUserDefaults objectForKey:@"permImages"];
    }
    else
    {//No info has been stored before
        maImages        = [NSMutableArray arrayWithObjects: nInitialsImages];
        NSLog(@"maNames %@", maNames );
    }
    
    [self.tblEmployees reloadData];
}
- (void)Tab01Active:(NSNotification *)notification
{
    NSLog(@"Tab01Active");
}
/******************************************************************************
 Table functions
 ******************************************************************************/
//-----------------------------------------
//Table functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return maNames.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nCellStatesHeight;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellStates");
    static NSString *CellIdentifier = @"cellEmployees";
    
    cellEmployees *cell = (cellEmployees *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[cellEmployees alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.lblName.text          = maNames[indexPath.row];
    cell.imgEmployees.image    = [UIImage imageNamed:maImages[indexPath.row]];
    return cell;
}

- (IBAction)btnAddPressed:(id)sender
{
    [self.tblEmployees reloadData];
    [self createPopin];
}
/**********************************************************************************************
 Popin View Controller
 **********************************************************************************************/
- (void) createPopin
{//-------------------------------------------------------------------------------
    PopinEmployees *popin = [[PopinEmployees alloc] init];
    [popin setPopinTransitionStyle:BKTPopinTransitionStyleZoom];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [popin setPopinAlignment:0];
    
    BKTBlurParameters *blurParameters       = [BKTBlurParameters new];
    blurParameters.alpha                    = 1.0f;
    blurParameters.radius                   = 8.0f;
    blurParameters.saturationDeltaFactor    = 1.8f;
    blurParameters.tintColor                = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:255/255.0 alpha:0.50];
    [popin setBlurParameters:blurParameters];
    [popin setPopinOptions:[popin popinOptions]|BKTPopinBlurryDimmingView];
    [popin setPreferedPopinContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [popin setPopinTransitionDirection:BKTPopinTransitionDirectionTop];
    [self presentPopinController:popin animated:YES completion:nil];
}



@end
