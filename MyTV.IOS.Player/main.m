/*

    File: main.m 
Abstract:  
Entry point for the application. Creates the application object and
causes the event loop to start.

*/

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) 
{	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, nil);
	[pool release];
	return retVal;
}
