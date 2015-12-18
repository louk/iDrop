//
//  DBTManager.m
//  Donation
//
//  Created by Larry Walters on 11/14/15.
//  Copyright © 2015 Larry Walters. All rights reserved.
//

#import "DBTManager.h"
#import <dbt-sdk/dbt.h>
#import <dbt-sdk/DBTBookOrder.h>

NSString* API_KEY = @"cc79c4b62ebfe6cf77f6d07c27d4949a";

NSString* MEDIA_TEXT = @"text";
NSString* MEDIA_AUDIO = @"audio";
NSString* MEDIA_VIDEO = @"video";

static DBTManager* s_singletonManager = nil;

@implementation IDropVerse

+(IDropVerse*)newVerseWithBook:(NSString*)book chapter:(NSNumber*)chapter verse:(NSNumber*)verse
{
    return [IDropVerse newVerseWithBook:book
                                chapter:chapter
                                  verse:verse
                                   text:nil
                              reference:nil
                                 cached:NO];
}

+(IDropVerse*)newVerseWithBook:(NSString*)book chapter:(NSNumber*)chapter verse:(NSNumber*)verse text:(NSString*)text reference:(NSString*)reference cached:(BOOL)cached
{
    IDropVerse* newVerse = [IDropVerse new];
    newVerse.text = text;
    newVerse.book = book;
    newVerse.chapter = chapter;
    newVerse.verse = verse;
    newVerse.reference = reference;
    newVerse.cached = cached;
    return newVerse;
}

-(id)copy
{
    return [IDropVerse newVerseWithBook:self.book
                                chapter:self.chapter
                                  verse:self.verse
                                   text:self.text
                              reference:self.reference
                                 cached:self.cached];
}

-(NSString*)description
{
    return [NSString stringWithFormat:@"bookId: %@ chapter: %@ verse %@ ref %@ text %@ cached %@",self.book, self.chapter, self.verse, self.reference, self.text, self.cached ? @"YES" : @"NO"];
}

@end

@interface DBTManager ()

@property ( nonatomic, strong ) NSArray* verses;

@end

@implementation DBTManager

-(void)test
{
    [DBT getLibraryVolumeWithDamID:nil
                      languageCode:@"ENG"
                             media:MEDIA_TEXT
                           success:^(NSArray* volumes)
     {
         NSLog(@"volumes %@",volumes);
         for (DBTVolume* volume in volumes)
         {
             // ESV NT
             if ( [volume.damId isEqualToString:@"ENGESVN2ET"] )
             {
                 [DBT getLibraryBookWithDamId:volume.damId
                                      success:^(NSArray* books)
                  {
                      NSLog(@"NT books %@",books);
                      [DBT getLibraryChapterWithDamId:volume.damId
                                               bookId:@"John"
                                              success:^(NSArray* chapters)
                       {
                           NSLog(@"John chapters %@",chapters);
                           [DBT getTextVerseWithDamId:volume.damId
                                                 book:@"John"
                                              chapter:@3
                                           verseStart:nil
                                             verseEnd:nil
                                              success:^(NSArray* verses)
                            {
                                NSLog(@"John verses %@",verses);
                            }
                                              failure:^(NSError* error)
                            {
                                NSLog(@"error %@",error);
                            }];
                       }
                                              failure:^(NSError* error)
                       {
                           NSLog(@"error %@",error);
                       }];
                  }
                                      failure:^(NSError* error)
                  {
                      NSLog(@"error %@",error);
                  }];
             }
             else if ( [volume.damId isEqualToString:@"ENGESVO2ET"] )
             {
                 [DBT getLibraryBookWithDamId:volume.damId
                                      success:^(NSArray* books)
                  {
                      NSLog(@"OT books %@",books);
                  }
                                      failure:^(NSError* error)
                  {
                      NSLog(@"error %@",error);
                  }];
             }
         }
         
     }
                           failure:^(NSError* error)
     {
         NSLog(@"error %@",error);
     }];
}

+(DBTManager*)instance
{
    if( s_singletonManager == nil )
    {
        s_singletonManager = [[DBTManager alloc] init];
    }
    return s_singletonManager;
}

+(void)initManager
{
    [DBTManager instance];
}

-(instancetype)init
{
    self = [super init];
    if( self )
    {
        [DBT setAPIKey:API_KEY];
        [self setupVerses];
    }
    return self;
}

-(void)setupVerses
{
    self.verses = [[NSArray alloc] initWithObjects:
                   [IDropVerse newVerseWithBook:@"Ps" chapter:@37 verse:@21],
                   [IDropVerse newVerseWithBook:@"Ps" chapter:@112 verse:@5],
                   [IDropVerse newVerseWithBook:@"Prov" chapter:@11 verse:@25],
                   [IDropVerse newVerseWithBook:@"Prov" chapter:@22 verse:@9],
                   [IDropVerse newVerseWithBook:@"Matt" chapter:@20 verse:@15],
                   [IDropVerse newVerseWithBook:@"2Cor" chapter:@9 verse:@5],
                   [IDropVerse newVerseWithBook:@"2Cor" chapter:@9 verse:@6],
                   [IDropVerse newVerseWithBook:@"2Cor" chapter:@9 verse:@11],
                   [IDropVerse newVerseWithBook:@"Titus" chapter:@3 verse:@6],
                   [IDropVerse newVerseWithBook:@"Jas" chapter:@1 verse:@5],
                   nil];
}

-(void)getVolumeDamIdsWithSuccess:(void (^)(NSString* damIdOT, NSString* damIdNT))success
                          failure:(void (^)(NSError* error))failure
{
    [DBT getLibraryVolumeWithDamID:nil
                      languageCode:@"ENG"
                             media:MEDIA_TEXT
                           success:^(NSArray* volumes)
     {
         NSString* damIdOT = nil;
         NSString* damIdNT = nil;
         for (DBTVolume* volume in volumes)
         {
             // ESV NT
             if ( [volume.damId isEqualToString:@"ENGESVN2ET"] )
             {
                 damIdNT = volume.damId;
             }
             // ESV OT
             else if ( [volume.damId isEqualToString:@"ENGESVO2ET"] )
             {
                 damIdOT = volume.damId;
             }
         }
         success( damIdOT, damIdNT );
     }
                           failure:^(NSError* error)
     {
         NSLog(@"error %@",error);
     }];
}

-(void)verseInBook:(NSString*)book
           chapter:(NSNumber*)chapter
             verse:(NSNumber*)verse
           success:(void (^)(IDropVerse* verse))success
           failure:(void (^)(NSError* error))failure
{
    [self getVolumeDamIdsWithSuccess:^(NSString* damIdOT, NSString* damIdNT )
     {
         [self determineDamIdForBook:book
                             damIdOT:damIdOT
                             damIdNT:damIdNT
                             success:^(NSString* damId)
          {
              [DBT getTextVerseWithDamId:damId
                                    book:book
                                 chapter:chapter
                              verseStart:verse
                                verseEnd:verse
                                 success:^(NSArray* verse)
               {
                   if( [verse count] == 1 && [verse[0] isKindOfClass:[DBTVerse class]] )
                   {
                       DBTVerse* dbtVerse = (DBTVerse*)verse[0];
                       NSLog(@"verse: %@",dbtVerse.verseText);
                       IDropVerse* iDropVerse = nil;
                       // Look to see if that verse is in our verses array
                       // If find it, update it and mark it as cached
                       for ( IDropVerse* currentVerse in self.verses )
                       {
                           if ( [currentVerse.book isEqualToString:dbtVerse.bookId] &&
                               currentVerse.chapter.intValue == dbtVerse.chapterId.intValue &&
                               currentVerse.verse.intValue == dbtVerse.verseId.intValue )
                           {
                               currentVerse.text = dbtVerse.verseText;
                               currentVerse.reference = [self verseFormatWithBook:dbtVerse.bookName
                                                                          chapter:dbtVerse.chapterId
                                                                            verse:dbtVerse.verseId];
                               currentVerse.cached = YES;
                               iDropVerse = [currentVerse copy];
                               break;
                           }
                       }
                       
                       // If it wasn't in our list, then it's some other verse
                       if ( iDropVerse == nil )
                       {
                           iDropVerse = [IDropVerse newVerseWithBook:dbtVerse.bookId
                                                             chapter:dbtVerse.chapterId
                                                               verse:dbtVerse.verseId
                                                                text:dbtVerse.verseText
                                                           reference:[self verseFormatWithBook:dbtVerse.bookName
                                                                                       chapter:dbtVerse.chapterId
                                                                                         verse:dbtVerse.verseId]
                                                              cached:NO];
                       }
                       
                       success(iDropVerse);
                   }
               }
                                 failure:^(NSError* error)
               {
                   failure(error);
               }
               ];
          }
                             failure:^(NSError* error)
          {
              failure(error);
          }
          ];
     }
                             failure:^(NSError* error)
     {
         failure(error);
     }
     ];
    
}

- (void)determineDamIdForBook:(NSString*)book
                      damIdOT:(NSString*)damIdOT
                      damIdNT:(NSString*)damIdNT
                      success:(void (^)(NSString* damId))success
                      failure:(void (^)(NSError* error))failure
{
    [DBT getLibraryBookOrderWithDamId:damIdOT
                              success:^(NSArray* bookOrder)
     {
         for( DBTBookOrder* currentBook in bookOrder)
         {
             if( [book isEqualToString:currentBook.bookId] )
             {
                 success(damIdOT);
                 return;
             }
         }
         
         // If didn't find it in the OT, try the NT
         [DBT getLibraryBookOrderWithDamId:damIdNT
                                   success:^(NSArray* bookOrder)
          {
              for( DBTBookOrder* currentBook in bookOrder)
              {
                  if( [book isEqualToString:currentBook.bookId] )
                  {
                      success(damIdNT);
                      return;
                  }
              }
              
          }
                                   failure:^(NSError* error)
          {
              failure(error);
          }
          ];
     }
                              failure:^(NSError* error)
     {
         failure(error);
     }
     ];
}

- (NSString*)verseFormatWithBook:(NSString*)book chapter:(NSNumber*)chapter verse:(NSNumber*)verse
{
    return [NSString stringWithFormat:@"%@ %@:%@",book,chapter,verse];
}

-(void)randomVerseOnSuccess:(void (^)(IDropVerse* verse))success
                    failure:(void (^)(NSError* error))failure;
{
    time_t currentTime;
    time(&currentTime);
    unsigned int seed = (unsigned int)currentTime;
    IDropVerse* ranVerse = self.verses[rand_r(&seed) % [self.verses count]];
    NSLog(@"ranVerse %@",ranVerse);
    if( ranVerse.cached )
    {
        success([ranVerse copy]);
    }
    else
    {
        [self verseInBook:ranVerse.book
                  chapter:ranVerse.chapter
                    verse:ranVerse.verse
                  success:^(IDropVerse* verse)
         {
             success(verse);
         }
                  failure:^(NSError* error)
         {
             failure(error);
         }
         ];
    }
}

@end
