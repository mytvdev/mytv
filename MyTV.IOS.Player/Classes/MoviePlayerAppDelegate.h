/*

    File: MoviePlayerAppDelegate.h 
Abstract:  A simple UIApplication delegate class that adds the MyMovieViewController
view to the window as a subview.

*/

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MoviePlayerAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> 
{
	IBOutlet UIWindow *window;
    IBOutlet UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

