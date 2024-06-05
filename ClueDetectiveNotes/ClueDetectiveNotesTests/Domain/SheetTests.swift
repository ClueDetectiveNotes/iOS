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
        XCTAssertFalse(sheet.isMultiMode())
        
        sheet.setMode(.multi)
        
        XCTAssertTrue(sheet.isMultiMode())
    }
    
    // 멀티 선택 모드일 때 선택되지 않은 셀을 선택하면 셀이 추가된다.
    func test_selectUnselectedCellInMultiSelectionModeToAddCell() throws {
        sheet.setMode(.multi)
        XCTAssertTrue(sheet.isMultiMode())
        
        let _ = try sheet.selectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertTrue(sheet.hasSelectedCell())
    }
    
    // 멀티 선택 모드일 때 선택된 셀을 선택하면 해당 셀이 선택 해제된다.
    func test_selectSelectedCellInMultiSelectionModeToDeselectCell() throws {
        sheet.setMode(.multi)
        XCTAssertTrue(sheet.isMultiMode())
        
        let selectedCells = try sheet.multiSelectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        let _ = try sheet.multiUnselectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        XCTAssertFalse(sheet.isSelectedCell(selectedCells.first!))
    }
    
    // 멀티 선택 모드일 때 멀티 선택 모드를 해제하면 모든 셀의 선택이 해제되고, 멀티 선택 모드도 해제된다.
    func test_disableMultiSelectionModeToDeselectAllCellsAndExitMultiSelectionMode() throws {
        sheet.setMode(.multi)
        XCTAssertTrue(sheet.isMultiMode())
        
        let _ = try sheet.multiSelectCell(
            rowName: sheet.getRowNames()[0],
            colName: sheet.getColNames()[0]
        )
        
        sheet.setMode(.single)
        XCTAssertFalse(sheet.hasSelectedCell())
        XCTAssertFalse(sheet.isMultiMode())
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
    
    // rowname과 colname이 선택되었을 때 해당하는 cell들을 반환한다
    // selectRowAndColumn 없이 기존 selectRow와 selectColumn으로 충분하지 않을까
    func test_returnCellsForRownameAndColnameSelection() {
        let rowName = sheet.getRowNames()[0]
        let colName = sheet.getColNames()[0]
        
        _ = sheet.selectRowName(rowName)
        _ = sheet.selectColumnName(colName)
        
        let cells = try! sheet.getCellsIntersectionOfSelection()
        
        //        XCTAssertEqual(
        //            cells.count,
        //            sheet.getColNames().count + sheet.getRowNames().count - 1
        //        )
        
        cells.forEach { cell in
            guard cell.getColName() == colName && cell.getRowName() == rowName else {
                XCTFail()
                return
            }
        }
    }
    
    // 선택된 rowname을 다시 선택하면 해당 rowname이 선택 해제된다.
    func test_deselectRownameOnReselection() {
        let rowName = sheet.getRowNames()[0]
        
        _ = sheet.selectRowName(rowName)
        XCTAssertTrue(sheet.hasSelectedRowName())
        XCTAssertTrue(sheet.isSelectedRowName(rowName))
        
        sheet.unselectRowName(rowName)
        XCTAssertFalse(sheet.hasSelectedRowName())
        XCTAssertFalse(sheet.isSelectedRowName(rowName))
    }
    
    // 선택된 colname을 다시 선택하면 해당 colname이 선택 해제된다.
    func test_deselectColnameOnReselection() {
        let colName = sheet.getColNames()[0]
        
        _ = sheet.selectColumnName(colName)
        XCTAssertTrue(sheet.hasSelectedColName())
        XCTAssertTrue(sheet.isSelectedColName(colName))
        
        sheet.unselectColumnName()
        XCTAssertFalse(sheet.hasSelectedColName())
        XCTAssertFalse(sheet.isSelectedColName(colName))
    }
    
    // rowname이 선택된 상태에서 같은 카테고리의 rowname이 선택되었을 때 이전 rowname은 선택 해제되고, 해당 rowname은 선택된다.
    func test_selectNewRownameAndDeselectPreviousInSameCategory() {
        let firstRowName = sheet.getRowNames()[0]
        let secondRowName = sheet.getRowNames()[1]
        _ = sheet.selectRowName(firstRowName)
        _ = sheet.selectRowName(secondRowName)
        
        let selectedRowNames = sheet.getSelectedRowNames()
        
        XCTAssertEqual(selectedRowNames[firstRowName.card.type], secondRowName)
    }
    
    // rowname이 선택된 상태에서 다른 카테고리의 rowname이 선택되었을 때 해당 rowname이 추가된다.
    func test_addRownameSelectionInDifferentCategory() {
        let firstRowName = sheet.getRowNames()[0]
        let secondRowName = sheet.getRowNames()[10]
        _ = sheet.selectRowName(firstRowName)
        _ = sheet.selectRowName(secondRowName)
        
        let selectedRowNames = sheet.getSelectedRowNames()
        
        XCTAssertEqual(selectedRowNames[firstRowName.card.type], firstRowName)
        XCTAssertEqual(selectedRowNames[secondRowName.card.type], secondRowName)
    }
    
    // colname이 선택된 상태에서 colname이 선택되었을 때 이전 colname은 선택 해제되고, 해당 colname은 선택된다.
    func test_selectNewColnameAndDeselectPrevious() {
        let firstColName = sheet.getColNames()[0]
        let secondColName = sheet.getColNames()[1]
        _ = sheet.selectColumnName(firstColName)
        _ = sheet.selectColumnName(secondColName)
        
        let selectedColName = sheet.getSelectedColName()
        
        XCTAssertEqual(selectedColName, secondColName)
    }
    
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
    
    // 멀티모드에서 셀들을 선택하고 마커를 선택했을 때, 현재 설정된 마커와 관계없이 선택된 모든 셀에 마킹이 된다.
    // 선택된 셀에 마커가 하나도 없는 경우
    func test_whenSelectUnmarkedCellsAndChooseMarkerInMultimode_AllSelectedCellsAreMarkedOfTheCurrentlySetMarker() {
        let cells = sheet.getCells()
        
        sheet.setMode(.multi)
        
        _ = try! sheet.multiSelectCell(cells[0])
        _ = try! sheet.multiSelectCell(cells[1])
        _ = try! sheet.multiSelectCell(cells[2])
        
        let selectedCells = sheet.getSelectedCells()
        let selectedMainMarker = MainMarker(notation: .cross)
        
        selectedCells.forEach { cell in
            if !cell.isEmptyMainMarker() { XCTFail() }
            cell.setMainMarker(selectedMainMarker)
        }
        
        selectedCells.forEach { cell in
            XCTAssertEqual(cell.getMainMarker(), selectedMainMarker)
        }
    }
    
    // 멀티모드에서 셀들을 선택하고 마커를 선택했을 때, 현재 설정된 마커와 관계없이 선택된 모든 셀에 마킹이 된다.
    // 선택된 셀에 일부만 마커가 있는 경우
    func test_whenSelectMarkedOrUnmarkedCellsCellsAndChooseMarkerInMultimode_AllSelectedCellsAreMarkedOfTheCurrentlySetMarker() {
        let cells = sheet.getCells()
        
        cells[2].setMainMarker(.init(notation: .question))
        cells[3].setMainMarker(.init(notation: .question))
        
        sheet.setMode(.multi)
        
        _ = try! sheet.multiSelectCell(cells[0])
        _ = try! sheet.multiSelectCell(cells[1])
        _ = try! sheet.multiSelectCell(cells[2])
        _ = try! sheet.multiSelectCell(cells[3])
        
        let selectedCells = sheet.getSelectedCells()
        let selectedMainMarker = MainMarker(notation: .cross)
        
        selectedCells.forEach { cell in
            cell.setMainMarker(selectedMainMarker)
        }
        
        selectedCells.forEach { cell in
            XCTAssertEqual(cell.getMainMarker(), selectedMainMarker)
        }
    }
    
    // 멀티모드에서 셀들을 선택하고 마커를 선택했을 때, 현재 설정된 마커와 관계없이 선택된 모든 셀에 마킹이 된다.
    // 선택된 모든 셀에 마커가 있는 경우
    func test_whenSelectMarkedCellsAndChooseMarkerInMultimode_AllSelectedCellsAreMarkedOfTheCurrentlySetMarker() {
        let cells = sheet.getCells()
        
        cells[0].setMainMarker(.init(notation: .question))
        cells[1].setMainMarker(.init(notation: .question))
        cells[2].setMainMarker(.init(notation: .slash))
        cells[3].setMainMarker(.init(notation: .cross))
        
        sheet.setMode(.multi)
        
        _ = try! sheet.multiSelectCell(cells[0])
        _ = try! sheet.multiSelectCell(cells[1])
        _ = try! sheet.multiSelectCell(cells[2])
        _ = try! sheet.multiSelectCell(cells[3])
        
        let selectedCells = sheet.getSelectedCells()
        let selectedMainMarker = MainMarker(notation: .cross)
        
        selectedCells.forEach { cell in
            cell.setMainMarker(selectedMainMarker)
        }
        
        selectedCells.forEach { cell in
            XCTAssertEqual(cell.getMainMarker(), selectedMainMarker)
        }
    }
    
    // 멀티모드에서 특정 마커가 선택한 모든 셀에 있을 때 해당 마커를 한 번 더 선택하면 모든 마커가 지워진다
    func test_whenSameMarkerInSelectedCellsOneMoreSelectionOfThatMarkerClearsAllMarker() {
        let cells = sheet.getCells()
        
        cells[0].setMainMarker(.init(notation: .question))
        cells[1].setMainMarker(.init(notation: .cross))
        cells[2].setMainMarker(.init(notation: .slash))
        cells[3].setMainMarker(.init(notation: .cross))
        
        sheet.setMode(.multi)
        
        _ = try! sheet.multiSelectCell(cells[0])
        _ = try! sheet.multiSelectCell(cells[1])
        _ = try! sheet.multiSelectCell(cells[2])
        _ = try! sheet.multiSelectCell(cells[3])
        
        let selectedCells = sheet.getSelectedCells()
        let selectedMainMarker = MainMarker(notation: .cross)
        
        selectedCells.forEach { cell in
            if cell.equalsMainMarker(selectedMainMarker) {
                cell.removeMainMarker()
            } else {
                cell.setMainMarker(selectedMainMarker)
            }
        }
        
        XCTAssertEqual(cells[0].getMainMarker(), selectedMainMarker)
        XCTAssertEqual(cells[1].getMainMarker(), nil)
        XCTAssertEqual(cells[2].getMainMarker(), selectedMainMarker)
        XCTAssertEqual(cells[3].getMainMarker(), nil)
    }
    
    // 멀티모드에서 모든 셀을 선택해제했을 때 기본 모드가 된다.
    func test_whenAllCellsAreDeselectedInMultimodeThenGoToDefaultMode() {
        let cells = sheet.getCells()
        
        sheet.setMode(.multi)
        
        _ = try! sheet.multiSelectCell(cells[0])
        _ = try! sheet.multiSelectCell(cells[1])
        
        _ = try! sheet.multiUnselectCell(cells[0])
        _ = try! sheet.multiUnselectCell(cells[1])
        
        XCTAssertFalse(sheet.hasSelectedCell())
        
        sheet.setMode(.single)
        
        XCTAssertEqual(sheet.getMode(), .single)
    }
    
    // 추리모드에서 셀을 클릭하면 모드를 변경하는 예외가 발생한다.
    func test_whenACellIsClickedInInferenceModeThenAnExceptionOccursToChangeMode() {
        let cells = sheet.getCells()
        
        sheet.setMode(.inference)
        
        XCTAssertThrowsError(try sheet.selectCell(cells[0])) { error in
            XCTAssertEqual(error as? SheetError, SheetError.modeChanged(to: .single))
        }
    }
    
    // 추리전모드에서 셀을 클릭하면 모드를 변경하는 예외가 발생한다.
    func test_whenACellIsClickedInPreinferenceModeThenAnExceptionOccursToChangeMode() {
        let cells = sheet.getCells()
        
        sheet.setMode(.preInference)
        
        XCTAssertThrowsError(try sheet.selectCell(cells[0])) { error in
            XCTAssertEqual(error as? SheetError, SheetError.modeChanged(to: .single))
        }
    }
    
    // 추리모드에서 셀을 길게 누르면 모드를 변경하는 예외가 발생한다.
    func test_whenACellIsLongPressInInferenceModeThenAnExceptionOccursToChangeMode() {
        let cells = sheet.getCells()
        
        sheet.setMode(.inference)
        
        XCTAssertThrowsError(try sheet.multiSelectCell(cells[0])) { error in
            XCTAssertEqual(error as? SheetError, SheetError.modeChanged(to: .single))
        }
    }
    
    // 추리전모드에서 셀을 길게 누르면 모드를 변경하는 예외가 발생한다.
    func test_whenACellIsLongPressInPreinferenceModeThenAnExceptionOccursToChangeMode() {
        let cells = sheet.getCells()
        
        sheet.setMode(.preInference)
        
        XCTAssertThrowsError(try sheet.multiSelectCell(cells[0])) { error in
            XCTAssertEqual(error as? SheetError, SheetError.modeChanged(to: .single))
        }
    }
}
