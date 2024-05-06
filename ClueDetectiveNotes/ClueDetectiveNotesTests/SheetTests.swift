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
        sheet = Sheet(players: DummyPlayers.players, cards: Edition.classic.cards)
    }
    
    override func tearDownWithError() throws {
        sheet = nil
    }
    
    // 어떤 셀도 선택되지 않은 상태에서 셀을 선택하면 셀에 마커를 선택할 수 있다
    // 어떤 셀도 선택되지 않은 상태에서 셀을 선택하면 선택한 셀 리스트에 추가된다
    func test_selectOneCellWithoutAnyCellSelectedCanChooseMarkers() throws {
        XCTAssertFalse(sheet.hasSelectedCell())
        
        let _ = try sheet.selectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertTrue(sheet.hasSelectedCell())
    }
    
    // 멀티모드가 아닐 때, 어떤 셀이 선택된 상태에서 어떤 셀이든 선택하면 선택이 취소된다
    // -> 다른 셀이 선택되는 것이 아니라? 사용자가 셀이 아닌 다른 곳을 터치한다면?
    func test_selectAnyCellWhileOneCellSelectedUnselectTheCell() throws {
        let _ = try sheet.selectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertTrue(sheet.hasSelectedCell())
        
        sheet.unselectCell()
        
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
        
        let _ = try sheet.multiUnselectCell(
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
    
    // rowname만 선택되었을 때 row에 해당하는 cell들을 반환한다.
    func test_returnCellsForRownameSelection() {
        let rowName = sheet.getRowNames()[0]
        let cells = sheet.selectRowName(rowName)
        
        XCTAssertEqual(cells.count, sheet.getColNames().count)
        
        cells.forEach { cell in
            XCTAssertEqual(cell.getRowName(), rowName)
        }
    }
    
    // colname만 선택되었을 때 col에 해당하는 cell들을 반환한다
    func test_returnCellsForColnameSelection() {
        let colName = sheet.getColNames()[0]
        let cells = sheet.selectColumnName(colName)
        
        XCTAssertEqual(cells.count, sheet.getRowNames().count)
        
        cells.forEach { cell in
            XCTAssertEqual(cell.getColName(), colName)
        }
    }
    
//    // rowname과 colname이 선택되었을 때 해당하는 cell들을 반환한다
//    // selectRowAndColumn 없이 기존 selectRow와 selectColumn으로 충분하지 않을까
//    func test_returnCellsForRownameAndColnameSelection() {
//        let rowName = sheet.getRowNames()[0]
//        let colName = sheet.getColNames()[0]
//        
//        sheet.selectRow(rowName)
//        sheet.selectColumn(colName)
//        
//        let cells = sheet.getCellsInSelectedRowAndColumn(intersectionOnly: false)
//        
//        XCTAssertEqual(
//            cells.count,
//            sheet.getColNames().count + sheet.getRowNames().count - 1
//        )
//        
//        cells.forEach { cell in
//            guard cell.getColName() == colName || cell.getRowName() == rowName else {
//                XCTFail()
//                return
//            }
//        }
//    }
//    
//    // 선택된 rowname을 다시 선택하면 해당 rowname이 선택 해제된다.
//    func test_deselectRownameOnReselection() {
//        let rowName = sheet.getRowNames()[0]
//        
//        sheet.selectRow(rowName)
//        sheet.selectRow(rowName)
//        
//        XCTAssertFalse(sheet.hasSelectedRowName())
//    }
//    
//    // rowname이 선택된 상태에서 같은 카테고리의 rowname이 선택되었을 때 이전 rowname은 선택 해제되고, 해당 rowname은 선택된다.
//    func test_selectNewRownameAndDeselectPreviousInSameCategory() {
//        let firstRowName = sheet.getRowNames()[0]
//        let secondRowName = sheet.getRowNames()[1]
//        sheet.selectRow(firstRowName)
//        sheet.selectRow(secondRowName)
//        
//        let selectedRowNames = sheet.getSelectedRowNames()
//        
//        XCTAssertEqual(selectedRowNames[firstRowName.card.type], secondRowName)
//    }
//    
//    // rowname이 선택된 상태에서 다른 카테고리의 rowname이 선택되었을 때 해당 rowname이 추가된다.
//    func test_addRownameSelectionInDifferentCategory() {
//        let firstRowName = sheet.getRowNames()[0]
//        let secondRowName = sheet.getRowNames()[10]
//        sheet.selectRow(firstRowName)
//        sheet.selectRow(secondRowName)
//        
//        let selectedRowNames = sheet.getSelectedRowNames()
//        
//        XCTAssertEqual(selectedRowNames[firstRowName.card.type], firstRowName)
//        XCTAssertEqual(selectedRowNames[secondRowName.card.type], secondRowName)
//    }
//
//    // colname이 선택된 상태에서 colname이 선택되었을 때 이전 colname은 선택 해제되고, 해당 colname은 선택된다.
//    func test_selectNewColnameAndDeselectPrevious() {
//        let firstColName = sheet.getColNames()[0]
//        let secondColName = sheet.getColNames()[1]
//        sheet.selectColumn(firstColName)
//        sheet.selectColumn(secondColName)
//        
//        let selectedColName = sheet.getSelectedColName()
//        
//        XCTAssertEqual(selectedColName, secondColName)
//    }
//    
//    // 용의자, 무기, 장소에 해당하는 rowname 3개가 player(colname)가 선택되었을 때, 하이라이트를 위한 셀을 반환한다
//    func test_returnCellsForSelectedCategories() {
//        let suspect = sheet.getRowNames()[0]
//        let weapon = sheet.getRowNames()[7]
//        let room = sheet.getRowNames()[12]
//        let player = sheet.getColNames()[0]
//        
//        sheet.selectRow(suspect)
//        sheet.selectRow(weapon)
//        sheet.selectRow(room)
//        sheet.selectColumn(player)
//        
//        let cells = sheet.getCellsInSelectedRowAndColumn(intersectionOnly: false)
//        
//        let filteredBySuspect = cells.filter { $0.getRowName() == suspect }
//        let filteredByWeapon = cells.filter { $0.getRowName() == weapon }
//        let filteredByRoom = cells.filter { $0.getRowName() == room }
//        let filteredByPlayer = cells.filter { $0.getColName() == player }
//        
//        XCTAssertEqual(filteredBySuspect.count, sheet.getColNames().count)
//        XCTAssertEqual(filteredByWeapon.count, sheet.getColNames().count)
//        XCTAssertEqual(filteredByRoom.count, sheet.getColNames().count)
//        XCTAssertEqual(filteredByPlayer.count, sheet.getRowNames().count)
//    }
    
    // 용의자, 무기, 장소에 해당하는 rowname 3개가 player(colname)가 선택되었을 때, 추리세트(셀)를 반환한다
    func test_returnClueSetForSelectedCategories() {
        let suspect = sheet.getRowNames()[0] // 스칼렛
        let weapon = sheet.getRowNames()[7] // 나이프
        let room = sheet.getRowNames()[12] // 침실
        let player = sheet.getColNames()[0] // 코코
        
        _ = sheet.selectRowName(suspect)
        _ = sheet.selectRowName(weapon)
        _ = sheet.selectRowName(room)
        _ = sheet.selectColumnName(player)
        
        let cells = try! sheet.getCellsIntersectionOfSelection()
        
        XCTAssertEqual(cells.count, 3)
    }
}
