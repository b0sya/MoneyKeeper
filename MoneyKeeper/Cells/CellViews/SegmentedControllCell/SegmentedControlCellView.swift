//
//  SegmentedControlCellView.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 27.02.2021.
//

import UIKit

final class SegmentedControlCellView: RoundedContainerCellView {
    private let segmentedControll = UISegmentedControl()
    private var wasConfigured = false
    
    var onChangedSegmentedIndex: ParameterClosure<Int>?
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(segmentedControll)
    }
    
    override func addTargets() {
        super.addTargets()
        
        segmentedControll.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        segmentedControll.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        if #available(iOS 13.0, *) {
            segmentedControll.backgroundColor = .MKGreen
            segmentedControll.selectedSegmentTintColor = .whiteBackgoundGray
        } else {
            segmentedControll.tintColor = .MKGreen
        }
    }
    
    @objc private func segmentChanged() {
        onChangedSegmentedIndex?(segmentedControll.selectedSegmentIndex)
    }
}

extension SegmentedControlCellView: ConfigurableView {
    func configure(with viewModel: SegmentedControlCellViewModel) {
        //FIXME: TRY TO FIX ME PLS
        guard !wasConfigured else { return }
        wasConfigured = true
        for (index, title) in viewModel.segmentTitles.enumerated() {
            segmentedControll.insertSegment(withTitle: title, at: index, animated: false)
        }
        
        segmentedControll.selectedSegmentIndex = viewModel.selectedIndex
        
        onChangedSegmentedIndex = viewModel.onChangedSegmentedIndex
    }
}
