//
//  TabEmployees.h
//  Examen
//
//  Created by Daniela Mota / Ruben Ramos on 21/05/15.
//  Copyright (c) 2015 Daniela Mota / Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MaryPopin.h"
@interface TabEmployees : UIViewController<UITableViewDelegate, UITableViewDataSource>

//Table
@property (weak, nonatomic) IBOutlet UITableView *tblEmployees;

//Actions
- (IBAction)btnAddPressed:(id)sender;

@end
