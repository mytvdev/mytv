//
//  DataFetcher.m
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/17/12.
//
//

#import "DataFetcher.h"
#import "Logging.h"

@implementation DataFetcher

+(void)Get:(NSString *)url withCallback:(NSObject *)callbackObject usingSelector:(SEL)callbackSelector {
    DLog(@"DataFetcher::Get:withCallback:usingSelector");
    
    DataFetcher *fetcher = [DataFetcher new];
    [fetcher setCallbackObject:callbackObject];
    [fetcher setCallbackSelector:callbackSelector];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:fetcher];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    DLog(@"Connection has failed as expected");
    [self.callbackObject performSelector:self.callbackSelector withObject:NULL withObject:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    DLog(@"Connection Did Finish Loading");
}

- (void)didReceiveResponse:(NSURLResponse *)response {
    DLog("%@", response);
}

@end
