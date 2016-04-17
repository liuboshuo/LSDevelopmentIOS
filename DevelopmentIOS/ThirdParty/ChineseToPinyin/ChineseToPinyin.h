#import <UIKit/UIKit.h>

@interface ChineseToPinyin : NSObject {
    
}

+ (NSString *)pinyinFromChineseString:(NSString *)string;
+ (NSString *)spFromChineseString:(NSString *)string;
+ (NSMutableArray *)stringSplit:(NSString *)string;
+ (char) sortSectionTitle:(NSString *)string; 

@end