//
//  BaseNavigationView.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/15.
//

import Foundation
import UIKit

class BaseNavigationView: UIView {
    
    var backBlock: (() -> ())?
    
    public lazy var barView: UIView = {
        let view = UIView()
        return view
    }()
    
    public lazy var naviBackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(backEvent), for: .touchUpInside)
        return button
    }()
    
    public lazy var naviTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center 
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(barView)
        barView.snp.makeConstraints { make in
            make.top.equalTo(kTopSafeHeight + 20)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        barView .addSubview(naviBackButton)
        naviBackButton.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        barView.addSubview(naviTitle)
        naviTitle.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.center.equalToSuperview()
        }
    }
    
    @objc func backEvent() {
        backBlock?()
    }
}
