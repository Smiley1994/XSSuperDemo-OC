//
//  IIPFloatCardController.h
//  huafangDemo
//
//  Created by Liguoan on 2022/4/15.
//

#import "IIPSideDialogController.h"

NS_ASSUME_NONNULL_BEGIN

@interface IIPFloatCardController : IIPSideDialogController

/// 内容视图的偏移量
/// .top: 表示内容向上偏移。  .left:内容向左偏移。 .bottom:内容向下偏移。 .right:内容向右偏移。
/// Note: 水平偏移请设置 .left 或 .right;
/// Note: 垂直偏移请设置 .top 或 .bottom;
/// 代码逻辑: .left 和 .top 在计算时会默认在坐标系中做 “减” 操作，.right 和 .bottom 默认为 "加" 操作， 所以四个方向设置时均需传入 "正数" 即可。
/// 代码逻辑: .left 和 .right 会互相影响。  如: .left 传 5，.right 传 4, 则内容视图将会向左侧移动 "1"。 .top 和 .bottom 同理。
@property (nonatomic, assign) UIEdgeInsets floatCardOffset;

@end

NS_ASSUME_NONNULL_END
