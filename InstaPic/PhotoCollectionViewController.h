//
//  PhotoCollectionViewController.h
//  InstaPic
//
//  Created by Steven Sickler on 8/20/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
     UICollectionView *_collectionView;
}

@end
