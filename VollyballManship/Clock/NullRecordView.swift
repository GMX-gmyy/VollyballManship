//
//  NullRecordView.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/17.
//

import Foundation
import UIKit

class NullRecordView: UIView {
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "vollyballBgImage"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var promptLabel: UILabel = {
        let label = UILabel()
        label.text = "There is no record yet~"
        label.textColor = UIColor(red: 133 / 255, green: 192 / 255, blue: 248 / 255, alpha: 1)
        label.font = .systemFont(ofSize: 14)
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
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.width.equalTo(316)
            make.height.equalTo(324)
            make.center.equalToSuperview()
        }
        
        addSubview(promptLabel)
        promptLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgImageView.snp.bottom).offset(12)
        }
    }
}
