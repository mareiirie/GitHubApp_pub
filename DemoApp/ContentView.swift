//
//  ContentView.swift
//  DemoApp
//
//  Created by marei_irie on 2024/09/18.
//

import SwiftUI
import CommonView

// LoadingViewの動作だけ見たい場合
struct ContentView: View {
    @State var shouldLoad = false
    var body: some View {
        LoadingView(isLoading: $shouldLoad)
            .onAppear {
                shouldLoad = true
            }
    }
}

#Preview {
    ContentView()
}
