//
//  DependenciesType.swift
//  Foodinko
//
//  Created by 정윤호 on 2020/01/19.
//  Copyright © 2020 Foodinko. All rights reserved.
//


import Foundation
import UIKit


// MARK: Networking
public protocol HasNetworking {
    var networking: LinkedOutNetworking { get }
}


// MARK: Store
public protocol HasPushStore {
    var pushStore: PushStoreType { get }
}

public protocol HasFileStore {
    var fileStore: FileStoreType { get }
}


// MARK: Dependencies
public protocol DependenciesType {
    // logout
    func logout()
}
