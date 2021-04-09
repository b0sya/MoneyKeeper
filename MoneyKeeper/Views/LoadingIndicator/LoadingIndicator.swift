//
//  LoadingIndicator.swift
//  MoneyKeeper
//
//  Created by Максим Шалашников on 09.04.2021.
//

import UIKit

final class LoadingIndicator: BaseView {
    private let titleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()
    
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(effectView)
        addSubview(titleLabel)
        addSubview(activityIndicator)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        effectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview().inset(8)
            $0.width.height.equalTo(46)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        titleLabel.font = .systemFont(ofSize: 14)
        activityIndicator.style = .white
        activityIndicator.color = .blackWhite
        
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        titleLabel.text = .loading
        
        isHidden = true
    }
    
    func show() {
        isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hide(){
        isHidden = true
        activityIndicator.stopAnimating()
    }
}
