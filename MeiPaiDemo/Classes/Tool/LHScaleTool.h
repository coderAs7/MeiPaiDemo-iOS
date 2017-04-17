//
//  LHScaleTool.h
//  TryMen
//
//  Created by xiongdexi on 17/2/18.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHScaleTool : NSObject

/**
 *  rect 比例frame
 *  float 比例float
 *  size  比例size
 *  point  比例point
 *  后面bool值代表是否以高度比例
 */
+ (CGRect)rectWithOriginalRect:(CGRect)rect isFlexibleHeight:(BOOL)isHeight;

+ (CGFloat)floatWithOriginalFloat:(CGFloat)originalFloat isFlexibleHeight:(BOOL)isHeight;

+ (CGSize)sizeWithOriginalSize:(CGSize)size isFlexibleHeight:(BOOL)isHeight;

+ (CGPoint)pointWithOriginalPoint:(CGPoint)point isFlexibleHeight:(BOOL)isHeight;


/**
 千分位计数，默认保留小数点后两位
 */
+ (NSString *)positiveFormat:(NSString *)text;
/**
 调整数字最后两位数字的大小
 
 @param string 要修改的字符串
 @param size   修改字体大小
 */

+ (NSString *)positiveFormatWithOutDot:(NSString *)text;
+ (NSMutableAttributedString *)addFontAttribute:(NSString*)string withSize:(CGFloat) size number:(NSInteger)number;



/**
 限制小数点后输入几位数字的方法
 用法：- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 
 return  [LHScaleTool isValidAboutInputText:textField shouldChangeCharactersInRange:range replacementString:string decimalNumber:2];
 
 
 }
 */

+(BOOL)isValidAboutInputText:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string decimalNumber:(NSInteger)number;



/**
 *  封装AFN的GET请求
 *
 *  @param URLString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
+ (void)GET:(NSString *)URLString dict:(id)dict succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;




/**
 *  封装AFN的POST请求
 *
 *  @param URLString 网络请求地址
 *  @param dict      参数(可以是字典或者nil)
 *  @param succeed   成功后执行success block
 *  @param failure   失败后执行failure block
 */
+ (void)POST:(NSString *)URLString dict:(id)dict succeed:(void (^)(id data))succeed failure:(void (^)(NSError *error))failure;


+ (UIView *)backLoadingView:(UIView *)superView;

@end
