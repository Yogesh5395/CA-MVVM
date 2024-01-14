//
//  ProductList_Fetch_Validation_unitTest.swift
//  MVVM_DummyTests
//
//  Created by Yogesh on 11/01/24.
//

import XCTest
@testable import MVVM_Dummy

final class ProductList_Fetch_Validation_unitTest: XCTestCase {
    
    var viewModel: ProductViewModel!
//    var mockService: MockService!
//
//    override func setUp() {
//        super.setUp()
//        mockService = MockService()
//        viewModel = ProductListViewModel(service: mockService)
//    }
//
//    override func tearDown() {
//        viewModel = nil
//        mockService = nil
//        super.tearDown()
//    }
    
    func testFetchProductList() {
        let expectation = XCTestExpectation(description: "Fetch Product List")
        viewModel.fetchProductList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertNotNil(viewModel.productsVM)
        XCTAssertEqual(viewModel.productsVM.count, 2)
    }
    
    func testFetchProductListFailure() {
//        mockService.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Fetch Product List")
        viewModel.fetchProductList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
        XCTAssertNil(viewModel.productsVM)
        XCTAssertNotNil(viewModel.eventHandler)
//        XCTAssertEqual(viewModel.eventHandler(.error()), "Error")
    }
    
}
