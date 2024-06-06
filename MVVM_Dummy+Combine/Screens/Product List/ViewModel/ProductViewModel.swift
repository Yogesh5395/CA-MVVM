//
//  ProductViewModel.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 08/12/23.
//

import Foundation
import Combine

class ProductViewModel {
    
    var productsVM:[SingleProductViewModel] = []
    var filteredProductsVM: [SingleProductViewModel] = []
    var deletedProductsVM: [SingleProductViewModel] = []
    var nonDeletedProductsVM: [SingleProductViewModel] = []
    var deletedFavProductsVM: [SingleProductViewModel] = []
    var deletedFavFilterProductsVM: [SingleProductViewModel] = []
    
    var eventHandler: ((_ event:Event) -> Void)? // Data Binding Closure
    
    var productUseCase: ProductUseCase
    init(productUseCase: ProductUseCase) {
        self.productUseCase = productUseCase
    }
    
    // Combine subjects
    var eventHandlerSubject = PassthroughSubject<Event, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchProductList() {
        eventHandlerSubject.send(.loading)
        self.productUseCase.fetch()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.eventHandlerSubject.send(.stopLoading)
                if case .failure(let error) = completion {
                    self.eventHandlerSubject.send(.error(error))
                }
            } receiveValue: { products in
                self.productsVM = products.map { SingleProductViewModel(product: $0) }
                self.eventHandlerSubject.send(.dataLoad)
            }
            .store(in: &cancellables) // Store the cancellable to manage the subscription lifecycle
        
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
