//
//  KeychainManager.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import Foundation
import KeychainAccess
import RxSwift

protocol KeychainHandling: AnyObject {
    func get(key: String) -> Single<String?>
    func getData(key: String) -> Single<Data?>
    func set(value: String, key: String) -> Single<String>
    func set(data: Data, key: String) -> Single<Data>
}

final class KeychainHandler: KeychainHandling {
    private let keyChainServiceKey: String
    private let scheduler: SchedulerType

    init(withKeyChainServiceKey keyChainServiceKey: String,
         andScheduler backgroundScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.userInitiated)) {
        self.keyChainServiceKey = keyChainServiceKey
        self.scheduler = backgroundScheduler
    }

     func get(key: String) -> Single<String?> {
        return getKeychain().map { keychain in
            try keychain.get(key)
        }
    }

    func getData(key: String) -> Single<Data?> {
        return getKeychain().map { keychain in
            try keychain.getData(key)
        }
    }

     func set(value: String, key: String) -> Single<String> {
        return getKeychain().map { keychain in
            try keychain.set(value, key: key)
            return value
        }
    }

    func set(data: Data, key: String) -> Single<Data> {
        return getKeychain().map { keychain in
            try keychain.set(data, key: key)
            return data
        }
    }

    private func getKeychain() -> Single<Keychain> {
        return Single<Keychain>.create { single -> Disposable in
            single(.success(Keychain(service: self.keyChainServiceKey)))
            return Disposables.create()
            }.subscribeOn(scheduler)
    }
}
