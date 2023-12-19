//
//  AddProductViewModel.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation

class AddProductViewModel {
    
    var productsVM:[SingleProductViewModel] = []
    
    var eventHandler: (((Event)?) -> Void)?
    
    let addProductUseCases: AddProductUseCases
    
    init(addProductUseCases: AddProductUseCases) {
        self.addProductUseCases = addProductUseCases
    }
    
    func uploadProduct() {
        
        self.eventHandler?(.loading)
        
        self.addProductUseCases.uploadProduct { response in
            self.eventHandler?(.stopLoading)
            
            switch response {
            case .success(_):
                self.eventHandler?(.dataLoad)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
