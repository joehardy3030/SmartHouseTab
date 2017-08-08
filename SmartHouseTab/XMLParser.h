//
//  XMLParser.h
//  SHOC
//
//  Created by Joseph Hardy on 6/10/16.
//  Copyright © 2016 Joseph Hardy. All rights reserved.
//

#ifndef XMLParser_h
#define XMLParser_h

#import <Foundation/Foundation.h>

//@class Bart;

@interface XMLParser : NSObject <NSXMLParserDelegate>
 {
    // an ad hoc string to hold element value
    NSMutableString *currentElementValue;
    // estimates object
  //  Bart *bart;
    NSMutableDictionary *estimates;
    // array of user objects
    NSMutableArray *barts;
}
//@property (nonatomic, retain) Bart *bart;
@property (nonatomic, retain) NSMutableArray *barts;
@property (nonatomic, retain) NSMutableDictionary *estimates;

- (XMLParser *) initXMLParser;

@end

#endif /* XMLParser_h */
