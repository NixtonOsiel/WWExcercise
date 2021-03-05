//
//  FoodListViewModelTests.swift
//  WW-Exercise-01Tests
//
//  Created by Aylwing Olivas on 1/17/21.
//  Copyright © 2021 Weight Watchers. All rights reserved.
//

import XCTest
import Combine
@testable import WW_Exercise_01

final class FoodListViewModelTests: XCTestCase {

    func testViewModelLoad_invalid() {
        let mockStore = MockFoodListStore_Invalid()
        let mockFoodListViewModelSubscriber = MockFoodListViewModelSubscriber()
        let viewModelStub = FoodListViewModel(store: mockStore)

        XCTAssertFalse(mockFoodListViewModelSubscriber.hasSubscriber)
        viewModelStub.foodEntitySubject.subscribe(mockFoodListViewModelSubscriber)
        XCTAssertTrue(mockFoodListViewModelSubscriber.hasSubscriber)

        viewModelStub.loadData()
        XCTAssertTrue(mockFoodListViewModelSubscriber.recievedError)
    }

    func testViewModelLoad_valid() {
        let mockStore = MockFoodListStore_Valid()
        let mockFoodListViewModelSubscriber = MockFoodListViewModelSubscriber()
        let viewModelStub = FoodListViewModel(store: mockStore)

        XCTAssertFalse(mockFoodListViewModelSubscriber.hasSubscriber)
        viewModelStub.foodEntitySubject.subscribe(mockFoodListViewModelSubscriber)
        XCTAssertTrue(mockFoodListViewModelSubscriber.hasSubscriber)

        viewModelStub.loadData()
        XCTAssertTrue(mockFoodListViewModelSubscriber.recievedInput)
    }

    func testViewModelLoad_Search() {
        let mockStore = MockFoodListStore_Valid()
        let mockFoodListViewModelSubscriber = MockFoodListViewModelSubscriber()
        let viewModelStub = FoodListViewModel(store: mockStore)

        viewModelStub.foodEntitySubject.subscribe(mockFoodListViewModelSubscriber)

        XCTAssertTrue(mockFoodListViewModelSubscriber.input.isEmpty)
        viewModelStub.loadData()
        XCTAssertFalse(mockFoodListViewModelSubscriber.input.isEmpty)

        XCTAssertEqual(mockFoodListViewModelSubscriber.input.count, 8)
        viewModelStub.searchFoodList(for: "Italian")
        XCTAssertEqual(mockFoodListViewModelSubscriber.input.count, 1)

        viewModelStub.searchFoodList(for: "")
        XCTAssertEqual(mockFoodListViewModelSubscriber.input.count, 8)

        viewModelStub.searchFoodList(for: "ITALIAN")
        XCTAssertEqual(mockFoodListViewModelSubscriber.input.count, 1)

        viewModelStub.searchFoodList(for: nil)
        XCTAssertEqual(mockFoodListViewModelSubscriber.input.count, 8)

        viewModelStub.searchFoodList(for: "cook")
        XCTAssertEqual(mockFoodListViewModelSubscriber.input.count, 1)
    }
}

struct MockFoodListStore_Invalid: FoodListsStore {
    func readFoodLists(completion: @escaping (Result<[FoodListItem], APIError>) -> Void) {
        completion(.failure(.decodingError))
    }
}

struct MockFoodListStore_Valid: FoodListsStore {

    func readFoodLists(completion: @escaping (Result<[FoodListItem], APIError>) -> Void) {

        let decoder = JSONDecoder()

        guard
            let stubData = testDataFoodList.data(using: .utf8),
            let decodedEntity = try? decoder.decode([FoodListItem].self, from: stubData) else {
            completion(.failure(.decodingError))
            return
        }

        completion(.success(decodedEntity))
    }
}

final class MockFoodListViewModelSubscriber: Subscriber {

    var hasSubscriber = false
    var recievedInput = false
    var recievedError = false
    var input: Input = []

    typealias Input = [FoodListItem]
    typealias Failure = Error

    /// Subscriber is willing recieve unlimited values upon subscription
    func receive(subscription: Subscription) {
        hasSubscriber = true
        subscription.request(.unlimited)
    }

    /// .none, indicating that the subscriber will not adjust its demand
    func receive(_ input: [FoodListItem]) -> Subscribers.Demand {
        recievedInput = true
        self.input = input
        return .none
    }

    /// Print the completion event
    func receive(completion: Subscribers.Completion<Error>) {
        recievedError = true
        print("Received completion", completion)
    }
}
