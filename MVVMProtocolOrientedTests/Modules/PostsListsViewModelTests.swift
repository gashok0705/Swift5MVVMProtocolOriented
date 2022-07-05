//
//  PostsListsViewModelTests.swift
//  MVVMProtocolOrientedTests
//
//  Created by Rajagopal Ganesan on 04/07/22.
//

import XCTest
@testable import MVVMProtocolOriented

class PostsListsViewModelTests: XCTestCase {
    
    var postListsViewModel: PostsListsViewModel!
    var webService: WebserviceImpl!
    var mockWebService: MockWebService!
    
    override func setUp() {
        super.setUp()
        setupData()
        
    }
    
    override func tearDown() {
        postListsViewModel = nil
        webService = nil
        mockWebService = nil
        super.tearDown()
    }
    
    func setupData() {
        webService = WebserviceImpl()
        mockWebService = MockWebService()
        postListsViewModel = PostsListsViewModelImpl(webService: mockWebService)
    }
    
    func testfetchPostsLists() {
        //Given
        setupData()
        
        mockWebService.resultType = .success
        
        let expected = XCTestExpectation(description: "PostsListsViewModel fetchingPostsLists and runs the callback closure")
        postListsViewModel.fetchPostsLists {
            
            // fulfill the expectation in the async callback
            expected.fulfill()
        }
        
        wait(for: [expected], timeout: 10.0)
        //Then
        print("success response")
        print(self.postListsViewModel.usersModel)
        print(self.postListsViewModel.usersModelCount)
        XCTAssertNotNil(self.postListsViewModel.usersModel)
        XCTAssertNotNil(self.postListsViewModel.usersModelCount)
        
    }
    
    func testfetchPostsListsFailure() {
        //Given
        setupData()
        
        mockWebService.resultType = .failure
        
        let expected = XCTestExpectation(description: "PostsListsViewModel fetchingPostsLists and runs the callback closure with failure")
        postListsViewModel.fetchPostsLists {
            
            // fulfill the expectation in the async callback
            expected.fulfill()
        }
        
        wait(for: [expected], timeout: 10.0)
        //Then
        print("================================")
        print("failure response")
        print(self.postListsViewModel.usersModel)
        print(self.postListsViewModel.usersModelCount)
        XCTAssertEqual(self.postListsViewModel.usersModelCount, 0)
        XCTAssertTrue((self.postListsViewModel.usersModel.count == 0), "Success")
        
    }
    
}

class MockWebService: Webservice {
    
    enum ResponseType: String {
        case success
        case failure
    }
    
    var resultType: ResponseType!
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        
        switch resultType {
        case .failure:
            completion(.failure(.decodingError))
        case .success:
            let jsonString = """
            [{"id":4264,"name":"Laxmi Patil","email":"laxmi_patil@funk-walsh.co","gender":"female","status":"inactive"},{"id":4263,"name":"Aaditya Prajapat","email":"aaditya_prajapat@sporer.info","gender":"female","status":"inactive"}
            ]
            """
            let jsonData = Data(jsonString.utf8)
            let decoder = JSONDecoder()
            do {
                let users = try decoder.decode([Users].self, from: jsonData)
                completion(.success(users as! T))
                //print(people)
            } catch {
                print("Error is \(error.localizedDescription)")
            }
            //completion(.success(result as! T))
        default:
            print("No Matches Found")
        }
    }
    
}
