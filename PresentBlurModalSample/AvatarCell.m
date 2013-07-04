//
// Created by Zhang Zeqing on 1/7/13.
// Copyright (c) 2013 Zhang Zeqing. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AvatarCell.h"


@implementation AvatarCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
        imageView.image = [UIImage imageNamed:@"avatar.jpg"];
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 28;
        imageView.center = self.contentView.center;
        [self.contentView addSubview:imageView];

        UILabel *titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.bounds.size.height - 20, self.contentView.bounds.size.width, 20)];
        titleView.textColor = [UIColor whiteColor];
        titleView.text = @"Taylor Swift";
        titleView.textAlignment = NSTextAlignmentCenter;
        titleView.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:titleView];

    }

    return self;
}


@end