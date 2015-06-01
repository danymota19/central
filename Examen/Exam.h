//
//  Exam.h
//  Examen
//
//  Created by Ruben G Ramos Amezcua on 5/25/15.
//  Copyright (c) 2015 Agustin Castaneda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exam : UIViewController

@property (strong, nonatomic) UIPageViewController *pageViewController;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *lblSkip;




//Actions
@property (weak, nonatomic) IBOutlet UIButton *btnSkip;
- (IBAction)btnSkIp:(id)sender;

@end
