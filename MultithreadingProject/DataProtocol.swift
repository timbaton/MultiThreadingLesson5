//
//  DataProtocol.swift
//  MultithreadingProject
//
//  Created by Тимур Бадретдинов on 17/11/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit

protocol PostDataProtocol {
    func getPostSync(by id: Int) -> PostModel?
    func getPostAsync(by id: Int, completionBlock: @escaping (PostModel?) -> Void)
    
    func addPostSync(postModel: PostModel)
    func addPostAsync(postModel: PostModel, completionBlock: @escaping (Bool) -> Void)
    
    func getAllPostsSync() -> [PostModel]
    func getAllPostsAsync(completionBlock: @escaping ([PostModel]) -> Void) -> Void
}
