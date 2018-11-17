//
//  DataProtocol.swift
//  MultithreadingProject
//
//  Created by Тимур Бадретдинов on 17/11/2018.
//  Copyright © 2018 Ильдар Залялов. All rights reserved.
//

import UIKit

protocol PostDataProtocol {
    func syncSearchModel(by id: Int) -> PostModel?
    func asyncSearchModel(by id: Int, completionBlock: @escaping (PostModel?) -> Void)
    
    func addModelSync(postModel: PostModel)
    func addModelAsync(postModel: PostModel, completionBlock: @escaping (Bool) -> Void)
}
