//
//  XMLParser.m
//  SHOC
//
//  Created by Joseph Hardy on 6/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLParser.h"

@implementation XMLParser;
@synthesize barts, estimates;

- (XMLParser *) initXMLParser {
    // init array of user objects
    barts = [[NSMutableArray alloc] init];
    return self;
}

- (void)parser:(NSXMLParser *)parser
                didStartElement:(NSString *)elementName
                namespaceURI:(NSString *)namespaceURI
                qualifiedName:(NSString *)qualifiedName
                attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"estimate"]) {
        NSLog(@"estimate element found – create a new instance of estimates class...");
        estimates = [[NSMutableDictionary alloc] init];

        //We do not have any attributes in the user elements, but if
        // you do, you can extract them here:
        // user.att = [[attributeDict objectForKey:@"<att name>"] ...];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!currentElementValue) {
        // init the ad hoc string with the value
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    } else {
        // append value to the ad hoc string
        [currentElementValue appendString:string];
    }
    NSLog(@"Processing value for : %@", string);
}

- (void)parser:(NSXMLParser *)parser
                didEndElement:(NSString *)elementName
                namespaceURI:(NSString *)namespaceURI
                qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"root"]) {
        // We reached the end of the XML document
        return;
    }
    
    if ([elementName isEqualToString:@"estimate"]) {
        // We are done with user entry – add the parsed user
        // object to our user array
        [barts addObject:estimates];
        // release user object
     //   [bart release];
        estimates = nil;
    } else {
        // The parser hit one of the element values.
        // This syntax is possible because User object
        // property names match the XML user element names
        [estimates setObject:currentElementValue forKey:elementName];

    }
    
  //  [currentElementValue release];
    currentElementValue = nil;
}

@end

