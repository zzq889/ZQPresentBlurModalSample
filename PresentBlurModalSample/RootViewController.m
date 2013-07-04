//
// Created by Zhang Zeqing on 28/6/13.
// Copyright (c) 2013 Zhang Zeqing. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "RootViewController.h"
#import "UIImage+ImageEffects.h"
#import "AvatarCell.h"

static NSString *CellIdentifier = @"Cell";

@implementation RootViewController {
    BOOL isModalPresentation_;
    UIView *modalView_;
    UIImageView *modalBgView_;
}

- (void)loadView {
    [super loadView];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    bgView.image = [UIImage imageNamed:@"bg1.jpg"];
    [self.view addSubview:bgView];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200)/2, 100, 200, 80)];
    button.center = self.view.center;
    [button setTitle:@"Hello" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [button addTarget:self action:@selector(toggleModal:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    UIView *modalView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height/2)];
    [self.view addSubview:modalView];
    modalView_ = modalView;

    modalBgView_ = [[UIImageView alloc] initWithFrame:modalView.bounds];
    modalBgView_.clipsToBounds = YES;
    modalBgView_.contentMode = UIViewContentModeBottom;
    [modalView_ addSubview:modalBgView_];

    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];

    [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [collectionViewFlowLayout setItemSize:CGSizeMake(100, 100)];
    [collectionViewFlowLayout setMinimumInteritemSpacing:0];
    [collectionViewFlowLayout setMinimumLineSpacing:10];
    [collectionViewFlowLayout setSectionInset:UIEdgeInsetsMake(20, 10, 0, 10)];

    _collectionView = [[UICollectionView alloc] initWithFrame:modalView_.bounds collectionViewLayout:collectionViewFlowLayout];
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    [_collectionView setAlwaysBounceHorizontal:YES];
    [_collectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin];
    _collectionView.backgroundColor = [UIColor clearColor];

    [_collectionView registerClass:[AvatarCell class] forCellWithReuseIdentifier:CellIdentifier];

    [modalView_ addSubview:_collectionView];
}


- (UIImage *)captureView:(UIView *)view {
    CGRect screenRect = view.bounds;

    UIGraphicsBeginImageContext(screenRect.size);

    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(ctx, screenRect.origin.x,  - self.view.bounds.size.height + screenRect.size.height);
    [[UIColor blackColor] set];
    CGContextFillRect(ctx, screenRect);

    [view.layer renderInContext:ctx];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return newImage;
}

- (void)toggleModal:(id)sender {
    isModalPresentation_ = !isModalPresentation_;
    CGRect rect = modalView_.bounds;
    CGRect bgFrame = rect;

    if (isModalPresentation_) {
        modalBgView_.image = [[self captureView:self.view] applyLightEffect];
        bgFrame.size.height = 0;
        modalBgView_.frame = bgFrame;
    }
    rect.origin.y = isModalPresentation_ ? self.view.bounds.size.height - rect.size.height : self.view.bounds.size.height;
    bgFrame.size.height = isModalPresentation_ ? self.view.bounds.size.height - rect.origin.y: 0;

    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.9
          initialSpringVelocity:20.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         modalView_.frame = rect;
                         modalBgView_.frame = bgFrame;
                     }
                     completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AvatarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    return cell;
}


@end