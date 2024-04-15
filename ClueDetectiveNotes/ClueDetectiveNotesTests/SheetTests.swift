//
//  SheetTests.swift
//  SheetTests
//
//  Created by Dasan & Mary on 2024/03/31.
//

import XCTest
@testable import ClueDetectiveNotes

final class SheetTests: XCTestCase {
    private var sheet: Sheet!
    
    override func setUpWithError() throws {
        sheet = Sheet(players: DummyPlayers.players)
    }
    
    override func tearDownWithError() throws {
        sheet = nil
    }
    
    // 어떤 셀도 선택되지 않은 상태에서 셀을 선택하면 셀에 마커를 선택할 수 있다
    // 어떤 셀도 선택되지 않은 상태에서 셀을 선택하면 선택한 셀 리스트에 추가된다
    func test_selectOneCellWithoutAnyCellSelectedCanChooseMarkers() throws {
        XCTAssertFalse(sheet.hasSelectedCell())
        
        let test = try sheet.selectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertTrue(sheet.hasSelectedCell())
    }
    
    // 어떤 셀이 선택된 상태에서 어떤 셀이든 선택하면 선택이 취소된다
    // 멀티모드가 아닐 때, 어떤 셀이 선택된 상태에서 어떤 셀이든 선택하면 선택이 취소된다
    // -> 다른 셀이 선택되는 것이 아니라? 사용자가 셀이 아닌 다른 곳을 터치한다면?
    func test_selectAnyCellWhileOneCellSelectedUnselectTheCell() throws {
        let _ = try sheet.selectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertTrue(sheet.hasSelectedCell())
        
        sheet.unselectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertFalse(sheet.hasSelectedCell())
    }

    // 어떤 셀도 선택되지 않은 상태에서 멀티 선택 모드로 스위치(long press)했을 때 멀티 선택 모드가 된다.
    func test_switchToMultiSelectionModeFromNoCellSelectedStateOnLongPress() {
        XCTAssertFalse(sheet.hasSelectedCell())
        XCTAssertFalse(sheet.isMultiSelectionMode())
        
        sheet.switchSelectionMode()
        
        XCTAssertTrue(sheet.isMultiSelectionMode())
    }

    // 멀티 선택 모드일 때 선택되지 않은 셀을 선택하면 셀이 추가된다.
    func test_selectUnselectedCellInMultiSelectionModeToAddCell() throws {
        sheet.switchSelectionMode()
        XCTAssertTrue(sheet.isMultiSelectionMode())
       
        let _ = try sheet.selectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertTrue(sheet.hasSelectedCell())
    }

    // 멀티 선택 모드일 때 선택된 셀을 선택하면 해당 셀이 선택 해제된다.
    func test_selectSelectedCellInMultiSelectionModeToDeselectCell() throws {
        sheet.switchSelectionMode()
        XCTAssertTrue(sheet.isMultiSelectionMode())
        
        let _ = try sheet.multiSelectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        let _ = try sheet.multiSelectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertFalse(sheet.hasSelectedCell())
    }

    // 멀티 선택 모드일 때 멀티 선택 모드를 해제하면 모든 셀의 선택이 해제되고, 멀티 선택 모드도 해제된다.
    func test_disableMultiSelectionModeToDeselectAllCellsAndExitMultiSelectionMode() throws {
        sheet.switchSelectionMode()
        XCTAssertTrue(sheet.isMultiSelectionMode())
        
        let _ = try sheet.multiSelectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        sheet.switchSelectionMode()
        XCTAssertFalse(sheet.hasSelectedCell())
        XCTAssertFalse(sheet.isMultiSelectionMode())
    }
}
