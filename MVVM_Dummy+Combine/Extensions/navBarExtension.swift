//
//  navBarExtension.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 06/12/23.
//

import UIKit

extension UIViewController {
    
    func setupNavigationItems(leftButtonTitle: String, rightButtonTitle: String, logoImageName: String, showLogoImage:Bool, backgroundColor:UIColor ) {
        // Left Bar Button
        
        if leftButtonTitle != "" {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: leftButtonTitle, style: .plain, target: self, action: #selector(leftBarButtonTapped))
        }
        
        if rightButtonTitle != "" {
            // Right Bar Button
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightButtonTitle, style: .plain, target: self, action: #selector(rightBarButtonTapped))
        }
        
        if showLogoImage {
            // Logo in the Center
            let logoImage = UIImage(named: logoImageName)
            let logoImageView = UIImageView(image: logoImage)
            logoImageView.contentMode = .scaleAspectFit
            navigationItem.titleView = logoImageView
        }else {
            // Set the title
            self.navigationItem.title = "MOVIUS"
            
            // Customize the navigation bar appearance
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = backgroundColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black] // Set your title color
            appearance.shadowColor = nil // Removes the border
            
            // Apply the appearance to the navigation bar
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }

    @objc func leftBarButtonTapped() {
        // Override in individual view controller to provide specific functionality
    }

    @objc func rightBarButtonTapped() {
        // Override in individual view controller to provide specific functionality
    }
}
