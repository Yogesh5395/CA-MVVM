//
//  TabBarViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 07/12/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems(leftButtonTitle: "", rightButtonTitle: "", logoImageName: ImageName.logoImageName, showLogoImage: false, backgroundColor: .white)
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let index = viewControllers?.firstIndex(of: viewController) {
            print("Selected tab index: \(index)")
            // Perform additional actions based on tab selection
            
            switch index {
            case 0:
                // Perform action for the first tab
                navigateToFirstTabRelatedScreen()
            case 1:
                // Perform action for the second tab
                navigateToSecondTabRelatedScreen()
                // Add more cases for additional tabs
            case 2:
                navigateToThirdTabRelatedScreen()
            default:
                break
            }
        }
    }
    
    
    func navigateToFirstTabRelatedScreen() {
//        let storyboard = UIStoryboard(name: StoryboardName.product, bundle: nil) // Replace "Main" with your storyboard name
//        if let newViewController = storyboard.instantiateViewController(withIdentifier: addProductSBN_SBI.addProduct_ViewController) as? AddProduct_ViewController {
//            // Configure the new view controller if needed
//
//            // Present the view controller
//            self.present(newViewController, animated: true, completion: nil)
//        }
    }
    
    func navigateToSecondTabRelatedScreen() {
        
    }
    
    func navigateToThirdTabRelatedScreen() {
        
    }
}
