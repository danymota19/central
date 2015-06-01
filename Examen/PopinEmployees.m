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

#import "PopinEmployees.h"
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "cellEmployees.h"
#import "Declarations.h"

#define nTextEmpty              0
#define nTextNoEmpty            1

#define nTxtStateMaxLenght      50
#define nTxtCapitalMaxLenght    50
#define nTxtPOMaxLenght         5
#define nTxtMaxPopulation       10

int     iKeyboardHeight;
int     iKeyboardWidth;

NSString *txtImage;

BOOL    boAllTxts       = nTextEmpty;
BOOL    boTxtName       = nTextEmpty;
BOOL    boTxtCapital    = nTextEmpty;


BOOL newMedia;




@interface PopinEmployees ()
@end

@implementation PopinEmployees

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
    
    
    self.wMain.layer.borderColor  = [UIColor clearColor].CGColor;
    self.wMain.layer.borderWidth  = 1.0;
    self.wMain.clipsToBounds      = YES;
    self.wMain.layer.cornerRadius = 8;

}
/**********************************************************************************************
 Keyboard appears and disappears
 **********************************************************************************************/
- (void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@"keyboardDidShow");
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    iKeyboardHeight     = MIN(keyboardSize.height,keyboardSize.width);
    iKeyboardWidth      = MAX(keyboardSize.height,keyboardSize.width);
    
    NSLog(@"height = %d, width  %d", iKeyboardHeight, iKeyboardWidth);
    
    if (self.txtNames.isEditing)
    {
        self.swMain.contentSize = CGSizeMake(self.swMain.frame.size.width, self.swMain.frame.size.height + iKeyboardHeight/2  + 10);
        
        [self.swMain setContentOffset: CGPointMake(0, 124) animated:YES];
    }
    else
    {
        self.swMain.contentSize = CGSizeMake(self.swMain.frame.size.width, self.swMain.frame.size.height + iKeyboardHeight/2  + 10);
        
        [self.swMain setContentOffset: CGPointMake(0,iKeyboardHeight - (self.view.frame.size.height - self.wMain.frame.size.height)/2 + 10)  animated:YES];
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
    if (textField == self.txtNames)
    {
        NSLog(@"txtNames");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtName      = nTextNoEmpty;
            self.txtNames.backgroundColor = [UIColor lightGrayColor];
            if ([newString length] > nTxtStateMaxLenght)
            {
                return NO;
            }
        }
        else
        {
            boTxtName      = nTextEmpty;
        }
        return YES;
    }
   /* else if (textField == self.txtCapital)
    {
        NSLog(@"txtCapital");
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([newString length] > nTextEmpty)
        {
            boTxtCapital      = nTextNoEmpty;
            self.txtCapital.backgroundColor = [UIColor lightGrayColor];
            if ([newString length] > nTxtCapitalMaxLenght)
            {
                return NO;
            }
        }
        else
        {
            boTxtCapital      = nTextEmpty;
        }
        return YES;
    }*/
        return NO;
}
/**********************************************************************************************
 Buttons functions
 **********************************************************************************************/
- (IBAction)btnCancelPressed:(id)sender
{
    [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:nil];
}

- (IBAction)btnSavePressed:(id)sender
{
    if (/*(boTxtCapital == nTextEmpty) ||*/ boTxtName == nTextEmpty)
    {//At least one of the text is empty
        if (boTxtName == nTextEmpty)
        {
            self.txtNames.backgroundColor = [UIColor redColor];
        }
    /*    if (boTxtCapital == nTextEmpty)
        {
            self.txtCapital.backgroundColor = [UIColor redColor];
        }*/
    }
    else
    {//All text have info
        NSLog(@"Ready for saving");
        
         maNames       = [[NSMutableArray arrayWithArray:maNames] mutableCopy];
        [maNames addObject:self.txtNames.text];
        
     //   maImages      = [[NSMutableArray arrayWithArray:maImages] mutableCopy];
      //  [maImages addObject:self.txtCapital.text];
        
        
        
        [mUserDefaults setObject: maNames forKey: @"permNames"];
        //[mUserDefaults setObject: maImages forKey: @"permImages"];
        
        
        NSLog(@"permNames = %@", [mUserDefaults objectForKey:@"permNames"]);
      //  NSLog(@"permImages = %@", [mUserDefaults objectForKey:@"permImages"]);
       
        
        [self.presentingPopinViewController dismissCurrentPopinControllerAnimated:YES completion:nil];
    }
    
}
/**********************************************************************************************
 Button Image
 **********************************************************************************************/

- (IBAction)btnImage:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:[NSString stringWithFormat:@"Cancelar"]
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:
                                  [NSString stringWithFormat:@"Tomar foto"],
                                  [NSString stringWithFormat:@"Seleccionar de carrete"],
                                  [NSString stringWithFormat:@"Usar Default"], nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if([buttonTitle isEqualToString:[NSString stringWithFormat:@"Tomar foto"]])
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker    = [[UIImagePickerController alloc] init];
            imagePicker.delegate                    = self;
            imagePicker.sourceType                  = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes                  = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing               = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            newMedia = YES;
        }
    }
    else if([buttonTitle isEqualToString:[NSString stringWithFormat:@"Seleccionar de carrete"]])
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker    = [[UIImagePickerController alloc] init];
            imagePicker.delegate                    = self;
            imagePicker.sourceType                  = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes                  = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing               = YES;
            [self presentViewController:imagePicker animated:YES completion:nil];
            newMedia = NO;
        }
    }
    else if([buttonTitle isEqualToString:[NSString stringWithFormat:@"Usar Default"]])
    {
        self.imgPick.image  = [UIImage imageNamed:@"1_circle-32.png"];
        txtImage = @"1_circle-32.png";
         //NSLog(@"Default %@", self.imgPick.);
        
  //      self.imgPick.accessibilityIdentifier;
     
        maImages  = [[NSMutableArray arrayWithArray:maImages] mutableCopy];
          [maImages addObject: txtImage];
        
        NSLog(@"Images are %@", maImages);
        
        //[self dismissViewControllerAnimated:YES completion:nil];
    }
}
/**********************************************************************************************/
#pragma mark UIImagePickerControllerDelegate
/**********************************************************************************************/

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image      = info[UIImagePickerControllerOriginalImage];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.imgPick.image      = image;
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}
//-------------------------------------------------------------------------------
-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: [NSString stringWithFormat:@"Error"]
                              message: [NSString stringWithFormat:@"Error Foto"]
                              delegate: nil
                              cancelButtonTitle:[NSString stringWithFormat:@"OK"]
                              otherButtonTitles:nil];
        [alert show];
    }
}
//-------------------------------------------------------------------------------
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
