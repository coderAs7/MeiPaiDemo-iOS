//
//  LHScaleTool.m
//  TryMen
//
//  Created by xiongdexi on 17/2/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import "LHScaleTool.h"

@implementation LHScaleTool

+ (CGRect)rectWithOriginalRect:(CGRect)rect isFlexibleHeight:(BOOL)isHeight {
    CGRect currentRect = CGRectMake(0, 0, 0, 0);
    currentRect.origin = [self pointWithOriginalPoint:rect.origin isFlexibleHeight:isHeight];
    currentRect.size = [self sizeWithOriginalSize:rect.size isFlexibleHeight:isHeight];
    
    return currentRect;
}


+ (CGPoint)pointWithOriginalPoint:(CGPoint)point isFlexibleHeight:(BOOL)isHeight {
    CGPoint currentPoint = CGPointZero;
    currentPoint.x = point.x * Flexible_W;
    
    if (isHeight) {
        currentPoint.y = point.y * Flexible_H;
    } else {
        currentPoint.y = point.y * Flexible_W;
    }
    return currentPoint;
}

+ (CGSize)sizeWithOriginalSize:(CGSize)size isFlexibleHeight:(BOOL)isHeight {
    CGSize currentSize = CGSizeZero;
    currentSize.width = size.width * Flexible_W;
    
    if (isHeight) {
        currentSize.height = size.height * Flexible_H;
    } else {
        currentSize.height = size.height * Flexible_W;
    }
    return currentSize;
}



+ (CGFloat)floatWithOriginalFloat:(CGFloat)originalFloat isFlexibleHeight:(BOOL)isHeight {
    if (isHeight) {
        return originalFloat * Flexible_H;
    } else {
        return originalFloat * Flexible_W;
    }
}


/**
 千分位计数，默认保留小数点后两位
 */
+ (NSString *)positiveFormat:(NSString *)text{
    if(!text || [text floatValue] == 0){
        return @"0.00";
    }
    if ( text.floatValue > -1000 && text.floatValue < 1000) {
        return  [NSString stringWithFormat:@"%.2f",text.floatValue];
    };
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###.00;"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
}

+ (NSString *)positiveFormatWithOutDot:(NSString *)text{
    if(!text || [text floatValue] == 0){
        return @"0";
    }
    if ( text.floatValue > -1000 && text.floatValue < 1000) {
        return  [NSString stringWithFormat:@"%.f",text.floatValue];
    };
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@",###;"];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
}

/**
 调整数字最后两位数字的大小
 
 @param string 要修改的字符串
 @param size   修改字体大小
 */
+ (NSMutableAttributedString *)addFontAttribute:(NSString*)string withSize:(CGFloat) size number:(NSInteger)number{
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc]initWithString:string];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size]range:NSMakeRange(string.length-number,number)];
    return aString;
}

/**
   限制小数点后输入几位数字的方法
 用法：- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 
 return  [self isValidAboutInputText:textField shouldChangeCharactersInRange:range replacementString:string decimalNumber:2];
 
 
 }
 */

+(BOOL)isValidAboutInputText:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger)number{
    
    NSScanner      *scanner    = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers;
    NSRange         pointRange = [textField.text rangeOfString:@"."];
    if ( (pointRange.length > 0) && (pointRange.location < range.location  || pointRange.location > range.location + range.length) ){
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    }else{
        numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] ){
        return NO;
    }
    short remain = number; //保留 number位小数
    NSString *tempStr = [textField.text stringByAppendingString:string];
    NSUInteger strlen = [tempStr length];
    if(pointRange.length > 0 && pointRange.location > 0){ //判断输入框内是否含有“.”。
        if([string isEqualToString:@"."]){ //当输入框内已经含有“.”时，如果再输入“.”则被视为无效。
            return NO;
        }
        if(strlen > 0 && (strlen - pointRange.location) > remain+1){ //当输入框内已经含有“.”，当字符串长度减去小数点前面的字符串长度大于需要要保留的小数点位数，则视当次输入无效。
            return NO;
        }
    }
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && zeroRange.location == 0){ //判断输入框第一个字符是否为“0”
        if(![string isEqualToString:@"0"] && ![string isEqualToString:@"."] && [textField.text length] == 1){ //当输入框只有一个字符并且字符为“0”时，再输入不为“0”或者“.”的字符时，则将此输入替换输入框的这唯一字符。
            textField.text = string;
            return NO;
        }else{
            if(pointRange.length == 0 && pointRange.location > 0){ //当输入框第一个字符为“0”时，并且没有“.”字符时，如果当此输入的字符为“0”，则视当此输入无效。
                if([string isEqualToString:@"0"]){
                    return NO;
                }
            }
        }
    }
    NSString *buffer;
    if ( ![scanner scanCharactersFromSet:numbers intoString:&buffer] && ([string length] != 0) ){
        return NO;
    }else{
        return YES;
    }
}


@end
