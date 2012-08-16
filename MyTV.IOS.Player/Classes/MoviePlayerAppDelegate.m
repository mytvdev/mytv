/*

    File: MoviePlayerAppDelegate.m 
Abstract:  A simple UIApplication delegate class that adds the MyMovieViewController
view to the window as a subview.  

*/

#import "MoviePlayerAppDelegate.h"
#import "MyMovieViewController.h"

@implementation MoviePlayerAppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{	
    /* Override point for customization after app. launch. */

    /* Add the tab bar controller's current view as a subview of the window. */
    [window addSubview:tabBarController.view];
    [window makeKeyAndVisible];    
}

/* Tells the delegate that the application is about to enter the foreground. */
- (void)applicationWillEnterForeground:(UIApplication *)application
{
	MyMovieViewController *selectedViewController = (MyMovieViewController *)tabBarController.selectedViewController;
	if ([selectedViewController respondsToSelector:@selector(viewWillEnterForeground)])
	{
		[selectedViewController viewWillEnterForeground]; 
	}
}

- (void)dealloc 
{
    [window release];
    [super dealloc];
}


@end
