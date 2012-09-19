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

+(DataFetcher *)Get:url usingCallback:(DataProcessorCallback)callback {
    DLog("%@", [NSString stringWithFormat:@"url is %@", url]);
    
    DataFetcher *fetcher = [DataFetcher new];
    [fetcher setDataCallback:callback];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [fetcher setConnection:[NSURLConnection connectionWithRequest:request delegate:fetcher]];
    return fetcher;
}

+(DataFetcher *)Get:url Synchronously:(BOOL)sync usingCallback:(DataProcessorCallback)callback {
    if(sync == NO) {
        return [self Get:url usingCallback:callback];
    }
    else {
        DLog("%@", [NSString stringWithFormat:@"url is %@", url]);
        
        NSURLResponse* response;
        NSError *error;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error != nil) {
            callback(nil, error);
        }
        else {
            callback(data, nil);
        }
        return nil;
    }
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    DLog(@"Connection has failed as expected");
    self.hasFinishedLoading = TRUE;
    self.dataCallback(NULL, error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    DLog(@"Connection Did Finish Loading");
    self.hasFinishedLoading = TRUE;
    if(!self.hasReceivedData) {
        DLog(@"Connection has received empty document, submitting null values to callback");
        self.dataCallback(NULL, NULL);
        
    }
    else {
        self.dataCallback([NSData dataWithData:self.receievedData] , NULL);
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    DLog("Data Recieved %d", [data length]);
    self.hasReceivedData = TRUE;
    if(data != NULL) {
        if(self.receievedData == NULL) {
            self.receievedData = [NSMutableData new];
        }
        [self.receievedData appendData:data];
    }
    
}

-(BOOL) cancelPendingRequest {
    if(!self.hasFinishedLoading) {
        self.hasFinishedLoading = TRUE;
        [self.connection cancel];
        return TRUE;
    }
    return FALSE;
}

-(void) dealloc {
    self.receievedData = nil;
    self.connection = nil;
    self.dataCallback = nil;
}


@end