//
//  BaseViewController.swift
//  VollyballManship
//
//  Created by 龚梦洋 on 2023/7/15.
//

import Foundation
import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    public lazy var naviView: BaseNavigationView = {
        let view = BaseNavigationView()
        return view
    }()
    
    public var barView: UIView {
        get {
            return naviView.barView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        let viewControllers = self.navigationController?.viewControllers
        if self == viewControllers?.first {
            isBackHidden = true
        }
        
        view.addSubview(naviView)
        naviView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(kNavigationBarHeight)
        }
        
        naviView.backBlock = { [weak self] in
            guard let `self` = self else { return }
            self.backButtonEvent()
        }
    }
    
    var isBackHidden: Bool = false {
        didSet {
            naviView.naviBackButton.isHidden = isBackHidden
        }
    }
    
    public func backButtonEvent() {
        self.navigationController?.popViewController(animated: true)
    }
}
