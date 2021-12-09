//
//  MaxCardManager.m
//  VVCollectProject
//
//  Created by Admin on 2021/12/10.
//  Copyright © 2021 Mike. All rights reserved.
//

#import "MaxCardManager.h"

@implementation MaxCardManager


///**
//     * 计算最大的五张牌
//     */
////    @SuppressWarnings("unchecked")
//    - (void)computeMaxCardGroup {
//        if (self.pokers.count == 5) {
//            CardGroup group = new CardGroup(pokers);
//            this.maxGroup = group;
//        }
//        else if (pokers.size() == 6) {
//            ArrayList<CardGroup> groups = new ArrayList<CardGroup>();
//            for (int i = 0; i < 6; i++) {
//                ArrayList<Poker> pokerList = new ArrayList<Poker>(
//                        pokers);
//                pokerList.remove(i);
//                groups.add(new CardGroup(pokerList));
//            }
//            Collections.sort(groups, new CardGroupComparator());
//            this.maxGroup = groups.get(0);
//        }
//        else if (pokers.size() == 7) {
//            ArrayList<CardGroup> groups = new ArrayList<CardGroup>();
//            for (int i = 0; i < 7; i++) {
//                for (int j = 0; j < 7; j++) {
//                    if (i == j) continue;
//                    ArrayList<Poker> pokerList = new ArrayList<Poker>(
//                            pokers);
//                    Poker pi = pokerList.get(i);
//                    Poker pj = pokerList.get(j);
//                    pokerList.remove(pi);
//                    pokerList.remove(pj);
//
//                    groups.add(new CardGroup(pokerList));
//                }
//            }
//            Collections.sort(groups, new CardGroupComparator());
//            this.maxGroup = groups.get(0);
//        }
//
//    }



@end
