//
//  BaseFirstView.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/15.
//

import Foundation
import UIKit

class BaseFirstView: UIView {
    
    var rightTapBlock: (() -> ())?
    
    private lazy var headImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "anotherHeadImage"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var HeadView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "headImage"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "setting"))
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var headTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
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
        
        addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenHeight / 5)
        }
        
        addSubview(HeadView)
        HeadView.snp.makeConstraints { make in
            make.top.equalTo(kTopSafeHeight + 10)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(80)
        }
        
        HeadView.addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.width.height.equalTo(68)
            make.centerY.equalToSuperview()
            make.left.equalTo(24)
        }
        
        HeadView.addSubview(headTitleLabel)
        headTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        let rightTap = UITapGestureRecognizer(target: self, action: #selector(rightTap))
        rightImageView.addGestureRecognizer(rightTap)
        
        
        HeadView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.right.equalTo(-24)
        }
    }
    
    @objc func rightTap() {
        rightTapBlock?()
    }
    
    var headTitle: String = "" {
        didSet {
            headTitleLabel.text = headTitle
        }
    }
    
    var headImage: String = "" {
        didSet {
            headImageView.image = UIImage(named: headImage)
        }
    }
    
    var rightImageIsHidden: Bool = false {
        didSet {
            rightImageView.isHidden = !rightImageIsHidden
        }
    }
}
