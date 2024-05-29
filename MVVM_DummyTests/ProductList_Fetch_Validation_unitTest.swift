//
//  ProductList_Fetch_Validation_unitTest.swift
//  MVVM_DummyTests
//
//  Created by Yogesh on 11/01/24.
//

import XCTest
@testable import MVVM_Dummy

final class ProductList_Fetch_Validation_unitTest: XCTestCase {
    
    var viewModel:  MVVM_Dummy.ProductViewModel!

    override func setUp() {
        super.setUp()
        
        // Use the mock service implementation
        let apiManager = MVVM_Dummy.ProductService_MockData()
        let serviceImplementation = MVVM_Dummy.ProductServiceImpl(apiManager: apiManager)
        let persistentStorageObj = MVVM_Dummy.PersistentStorage(inMemory: true)
        let productDataManager = MVVM_Dummy.ProductDataManager(persistentStorageObj: persistentStorageObj)
        let productRepository = MVVM_Dummy.ProductRepository(productServiceImplementation: serviceImplementation, productDataManager: productDataManager)
        let productUseCase = MVVM_Dummy.ProductUseCase(repository: productRepository)
        var viewModel = MVVM_Dummy.ProductViewModel(productUseCase: productUseCase)

    }
    
    func testFetchProductList() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch product list")
        
        // When
        viewModel.eventHandler = { event in
            switch event {
            case .dataLoad:
                // Then
                XCTAssertNotNil(self.viewModel.productsVM, "Products should not be nil")
                XCTAssertEqual(self.viewModel.productsVM.count, 20, "There should be 20 products")
                expectation.fulfill()
            case .error(let error):
                XCTFail("Error fetching products: \(error?.localizedDescription ?? "")")
            default:
                break
            }
        }
        
        viewModel.fetchProductList()
        
        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 5.0)
    }
    

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
}
