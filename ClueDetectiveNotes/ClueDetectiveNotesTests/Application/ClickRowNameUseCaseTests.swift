//
//  ClickRowNameUseCaseTests.swift
//  ClueDetectiveNotesTests
//
//  Created by Dasan & Mary on 6/12/24.
//

import XCTest
@testable import ClueDetectiveNotes

final class ClickRowNameUseCaseTests: XCTestCase {
    private var clickRowNameUseCase: ClickRowNameUseCase!
    private var sheet: Sheet!

    override func setUpWithError() throws {
        sheet = Sheet(
            players: DummyPlayers.players,
            cards: Edition.classic.cards
        )
        clickRowNameUseCase = ClickRowNameUseCase(sheet: sheet)
    }

    override func tearDownWithError() throws {
        sheet = nil
        clickRowNameUseCase = nil
    }

    // 같은 row type 안에서 이미 선택된 RowName이 있을 때, 해당 RowName을 클릭하면 RowName의 타입에 해당하는 selectedRowNames의 값이 nil이 된다.
    func test_같은rowtype안에서이미선택된RowName이있을때_해당RowName을클릭하면_RowName의타입에해당하는selectedRowNames의값이nil이된다() throws {
        let cells = sheet.getCells()
        let targetRowName = cells[0].getRowName()
        let targetRowNameType = cells[0].getRowName().card.type
        _ = sheet.selectRowName(targetRowName)
        
        XCTAssertTrue(sheet.isSelectedRowName(targetRowName))
        
        _ = try clickRowNameUseCase.execute(targetRowName)
        
        let currentRowName = sheet.getSelectedRowNames()
        XCTAssertEqual(currentRowName[targetRowNameType], nil)
    }
    
    // 같은 row type 안에서 선택된 RowName이 없을 때, RowName을 클릭하면 RowName의 타입에 해당하는 selectedRowNames의 값이 해당 RowName이 된다.
    func test_같은rowtype안에서선택된RowName이없을때_RowName을클릭하면_RowName의타입에해당하는selectedRowNames의값이해당RowName이된다() throws {
        let cells = sheet.getCells()
        let targetRowName = cells[0].getRowName()
        let targetRowNameType = cells[0].getRowName().card.type
        
        XCTAssertFalse(sheet.isSelectedRowName(targetRowName))
        
        _ = try clickRowNameUseCase.execute(targetRowName)
        
        let currentRowName = sheet.getSelectedRowNames()
        XCTAssertEqual(currentRowName[targetRowNameType], targetRowName)
    }
    
    // RowName이나 ColName이 1개 이상 선택되었을 때 추리전(pre-inference) 모드로 변경된다.
    func test_RowName이나ColName이1개이상선택되었을때_추리전모드로변경된다() throws {
        let cells = sheet.getCells()
        let targetRowName = cells[0].getRowName()
        
        _ = try clickRowNameUseCase.execute(targetRowName)
        
        XCTAssertTrue(sheet.hasSelectedRowName())
        XCTAssertTrue(sheet.isPreInferenceMode())
    }
    
    // RowName이 3개, ColName 1개 선택되었을 때 추리 모드(inference mode)로 변경된다.
    func test_RowName이3개ColName1개선택되었을때_추리모드로변경된다() throws {
        let cells = sheet.getCells()
        let targetRowName1 = cells[0].getRowName() //용의자-스칼렛
        let targetRowName2 = cells[30].getRowName() //무기-나이프
        let targetRowName3 = cells[50].getRowName() //장소-욕실
        let targetColName = cells[0].getColName()
        
        _ = sheet.selectRowName(targetRowName1)
        _ = sheet.selectRowName(targetRowName2)
        _ = sheet.selectColumnName(targetColName)
        
        _ = try clickRowNameUseCase.execute(targetRowName3)
        XCTAssertTrue(sheet.isInferenceMode())
    }
    
    // 싱글모드일 때 RowName을 클릭하면 기존에 선택된 셀이 해제되고 추리전 모드로 변경된다.
    func test_싱글모드일때_RowName을클릭하면_기존에선택된셀이해제되고추리전모드로변경된다() throws {
        let cells = sheet.getCells()
        let targetRowName = cells[0].getRowName()
        
        _ = try sheet.selectCell(cells[1])
        
        _ = try clickRowNameUseCase.execute(targetRowName)
        
        XCTAssertFalse(sheet.hasSelectedCell())
        XCTAssertTrue(sheet.isPreInferenceMode())
    }
    
    // 멀티모드일 때 RowName을 클릭하면 기존에 선택된 셀이 해제되고 추리전 모드로 변경된다.
    func test_멀티모드일때_RowName을클릭하면_기존에선택된셀이해제되고_추리전모드로변경된다() throws {
        let cells = sheet.getCells()
        let targetRowName = cells[0].getRowName()
        
        sheet.switchMode(.multi)
        
        _ = try sheet.multiSelectCell(cells[1])
        _ = try sheet.multiSelectCell(cells[2])
        
        _ = try clickRowNameUseCase.execute(targetRowName)
        
        XCTAssertFalse(sheet.hasSelectedCell())
        XCTAssertTrue(sheet.isPreInferenceMode())
    }
}
