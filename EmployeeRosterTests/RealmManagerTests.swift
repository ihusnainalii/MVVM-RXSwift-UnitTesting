//
//  RealmManagerTests.swift
//  EmployeeRosterTests
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import Cuckoo
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import EmployeeRoster

class RealmManagerTests: QuickSpec {
    override func spec() {
        var testHandler: RealmManager!
        var testScheduler: TestScheduler!
        let employeeModel: EmployeeModel = MockData().stubEmployeeModel() ?? EmployeeModel.empty

        describe("RealmManager") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                testHandler = RealmManager(withQueueScheduler: MainScheduler.instance)
            }

            describe("when save Employee List to local DB succeed ", {
                var result: MaterializedSequenceResult<Never>?
                beforeEach {
                    result = testHandler.saveEmployeeInfo(withInfo: employeeModel).toBlocking().materialize()
                }
                it("it completed successfully", closure: {
                    result?.assertSequenceCompletes()
                })
            })

            describe("when get jobs Closed Jobs List from local DB succeed ", {
                var result: MaterializedSequenceResult<Never>?

                beforeEach {
                    result = testHandler.saveEmployeeInfo(withInfo: employeeModel).toBlocking().materialize()
                }
                it("it completed successfully", closure: {
                    result?.assertSequenceCompletes()
                })
                it("return the news list from DB", closure: {
                    let observable = testHandler.fetchEmployeeInfo().asObservable()

                    let res = testScheduler.start { observable }
                    expect(res.events.count).to(equal(2))
                    let correctResult = [Recorded.next(200, employeeModel),
                                         Recorded.completed(200)]
                    expect(res.events).to(equal(correctResult))
                })
            })
        }
    }
}
