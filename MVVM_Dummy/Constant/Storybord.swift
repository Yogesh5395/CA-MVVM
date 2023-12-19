//
//  Storybord.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

enum StoryboardName {
    static let main = "Main"
    static let addProductSBN = "AddProduct_Storyboard"
}

// StoryboardName_StoryBordID
enum Main_StoryBordID {
    static let TabBarViewController = "TabBarViewController"
    static let ProductList_ViewController = "ProductList_ViewController"
}

enum addProductSBN_SBI {
    static let addProduct_ViewController = "AddProduct_ViewController"
}

//CellId_and_Nib_StoryBordID
enum CellId_and_Nib_ProductList_ViewController {
    static let ProductCell = "ProductCell"
}
