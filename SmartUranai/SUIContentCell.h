//
//  SUIContentCell.h
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SUIContentCellDelegate <NSObject>

- (void)didChangeSelectionString:(NSString *)str;

@end


@interface SUIContentCell : UITableViewCell

@property (nonatomic) NSString *content;
@property (nonatomic, assign) id<SUIContentCellDelegate> delegate;

- (void)resetStringSelection;

@end
