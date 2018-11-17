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
    var post: PostModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ivPostImage.image = post.postImage
        tvPostText.text = post.postText
    }
}
