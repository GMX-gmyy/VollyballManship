//
//  RecordDetailViewController.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/18.
//

import Foundation
import UIKit

class RecordDetailViewController: BaseViewController {
    
    public var model = ClockRecordModel()
    
    private lazy var recordDetailView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 133 / 255, green: 192 / 255, blue: 248 / 255, alpha: 0.5)
        view.layer.borderColor = UIColor(red: 133 / 255, green: 192 / 255, blue: 248 / 255, alpha: 1).cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var recordDetailContentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.text = model.record
        textView.isEditable = false
        textView.font = .systemFont(ofSize: 20)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        naviView.naviTitle.text = "Records"
        
        view.addSubview(recordDetailView)
        recordDetailView.snp.makeConstraints { make in
            make.top.equalTo(kTopSafeHeight + kNavigationBarHeight)
            make.bottom.equalTo(-(kBottomSafeHeight + 20))
            make.left.equalTo(24)
            make.right.equalTo(-24)
        }
        
        recordDetailView.addSubview(recordDetailContentTextView)
        recordDetailContentTextView.snp.makeConstraints { make in
            make.top.equalTo(24)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.bottom.equalTo(-24)
        }
    }
}
