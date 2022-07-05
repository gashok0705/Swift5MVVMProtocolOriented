//
//  PostsCollectionViewCell.swift
//  MVVMProtocolOriented
//
//  Created by Rajagopal Ganesan on 04/07/22.
//

import UIKit

class PostsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var postTitle: UILabel!
    @IBOutlet private weak var postBody: UILabel!
    
    func populateValues(_ usersModel: Users) {
        self.postTitle.text = usersModel.name
        self.postBody.text = usersModel.email
    }
}
