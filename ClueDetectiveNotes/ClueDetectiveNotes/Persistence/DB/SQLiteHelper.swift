//
//  SQLiteHelper.swift
//  ClueDetectiveNotes
//
//  Created by MARY on 10/9/24.
//

import Foundation
import SQLite3

final class SQLiteHelper {
    static let shared = SQLiteHelper()
    var db: OpaquePointer?
    let dbName = "clueDetectiveNotes.sqlite"
    
    init() {
        initDB()
    }
    
    deinit {
        sqlite3_close(db)
    }
    
    private func initDB() {
        // DB 생성
        self.db = createDB()
        
        // 옵션 테이블 생성 및 데이터 삽입
        insertOptions()
        
        // 공통 코드 테이블 생성 및 데이터 삽입
        insertCommonCode()
        
        // 다국어 테이블 생성 및 데이터 삽입
        insertOptionsMultiLang()
        insertCardMultiLang()
        insertMessageMultiLang()
        insertButtonMultiLang()
    }
    
    private func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        do {
            let dbPath: String = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false).appendingPathComponent(dbName).path
            
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("Successfully created DB. Path: \(dbPath)")
                return db
            }
        } catch {
            print("Error while creating Database -\(error.localizedDescription)")
        }
        
        return nil
    }
    
    private func insertOptions() {
        execSQL(query: "CREATE TABLE IF NOT EXISTS OPTIONS (CODE text, SEQ integer, TYPE text, VALUE text, primary key(CODE));")
        execSQL(query: "INSERT INTO OPTIONS VALUES ('LANGUAGE',1,'SELECT_BOX','KR');")
    }
    
    private func insertCommonCode() {
        execSQL(query: "CREATE TABLE IF NOT EXISTS COMMON_CODE (CODE text, TYPE text, PART text, SEQ integer, primary key(CODE,TYPE));")
        execSQL(query: "INSERT INTO COMMON_CODE VALUES ('KR','SELECT_BOX','LANGUAGE',1);")
        execSQL(query: "INSERT INTO COMMON_CODE VALUES ('EN','SELECT_BOX','LANGUAGE',2);")
    }
    
    private func insertOptionsMultiLang() {
        execSQL(query: "CREATE TABLE IF NOT EXISTS MULTI_LANG (CODE text, TYPE text, LANG text, VALUE text, primary key(CODE, TYPE, LANG));")
        //한국어
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('LANGUAGE','OPT','KR','언어');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('KR','CM_CD','KR','한국어');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('EN','CM_CD','KR','영어');")
        
        //영어
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('LANGUAGE','OPT','EN','Language');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('KR','CM_CD','EN','Korean');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('EN','CM_CD','EN','English');")
    }
    
    private func insertCardMultiLang(){
        //한국어
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('ANSWER','CRD_HD','KR','정답');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PUBLIC','CRD_HD','KR','공용');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('UNKNOWN','CRD_HD','KR','미확인');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SUSPECT','CRD_TP','KR','용의자');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('WEAPON','CRD_TP','KR','흉기');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CRIME_SCENE','CRD_TP','KR','범행장소');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SCARLET','CRD','KR','스칼렛');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('MUSTARD','CRD','KR','머스타드');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('WHITE','CRD','KR','화이트');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('GREEN','CRD','KR','그린');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PEACOCK','CRD','KR','픽콕');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PLUM','CRD','KR','플럼');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CANDLESTICK','CRD','KR','촛대');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('KNIFE','CRD','KR','단검');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('LEAD_PIPE','CRD','KR','파이프');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('REVOLVER','CRD','KR','권총');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('ROPE','CRD','KR','밧줄');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('WRENCH','CRD','KR','렌치');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('BATHROOM','CRD','KR','욕실');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('STUDY','CRD','KR','서재');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('GAME_ROOM','CRD','KR','게임룸');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('GARAGE','CRD','KR','차고');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('BEDROOM','CRD','KR','침실');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('LIVING_ROOM','CRD','KR','거실');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('KITCHEN','CRD','KR','부엌');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('YARD','CRD','KR','마당');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('DINING_ROOM','CRD','KR','식당');")
        
        //영어
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('ANSWER','CRD_HD','EN','Answer');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PUBLIC','CRD_HD','EN','Public One');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('UNKNOWN','CRD_HD','EN','Unknown One');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SUSPECT','CRD_TP','EN','Suspect');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('WEAPON','CRD_TP','EN','Weapon');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CRIME_SCENE','CRD_TP','EN','Crime Scene');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SCARLET','CRD','EN','Scarlet');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('MUSTARD','CRD','EN','Mustard');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('WHITE','CRD','EN','White');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('GREEN','CRD','EN','Green');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PEACOCK','CRD','EN','Peacock');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PLUM','CRD','EN','Plum');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CANDLESTICK','CRD','EN','Candlestick');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('KNIFE','CRD','EN','Knife');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('LEAD_PIPE','CRD','EN','Lead Pipe');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('REVOLVER','CRD','EN','Revolver');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('ROPE','CRD','EN','Rope');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('WRENCH','CRD','EN','Wrench');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('BATHROOM','CRD','EN','Bathroom');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('STUDY','CRD','EN','Study');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('GAME_ROOM','CRD','EN','Game Room');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('GARAGE','CRD','EN','Garage');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('BEDROOM','CRD','EN','Bedroom');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('LIVING_ROOM','CRD','EN','Living Room');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('KITCHEN','CRD','EN','Kitchen');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('YARD','CRD','EN','Yard');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('DINING_ROOM','CRD','EN','Dining Room');")
    }

    private func insertMessageMultiLang() {
        //한국어
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PS_TITLE','MSG','KR','플레이어 설정');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PS_DESC','MSG','KR','게임에 참여하는 인원 수와 이름을 설정해주세요.');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PS_COND','MSG','KR','이름이 입력되지 않았거나, 중복된 이름이 있습니다.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PDS_TITLE','MSG','KR','플레이어 설정');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PDS_DESC','MSG','KR','자신을 선택하고, 플레이 순서에 맞게 정렬해주세요.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('HDS_TITLE','MSG','KR','개인 카드 설정');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('HDS_DESC','MSG','KR','개인 카드를 설정해주세요.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PCS_TITLE','MSG','KR','공용 카드 설정');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PCS_DESC','MSG','KR','공용 카드를 설정해주세요.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SHT_IF_DL_TITLE','MSG','KR','추리모드를 해제 하시겠습니까?');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SHT_IF_DL_DESC','MSG','KR','확인 버튼을 누르면 추리모드가 해제되며 기본 선택 모드로 돌아갑니다.');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SHT_CB_ADSBMK_DESC','MSG','KR','사용할 서브 마커를 입력해주세요.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CM_BOP','MSG','KR','한 번 더 누르시면 앱이 종료됩니다.');")


        //영어
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PS_TITLE','MSG','EN','Player Setting');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PS_DESC','MSG','EN','Please set the number of the players and name of the players who join in the game.');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PS_COND','MSG','EN','The name is not entered, or there is a duplicate name.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PDS_TITLE','MSG','EN','Player Setting');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PDS_DESC','MSG','EN','Please choose yourself, and arrange it in order of play.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('HDS_TITLE','MSG','EN','Hand Setting');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('HDS_DESC','MSG','EN','Please set the your hand.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PCS_TITLE','MSG','EN','Public Card Setting');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PCS_DESC','MSG','EN','Please set up public cards.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SHT_IF_DL_TITLE','MSG','EN','Do you want to turn off the inference mode?');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SHT_IF_DL_DESC','MSG','EN','Press the Confirm button to release the inference mode and return to the default selection mode.');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SHT_CB_ADSBMK_DESC','MSG','EN','Please enter the sub-marker to use.');")

        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CM_BOP','MSG','EN','If you press it again, the app will be shut down.');")

    }

    private func insertButtonMultiLang() {
        //한국어
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('START','BTN','KR','시작');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('OPTION','BTN','KR','옵션');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('NEXT','BTN','KR','다음');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PLAY','BTN','KR','플레이');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CONFIRM','BTN','KR','확인');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CANCEL','BTN','KR','취소');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('HOME','BTN','KR','홈');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SETTING','BTN','KR','설정');")

        //영어
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('START','BTN','EN','Start');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('OPTION','BTN','EN','Option');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('NEXT','BTN','EN','Next');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('PLAY','BTN','EN','Play');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CONFIRM','BTN','EN','Confirm');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('CANCEL','BTN','EN','Cancel');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('HOME','BTN','EN','Home');")
        execSQL(query: "INSERT INTO MULTI_LANG VALUES ('SETTING','BTN','EN','Setting');")
    }

    private func execSQL(query: String) {
        if sqlite3_exec(db, query, nil, nil, nil) != SQLITE_OK {
            let errMsg = String(cString: sqlite3_errmsg(db))
            print("query: \(query)")
            print("error: \(errMsg)")
        }
    }
    
    private func getOptions() -> [[String: String]]? {
        let query = "SELECT CODE, TYPE, VALUE FROM OPTIONS ORDER BY SEQ"
        var stmt:OpaquePointer?
        var result = [[String: String]]()
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW){
                var row = [String: String]()
                
                row["TYPE"] = String(cString: sqlite3_column_text(stmt, 0))
                row["VALUE"] = String(cString: sqlite3_column_text(stmt, 1))
                
                result.append(row)
                
                print("read value type : \(String(describing: row["TYPE"])) value : \(String(describing: row["VALUE"]))")
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: v1\(errMsg)")
        }
        
        return result
    }
    
    private func getCommonCode() -> [[String: String]]? {
        let query = "SELECT CODE, PART, TYPE FROM COMMON_CODE ORDER BY SEQ"
        var stmt:OpaquePointer?
        var result = [[String: String]]()
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW){
//                var row = [String: String]()
//
//                row["TYPE"] = String(cString: sqlite3_column_text(stmt, 0))
//                row["VALUE"] = String(cString: sqlite3_column_text(stmt, 1))
//
//                result.append(row)
//
//                print("read value type : \(String(describing: row["TYPE"])) value : \(String(describing: row["VALUE"]))")
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: v1\(errMsg)")
        }
        
        return result
    }
    
    private func getMultiLang(language: String) -> [[String: String]]? {
        let query = "SELECT CODE, TYPE, VALUE FROM MULTI_LANG WHERE LANG = ?"
        var stmt:OpaquePointer?
        var result = [[String: String]]()
        
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            while(sqlite3_step(stmt) == SQLITE_ROW){
//                var row = [String: String]()
//
//                row["TYPE"] = String(cString: sqlite3_column_text(stmt, 0))
//                row["VALUE"] = String(cString: sqlite3_column_text(stmt, 1))
//
//                result.append(row)
//
//                print("read value type : \(String(describing: row["TYPE"])) value : \(String(describing: row["VALUE"]))")
            }
        } else {
            let errMsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: v1\(errMsg)")
        }
        
        return result
    }

    
    // 삭제?
    private func createTable(query: String) {
        var statement: OpaquePointer? = nil

        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {   // 쿼리를 실행할 준비를 하는 단계
            if sqlite3_step(statement) == SQLITE_DONE { // 쿼리를 실행하는 단계
                print("Creating table has been succesfully done. db: \(String(describing: self.db))")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(self.db))
                print("\nsqlte3_step failure while creating table: \(errorMessage)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(self.db))
            print("\nsqlite3_prepare failure while creating table: \(errorMessage)")
        }
        
        sqlite3_finalize(statement) // 메모리에서 sqlite3 할당 해제
    }
}

