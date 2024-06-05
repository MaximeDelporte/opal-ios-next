//
//  HomeViewController.swift
//  opal-ios
//
//  Created by afx on 04/06/2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let referredButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        setUpBindings()
    }
}

// MARK: - Common Methods

extension HomeViewController {
    
    private func setUpViews() {
        view.backgroundColor = .white
        view.addSubview(referredButton)
        referredButton.setTitle("Open Sponsorship View", for: .normal)
        referredButton.setTitleColor(.blue, for: .normal)
    }
    
    private func setUpConstraints() {
        referredButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setUpBindings() {
        referredButton.addTarget(self, action: #selector(openReferredView), for: .touchUpInside)
    }
}

// MARK: - Convenience Methods

extension HomeViewController {
    
    @objc private func openReferredView() {
        let controller = SponsorshipViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController?.present(navigationController, animated: true)
    }
}

