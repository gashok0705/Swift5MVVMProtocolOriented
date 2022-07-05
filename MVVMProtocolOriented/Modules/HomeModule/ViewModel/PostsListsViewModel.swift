//
//  PostsListsViewModel.swift
//  MVVMProtocolOriented
//
//  Created by Rajagopal Ganesan on 03/07/22.
//

import Foundation

protocol PostsListsViewModel : AnyObject {
    
    //getting data
    var usersModel: [Users] { get }
    var usersModelCount: Int { get }
    //fetch posts lists
    func fetchPostsLists(completion: @escaping () -> Void)
    
}

class PostsListsViewModelImpl : PostsListsViewModel {
    
    private var _usersModel: [Users] = []
    private var _usersModelCount: Int = 0
    private var _webService : Webservice!
    
    init(webService: Webservice) {
        self._webService = webService
    }
    
    //Protocol Implementation
    var usersModel: [Users] {
        return _usersModel
    }
    var usersModelCount: Int {
        return _usersModelCount
    }
    
    func fetchPostsLists(completion: @escaping () -> Void) {
        _webService.load(resource: Users.all) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?._usersModel = users
                    self?._usersModelCount = users.count
                case .failure(let error):
                    print(error)
                }
                completion()
            }
        }
    }
    
    
}
