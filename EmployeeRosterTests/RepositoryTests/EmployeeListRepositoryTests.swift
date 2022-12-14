//
//  EmployeeListRepositoryTests.swift
//  EmployeeRosterTests
//
//  Created by Husnain Ali on 26/11/22.
//  Copyright © 2022 HusnainnAli. All rights reserved.
//

import Cuckoo
@testable import EmployeeRoster
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest
import XCTest

final class EmployeeListRepositoryTests: QuickSpec {
    override func spec() {
        var testViewModel: EmployeeListRepository!
        var mockGetEmployeeInfo: MockEmployeeNetworkHandling!
        var mockRealmManager: MockRealmManagerDataSource!

        var testScheduler: TestScheduler!
        let employeeModel: EmployeeModel = MockData().stubEmployeeModel() ?? EmployeeModel.empty
        let employeeList = MockData().employeeList()

        describe("EmployeeListRepository") {
            beforeEach {
                testScheduler = TestScheduler(initialClock: 0)
                mockGetEmployeeInfo = MockEmployeeNetworkHandling()
                stub(mockGetEmployeeInfo, block: { stub in
                    when(stub.request()).thenReturn(Observable.just(EmployeeModel.empty))
                })

                mockRealmManager = MockRealmManagerDataSource()
                stub(mockRealmManager) { stub in
                    when(stub.fetchEmployeeInfo()).thenReturn(Single.just(employeeModel))
                    when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                }

                testViewModel = EmployeeListRepository(withGetWeather: mockGetEmployeeInfo, withRealmManager: mockRealmManager)
            }

            describe("Get Employee Info from server", {
                context("when server request succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(employeeModel))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.error(MockError.unknown))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
                        _ = try? testViewModel.getRosterInfo().toBlocking(timeout: 2).toArray()
                    }
                    it("it completed successfully", closure: {
                        verify(mockGetEmployeeInfo).request()
                    })
                    it("it save to local DB successfully", closure: {
                        verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                    })

                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, employeeList),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when server request failed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.error(RxError.noElements))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.error(MockError.unknown))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
                    }

                    it("doesnt emits employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(1))
                        let correctResult = [Recorded.completed(200, [[EmployeeListDTO]].self)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })

            describe("Save and retreive Employee Info from Database", {
                context("when saveEmployeeInfo to realmManager succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(employeeModel))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.error(MockError.unknown))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.empty())
                        }
                        _ = try? testViewModel.getRosterInfo().toBlocking(timeout: 2).toArray()
                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                    })
                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, employeeList),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when saveEmployeeInfo to realmManager failed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.just(employeeModel))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.error(MockError.unknown))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.error(MockError.unknown))
                        }
                        _ = try? testViewModel.getRosterInfo().toBlocking(timeout: 2).toArray()
                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        verify(mockRealmManager).saveEmployeeInfo(withInfo: any())
                    })
                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, employeeList),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })

                context("when getRosterInfo from realmManager succeed ", {
                    beforeEach {
                        stub(mockGetEmployeeInfo, block: { stub in
                            when(stub.request()).thenReturn(Observable.error(MockError.unknown))
                        })
                        stub(mockRealmManager) { stub in
                            when(stub.fetchEmployeeInfo()).thenReturn(Single.just(employeeModel))
                            when(stub.saveEmployeeInfo(withInfo: any())).thenReturn(Completable.error(MockError.unknown))
                        }
                        _ = try? testViewModel.getRosterInfo().toBlocking(timeout: 2).toArray()
                    }
                    it("calls to realmManager to saveEmployeeInfo", closure: {
                        verify(mockRealmManager).fetchEmployeeInfo()
                    })
                    it("emits the employeeResult to the UI", closure: {
                        let res = testScheduler.start { testViewModel.getRosterInfo().asObservable() }
                        expect(res.events.count).to(equal(2))
                        let correctResult = [Recorded.next(200, employeeList),
                                             Recorded.completed(200)]
                        expect(res.events).to(equal(correctResult))
                    })
                })
            })
        }
    }
}
