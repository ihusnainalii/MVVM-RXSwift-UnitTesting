//
//  RealmManager.swift
//  EmployeeRoster
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import CocoaLumberjack
import Foundation
import RealmSwift
import RxSwift

protocol RealmManagerDataSource {
    func saveEmployeeInfo(withInfo data: EmployeeModel) -> Completable
    func fetchEmployeeInfo() -> Single<EmployeeModel>
}

struct RealmManager: RealmManagerDataSource {
    private var queueScheduler: SchedulerType!

    init(withQueueScheduler queueScheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background)) {
        self.queueScheduler = queueScheduler
    }

    /// clear and save employee info to DB
    func saveEmployeeInfo(withInfo info: EmployeeModel) -> Completable {
        return deleteEmployeeInfo()
        .andThen(saveInfo(withInfo: info))
    }

    /// Save employee info to DB
   private func saveInfo(withInfo data: EmployeeModel) -> Completable {
        return Completable.create { completable in
            do {
                let realm = try Realm()
                let realmEmployee = RealmEmployee()

                // ScheduleModel
                let realmSchedule = RealmSchedule()
                if let scheduledToday = data.scheduledToday {
                    realmSchedule.update(withScheduleModel: scheduledToday)
                    realmEmployee.scheduledToday = realmSchedule
                }

                // RosterModel
                if let roster = data.roster {
                    _ = roster.map({ rosterModel -> RealmRoster in
                        let realmRoster = RealmRoster()
                        realmRoster.update(withRosterModel: rosterModel)
                        realmEmployee.roster.append(realmRoster)
                        return realmRoster
                    })
                }
                try realm.write {
                    realmEmployee.update(withEmployeeModel: data)
                    realm.add(realmEmployee)
                }
                completable(.completed)
                return Disposables.create {}
            } catch {
                DDLogError("Realm error: \(error)")
                completable(.error(error))
                return Disposables.create {}
            }
    }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.default))
    }

    /// get employee info from DB
    func fetchEmployeeInfo() -> Single<EmployeeModel> {
        return Single<EmployeeModel>.create { single in
            do {
                let realm = try Realm()
                guard let realmEmployee = realm.objects(RealmEmployee.self).first else {
                    single(.error(RxError.noElements))
                    return Disposables.create {}
                }

                let result = EmployeeModel(withRealmEmployee: realmEmployee)
                DDLogInfo("realmEmployee: \(realmEmployee)")
                single(.success(result))

            } catch {
                DDLogError("Realm error: \(error)")
                single(.error(error))
            }
            return Disposables.create {}
            }.subscribeOn(self.queueScheduler)
    }

    /// clear employee info from DB
    private func deleteEmployeeInfo() -> Completable {
        return Completable.create { completable in
            do {
                let realm = try Realm()
                let realmEmployee = realm.objects(RealmEmployee.self)
                try realm.write {
                    realm.delete(realmEmployee)
                }
                completable(.completed)
                return Disposables.create {}
            } catch {
                DDLogError("Realm error: \(error)")
                completable(.error(error))
                return Disposables.create {}
            }
            }.subscribeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
    }
}
