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

    @State var score = 0
    
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Score: \(score)")
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("New Game", action: newGame)
                    }
                }
        }.onAppear (perform: initGameResource)
    }
    
    func newGame() {
        initGameResource()
        score = 0
        usedWords = []
        inputWord = ""
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
        
        guard chechSize(inputWord) else {
            showAlert(title: "Word is not allowed", msg: "Yor can't spell word just equal to \(rootWord), or the word's length is shortten than 3")
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
        score += 1
    }
    
    func chechSize(_ word: String) -> Bool {
        return word != rootWord && word.count >= 3
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
        let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

            return misspelledRange.location == NSNotFound
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
