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
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        guard let newRootVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {
            print("TabBarViewController could not be instantiated")
            return
        }
        
        // Set the new root view controller with or without animation
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {
            window.rootViewController = newRootVC
        }, completion: nil)
    }
    
}

