//
//  ScratchView.swift
//  WeSplit
//
//  Created by 张洋 on 2021/9/8.
//

import SwiftUI

struct ScratchView: View {
    
    
    @State private var tapCount = 0
    
    @State private var name = ""
    
    private let students = ["Harry", "Hermione", "Ron"]
    
    @State private var selectedStudents = 1
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    HStack{
                        Image(systemName: "trash")
                        Text("delete")
                    }
                    
                }
                Section{
                    TextField("Please input your name: ", text: $name)
                    Text("Your name is: \(name)")
                }
                Section{
                    VStack{
                        Picker("Select your student", selection: $selectedStudents){
                            ForEach(0 ..< students.count){
                                Text(self.students[$0])
                            }
                        }
                        Text("You choose: Student # \(students[selectedStudents])")
                    }
//                    ForEach(0 ..< 100){
//                        Text("Row \($0)")
//                    }
                }
            }.navigationBarTitle("WeSplit", displayMode: .automatic)
            
            Button("Tap Count: \(tapCount)"){
                self.tapCount += 1
            }
        }
    }
}

struct ScratchView_Previews: PreviewProvider {
    static var previews: some View {
        ScratchView()
    }
}
