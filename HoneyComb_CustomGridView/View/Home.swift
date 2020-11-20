//
//  Home.swift
//  HoneyComb_CustomGridView
//
//  Created by Maxim Macari on 19/11/20.
//

import SwiftUI

struct Home: View {
    
    //sample data
    @State var sampleData: [Date] = Array(repeating: Date(), count: 0)
    
    //sinceee it is vertical ScrollView
    @State  var rows: [[Date]] = []
    
    // padding = 30
    let width = UIScreen.main.bounds.width - 30
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: -10){
                ForEach(rows.indices, id: \.self){ index in
                    HStack(spacing: 10){
                        ForEach(rows[index], id: \.self){ value in
                            Hexagon()
                                .fill(Color.red)
                                .frame(width: (width - 20) / 3, height: 130)
                                .offset(x: getOffset(index: index))
                        }
                    }
                }
            }
            .padding()
            .frame(width: width)
        }
        //meenu
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        withAnimation {
                            rows.removeAll()
                            sampleData.append(Date())
                            generate()
                        }
                        print("sampleData count: \(sampleData.count)")
                        print("rows count: \(rows.count)")
                    }, label: {
                        Image(systemName: "plus")
                        Text("Add new item")
                    })
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title)
                }

                
            }
        })
        
        .onAppear(){
            generate()
        }
    }
    
    //if the row contains only one columnView (One hexagon), then we move the view to leftside with
    //offset y= width of hexagon / 2
    func getOffset(index: Int) -> CGFloat{
        let current = rows[index].count
        
        //moving half the width..
        let offset = ((width - 20) / 3) / 2
        
        if index != 0 {
            if index != 0{
                let previous = rows[index - 1].count
                
                if current == 1 {
                    if previous == 3 {
                        return -offset
                    }
                }
                if current == previous {
                    return -offset
                }
            }
            
        }
        
        return 0
    }
    
    
    //generating honeycomb rows
    func generate() {
        var count = 0
        
        //you can use anything here
        var generated: [Date] = []
        
        for i in sampleData{
            generated.append(i)
            
            //checking and creating rows...
            
            if generated.count == 2 {
                if let last = rows.last{
                    if last.count == 3 {
                        rows.append(generated)
                        
                        generated.removeAll()
                        
                    }
                }
                //for first time no data
                
                if rows.isEmpty {
                    rows.append(generated)
                    
                    generated.removeAll()
                }
                
            }
            
            if generated.count == 3 {
                if let last = rows.last{
                    if last.count == 2 {
                        rows.append(generated)
                        
                        generated.removeAll()
                    }
                    
                }
            }
            
            count += 1
            //for exhaust data or single data ...
            
            if count == sampleData.count && !generated.isEmpty {
                rows.append(generated)
            }
        }
    }
}


