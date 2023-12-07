//
//  navBarExtension.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 06/12/23.
//

import UIKit

extension UIViewController {
    
    func setupNavigationItems(leftButtonTitle: String, rightButtonTitle: String, logoImageName: String) {
        // Left Bar Button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftButtonTitle, style: .plain, target: self, action: #selector(leftBarButtonTapped))

        // Right Bar Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightButtonTitle, style: .plain, target: self, action: #selector(rightBarButtonTapped))

        // Logo in the Center
        let logoImage = UIImage(named: logoImageName)
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = logoImageView
    }

    @objc func leftBarButtonTapped() {
        // Override in individual view controller to provide specific functionality
    }

    @objc func rightBarButtonTapped() {
        // Override in individual view controller to provide specific functionality
    }
}

class CustomNavigationView: UIView {

    let logoImageView = UIImageView()
    let segmentedControl = UISegmentedControl(items: ["All", "Favourites"])
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // Configure and add the logo image view
        logoImageView.image = UIImage(named: "brandLogo") // Replace with your logo
        logoImageView.contentMode = .scaleAspectFit
        addSubview(logoImageView)

        // Configure the segmented control
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
        addSubview(segmentedControl)

        // Configure the title label
        titleLabel.text = "Your Large Title"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold) // Customize as needed
        addSubview(titleLabel)

        // Set up layout constraints
        setupConstraints()
    }

    @objc private func setupConstraints() {
        // Set translatesAutoresizingMaskIntoConstraints to false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Activate constraints
        NSLayoutConstraint.activate([
            // Logo ImageView Constraints
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 40), // Adjust as needed
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5), // 50% of view width

            // Segmented Control Constraints
            segmentedControl.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5),
            segmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9), // 90% of view width
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),

            // Title Label Constraints
            titleLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5) // Adjust for bottom padding
        ])
    }



    @objc private func segmentedControlChanged(_ sender: UISegmentedControl) {
        // Handle segment change
    }
}
