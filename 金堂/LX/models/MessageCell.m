//
//  MessageCell.m
//  金堂
//
//  Created by zouxin on 16/4/13.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "MessageCell.h"
//使用宏定义为代码中频繁用到的数字 定义别名
//好处 维护方便
#define CELL_MARGIN_TB    4.0 //气泡上下外边缘
#define CELL_MARGIN_LR    10.0 //气泡左右外边距
#define CELL_CORNOR        18.0 //气泡圆角半径
#define CELL_TAIL_WIDTH    16.0 //气泡尾巴宽度
#define MAX_WIDTH_OF_TEXT   200.0 //文字宽度限制
#define CELL_PADDING      8.0 //气泡内边距

@implementation MessageCell
//内容标签
- (UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [UILabel new];
        //必须允许自动换行
        _contentLb.numberOfLines = 0;
    }
    return _contentLb;
}
//泡泡图
- (UIImageView *)popIV{
    if (!_popIV) {
        _popIV = [UIImageView new];
    }
    return _popIV;
}
//当为message属性赋值后，就可以根据message中的数值
//计算泡泡图和标签 的大小 和位置
//所以我们选择重写message的set方法 来抓住这个时间点
-(void)setMessage:(Message *)message{
    _message = message;
    //因为开启了autolayout模式，直接获取self.bounds是不准确的
    //self.bounds只有在layoutSubViews生命周期之后才准确
    //所以获取当前屏幕宽度不能用self.bounds取
    
     CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    //必须先为label赋值，之后才能算出label需要多大才能展示出它的内容
    self.contentLb.text = message.content;
    //计算在某个宽度限制下，需要多高能够显示所有内容
    CGRect textOfRect = [self.contentLb textRectForBounds:CGRectMake(0, 0, MAX_WIDTH_OF_TEXT, MAXFLOAT) limitedToNumberOfLines:0];
    
  //判断是收还是发消息
    if (message.fromMe) {//蓝色气泡,尾巴在右
        //标签内容的颜色
        self.contentLb.textColor = [UIColor whiteColor];
        self.popIV.image = [[UIImage imageNamed:@"message_i"]resizableImageWithCapInsets:UIEdgeInsetsMake(CELL_CORNOR, CELL_CORNOR, CELL_CORNOR, CELL_CORNOR +CELL_TAIL_WIDTH)];
        //根据计算出的标签的最大宽度和高度，计算它所处的位置
        CGRect frameOfLabel = CGRectZero;
        frameOfLabel.size = textOfRect.size;
        frameOfLabel.origin.y = CELL_MARGIN_TB + CELL_PADDING;
        
        //label的x轴=屏幕宽-尾巴距离右侧-尾巴宽-气泡与标签内边距-标签本身宽
        frameOfLabel.origin.x = width-CELL_MARGIN_LR-CELL_TAIL_WIDTH-CELL_PADDING-textOfRect.size.width;
        self.contentLb.frame = frameOfLabel;
        //2.计算气泡的位置和大小
        CGRect frameOfPop = frameOfLabel;
        frameOfPop.origin.x -= CELL_PADDING;
        frameOfPop.origin.y -= CELL_PADDING;
        frameOfPop.size.width += 2*CELL_PADDING+CELL_TAIL_WIDTH;
        frameOfPop.size.height += 2*CELL_PADDING;
        self.popIV.frame = frameOfPop;
        //记录当前cell需要多高才能显示全所有内容
        _cellHeight = frameOfPop.size.height + 2*CELL_MARGIN_TB;
        
    }else{//灰色汽泡，尾巴朝左
        self.contentLb.textColor = [UIColor darkGrayColor];
        
        self.popIV.image = [[UIImage imageNamed:@"message_other"] resizableImageWithCapInsets:UIEdgeInsetsMake(CELL_CORNOR, CELL_CORNOR + CELL_TAIL_WIDTH, CELL_CORNOR, CELL_CORNOR)];
        //1.计算左侧的标签的位置和大小
        
        CGRect frameOfLabel = CGRectZero;
        frameOfLabel.size = textOfRect.size;
        frameOfLabel.origin.y = CELL_MARGIN_TB+CELL_PADDING;
        frameOfLabel.origin.x = CELL_MARGIN_LR+CELL_TAIL_WIDTH+CELL_PADDING;
        self.contentLb.frame = frameOfLabel;
        
        //2.计算左侧气泡的宽高位置
        CGRect frameOfPop = frameOfLabel;
        frameOfPop.origin.x = CELL_MARGIN_LR;
        frameOfPop.origin.y = CELL_MARGIN_TB;
        frameOfPop.size.width += 2*CELL_PADDING+CELL_TAIL_WIDTH;
        frameOfPop.size.height += 2*CELL_PADDING;
        self.popIV.frame = frameOfPop;
        
        //3.记录需要多高能够显示所有内容
         _cellHeight = frameOfPop.size.height + 2*CELL_MARGIN_TB;
    }
    //把气泡和标签添加到cell中，注意添加顺序
    
    [self.contentView addSubview:self.popIV];
    [self.contentView addSubview:self.contentLb];

}
@end
