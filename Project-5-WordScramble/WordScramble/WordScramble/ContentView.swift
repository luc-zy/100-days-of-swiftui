//
//  ContentView.swift
//  WordScramble
//
//  Created by 张洋 on 2022/6/12.
//

import SwiftUI

struct ContentView: View {
    
    @State var usedWords = [String]()
    @State var rootWord = "test"
    @State var inputWord = ""
    
    @State var alertTitle = ""
    @State var alertMsg = ""
    @State var showingAlert = false
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your words", text: $inputWord)
                        .onSubmit(submitNewWord)
                }.alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {}
                } message: {
                    Text(alertMsg)
                }
                Section{
                    ForEach(usedWords, id: \.self) { word in
                        Text(word)
                    }
                }
            }.navigationTitle(rootWord)
        }.onAppear (perform: initGameResource)
    }
    
    func initGameResource() {
        if let url = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let content = try? String(contentsOf: url){
                let contentArray = content.split(separator: "\n")
                rootWord = String(contentArray.randomElement() ?? "silkworm")
                return
            }
        }
        fatalError("Game crashed, init resourcese failed")
    }

    
    func submitNewWord() {
        //1. 转为小写，去除空格
        //2. 检查是否满足root要求
        //3. 检查是否为真实的单词
        //4. 添加到列表中
        
        inputWord = inputWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if usedWords.contains(inputWord) {
            showAlert(title: "Word used already", msg: "Be more creative!")
            return
        }
        
        guard checkMatch(inputWord) else {
            showAlert(title: "Word not possible", msg: "Yor can't spell that word from \(rootWord)")
            return
        }
        
        guard checkReality(inputWord) else {
            showAlert(title: "Word not real", msg: "\"\(inputWord)\" is not a real word")
            return
        }
        
        
        usedWords.insert(inputWord, at: 0)
        inputWord = ""
    }
    
    func checkMatch(_ word: String) -> Bool {
        var copy = rootWord
        for c in word {
            if let index = copy.firstIndex(of: c){
                copy.remove(at: index)
            } else{
                return false
            }
        }
        return true
    }
    
    func checkReality(_ word: String) -> Bool {
        //TODO: 完成单词真实性校验
        return true
    }
    
    func showAlert(title: String, msg: String) {
        self.alertTitle = title
        self.alertMsg = msg
        self.showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
