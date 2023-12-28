//
//  ProductViewModel.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation

class ProductViewModel {
    
    var productsVM:[SingleProductViewModel] = []
    var filteredProductsVM: [SingleProductViewModel] = []
    var deletedProductsVM: [SingleProductViewModel] = []
    var nonDeletedProductsVM: [SingleProductViewModel] = []
    var deletedFavProductsVM: [SingleProductViewModel] = []
    
    var eventHandler: ((_ event:Event) -> Void)? // Data Binding Closure
    
    var productUseCase: ProductUseCase
    init(productUseCase: ProductUseCase) {
        self.productUseCase = productUseCase
    }
    
    func fetchProductList() {
        self.eventHandler?(.loading)
        self.productUseCase.fetch() { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.productsVM = products.map{SingleProductViewModel(product: $0)}
                self.eventHandler?(.dataLoad)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func updateProductFavouriteStatus(forID id: Int16, toNewStatus newStatus: Bool) {
        self.productUseCase.updateProductFavouriteStatus(forID: id, toNewStatus: newStatus)
    }
    
    func updateProductFavouriteDeleteStatus(forID id: Int16, toNewStatus newStatus: Bool) {
        self.productUseCase.updateProductFavouriteDeleteStatus(forID: id, toNewStatus: newStatus)
    }
    
    func deleteProduct(forID id: Int16) -> Bool {
        self.productUseCase.deleteProduct(forID: id)
    }
}

extension ProductViewModel {
    // Only without deleted Products means normal + favourite
    func filterOutDeletedProducts() -> [SingleProductViewModel]{
        nonDeletedProductsVM = productsVM.filter { product in
            return !product.isDeleted_
        }
        
        return nonDeletedProductsVM
    }
    
    // Only Deleted + Favourite Products
    func filterDeletedandFavouriteProducts()  -> [SingleProductViewModel] {
        deletedFavProductsVM = productsVM.filter { product in
            return product.isDeleted_ && product.favourite
        }
        
        return deletedFavProductsVM
    }
    
    // Only Deleted Products
    func filterDeletedProducts() -> [SingleProductViewModel] {
        deletedProductsVM = productsVM.filter { product in
            return product.isDeleted_
        }
        
        return deletedProductsVM
    }
    
    // Only Favourite Products
    func filterFavProducts() {
        filteredProductsVM = productsVM.filter { product in
            return product.favourite
        }
    }
}
