//
//  Declarations.h
//  Examen
//
//  Created by Agustin Castaneda on 21/05/15.
//  Copyright (c) 2015 Agustin Castaneda. All rights reserved.
//

#import <Foundation/Foundation.h>

//Names and Images
#define     nInitialNames       @"Daniela", @"Agustin",@"Ramon",nil
#define     nInitialsImages     @"1_circle-32.png", @"2_circle-32.png",@"3_circle-32.png",nil
#define     nTutorialfirst     @"IOS Exam", @"Daniela Mota", @"",nil
#define     nTutorialsecond    @"25/05/2015", @"Ruben Ramos",@"SALUDOS",nil
#define     nMensaje           @"",@"",@"Yo solo se que no se nada",nil
#define     ninitialLatitud    @"19.2602",nil
#define     ninitialLongitud   @"-99.0826", nil
#define     ninitialLocation   @"Torre Latinoamericana", nil

//#define     ninitialLatitud    19.2602f,nil

//Cells features
#define     nCellStatesHeight   64


//Colors
#define     nBlackTransparency  colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.50

//Employees
extern NSMutableArray *maNames;
extern NSMutableArray *maImages;

//Tutorial
extern NSMutableArray *maFirst;
extern NSMutableArray *maSecond;
extern NSMutableArray *maMensajes;
extern int            miIndex;
extern int            miAppear;

//Maps
extern NSMutableArray       *maLatitude;
extern NSMutableArray       *maLongitude;
//extern NSNumber         *maLatitude;
extern NSMutableArray   *maLocation;




extern NSUserDefaults *mUserDefaults;


@interface Declarations : NSObject

@end
