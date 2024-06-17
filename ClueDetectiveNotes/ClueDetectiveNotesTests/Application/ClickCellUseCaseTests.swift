//
//  ClickCellUseCaseTests.swift
//  ClueDetectiveNotesTests
//
//  Created by Dasan & Mary on 5/25/24.
//

import XCTest
@testable import ClueDetectiveNotes

final class ClickCellUseCaseTests: XCTestCase {
    private var clickCellUseCase: ClickCellUseCase!
    private var sheet: Sheet!
    
    override func setUpWithError() throws {
        sheet = Sheet(
            players: DummyPlayers.players,
            cards: Edition.classic.cards
        )
        clickCellUseCase = ClickCellUseCase(sheet: sheet)
    }

    override func tearDownWithError() throws {
        sheet = nil
        clickCellUseCase = nil
    }

    // 싱글모드에서 이미 선택된 셀을 클릭하면 해당 셀의 선택이 해제된다
    func test_clickSelectedCellInSingleModeToUnselect() throws {
        let targetCell = sheet.getCells()[0]
        _ = try sheet.selectCell(targetCell)
        
        let presentationCell = sheet.getCellImmutable(cell: targetCell)
        _ = try clickCellUseCase.execute(presentationCell)
        
        XCTAssertFalse(sheet.isSelectedCell(targetCell))
    }
    
    // 싱글모드에서 기존에 선택되지 않은 셀을 클릭하면 해당 셀이 선택된다
    func test_clickUnselectedCellInSingleModeToSelect() throws {
        let targetCell = sheet.getCells()[0]
        
        let presentationCell = sheet.getCellImmutable(cell: targetCell)
        _ = try clickCellUseCase.execute(presentationCell)
        
        XCTAssertTrue(sheet.isSelectedCell(targetCell))
    }
    
    // 멀티모드에서 클릭한 셀이 이미 선택되어있고 클릭한 셀 외에 선택한 셀이 없으면 해당 셀이 선택 해제되고, 싱글모드로 변경된다.
    func test_clickOnlySelectedCellInMultiModeToUnselectAndSwitchToSingleMode() throws {
        let targetCell = sheet.getCells()[0]
        sheet.switchMode(.multi)
        _ = try sheet.multiSelectCell(targetCell)
        
        let presentationCell = sheet.getCellImmutable(cell: targetCell)
        _ = try clickCellUseCase.execute(presentationCell)
        
        XCTAssertFalse(sheet.isSelectedCell(targetCell))
        XCTAssertEqual(sheet.getMode(), .single)
    }
    
    // 멀티모드에서 클릭한 셀이 이미 선택되어있고 클릭한 셀 외에 선택한 셀이 있으면 해당 셀이 선택 해제되고, 멀티모드가 유지된다.
    func test_clickSelectedCellWithOtherCellsSelectedInMultiModeToUnselectAndRetainMultiMode() throws {
        let alreadySelectedCell = sheet.getCells()[0]
        let targetCell = sheet.getCells()[1]
        
        sheet.switchMode(.multi)
        _ = try! sheet.multiSelectCell(alreadySelectedCell)
        _ = try! sheet.multiSelectCell(targetCell)
        
        let presentationCell = sheet.getCellImmutable(cell: targetCell)
        _ = try clickCellUseCase.execute(presentationCell)
        
        XCTAssertFalse(sheet.isSelectedCell(targetCell))
        XCTAssertEqual(sheet.getMode(), .multi)
    }
    
    // 멀티모드에서 클릭한 셀이 기존에 선택되지 않은 셀이면 해당 셀이 선택된다.
    func test_clickUnselectedCellInMultiModeToSelect() throws {
        let targetCell = sheet.getCells()[0]
        
        sheet.switchMode(.multi)
        
        let presentationCell = sheet.getCellImmutable(cell: targetCell)
        _ = try clickCellUseCase.execute(presentationCell)
        
        XCTAssertTrue(sheet.isSelectedCell(targetCell))
    }
}
