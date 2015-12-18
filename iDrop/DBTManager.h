//
//  DBTManager.h
//  Donation
//
//  Created by Larry Walters on 11/14/15.
//  Copyright © 2015 Larry Walters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDropVerse : NSObject

@property ( nonatomic, strong ) NSString* text;
@property ( nonatomic, strong ) NSString* book; // The shortened form of the book name (OSIS code)
@property ( nonatomic, strong ) NSNumber* chapter;
@property ( nonatomic, strong ) NSNumber* verse;
@property ( nonatomic, strong ) NSString* reference; // Formatted unabbreviated book name, with chapter and verse numbers
@property ( nonatomic ) BOOL cached;

@end

@interface DBTManager : NSObject

+(void)initManager;
+(DBTManager*)instance;
-(void)verseInBook:(NSString*)book
           chapter:(NSNumber*)chapter
             verse:(NSNumber*)verse
           success:(void (^)(IDropVerse* verse))success
           failure:(void (^)(NSError* error))failure;
-(void)randomVerseOnSuccess:(void (^)(IDropVerse* verse))success
                    failure:(void (^)(NSError* error))failure;

@end
