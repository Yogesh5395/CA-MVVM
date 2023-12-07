//
//  ViewController.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 06/12/23.
//

import UIKit

class ProductListViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            setupNavigationItems(leftButtonTitle: "Left", rightButtonTitle: "Right", logoImageName: logoImageName)
        }

        override func leftBarButtonTapped() {
            print("Left button tapped in MyViewController")
        }

        override func rightBarButtonTapped() {
            print("Right button tapped in MyViewController")
        }

}

