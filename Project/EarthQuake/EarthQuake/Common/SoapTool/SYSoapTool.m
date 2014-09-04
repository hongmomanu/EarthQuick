//
//  SYSoapTool.m
//  BestSoapTool
//
//  Created by Serdar YILLAR on 12/28/12.
//  Copyright (c) 2012 yillars. All rights reserved.
//

#import "SYSoapTool.h"
#import "SYXmlParser.h"

@implementation SYSoapTool{
    
    NSURLConnection *theConnection;
    NSMutableData *receivedData;
    NSXMLParser *XParser;
    NSString *LaStr;
    NSMutableArray *resultArray;
    SYXmlParser *parser;
    NSString *functionName;
    NSString *soapUrl;
    NSMutableArray *tags;
    NSMutableArray *vars;
    NSString *respType;
    
    
}
@synthesize delegate;

-(void)startSoapTool:(int)__status
{
    //0 = withoutParameter
    //1 = withParameter
    NSURL *urlm = [NSURL URLWithString:soapUrl];
    //  NSLog(@"Loginstg items : %@",urlm);
    NSMutableURLRequest *url = [NSMutableURLRequest requestWithURL:urlm];
    [url setTimeoutInterval:60];
    [url setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    NSMutableDictionary *headers = [NSMutableDictionary dictionaryWithCapacity:0];
    [headers setObject:@"text/xml; charset=utf-8" forKey:@"Content-Type"];
    //  [headers setObject:@"utf-8" forKey:@"charset"];
    [headers setObject:@"tr" forKey:@"Lang"];
    [headers setObject:[NSString stringWithFormat:@"http://tempuri.org/%@",functionName] forKey:@"SOAPAction"];
//    NSLog(@"看看这里的headers%@",headers);
     //UploadDataPub=functionName
    [headers setObject:@"Mac OS X; WebServicesCore.framework (1.0.0)" forKey:@"User-Agent"];
    [url setAllHTTPHeaderFields:headers];
    [url setHTTPMethod:@"POST"];
    NSMutableString *log = [NSMutableString string];
    [log appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
     "<soap:Body>"];
//    NSLog(@"进来没1？%@",log);
   if (__status == 1)
   {
       [log appendString:[NSString stringWithFormat:@"\n<%@ xmlns=\"http://tempuri.org/\">\n",functionName]];
//       NSLog(@"进来没2？%@",log);
    }
   else
   {
        [log appendString:[NSString stringWithFormat:@"\n<%@ xmlns=\"http://tempuri.org/\"/>",functionName]];
    }
   for (int i=0;i<[tags count]; i++)
   {
        
        if(__status == 1)
        {
            
            NSString *strResult = [NSString stringWithFormat:@"<%@>%@</%@>", [tags objectAtIndex:i],[vars objectAtIndex:i],[tags objectAtIndex:i]];
            
            [log appendString:strResult];
            
//            NSLog(@"进来没3？%@",log);
        }
    }
   if (__status == 1) {
        [log appendString:[NSString stringWithFormat:@"\n</%@>\n</soap:Body>\n</soap:Envelope>",functionName]];
//       NSLog(@"进来没4？%@",log);
    }
   else
   {
        [log appendString:[NSString stringWithFormat:@"\n</soap:Body>\n</soap:Envelope>"]];
   }
    
//    NSLog(@"logggg: %@",log);
    NSData* aData;
    aData = [log dataUsingEncoding: NSUTF8StringEncoding];
    [url setHTTPBody:aData];
    theConnection = [[NSURLConnection alloc] initWithRequest:(NSURLRequest *)url delegate:self];
    if (theConnection)
    {
        receivedData = [NSMutableData data];
    }
    else
    {
        
        
    }
    
}

-(void)callSoapServiceWithoutParameters__functionName:(NSString*)___functionName wsdlURL:(NSString*)___url{
    
    functionName =     ___functionName;
    soapUrl      =     ___url;
    
    [self startSoapTool:0];
    
}



-(void)callSoapServiceWithParameters__functionName:(NSString*)___functionName tags:(NSMutableArray*)___tags vars:(NSMutableArray*)___vars wsdlURL:(NSString*)___url {
    
    functionName =     ___functionName;
    soapUrl      =     ___url;
    tags         =     ___tags;
    vars         =     ___vars;
    
    [self startSoapTool:1];
    
    
}

-(void)serviceDone{
    
 
    [delegate retriveFromSYSoapTool:resultArray];
    
}

//将接收输出"
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	if(connection == theConnection)
	{
		[receivedData setLength:0];
      
	}
	
}
//接受数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)datas
{
	if(connection == theConnection)
	{
		[receivedData appendData:datas];
        
		LaStr = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	}
	
}
//
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
}
- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	if(connection == theConnection)
	{
   //	NSString * hold = [[NSString alloc] initWithFormat:@"Connection failed! Error - %@",[error localizedDescription]];
   
        [self.delegate retriveErrorSYSoapTool:error];
        
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
		
	}
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
//请求完成"
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
   if(connection == theConnection)
	{
		
		NSString * tmp = [[NSString alloc] initWithFormat:@"%@",LaStr];
     
        //NSLog(@"LaStr:%@",LaStr);
        
        
		NSData* tmp_Data = [tmp dataUsingEncoding: NSUTF8StringEncoding];
		
        parser = [[SYXmlParser alloc]initWithData:tmp_Data];
        
        [parser startParser];
        
        
        
        if([parser theDataArray]!= nil && [[parser theDataArray]count]!= 0)
        {
           //NSLog(@"看看5");
            
            resultArray = [[NSMutableArray alloc]initWithArray:[parser theDataArray]];
            
            [self performSelectorOnMainThread:@selector(loadFinished) withObject:nil waitUntilDone:YES];
        }
        
		
	}
    
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
    
}

-(void)loadFinished
{
    
    [self serviceDone];
}


-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)redirectResponse
{
	NSURLRequest *newRequest=request;
	if (redirectResponse)
	{
		newRequest=nil;
	    
	}
	
	return newRequest;
}

@end