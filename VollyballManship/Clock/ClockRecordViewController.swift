//
//  ClockRecordViewController.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/17.
//

import Foundation
import UIKit

class ClockRecordViewController: BaseViewController {
    
    private var dataSource: [ClockRecordModel] = []
    
    private lazy var clockBgView: BaseFirstView = {
        let view = BaseFirstView()
        return view
    }()
    
    private lazy var nullBgView: NullRecordView = {
        let view = NullRecordView()
        return view
    }()
    
    private lazy var clockRecordTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ClockRecordCell.self, forCellReuseIdentifier: "ClockRecordCell")
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource = ClockRecordManager.shared.getRecordInfo().reversed()
        clockRecordTableView.reloadData()
        nullBgView.isHidden = false
        if dataSource.isEmpty {
            clockRecordTableView.isHidden = true
            nullBgView.isHidden = false
        } else {
            clockRecordTableView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        clockBgView.headTitle = "锻炼记录"
        clockBgView.rightImageIsHidden = false
        view.addSubview(clockBgView)
        clockBgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        clockBgView.addSubview(nullBgView)
        nullBgView.snp.makeConstraints { make in
            make.top.equalTo(kNavigationBarHeight + 50)
            make.bottom.equalTo(-(kBottomSafeHeight + 20))
            make.width.equalToSuperview()
        }
        
        clockBgView.addSubview(clockRecordTableView)
        clockRecordTableView.snp.makeConstraints { make in
            make.top.equalTo(kNavigationBarHeight + 50)
            make.bottom.equalTo(-(kBottomSafeHeight + 20))
            make.width.equalToSuperview()
        }
    }
}

extension ClockRecordViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClockRecordCell", for: indexPath) as? ClockRecordCell
        cell?.clockRecord = dataSource[indexPath.row]
        return cell ?? ClockRecordCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row]
        let vc = RecordDetailViewController()
        vc.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class ClockRecordCell: UITableViewCell {
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 0.2).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8
        return view
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        selectionStyle = .none
        backgroundColor = .white
        
        contentView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.top.equalTo(24)
            make.bottom.equalTo(-24)
        }
        
        bgView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(20)
        }
        
        bgView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.left.equalTo(12)
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.bottom.equalTo(-12)
            make.right.equalTo(-12)
        }
    }
    
    var clockRecord: ClockRecordModel? {
        didSet {
            if let clockRecord = clockRecord {
                timeLabel.text = DateToolsMannager.getTimeFromTimestamp(timeFormat: "YYYY-MM-dd HH:mm", timeString: clockRecord.date ?? 0) 
                contentLabel.text = clockRecord.record
            }
        }
    }
}
