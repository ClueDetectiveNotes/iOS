//
//  CellTests.swift
//  ClueDetectiveNotesTests
//
//  Created by Yena on 2024/04/17.
//

import XCTest
@testable import ClueDetectiveNotes

final class CellTests: XCTestCase {
    private var cell: Cell!

    override func setUpWithError() throws {
        cell = Cell(
            rowName: RowName(card: Edition.classic.cards.suspects.first!),
            colName: ColName(player: DummyPlayers.players.first!)
        )
    }

    override func tearDownWithError() throws {
        cell = nil
    }
    
    // mainMarker를 설정하면 해당 mainMarker가 추가된다.
    func test_addMainMarker() {
        let mainMarker = MainMarker(notation: .question)
        cell.setMainMarker(mainMarker)
        
        let expectation = cell.getMainMarker()
        
        XCTAssertEqual(mainMarker, expectation)
    }
    
    // subMarker를 설정하면 해당 subMarker가 추가된다.
    func test_addSubMarker() {
        let subMarker = SubMarker(notation: "a")
        cell.setSubMarker(subMarker)
        
        let expectation = cell.getSubMarkers()
        
        XCTAssertTrue(expectation.contains(subMarker))
    }

    // 이미 설정된 mainMarker를 다시 설정하면 해당 mainMarker가 삭제된다.
    func test_removeMainMarkerIfAlreadySet() {
        let mainMarker = MainMarker(notation: .question)
        cell.setMainMarker(mainMarker)
        cell.setMainMarker(mainMarker)
        
        let expectation = cell.getMainMarker()
        
        XCTAssertNil(expectation)
    }
    
    // 이미 설정된 subMarker를 다시 설정하면 해당 subMarker가 삭제된다.
    func test_removeSubMarkerIfAlreadySet() {
        let subMarker = SubMarker(notation: "a")
        cell.setSubMarker(subMarker)
        cell.setSubMarker(subMarker)
        
        let expectation = cell.getSubMarkers()
        
        XCTAssertFalse(expectation.contains(subMarker))
    }

    // main marker가 있는 상태에서 main marker가 들어오면 새로운 값으로 override된다.
    func test_overrideMainMarkerIfAlreadyExists() {
        let previousMainMarker = MainMarker(notation: .question)
        let mainMarker = MainMarker(notation: .exclamation)
        cell.setMainMarker(previousMainMarker)
        cell.setMainMarker(mainMarker)
        
        let expectation = cell.getMainMarker()
        
        XCTAssertEqual(mainMarker, expectation)
    }

    // sub marker가 있는 상태에서 sub marker가 들어오면 markers에 추가된다.
    func test_addSubMarkerIfAlreadyExists() {
        let previousSubMarker = SubMarker(notation: "a")
        let subMarker = SubMarker(notation: "b")
        cell.setSubMarker(previousSubMarker)
        cell.setSubMarker(subMarker)
        
        let expectation = cell.getSubMarkers()
        
        XCTAssertTrue(expectation.contains(previousSubMarker))
        XCTAssertTrue(expectation.contains(subMarker))
    }
}
