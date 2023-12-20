//
//  MainViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 06/12/23.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        resetRootViewController()
    }
    
    func resetRootViewController() {
        // Accessing the SceneDelegate
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            print("SceneDelegate not found")
            return
        }

        // Getting the window from SceneDelegate
        guard let window = sceneDelegate.window else {
            print("Window is nil")
            return
        }
        
        // Create a new instance of the desired new root view controller
        let storyboard = UIStoryboard(name: StoryboardName.tabBar, bundle: nil) // Replace "Main" with your storyboard name if different
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: Main_StoryBordID.TabBarViewController) as? TabBarViewController else {
            print("TabBarViewController could not be instantiated")
            return
        }
        
        // programatically adding the tabbar items 
//        let firstStoryboard = UIStoryboard(name: StoryboardName.product, bundle: nil)
//        let firstViewController = firstStoryboard.instantiateViewController(withIdentifier: addProductSBN_SBI.addProduct_ViewController) as! AddProduct_ViewController
//        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
//
//        tabBarController.viewControllers = [firstViewController]
        
        // Set the new root view controller with or without animation
//        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
//            window.rootViewController = tabBarController
//        }, completion: nil)
        
//        let navigationController = UINavigationController(rootViewController: tabBarController)
//        navigationController.pushViewController(tabBarController, animated: true)

//        self.navigationController?.pushViewController(navigationController, animated: true)
        
//        self.navigationController?.pushViewController(tabBarController, animated: true)
        
        let navigationController = UINavigationController(rootViewController: tabBarController)

        // Assuming you have access to the window from AppDelegate or SceneDelegate
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}

