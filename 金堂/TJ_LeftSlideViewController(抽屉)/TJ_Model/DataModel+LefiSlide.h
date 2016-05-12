//
//  DataModel+LefiSlide.h
//  金堂
//
//  Created by SDKJ on 16/5/12.
//  Copyright © 2016年 luxia. All rights reserved.
//

#import "DataModel.h"

@interface DataModel (LefiSlide)
/**
 *  根据ID获取动态关注数据
 *
 *  @param ID 帖子ID
 */
- (void)getLefiSlideDataWithID:(NSNumber *)ID success:(DataModelBlock)success failure:(DataModelBlock)failure;
@end
