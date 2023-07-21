//
//  MedalViewController.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/15.
//

import Foundation
import UIKit

enum MedalType {
    case medal1
    case medal2
    case medal3
    
    var name: String {
        switch self {
        case .medal1:
            return "排球达人"
        case .medal2:
            return "排球能手"
        case .medal3:
            return "排球健将"
        }
    }
    
    var content: String {
        switch self {
        case .medal1:
            return "获奖条件：坚持运动打卡一周"
        case .medal2:
            return "获奖条件：坚持运动打卡一月"
        case .medal3:
            return "获奖条件：坚持运动打卡一年"
        }
    }
}

class MedalViewController: BaseViewController {
        
    private var dataSource: [MedalType] = [.medal1, .medal2, .medal3]
    
    private lazy var medalBgView: BaseFirstView = {
        let view = BaseFirstView()
        return view
    }()
    
    private lazy var medalTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MedalCell.self, forCellReuseIdentifier: "MedalCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        medalTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        medalBgView.headImage = "bgHead"
        medalBgView.headTitle = "荣誉墙"
        medalBgView.rightImageIsHidden = true
        view.backgroundColor = .white
        
        view.addSubview(medalBgView)
        medalBgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        medalBgView.addSubview(medalTableView)
        medalTableView.snp.makeConstraints { make in
            make.top.equalTo(kNavigationBarHeight + 40)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(-(kBottomSafeHeight + 20))
        }
        
        medalBgView.rightTapBlock = { [weak self] in
            guard let `self` = self else { return }
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
    }
}

extension MedalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedalCell", for: indexPath) as! MedalCell
        let medalType = dataSource[indexPath.row]
        cell.medalType = medalType
        if (medalType == .medal1) {
            cell.hasFinished = ClockRecordManager.shared.hasSignedWeek()
        } else if (medalType == .medal2) {
            cell.hasFinished = ClockRecordManager.shared.hasSignedMonth()
        } else {
            cell.hasFinished = ClockRecordManager.shared.hasSignedYear()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

class MedalCell: UITableViewCell {
    
    private lazy var lightBgView: LightMedalView = {
        let view = LightMedalView()
        view.isHidden = true
        return view
    }()
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 228 / 255, green: 228 / 255, blue: 228 / 255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var medalImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "unlightMedal"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var medalNameLabel: UILabel = {
        let label = UILabel()
        label.text = "排球健将"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var medalConditionLabel: UILabel = {
        let label = UILabel()
        label.text = "获得条件：坚持运动打卡一周"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .red
        label.numberOfLines = 0
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
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.top.equalTo(12)
            make.bottom.equalTo(-12)
        }
        
        addSubview(lightBgView)
        lightBgView.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
        }
        
        bgView.addSubview(medalImageView)
        medalImageView.snp.makeConstraints { make in
            make.height.equalTo(108)
            make.width.equalTo(108)
            make.centerY.equalToSuperview()
            make.left.equalTo(24)
        }
        
        bgView.addSubview(medalNameLabel)
        medalNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(medalImageView.snp.centerY).offset(-12)
            make.left.equalTo(medalImageView.snp.right).offset(20)
            make.right.equalToSuperview()
        }
        
        bgView.addSubview(medalConditionLabel)
        medalConditionLabel.snp.makeConstraints { make in
            make.top.equalTo(medalImageView.snp.centerY).offset(12)
            make.left.equalTo(medalImageView.snp.right).offset(20)
            make.right.equalToSuperview()
        }
    }
    
    var medalType: MedalType? {
        didSet {
            if let medalType = medalType {
                medalNameLabel.text = medalType.name
                medalConditionLabel.text = medalType.content
            }
        }
    }
    
    var hasFinished: Bool? {
        didSet {
            if let result = hasFinished {
                lightBgView.isHidden = !result
            }
        }
    }
}
