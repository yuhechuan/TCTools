//
//  TCSizeManager.m
//  TCTools
//
//  Created by 陈 胜 on 16/5/25.
//  Copyright © 2016年 陈胜. All rights reserved.
//

#import "TCSizeManager.h"

/**
 *  存储当前UI尺寸分类key
 */
static NSString * const TCSizeCategory = @"__TCSizeCategory__";

/**
 *  UI尺寸分类，分六档
 */
NSString * const TCSizeCategorySmall = @"TCSizeCategorySmall";
NSString * const TCSizeCategoryMedium = @"TCSizeCategoryMedium";
NSString * const TCSizeCategoryLarge = @"TCSizeCategoryLarge";
NSString * const TCSizeCategoryExtraLarge = @"TCSizeCategoryExtraLarge";
NSString * const TCSizeCategoryExtraExtraLarge = @"TCSizeCategoryExtraExtraLarge";
NSString * const TCSizeCategoryExtraExtraExtraLarge = @"TCSizeCategoryExtraExtraExtraLarge";

/**
 *  字体大小常量
 */
NSString * const TCFontTextStyleThemeHead = @"TCFontTextStyleThemeHead";
NSString * const TCFontTextStyleHeadline = @"TCFontTextStyleHeadline";
NSString * const TCFontTextStyleSubheadline = @"TCFontTextStyleSubheadline";
NSString * const TCFontTextStyleBody = @"TCFontTextStyleBody";
NSString * const TCFontTextStyleFootnote = @"TCFontTextStyleFootnote";
NSString * const TCFontTextStyleCaption1 = @"TCFontTextStyleCaption1";
NSString * const TCFontTextStyleCaption2 = @"TCFontTextStyleCaption2";

@implementation TCSizeManager

/**
 *  通过字体尺寸类型获取字体大小
 *
 *  @param textStyle 文本字体尺寸类型
 *  @param offset    偏移量
 *
 *  @return 字体大小
 */
+ (CGFloat)fontSizeForTextStyle:(NSString *)textStyle
                         offset:(CGFloat)offset {
    
    CGFloat fontSize = 17.0f; // 字体基准大小
    NSString *sizeCategory = [self sizeCategory];
    
    static dispatch_once_t onceToken;
    static NSDictionary *fontSizeOffsetDictionary;
    dispatch_once(&onceToken, ^{
        fontSizeOffsetDictionary = @{
                                     TCSizeCategorySmall: @{
                                             TCFontTextStyleThemeHead: @(0),
                                             TCFontTextStyleBody: @(-1),
                                             TCFontTextStyleHeadline: @(-1),
                                             TCFontTextStyleSubheadline: @(-4),
                                             TCFontTextStyleCaption1: @(-5),
                                             TCFontTextStyleCaption2: @(-6),
                                             TCFontTextStyleFootnote: @(-5)},
                                     
                                     TCSizeCategoryMedium: @{
                                             TCFontTextStyleThemeHead: @(2),
                                             TCFontTextStyleBody: @(0),
                                             TCFontTextStyleHeadline: @(0),
                                             TCFontTextStyleSubheadline: @(-3),
                                             TCFontTextStyleCaption1: @(-4),
                                             TCFontTextStyleCaption2: @(-5),
                                             TCFontTextStyleFootnote: @(-4)},
                                     
                                     TCSizeCategoryLarge: @{
                                             TCFontTextStyleThemeHead: @(4),
                                             TCFontTextStyleBody: @(1),
                                             TCFontTextStyleHeadline: @(1),
                                             TCFontTextStyleSubheadline: @(-2),
                                             TCFontTextStyleCaption1: @(-3),
                                             TCFontTextStyleCaption2: @(-4),
                                             TCFontTextStyleFootnote: @(-3)},
                                     
                                     TCSizeCategoryExtraLarge: @{
                                             TCFontTextStyleThemeHead: @(6),
                                             TCFontTextStyleBody:@(2),
                                             TCFontTextStyleHeadline: @(2),
                                             TCFontTextStyleSubheadline: @(-1),
                                             TCFontTextStyleCaption1: @(-2),
                                             TCFontTextStyleCaption2: @(-3),
                                             TCFontTextStyleFootnote: @(-2)},
                                     
                                     TCSizeCategoryExtraExtraLarge: @{
                                             TCFontTextStyleThemeHead: @(8),
                                             TCFontTextStyleBody: @(3),
                                             TCFontTextStyleHeadline: @(3),
                                             TCFontTextStyleSubheadline: @(0),
                                             TCFontTextStyleCaption1: @(-1),
                                             TCFontTextStyleCaption2: @(-2),
                                             TCFontTextStyleFootnote: @(-1)},
                                     
                                     TCSizeCategoryExtraExtraExtraLarge: @{
                                             TCFontTextStyleThemeHead: @(10),
                                             TCFontTextStyleBody: @(4),
                                             TCFontTextStyleHeadline: @(4),
                                             TCFontTextStyleSubheadline: @(1),
                                             TCFontTextStyleCaption1: @(0),
                                             TCFontTextStyleCaption2: @(-1),
                                             TCFontTextStyleFootnote: @(0)}
                                     };
        
    });
    
    CGFloat fontSizeOffset = [fontSizeOffsetDictionary[sizeCategory][textStyle] doubleValue] + offset;
    fontSize += fontSizeOffset;
    return fontSize;
}

/**
 *  通过字体尺寸类型获取字体大小
 *
 *  @param textStyle 文本字体尺寸类型
 *
 *  @return 字体大小
 */
+ (CGFloat)fontSizeForTextStyle:(NSString *)textStyle {
    return [self fontSizeForTextStyle:textStyle offset:0];
}

/**
 *  获取当前UI尺寸类型
 *
 *  @return UI尺寸类型
 */
+ (NSString *)sizeCategory {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *sizeCategory = [userDefault objectForKey:TCSizeCategory];
    if (!sizeCategory || [sizeCategory isEqualToString:@""]) {
        sizeCategory = TCSizeCategoryMedium;
    }
    return sizeCategory;
}

@end