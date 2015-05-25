//
//  TabEmployees.h
//  Examen
//
//  Created by Agustin Castaneda on 21/05/15.
//  Copyright (c) 2015 Agustin Castaneda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MaryPopin.h"
#import "PopinEmployees.h"
@interface TabEmployees : UIViewController<UITableViewDelegate, UITableViewDataSource>

//Table
@property (weak, nonatomic) IBOutlet UITableView *tblEmployees;

//Actions
- (IBAction)btnAddPressed:(id)sender;

@end
