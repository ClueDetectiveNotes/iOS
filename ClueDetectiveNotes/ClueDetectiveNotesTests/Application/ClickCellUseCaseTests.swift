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
    func test_clickSelectedCellInSingleModeToUnselect() {
        let targetCell = sheet.getCells()[0]
        _ = sheet.selectCell(targetCell)
        
        let presentationCell = sheet.getCellImmutable(cell: targetCell)
        _ = clickCellUseCase.execute(presentationCell)
        
        XCTAssertFalse(sheet.isSelectedCell(targetCell))
    }
    
    // 싱글모드에서 기존에 선택되지 않은 셀을 클릭하면 해당 셀이 선택된다
    
}
