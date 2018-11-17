//
//  DataManager.swift
//  MultithreadingProject
//
//  Created by Тимур Бадретдинов on 17/11/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit

class DataManager: PostDataProtocol  {

    static let sharedInstance = DataManager()
    var postsArray: [PostModel] = []
    
    init(){
         postsArray.append(PostModel(id: 0, authorAvatar: #imageLiteral(resourceName: "iv1"), postImage: #imageLiteral(resourceName: "iv2"), authorName: "Timur Badretdinov", postDate: "02.04.1998", postText: "Although these classes actually can support the display of arbitrary amounts of text, labels and text fields are intended to be used for relatively small amounts of text, typically a single line. Text views, on the other hand, are meant to display large amounts of text."))
    }
    
    
    // MARK: - Operation queues
    private lazy var getPostOperationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Search queue"
        
        return queue
    }()
    
    private lazy var addOperationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Add post queue"
        return queue
    }()
    
    private lazy var getAllPostsOperationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "Get all posts queue"
        return queue
    }()

    func getPostSync(by id: Int) -> PostModel? {
        postsArray = postsArray.filter{ post in post.id == id}
        return postsArray.first
    }
    
    func getPostAsync(by id: Int, completionBlock: @escaping (PostModel?) -> Void) {
        getPostOperationQueue.addOperation{ [weak self] in
            guard let strongSelf = self else { return }
            completionBlock(strongSelf.postsArray.filter{ model in model.id == id}.first)
        }
    }
    
    func addPostSync(postModel: PostModel) {
        postsArray.append(postModel)
    }
    
    func addPostAsync(postModel: PostModel, completionBlock: @escaping (Bool) -> Void) {
        addOperationQueue.addOperation {
            self.addPostSync(postModel: postModel)
            completionBlock(true)
        }
    }
    
    func getAllPostsSync() -> [PostModel] {
        return postsArray
    }
    
    func getAllPostsAsync(completionBlock: @escaping ([PostModel]) -> Void) {
        getAllPostsOperationQueue.addOperation{ [weak self] in
            guard let strongSelf = self else { return }
            completionBlock(strongSelf.postsArray)
        }
    }
}
