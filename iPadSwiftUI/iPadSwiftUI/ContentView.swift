//
//  ContentView.swift
//  iPadSwiftUI
//
//  Created by Sarika scc on 20/06/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            
            List(1..<100) { i in
                
                Text("Row \(i)")
            }
            .background(Color.red)
            .listStyle(.sidebar)
            .navigationBarItems(leading:
            
                                    HStack{
                
                Button {
                    print("tapable")
                } label: {
                        Image(systemName: "trash")
                }

            }
            )
            
            Text("Primary View")
                .padding()
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
