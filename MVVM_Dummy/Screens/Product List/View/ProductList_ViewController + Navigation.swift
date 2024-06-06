//
//  ProductList_ViewController + Navigation.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation
import UIKit

extension ProductList_ViewController {
    
    override func rightBarButtonTapped() {
        print("clicking...")
        
        //        self.addProduct?.addProductDelegate = self
        
        // Create a new instance of the desired new root view controller
        let storyboard = UIStoryboard(name: StoryboardName.product, bundle: nil) // Replace "Main" with your storyboard name if different
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: addProductSBN_SBI.addProduct_ViewController) as? AddProduct_ViewController {
            
            viewController.addProductDelegate = self
            
            if let navigationController = self.navigationController {
                // Push the view controller onto the navigation stack
                navigationController.pushViewController(viewController, animated: true)
            } else {
                print("NavigationController not found. This view controller is not part of a navigation stack.")
            }
        }
        
    }
    
}
