//
//  ClickColNameUseCaseTests.swift
//  ClueDetectiveNotesTests
//
//  Created by Dasan & Mary on 6/5/24.
//

import XCTest
@testable import ClueDetectiveNotes

final class ClickColNameUseCaseTests: XCTestCase {
    private var clickColNameUseCase: ClickColNameUseCase!
    private var sheet: Sheet!

    override func setUpWithError() throws {
        sheet = Sheet(
            players: DummyPlayers.players,
            cards: Edition.classic.cards
        )
        clickColNameUseCase = ClickColNameUseCase(sheet: sheet)
    }

    override func tearDownWithError() throws {
        sheet = nil
        clickColNameUseCase = nil
    }
    
    // 추리전모드에서 선택된 ColName이 있을 때, 해당 ColName을 클릭하면 selectedColName 값이 nil이 된다.
    func test_whenClickAColnameThatPreviousSelectedInPreinferenceModeThenClearSelectedColname() throws {
        let cells = sheet.getCells()
        let targetColName = cells[0].getColName()
        _ = sheet.selectColumnName(targetColName)
        
        XCTAssertTrue(sheet.isSelectedColName(targetColName))
        
        sheet.switchMode(.preInference)
        _ = try clickColNameUseCase.execute(targetColName)
        
        XCTAssertEqual(sheet.getSelectedColName(), nil)
    }
    
    // 추리모드에서 선택된 ColName이 있을 때, 해당 ColName을 클릭하면 selectedColName 값이 nil이 되고 추리전모드로 변경된다. -> (선택된 rowName이 없을 때 싱글모드로 변경됨)
    func test_whenClickAColnameThatPreviousSelectedInInferenceModeThenClearSelectedColname() throws {
        let cells = sheet.getCells()
        let targetColName = cells[0].getColName()
        _ = sheet.selectColumnName(targetColName)
        
        XCTAssertTrue(sheet.isSelectedColName(targetColName))
        
        sheet.switchMode(.inference)
        _ = try clickColNameUseCase.execute(targetColName)
        
        XCTAssertEqual(sheet.getSelectedColName(), nil)
        XCTAssertTrue(sheet.isSingleMode())
    }
    
    //선택된 ColName이 없을 때, ColName 클릭하면 selectedColName이 해당 ColName이 된다.
    func test_선택된ColName이없을때_ColName클릭하면_selectedColName이해당ColName이된다() throws {
        let cells = sheet.getCells()
        let targetColName = cells[0].getColName()
        
        XCTAssertFalse(sheet.hasSelectedColName())
        
        _ = try clickColNameUseCase.execute(targetColName)
        XCTAssertTrue(sheet.isSelectedColName(targetColName))
    }
    
    // RowName이나 ColName이 1개 이상 선택되었을 때 추리전(pre-inference) 모드로 변경된다.
    func test_RowName이나ColName이1개이상선택되었을때_추리전모드로변경된다() throws {
        let cells = sheet.getCells()
        let targetColName = cells[0].getColName()
        
        _ = try clickColNameUseCase.execute(targetColName)
        
        XCTAssertTrue(sheet.hasSelectedColName())
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
        _ = sheet.selectRowName(targetRowName3)
        
        _ = try clickColNameUseCase.execute(targetColName)
        XCTAssertTrue(sheet.isInferenceMode())
    }
    
    // 싱글모드일 때 ColName을 클릭하면 기존에 선택된 셀이 해제되고 추리전 모드로 변경된다.
    func test_싱글모드일때_ColName을클릭하면_기존에선택된셀이해제되고_추리전모드로변경된다() throws {
        let cells = sheet.getCells()
        let targetColName = cells[0].getColName()
        
        _ = try sheet.selectCell(cells[1])
        
        _ = try clickColNameUseCase.execute(targetColName)
        
        XCTAssertFalse(sheet.hasSelectedCell())
        XCTAssertTrue(sheet.isPreInferenceMode())
    }
    
    // 멀티모드일 때 ColName을 클릭하면 기존에 선택된 셀이 해제되고 추리전 모드로 변경된다.
    func test_멀티모드일때_ColName을클릭하면_기존에선택된셀이해제되고_추리전모드로변경된다() throws {
        let cells = sheet.getCells()
        let targetColName = cells[0].getColName()
        
        sheet.switchMode(.multi)
        
        _ = try sheet.multiSelectCell(cells[1])
        _ = try sheet.multiSelectCell(cells[2])
        
        _ = try clickColNameUseCase.execute(targetColName)
        
        XCTAssertFalse(sheet.hasSelectedCell())
        XCTAssertTrue(sheet.isPreInferenceMode())
    }
}
