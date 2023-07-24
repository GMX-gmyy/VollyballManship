//
//  ClockViewController.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/15.
//

import Foundation
import UIKit
import SwiftDate

class ClockViewController: BaseViewController {
    
    private lazy var headView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 133 / 255, green: 192 / 255, blue: 248 / 255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var dataLabel: UILabel = {
        let label = UILabel()
        label.text = "Date:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var dataContentLabel: UILabel = {
        let label = UILabel()
        label.text = DateToolsMannager.getCurrentTime(timeFormat: "YYYY-MM-dd HH:mm")
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var recordView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor(red: 133 / 255, green: 192 / 255, blue: 248 / 255, alpha: 1).cgColor
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var recordContentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.attributedText = NSAttributedString(string: textView.text, attributes: [NSAttributedString.Key.kern: 1])
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = UIColor(red: 133 / 255, green: 192 / 255, blue: 248 / 255, alpha: 1)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(saveEvent), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dataContentLabel.resignFirstResponder()
        recordContentTextView.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        naviView.naviTitle.text = "Clock in today"
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(kNavigationBarHeight + 20)
            make.left.equalTo(24)
            make.right.equalTo(-20)
            make.height.equalTo(38)
        }
        
        headView.addSubview(dataLabel)
        dataLabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.left.equalToSuperview()
        }
        
        headView.addSubview(dataContentLabel)
        dataContentLabel.snp.makeConstraints { make in
            make.left.equalTo(dataLabel.snp.right).offset(4)
            make.top.equalTo(2)
            make.bottom.equalTo(-2)
        }
        
        view.addSubview(recordView)
        recordView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(14)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.bottom.equalTo(-(kTabbarHeight + 40))
        }
        
        recordView.addSubview(recordContentTextView)
        recordContentTextView.snp.makeConstraints { make in
            make.left.top.equalTo(4)
            make.bottom.right.equalTo(-4)
        }
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in            make.bottom.equalTo(-(kBottomSafeHeight + 20))
            make.width.equalTo(160)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func saveEvent() {
        let model = ClockRecordModel()
        model.date = DateToolsMannager.getNowTimeTimestamp(timeFormat: "YYYY-MM-dd HH:mm")
        model.record = recordContentTextView.text
        ClockRecordManager.shared.saveRecordDays(date: Date())
        ClockRecordManager.shared.saveRecordInfo(model: model)
        let alertView = UIAlertController(title: "", message: "Save successfully!", preferredStyle: .alert)
        self.present(alertView, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            alertView.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
