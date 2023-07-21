//
//  SettingViewController.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/18.
//

import Foundation
import UIKit

class SettingViewController: BaseViewController {
    
    private lazy var privacyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 0.2).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8
        return view
    }()
    
    private lazy var privacyIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "privacy"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.text = "隐私政策"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        naviView.naviTitle.text = "设置"
        
        let privacyTap = UITapGestureRecognizer(target: self, action: #selector(privacyTap))
        privacyView.addGestureRecognizer(privacyTap)
        
        view.addSubview(privacyView)
        privacyView.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.height.equalTo(50)
            make.top.equalTo(kTopSafeHeight + kNavigationBarHeight + 20)
        }
        
        privacyView.addSubview(privacyIcon)
        privacyIcon.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        privacyView.addSubview(privacyLabel)
        privacyLabel.snp.makeConstraints { make in
            make.left.equalTo(privacyIcon.snp.right).offset(12)
            make.height.equalToSuperview()
            make.right.equalTo(-24)
        }
    }
    
    @objc func privacyTap() {
        let vc = PolicyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
