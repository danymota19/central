//
//  Names.h
//  Examen
//
//  Created by Ruben G Ramos Amezcua on 5/25/15.
//  Copyright (c) 2015 Daniela Mota / Ruben Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Names : UIViewController

@property NSUInteger    iPageIndex;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *lblFirst;
@property (weak, nonatomic) IBOutlet UILabel *lblSecond;
@property (weak, nonatomic) IBOutlet UILabel *lblMensaje;

@end
