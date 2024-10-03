//
//  ConvertManager.swift
//  ClueDetectiveNotes
//
//  Created by Dasan & Mary on 6/13/24.
//

struct ConvertManager {
    static func getImmutableCells(_ mutableCells: [Cell]) -> [PresentationCell] {
        return mutableCells.map { cell in
            PresentationCell(
                id: cell.getID(),
                rowName: cell.getRowName(),
                colName: cell.getColName(),
                mainMarker: cell.getMainMarker(),
                subMarkers: cell.getSubMarkers().sorted { $0.notation < $1.notation }
            )
        }
    }
    
    static func getImmutableSheet(_ mutableSheet: Sheet) -> PresentationSheet {
        return PresentationSheet(
            cells: getImmutableCells(mutableSheet.getCells()),
            mode: mutableSheet.getMode(),
            rowNames: mutableSheet.getRowNames(),
            colNames: mutableSheet.getColNames(),
            selectedCells: getImmutableCells(mutableSheet.getSelectedCells()),
            selectedRowNames: mutableSheet.getSelectedRowNames(),
            selectedColName: mutableSheet.getSelectedColName()
        )
    }
    
    static func getImmutableGameSetting(
        selectedPublicCards: [Card] = [],
        selectedMyCards: [Card] = []
    ) -> PresentationGameSetting {
        return PresentationGameSetting(
            edition: GameSetter.shared.getEdition(),
            players: GameSetter.shared.getPlayers().map { ($0.id, $0.name) },
            playerCount: GameSetter.shared.getPlayers().count,
            playerNames: GameSetter.shared.getPlayers().map { $0.name },
            selectedPlayer: GameSetter.shared.getUser()?.name ?? "",
            selectedPublicCards: selectedPublicCards, // 생각해보자
            selectedMyCards: selectedMyCards,
            publicCardsCount: GameSetter.shared.getPublicCardsCount(),
            myCardsCount: GameSetter.shared.getMyCardsCount()
        )
    }
    
    static func getImmutableControlBar(mutableSubMarkerType: SubMarkerType) -> PresentationControlBar {
        return PresentationControlBar(subMarkerTypes: mutableSubMarkerType.getSubMarkerTypes())
    }
}
