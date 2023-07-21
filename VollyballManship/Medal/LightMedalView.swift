//
//  UnlightMedalView.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/17.
//

import Foundation
import UIKit

class LightMedalView: UIView {
    
    private lazy var getMedalLabel: UILabel = {
        let label = UILabel()
        label.text = "恭喜您获得称号："
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var medalLightImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "light"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var getMedalView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var lightMedalImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lightMedal"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var medalNameLabel: UILabel = {
        let label = UILabel()
        label.text = "排球达人"
        label.font = .systemFont(ofSize: 16, weight: .bold)
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
        
        backgroundColor = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 1)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(getMedalLabel)
        getMedalLabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.height.equalTo(20)
            make.left.right.equalToSuperview()
        }
        
        addSubview(getMedalView)
        getMedalView.snp.makeConstraints { make in
            make.top.equalTo(getMedalLabel.snp.bottom)
            make.left.equalTo(32)
            make.right.equalTo(-32)
            make.bottom.equalTo(-8)
        }
        
        getMedalView.addSubview(medalLightImageView)
        medalLightImageView.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.top.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        medalLightImageView.addSubview(lightMedalImageView)
        lightMedalImageView.snp.makeConstraints { make in
            make.top.left.equalTo(24)
            make.right.bottom.equalTo(-24)
        }
        
        getMedalView.addSubview(medalNameLabel)
        medalNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(medalLightImageView.snp.right).offset(12)
            make.right.equalTo(-8)
            make.height.equalTo(20)
        }
    }
}
