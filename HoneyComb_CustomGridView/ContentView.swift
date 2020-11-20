//
//  ContentView.swift
//  HoneyComb_CustomGridView
//
//  Created by Maxim Macari on 19/11/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Home()
                .navigationTitle("Honey comb")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
