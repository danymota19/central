//
// The MIT License (MIT)
//
// Copyright (c) 2013 Backelite
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "PopinMaps.h"

#define nTextEmpty              0
#define nTextNoEmpty            1

#define nTxtLocationMaxLenght    50
#define nTxtLatitudeMaxLenght     10
#define nTxtLongitudeMaxLenght    10


int     iKeyboardHeight2;
int     iKeyboardWidth2;

BOOL    boAllTxts2       = nTextEmpty;
BOOL    boTxtLocation      = nTextEmpty;
BOOL    boTxtLatitude    = nTextEmpty;
BOOL    boTxtLongitude         = nTextEmpty;




@interface PopinMaps ()
@end

@implementation PopinMaps

//-------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"PopinBuyTicket viewDidLoad");
}
//-------------------------------------------------------------------------------
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initViewController];
}
/**********************************************************************************************
 Initialization
 **********************************************************************************************/
- (void) initViewController
{
    //Add a notification to let app know when the keyboard appears, so the texts move accordingly
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    
    self.vMain.layer.borderColor  = [UIColor clearColor].CGColor;
    self.vMain.layer.borderWidth  = 1.0;
    self.vMain.clipsToBounds      = YES;
    self.vMain.layer.cornerRadius = 8;

}
/**********************************************************************************************
 Keyboard appears and disappears
 **********************************************************************************************/
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@"keyboardDidShow");
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    iKeyboardHeight2     = MIN(keyboardSize.height,keyboardSize.width);
    iKeyboardWidth2      = MAX(keyboardSize.height,keyboardSize.width);
    
    NSLog(@"height = %d, width  %d", iKeyboardHeight2, iKeyboardWidth2);
    
    if (self.txtLocation.isEditing)
    {
        self.svMain.contentSize = CGSizeMake(self.svMain.frame.size.width, self.svMain.frame.size.height + iKeyboardHeight2/2  + 10);
        
        [self.svMain setContentOffset: CGPointMake(0, 124) animated:YES];
    }
    else
    {
        self.svMain.contentSize = CGSizeMake(self.svMain.frame.size.width, self.svMain.frame.size.height + iKeyboardHeight2/2  + 10);
        
        [self.svMain setContentOffset: CGPointMake(0,iKeyboardHeight2 - (self.view.frame.size.height - self.vMain.frame.size.height)/2 + 10)  animated:YES];
    }
}
/**********************************************************************************************
 Text Fields
 **********************************************************************************************/
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int x = (int)range.length;
    NSLog(@"x = %d", x);
    
    NSLog(@"Some text changed");
    if (textField == self.txtLocation)
    {
        NSLog(@"txtLocation");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtLocation      = nTextNoEmpty;
            self.txtLocation.backgroundColor = [UIColor lightGrayColor];
            if ([newString length] > nTxtLocationMaxLenght)
            {
                return NO;
            }
        }
        else
        {
            boTxtLocation      = nTextEmpty;
        }
        return YES;
    }
    else if (textField == self.txtLatitude)
    {
        NSLog(@"txtLatitude");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtLatitude      = nTextNoEmpty;
            self.txtLatitude.backgroundColor = [UIColor lightGrayColor];
            if ([newString length] > nTxtLatitudeMaxLenght)
            {
                return NO;
            }
        }
        else
        {
            boTxtLatitude      = nTextEmpty;
        }
        return YES;
    }
    else if (textField == self.txtLongitude)
    {
        NSLog(@"txtLongitude");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtLongitude         = nTextNoEmpty;
            self.txtLongitude.backgroundColor = [UIColor lightGrayColor];
            if ([newString length] > nTxtLongitudeMaxLenght)
            {
                return NO;
            }
        }
        else
        {
            boTxtLongitude      = nTextEmpty;
        }
        return YES;
    }
     return NO;
}
/**********************************************************************************************
 Buttons functions
 **********************************************************************************************/
- (IBAction)btnCancelPressed2:(id)sender
{
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:nil];
}

- (IBAction)btnSavePressed2:(id)sender
{
    if ((boTxtLatitude == nTextEmpty) || (boTxtLocation == nTextEmpty) || (boTxtLongitude == nTextEmpty)   )
    {//At least one of the text is empty
        if (boTxtLocation == nTextEmpty)
        {
            self.txtLocation.backgroundColor = [UIColor redColor];
        }
        if (boTxtLatitude == nTextEmpty)
        {
            self.txtLatitude.backgroundColor = [UIColor redColor];
        }
        if (boTxtLongitude == nTextEmpty)
        {
            self.txtLongitude.backgroundColor = [UIColor redColor];
        }
        
    }
    else
    {//All text have info
        NSLog(@"Ready for saving");
        
        maLocation        = [[NSMutableArray arrayWithArray:maLocation] mutableCopy];
        [maLocation addObject:self.txtLocation.text];
        
        
        maLatitude     = [[NSMutableArray arrayWithArray:maLatitude] mutableCopy];
        [maLatitude addObject:self.txtLatitude.text];
        
        maLongitude            = [[NSMutableArray arrayWithArray:maLongitude] mutableCopy];
        [maLongitude addObject:self.txtLongitude.text];
        
      
        
        [mUserDefaults setObject: maLocation forKey: @"permLocation"];
        [mUserDefaults setObject: maLatitude forKey: @"permLatitude"];
        [mUserDefaults setObject: maLongitude forKey: @"permLongitude"];
        
        
        NSLog(@"permLocation = %@", [mUserDefaults objectForKey:@"permLocation"]);
        NSLog(@"permLatitude = %@", [mUserDefaults objectForKey:@"permLatitude"]);
        NSLog(@"permLongitude = %@", [mUserDefaults objectForKey:@"permLongitude"]);
        
        
        [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:nil];
    }
    
}










@end
