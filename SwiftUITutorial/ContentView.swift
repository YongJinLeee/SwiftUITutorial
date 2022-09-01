//
//  ContentView.swift
//  SwiftUITutorial
//
//  Created by YongJin on 2022/08/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // 1번뷰
        VStack(alignment: .leading) {
            Text("불곡로 N번길")
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.green)
            
            HStack {
                Text("분당구, 성남시, 경기도!")
                // Spacer()
                Text("HStack 사용중")
                    .font(.subheadline)
                    .bold()
            }
            .padding()
        }
        
        
        // 2번 뷰
        VStack {
            Text("V스택 최상단")
                .font(.title)
                .foregroundColor(Color.pink)
                .bold()
            .padding( )
            VStack { // V 스택 2번뷰
                Text("V스택 상단 2번째")
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .bold()
                .padding( )
            
                VStack {
                    Text("V스택 상단 2번째의 내부")
                        .font(.title)
                        .bold()
                    .padding()
                }
                Text("상단 2번째와 동일 블럭에 위치")
            }
            Text("최상단에 위치")
                .bold()
                .font(.body)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
