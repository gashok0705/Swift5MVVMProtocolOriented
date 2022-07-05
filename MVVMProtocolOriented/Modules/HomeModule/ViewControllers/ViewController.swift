//
//  ViewController.swift
//  MVVMProtocolOriented
//
//  Created by Rajagopal Ganesan on 03/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var viewModel : PostsListsViewModel!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpNavigationBar()
        self.viewModel = PostsListsViewModelImpl(webService: WebserviceImpl())
        AlertLoader.shared.showAlert(viewController: self)
        self.loadUsers()
    }
    
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Users"
    }
    
    private func loadUsers() {
        self.viewModel.fetchPostsLists { [weak self] in
            AlertLoader.shared.hideAlert()
            if (self?.viewModel.usersModelCount ?? 0 > 0) {
                self?.reloadCollectionViewData()
            }
        }
    }
    
    private func reloadCollectionViewData() {
        self.postsCollectionView.dataSource = self
        self.postsCollectionView.delegate = self
        self.postsCollectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.usersModelCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell!
        
        if let cell_ = collectionView.dequeueReusableCell(withReuseIdentifier: PostsCollectionViewCellIdentifier, for: indexPath) as? PostsCollectionViewCell {
            
            let currentModel = self.viewModel.usersModel[indexPath.row]
            cell_.populateValues(currentModel)
            cell = cell_
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.height * 0.25)
    }
    
}


