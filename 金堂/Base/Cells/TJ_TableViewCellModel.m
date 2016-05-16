//
//  TJ_TableViewCellModel.m
//  金堂
//
//  Created by SDKJ on 16/4/15.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "TJ_TableViewCellModel.h"

@implementation TJ_TableViewCellModel

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //说说内容label
        self.titleLabel = [MLLinkLabel new];
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.dataDetectorTypes = MLDataDetectorTypeHashtag;
        self.titleLabel.delegate = self;
        
        //发布人昵称
        self.nameButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusLeft];
        self.nameButton.titleLabel.font = self.titleLabel.font;
        [self.nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.nameButton];
        
        //发布人头像
        self.headerButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusNormal];
        [self.contentView addSubview:self.headerButton];
        
        //发布时间label
        self.timeLabel = [UILabel new];
        self.timeLabel.textColor = [UIColor colorWithWhite:0.483 alpha:1.000];
        self.timeLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.timeLabel];
        
        //性别图
        self.sexImageView = [UIImageView new];
        [self.contentView addSubview:self.sexImageView];
        
        //发布地点
        self.rightButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusRight];
        [self.rightButton setTitleColor:[UIColor colorWithRed:0.175 green:1.000 blue:0.533 alpha:1.000] forState:UIControlStateNormal];
        self.rightButton.titleLabel.font = self.titleLabel.font;
        [self.contentView addSubview:self.rightButton];
        
        self.addressLabel = [UILabel new];
        [self.contentView addSubview:self.addressLabel];
        self.addressLabel.textColor = [UIColor grayColor];
        self.addressLabel.font = self.nameButton.titleLabel.font;
        
        //分享照片视图
        self.sharedPhotoView = [TJ__SharedPhotoView new];
        [self.contentView addSubview:self.sharedPhotoView];
        
        //分享按钮
        self.shareButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusCenter];
        [self.contentView addSubview:self.shareButton];
        [self.shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        // 浏览人数
        self.browseCountButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusCenter];
        [self.browseCountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.browseCountButton];
        
        //点赞人数
        self.supportCountButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusCenter];
        [self.supportCountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.supportCountButton];
        
        //回复人数
        self.replyCountButton = [[TJ_BACustomButton alloc] initWitAligenmentStatus:BAAligenmentStatusCenter];
        [self.replyCountButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.replyCountButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.headerButton.sd_layout
    .topSpaceToView(self.contentView, margin)
    .leftSpaceToView(self.contentView, margin)
    .widthIs(40)
    .heightEqualToWidth();
    
    self.nameButton.sd_layout
    .topEqualToView(self.headerButton)
    .leftSpaceToView(self.headerButton, margin / 2)
    .heightIs(self.headerButton.height / 2);
    
    self.sexImageView.sd_layout
    .topEqualToView(self.nameButton)
    .leftSpaceToView(self.nameButton, margin / 2)
    .heightIs(self.nameButton.height)
    .widthEqualToHeight();
    
    self.timeLabel.sd_layout
    .leftEqualToView(self.nameButton)
    .topSpaceToView(self.nameButton, margin / 3)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:150];
    
    self.rightButton.sd_layout
    .topEqualToView(self.headerButton)
    .rightSpaceToView(self.contentView, margin)
    .widthIs(100)
    .heightRatioToView(self.nameButton, 1);
    
    self.addressLabel.sd_layout
    .topEqualToView(self.nameButton)
    .heightRatioToView(self.nameButton, 1)
    .rightSpaceToView(self.rightButton, 0);
    [self.addressLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.headerButton, margin / 2)
    .leftEqualToView(self.headerButton)
    .rightSpaceToView(self.contentView, margin)
    .autoHeightRatio(0);
    
    self.sharedPhotoView.sd_layout
    .topSpaceToView(self.titleLabel, margin)
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.titleLabel);
    
    self.replyCountButton.sd_layout
    .topSpaceToView(self.titleLabel, margin / 2)
    .rightEqualToView(self.titleLabel)
    .widthIs(150)
    .heightIs(30);
    
    self.supportCountButton.sd_layout
    .topEqualToView(self.replyCountButton)
    .rightSpaceToView(self.replyCountButton, margin)
    .widthIs(150)
    .heightIs(30);
    
    self.browseCountButton.sd_layout
    .topEqualToView(self.replyCountButton)
    .rightSpaceToView(self.supportCountButton, margin)
    .widthIs(150)
    .heightIs(30);
    
//    [self setupAutoHeightWithBottomView:self.browseCountButton bottomMargin:margin / 2];
}

- (NSMutableAttributedString *)getAttributedStringWithText:(NSString *)text HeadIndent:(CGFloat)pointSize
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [paragraphStyle setFirstLineHeadIndent:pointSize];//首行缩进两个字体
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    return attributedString;
}

+ (NSString *)identifierForModelAtRow:(id)Model
{
    return NSStringFromClass([self class]);
}

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
