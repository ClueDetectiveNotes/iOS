//
//  HelpView.swift
//  ClueDetectiveNotes
//
//  Created by Dasan on 11/24/24.
//

import SwiftUI
// TODO: 기본기능/마커사용방법/편의기능 뷰 재활용 방법
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
                        Button("기본 기능") {
                            withAnimation {
                                proxy.scrollTo("기본기능", anchor: .top)
                            }
                        }
                        
                        Button("마커 사용 방법") {
                            withAnimation {
                                proxy.scrollTo("마커사용방법", anchor: .top)
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
                            BasicFeatures()
                            
                            Spacer()
                                .frame(height: 40)
                            
                            HowToWrite()
                            
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
                • 모두에게 공개된 카드와 내가 가지고 있는 카드에 따라 `O` 또는 `X`가 표에 자동으로 입력됩니다.
                • 칸에 메인 마커, 서브 마커를 입력할 수 있습니다.
                • 칸에 입력된 마커를 다시 입력하면 마커가 삭제됩니다.
                • `되돌리기`(↩️) / `다시 실행`(↪️) 기능을 지원합니다.
                • `블라인드`로 나의 화면을 일시적으로 가릴 수 있습니다.
                """
            )
        }
        .padding(.horizontal)
    }
}

private struct HowToWrite: View {
    var body: some View {
        // TODO: 마커 설명 사이트 출처 넣기 (safari 이동)
        SubTitleView("마커 사용 방법")
            .bold()
            .id("마커사용방법")
        
        VStack(alignment: .leading) {
            Text("보편적으로 알려져있는 마커 사용 방법을 소개합니다.")
                .foregroundStyle(Color("subText"))
            
            Spacer()
                .frame(height: 20)
            
            Text("메인 마커")
                .bold()
            
            Text(
                """
                • `!` : 플레이어가 이 카드를 가지고 있지 않을 수 있습니다.\n• `/` :  플레이어가 이 카드를 가지고 있지 않지만 다른 플레이어들은 이 사실을 모를 수 있습니다.\n• `X` : 플레이어가 이 카드를 가지고 있지 않고 다른 플레이어들도 이 사실을 알고 있습니다.\n• `?` : 플레이어가 이 카드를 가지고 있을 수 있습니다.\n• `O` : 플레이어가 이 카드를 확실히 가지고 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("서브 마커")
                .bold()
            
            Text(
                """
                • 0 ~ 9 : 플레이어가 같은 숫자로 표기된 카드 중 하나 이상을 확실히 가지고 있습니다. 이 숫자는 하나의 열에 2~3개의 세트로 표시됩니다.
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
            Text("아래 기능들을 사용하여 더 편리하게 게임을 진행하세요.")
                .foregroundStyle(Color("subText"))
            
            Spacer()
                .frame(height: 20)
            
            Text("멀티 모드")
                .bold()
            
            Text(
                """
                • 칸을 길게 누르면(롱클릭) 멀티 모드로 진입합니다.
                • 멀티 모드에서는 칸을 여러 개 선택하여 같은 마커를 동시에 입력할 수 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("추리 모드")
                .bold()
            
            Text(
                """
                • 플레이어를 클릭한 뒤 추리 세트(용의자, 무기, 장소)를 클릭하면 추리 모드로 진입합니다. (순서가 바뀌어도 같습니다.)
                • 추리 모드에서는 플레이어와 추리 세트(용의자, 무기, 장소)가 교차되는 3개의 칸에 같은 마커를 동시에 입력할 수 있습니다.
                • 추리 모드에서는 마커를 입력하거나, 스킵 버튼(|<, >|)을 클릭하면 같은 추리 세트의 다음 플레이어에 대한 입력을 이어서 할 수 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("잠금 기능")
                .bold()
            
            Text(
                """
                • X 또는 O 마커가 입력된 칸을 잠글 수 있습니다.
                • 잠겨진 칸에 대해서는 마커의 입력, 수정, 삭제가 불가능합니다.
                • 자물쇠 버튼을 터치하여 잠그고, 자물쇠 버튼을 길게 눌러(롱클릭) 잠금을 해제합니다.
                • 단, 게임 시작 시 자동으로 입력된 마커에 대해서는 잠금을 해제할 수 없습니다.
                • 더보기 메뉴에서 자물쇠 이미지를 숨길 수 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("정답 가리기 기능")
                .bold()
            
            Text(
                """
                • 더보기 메뉴에서 정답 열(Column)을 가릴 수 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("서브 마커 관리")
                .bold()
            
            Text(
                """
                • 사용자 기호에 맞게 서브 마커를 추가, 수정, 편집할 수 있습니다.
                • 설정에서 서브 마커를 관리할 수 있습니다.
                """
            )
            
            Spacer()
                .frame(height: 20)
            
            Text("정답 자동 완성 기능")
                .bold()

            Text(
                """
                • 하나의 행(Row)의 모든 칸에 `X`가 입력되었을 때, 정답 칸에 자동으로 `O`가 입력됩니다.
                • 하나의 행(Row)의 하나의 칸에 `O`가 입력되었을 때, 정답 칸을 포함한 모든 칸에 자동으로 `X`가 입력됩니다.
                • 설정에서 해당 기능을 활성화 할 수 있습니다.
                """
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    HelpView()
}
