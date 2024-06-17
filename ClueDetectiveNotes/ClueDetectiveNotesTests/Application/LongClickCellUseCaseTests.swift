//
//  LongClickCellUseCaseTests.swift
//  ClueDetectiveNotesTests
//
//  Created by Dasan & Mary on 6/5/24.
//

import XCTest
@testable import ClueDetectiveNotes

final class LongClickCellUseCaseTests: XCTestCase {
    private var longClickCellUseCase: LongClickCellUseCase!
    private var sheet: Sheet!

    override func setUpWithError() throws {
        sheet = Sheet(
            players: DummyPlayers.players,
            cards: Edition.classic.cards
        )
        longClickCellUseCase = LongClickCellUseCase(sheet: sheet)
    }

    override func tearDownWithError() throws {
        sheet = nil
        longClickCellUseCase = nil
    }
    
    // 싱글모드에서 셀을 길게 누르면 셀이 선택되고 멀티모드로 변경된다.
    func test_longPressCellInSingleModeToSelectAndSwitchToMultiMode() throws {
        let targetCell = sheet.getCells()[0]
        let presentationCell = sheet.getCellImmutable(cell: targetCell)
        
        _ = try longClickCellUseCase.execute(presentationCell)
        
        XCTAssertTrue(sheet.isSelectedCell(targetCell))
        XCTAssertTrue(sheet.isMultiMode())
    }
    
    // 멀티모드에서 기존에 선택되지 않은 셀을 길게 누르면 해당 셀이 선택된다.
    func test_inMultiModeWhenLongPressOnACellThatIsNotSelectedThenTheCellIsSelected() throws {
        let targetCell = sheet.getCells()[0]
        let presentationCell = sheet.getCellImmutable(cell: targetCell)
        
        sheet.switchMode(.multi)
        
        _ = try longClickCellUseCase.execute(presentationCell)
        
        XCTAssertTrue(sheet.isSelectedCell(targetCell))
    }
}
