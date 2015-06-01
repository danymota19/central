//
//  Names.m
//  Examen
//
//  Created by Ruben G Ramos Amezcua on 5/25/15.
//  Copyright (c) 2015 Agustin Castaneda. All rights reserved.
//

#import "Names.h"
#import "Declarations.h"
#import "Exam.h"

@interface Names ()

@end

@implementation Names

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
    
    self.lblFirst.text   = maFirst[self.iPageIndex];
    self.lblSecond.text  = maSecond[self.iPageIndex];
    self.lblMensaje.text = maMensajes[self.iPageIndex];

}

-(void)viewWillAppear:(BOOL)animated
{
    miAppear = (int)self.iPageIndex;
    NSLog(@"numero de pagina %d", miAppear );
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

@end
