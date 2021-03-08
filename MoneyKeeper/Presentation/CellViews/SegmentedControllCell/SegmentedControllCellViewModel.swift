//
//  SegmentedControllCellViewModel.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 27.02.2021.
//

import Foundation

final class SegmentedControlCellViewModel {
    let segmentTitles: [String]
    let selectedIndex: Int
    
    var onChangedSegmentedIndex: ParameterClosure<Int>?
    
    init(segmentTitles: [String],
         selectedIndex: Int,
         onChangedSegmentedIndex: ParameterClosure<Int>? = nil) {
        self.segmentTitles = segmentTitles
        self.selectedIndex = selectedIndex
        self.onChangedSegmentedIndex = onChangedSegmentedIndex
    }
}
