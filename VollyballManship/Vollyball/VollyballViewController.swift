//
//  VollyballViewController.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/15.
//

import Foundation
import UIKit
import SwiftDate

class VollyballViewController: BaseViewController{
    
    private var dataSource: [Date] = []
    
    private lazy var baseViewController: BaseViewController = {
        let viewController = BaseViewController()
        return viewController
    }()
    
    private lazy var bgView: BaseFirstView = {
        let view = BaseFirstView()
        return view
    }()
    
    //打卡
    private lazy var clockBgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor(red: 120 / 255, green: 120 / 255, blue: 120 / 255, alpha: 0.5).cgColor
        view.layer.cornerRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 8
        return view
    }()
    
    private lazy var clockLabelView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var clockLinkLabel: UILabel = {
        let label = UILabel()
        label.text = "今天也要加油啊～"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var clockPicBgView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var clockCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (kScreenWidth - 48 - (16 * 6)) / 7
        layout.itemSize = CGSize(width: width, height: 70)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(ClockCell.self, forCellWithReuseIdentifier: "ClockCell")
        return collectionView
    }()
    
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "vollyballBgImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var clockButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(red: 133 / 255, green: 192 / 255, blue: 248 / 255, alpha: 1)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.setTitle("今日打卡", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .heavy)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(jumpEvent), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSource = DateToolsMannager.getWeeksDate() ?? []
        clockCollectionView.reloadData()
        
//        clockDayNumberLabel.text = "\(cl)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        bgView.headTitle = "首页"
        view.backgroundColor = .white
        bgView.rightImageIsHidden = false
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(clockBgView)
        clockBgView.snp.makeConstraints { make in
            make.top.equalTo(kTopSafeHeight + 100)
            make.left.equalTo(28)
            make.right.equalTo(-28)
            make.height.equalTo(180)
        }
        
        clockBgView.addSubview(clockLabelView)
        clockLabelView.snp.makeConstraints { make in
            make.top.equalTo(32)
            make.height.equalTo(24)
            make.left.equalTo(8)
            make.right.equalTo(-8)
        }
        
        clockLabelView.addSubview(clockLinkLabel)
        clockLinkLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        clockBgView.addSubview(clockCollectionView)
        clockCollectionView.snp.makeConstraints { make in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.bottom.equalTo(-32)
            make.top.equalTo(clockLabelView.snp.bottom).offset(12)
        }
        
        bgView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalTo(clockBgView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(250)
        }
        
        bgView.addSubview(clockButton)
        clockButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-(kBottomSafeHeight + kTabbarHeight + 30))
        }
    }
    
    @objc func jumpEvent() {
        let vc = ClockViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension VollyballViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClockCell", for: indexPath) as? ClockCell
        cell?.date = dataSource[indexPath.item]
        return cell ?? ClockCell()
    }
}

class ClockCell: UICollectionViewCell {
    
    public lazy var clockImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "unclock"))
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    public lazy var clockLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.isUserInteractionEnabled = false
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
        contentView.backgroundColor = UIColor(red: 133 / 255, green: 192 / 255, blue: 248 / 255, alpha: 1)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(clockImageView)
        clockImageView.snp.makeConstraints { make in
            make.top.equalTo(12)
            make.width.height.equalTo(28)
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(clockLabel)
        clockLabel.snp.makeConstraints { make in
            make.top.equalTo(clockImageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(-4)
        }
    }
    
    var date: Date? {
        didSet {
            if let date = date {
                let week = DateToolsMannager.getWeekday(date)
                let models = ClockRecordManager.shared.getRecordInfo()
                let recordDates = models.map { model in
                    return model.date
                }
                var hasRecord = false
                for rDate in recordDates {
                    let rDates = DateToolsMannager.dateFromTimestamp(timeStamp: rDate ?? 0)
                    if (Calendar.current.isDate(rDates, inSameDayAs: date)) {
                        hasRecord = true
                        break
                    }
                }
                clockImageView.image = hasRecord ? UIImage(named: "clock") : UIImage(named: "unclock")
                if (Calendar.current.isDateInToday(date)) {
                    clockLabel.text = "今日"
                } else {
                    clockLabel.text = week
                }
            }
        }
    }
}
