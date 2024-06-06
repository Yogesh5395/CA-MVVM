//
//  AddProductViewModel.swift
//  MVVM_Dummy
//
//  Created by Yogesh on 19/12/23.
//

import Foundation
import Combine

class AddProductViewModel {
    
    var productsVM:[SingleProductViewModel] = []
    var productVM:SingleProductViewModel?
    var eventHandler: (((Event)?) -> Void)?
    // Combine subjects
    var eventHandlerSubject = PassthroughSubject<Event, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    let addProductUseCases: AddProductUseCases
    init(addProductUseCases: AddProductUseCases) {
        self.addProductUseCases = addProductUseCases
    }
    
    func uploadProduct() {
        self.eventHandlerSubject.send(.loading)
        self.addProductUseCases.uploadProduct()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.eventHandlerSubject.send(.error(error))
                }
            } receiveValue: { product in
                self.productVM = SingleProductViewModel.init(product: product)
                self.eventHandlerSubject.send(.dataLoad)
            }
            .store(in: &self.cancellables)

    }
}
