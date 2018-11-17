//
//  PostViewController.swift
//  TableViewLesson2
//
//  Created by Тимур Бадретдинов on 07.10.2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var ivPostImage: UIImageView!
    @IBOutlet weak var tvPostText: UILabel!
    
    let dataManager = DataManager.sharedInstance
    var postId: Int!
    var post: PostModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        post = dataManager.getPostSync(by: postId)
        ivPostImage.image = post.postImage
        tvPostText.text = post.postText
    }
}
