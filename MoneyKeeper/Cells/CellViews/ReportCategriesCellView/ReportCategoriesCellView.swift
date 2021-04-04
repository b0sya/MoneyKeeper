//
//  File.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 26.03.2021.
//

import UIKit

final class ReportCategoriesCellView: BaseView {
    private let leftCetegoryView = ReportCategoryView()
    private let rightCategoryView = ReportCategoryView()
    
    override func addSubviews() {
        addSubview(leftCetegoryView)
        addSubview(rightCategoryView)
    }
    override func configureLayout() {
        super.configureLayout()
        
        leftCetegoryView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
        }
        
        rightCategoryView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(leftCetegoryView)
            $0.bottom.equalTo(leftCetegoryView)
            $0.leading.equalTo(leftCetegoryView.snp.trailing).offset(8)
            $0.width.equalTo(leftCetegoryView)
        }
    }
    
}

extension ReportCategoriesCellView: ConfigurableView {
    func configure(with viewModel: ReportCategoryCellViewModel) {
        leftCetegoryView.configure(with: viewModel.leftReportCategoryViewModel)
        rightCategoryView.configure(with: viewModel.rightReportCategoryViewModel)
    }
}
