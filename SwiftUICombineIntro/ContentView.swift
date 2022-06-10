//
//  ContentView.swift
//  SwiftUICombineIntro
//
//  Created by Kaori Persson on 2022-06-10.
//  Tutorial: https://www.bravesoft.co.jp/blog/archives/15610

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WebApiViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Joke")
            Text(viewModel.joke)
            Button(action: viewModel.fetchJoke,
                   label: {
                Text("See a new joke!")
            })
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
