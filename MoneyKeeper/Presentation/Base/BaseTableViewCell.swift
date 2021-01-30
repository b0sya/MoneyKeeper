//
//  BaseTableCell.swift
//  MoneyKeeper
//
//  Created by Maxim Shalashnikov on 29.01.2021.
//

import RxCocoa
import RxSwift

public class BaseTableViewCell: UITableViewCell {

    private(set) var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addViews()
        bindViews()
        configureLayout()
        configureAppearance()
        localize()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func prepareForReuse() {
        super.prepareForReuse()

        disposeBag = DisposeBag()
    }

    // MARK: - InitializableView

    public func addViews() {}

    public func bindViews() {}

    public func configureLayout() {}

    public func configureAppearance() {
        selectionStyle = .none
    }

    public func localize() {}
}

