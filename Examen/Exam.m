//
//  Exam.m
//  Examen
//
//  Created by Ruben G Ramos Amezcua on 5/25/15.
//  Copyright (c) 2015 Agustin Castaneda. All rights reserved.
//

#import "Exam.h"
#import "Declarations.h"
#import "AppDelegate.h"
#import "Names.h"
#import "TabBTCentral.h"
#import "TabEmployees.h"

int iNumberOfPages = 3;
NSUInteger iIndex2 ;
int index2;


@interface Exam ()

@end

@implementation Exam

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
    [self initController];
    [self createPageViews];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-------------------------------------------------------------------------------
- (void)initController
{
    maFirst  = [NSMutableArray arrayWithObjects: nTutorialfirst];
    maSecond = [NSMutableArray arrayWithObjects: nTutorialsecond];
}

/**********************************************************************************************/
#pragma mark - Buttons functions
/**********************************************************************************************/

- (IBAction)btnSkIp:(id)sender
{
    if (iIndex2 != 3 )
    {
        nil;
    }
    
    else
    {
        TabEmployees *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TabEmployees"];
    [self presentViewController:viewController animated:YES completion:nil];
    }
    
}



/**********************************************************************************************/
#pragma mark - Page controller functions and delagates
/**********************************************************************************************/

- (void)createPageViews
{
    // Create page view controller
    self.pageViewController             = [self.storyboard instantiateViewControllerWithIdentifier:@"IntroPageController"];
    self.pageViewController.dataSource  = self;
    
    Names *startingViewController  = [self viewControllerAtIndex:0];
    NSArray *viewControllers            = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame  = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    NSArray *subviews = self.pageViewController.view.subviews;
    UIPageControl *thisControl = nil;
    for (int i=0; i<[subviews count]; i++) {
        if ([[subviews objectAtIndex:i] isKindOfClass:[UIPageControl class]]) {
            thisControl = (UIPageControl *)[subviews objectAtIndex:i];
        }
    }
    thisControl.hidden = true;
    

    [self.view bringSubviewToFront:self.btnSkip];
    
}

//-------------------------------------------------------------------------------
- (Names *)viewControllerAtIndex:(NSUInteger)index2
{
    if ((iNumberOfPages == 0) || (index2 >= iNumberOfPages)) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
   
    
    Names *NameIntro     = [self.storyboard instantiateViewControllerWithIdentifier:@"Names"];
    NameIntro.iPageIndex        = index2;
    
    NSLog(@"viewControllerAtIndex index2 = %d", (int)index2);
    return NameIntro;
}
//-------------------------------------------------------------------------------
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index2 = ((Names*) viewController).iPageIndex;
    
    if ((index2 == 0) || (index2 == NSNotFound)) {
        
        return nil;
    }
    
    index2--;
    iIndex2 = index2;
    return [self viewControllerAtIndex:index2];
}
//-------------------------------------------------------------------------------
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index2 = ((Names*) viewController).iPageIndex;
    
    if (index2 == NSNotFound) {
        return nil;
    }
    
    index2 ++;
    iIndex2 = index2;
    return [self viewControllerAtIndex:index2];
}
//-------------------------------------------------------------------------------
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return iNumberOfPages;
}
//-------------------------------------------------------------------------------



@end
