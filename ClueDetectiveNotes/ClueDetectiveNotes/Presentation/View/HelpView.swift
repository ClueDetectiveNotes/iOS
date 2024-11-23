//
//  HelpView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/24/24.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        VStack {
            TitleView(
                title: "도움말",
                description: ""
            )
            
            ScrollViewReader(content: { proxy in
                VStack {
                    HStack {
                        Button("작성 방법") {
                            withAnimation {
                                proxy.scrollTo("작성방법", anchor: .top)
                            }
                        }
                        
                        Button("기본 기능") {
                            withAnimation {
                                proxy.scrollTo("기본기능", anchor: .top)
                            }
                        }
                        
                        Button("편의 기능") {
                            withAnimation {
                                proxy.scrollTo("편의기능", anchor: .top)
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .padding(.bottom, 15)
                    
                    ScrollView {
                        VStack {
                            HowToWrite()
                            
                            Spacer()
                                .frame(height: 40)
                            
                            BasicFeatures()
                            
                            Spacer()
                                .frame(height: 40)
                            
                            ConvenienceFeatures()
                        }
                    }
                }
            })
            
        }
        .background(Color(.systemGroupedBackground))
    }
}

private struct HowToWrite: View {
    var body: some View {
        SubTitleView("작성 방법")
            .bold()
            .id("작성방법")
        
        VStack(alignment: .leading) {
            Text("보편적으로 알려져있는 작성 방법을 소개합니다.")
                .foregroundStyle(Color("subText"))
            
            Spacer()
                .frame(height: 20)
            
            Text("메인 마커")
                .bold()
            
            Text(
                """
                • `O` : 플레이어가 이 카드를 확실히 가지고 있습니다.\n• `X` : 플레이어가 이 카드를 가지고 있지 않습니다.\n• `?` : 플레이어가 이 카드를 가지고 있을 가능성이 있습니다.\n• `!` : 플레이어가 이 카드를 가지고 있지 않을 수 있습니다.\n• `/` : 플레이어가 이 카드를 가지고 있지 않고 자신도 알고 있지만 다른 플레이어는 아직 모를 수 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("서브 마커")
                .bold()
            
            Text(
                """
                • 0 ~ 9 : 이 숫자는 한 칸 안에 2개 또는 3개씩 세트로 표시되며(이 세트를 "표기 그룹"이라고 함), 플레이어가 이 카드 중 하나 이상을 확실히 보유하고 있음을 나타냅니다. (추리의 세트)
                """
            )
        }
        .padding(.horizontal)
    }
}

private struct BasicFeatures: View {
    var body: some View {
        SubTitleView("기본 기능")
            .bold()
            .id("기본기능")
        
        VStack(alignment: .leading) {
            Text("게임 진행을 위한 기본적인 기능입니다.")
                .foregroundStyle(Color("subText"))
            
            Spacer()
                .frame(height: 20)
            
            Text(
                """
                • 공개된 카드, 내 카드는 표에 자동으로 입력됩니다.
                • 칸에 메인 마커, 서브 마커를 입력할 수 있습니다.
                • 칸에 입력된 마커를 다시 누르면 마커가 삭제됩니다.
                • `Undo` / `Redo` 기능으로 칸에 대한 입력을 복구하거나 되돌릴 수 있습니다.
                • `화면 가리기`로 다른 사람이 나의 추리를 못보게 할 수 있습니다.
                """
            )
        }
        .padding(.horizontal)
    }
}

private struct ConvenienceFeatures: View {
    var body: some View {
        SubTitleView("편의 기능")
            .bold()
            .id("편의기능")
        
        VStack(alignment: .leading) {
            Text("아래 기능들을 사용하여 게임을 더 편하게 진행하세요.")
                .foregroundStyle(Color("subText"))
            
            Spacer()
                .frame(height: 20)
            
            Text("멀티 모드")
                .bold()
            
            Text(
                """
                • 칸을 여러 개 선택하여 같은 마커를 동시에 입력할 수 있습니다.
                • 칸을 길게 누르면(롱클릭) 멀티 모드로 진입합니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("추리 모드")
                .bold()
            
            Text(
                """
                • 추리 세트(선택된 용의자, 무기, 장소)와 플레이어가 교차되는 3개의 칸에 같은 마커를 동시에 입력할 수 있습니다.
                • 선택된 칸에 마커를 입력하거나, 스킵 버튼(|<, >|)을 클릭하면 같은 추리 세트의 다음 플레이어에 대한 입력을 이어 할 수 있습니다.
                • 용의자, 무기, 장소 이름을 클릭한 뒤 플레이어를 클릭하면 추리 모드로 진입합니다. (순서가 바뀌어도 같음)
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("`Lock` 기능")
                .bold()
            
            Text(
                """
                • X 또는 O 마커가 입력된 칸을 잠글 수 있습니다.
                • 잠겨진 칸에 대해서는 마커의 입력, 수정, 삭제가 불가능합니다.
                • 자물쇠 버튼을 터치하여 잠그고, 자물쇠 버튼을 길게 눌러(롱클릭) 잠금을 해제합니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("`정답칸 가리기` 기능")
                .bold()
            
            Text(
                """
                • 정답칸을 가려 표를 조금 더 넓게 보실 수 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("서브 마커 관리")
                .bold()
            
            Text(
                """
                • 사용자 기호에 맞게 서브 마커를 추가, 수정, 편집할 수 있습니다.
                • 설정탭에서 서브 마커를 관리하실 수 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("`정답 자동 입력` 제공")
                .bold()
            
            Text(
                """
                • 한 행(row)의 모든 칸에 X가 입력되었을 때, 정답칸에 자동으로 O가 입력됩니다.
                • 한 행(row)의 하나의 칸에 O가 입력되었을 때, 정답칸을 포함한 모든 칸에 자동으로 X가 입력됩니다.
                • 설정탭에서 해당 기능을 끄고 켤 수 있습니다.
                """
            )
        }
        .padding(.horizontal)
    }
}


#Preview {
    HelpView()
}
