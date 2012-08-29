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
    DLog("%@", [NSString stringWithFormat:@"DataFetcher::Get:withCallback:usingSelector url is %@", url]);
    
    DataFetcher *fetcher = [DataFetcher new];
    [fetcher setCallbackObject:callbackObject];
    [fetcher setCallbackSelector:callbackSelector];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:fetcher];
}

+(void)Get:url usingCallback:(DataProcessorCallback)callback {
    DLog("%@", [NSString stringWithFormat:@"url is %@", url]);
    
    DataFetcher *fetcher = [DataFetcher new];
    [fetcher setDataCallback:callback];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection connectionWithRequest:request delegate:fetcher];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    DLog(@"Connection has failed as expected");
    if(self.callbackObject != NULL) {
        [self.callbackObject performSelector:self.callbackSelector withObject:NULL withObject:error];
    }
    else {
        self.dataCallback(NULL, error);
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    DLog(@"Connection Did Finish Loading");
    if(!self.hasReceivedData) {
        DLog(@"Connection has received empty document, submitting null values to callback");
        if(self.callbackObject != NULL) {
            [self.callbackObject performSelector:self.callbackSelector withObject:NULL withObject:NULL];
        }
        else {
            self.dataCallback(NULL, NULL);
        }
    }
    else {
        if(self.callbackObject != NULL) {
            [self.callbackObject performSelector:self.callbackSelector withObject:[NSData dataWithData:self.receievedData] withObject:NULL];
        }
        else {
            self.dataCallback([NSData dataWithData:self.receievedData] , NULL);
        }
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    DLog("%@", data);
    self.hasReceivedData = TRUE;
    if(data != NULL) {
        if(self.receievedData == NULL) {
            self.receievedData = [NSMutableData new];
        }
        [self.receievedData appendData:data];
    }
    
}




@end