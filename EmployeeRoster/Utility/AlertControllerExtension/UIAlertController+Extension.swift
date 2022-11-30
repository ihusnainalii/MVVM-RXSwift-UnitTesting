//
//  UIAlertController+Extension.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

// MARK: - UIAlertController

extension UIAlertController {
    public func addAction(actions: [AlertAction]) -> Observable<Int> {
        return Observable.create { [weak self] observer in
            actions.map { action in
                UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(action.type)
                    observer.onCompleted()
                }
                }.forEach { action in
                    self?.addAction(action)
            }

            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
