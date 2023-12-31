//
//  ContentView.swift
//  WordScramble
//
//  Created by Da Hae Lee on 11/29/23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var sumOfWordLength = 0
    @State private var score = 0
    
    func addNewWord() {
        /// 1. `newWord`를 lowercase로 만들고 공백 제거하기
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        /// 2. `word`가 3개 이상의 문자로 이루어졌는지, 중복되지 않는지, 가능한 단어인지, 실제 있는 단어인지
        guard word.count > 2 else {
            wordError(title: "Empty Word", message: "You have to input more than 3 character.")
            return
        }
        guard isOriginal(word) else {
            wordError(title: "Word used already", message: "Be more original.")
            return
        }

        guard isPossible(word) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        /// 3. `word`를 `usedWords`배열의 첫번째 위치에 삽입하기
        withAnimation {
            usedWords.insert(word, at: 0)
        }
        /// 4. 점수 계산하기
        sumOfWordLength += newWord.count
        score = sumOfWordLength * usedWords.count
        /// 5. `newWord` 초기화하기
        newWord = ""
    }
    
    func startGame() {
        /// 1. Bundle에서 `start.txt`를 찾는다.
        guard let startWordURL = Bundle.main.url(forResource: "start", withExtension: "txt") else {
            fatalError("Could not load start.txt from bundle.")
        }
        /// 2. `start.txt`의 내용을 String 타입으로 받는다.
        guard let startWords = try? String(contentsOf: startWordURL) else {
            fatalError("Could not load start.txt from bundle.")
        }
        /// 3. String 배열로 쪼갠다.
        let allWords = startWords.components(separatedBy: "\n")
        /// 4. `rootWord`에 할당할 임의의 단어를 하나 선택하거나, 배열이 비어 있는 경우 기본값을 사용한다.
        rootWord = allWords.randomElement() ?? "slikworm"
        /// 5. reset
        sumOfWordLength = 0
        score = 0
        usedWords = []
    }
    
    func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word) && word != rootWord
    }
    
    func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    VStack(alignment: .leading) {
                        Text("Score: \(score)")
                            .font(.title3)
                            .bold()
                            .padding([.top, .bottom])
                        Text("The score is calculated as [the sum of the length of each word * the total number of words].")
                            .font(.caption2)
                    }
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar {
                Button("reset") { startGame() }
            }
        }
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK") { newWord = "" }
        } message: {
            Text(errorMessage)
        }
        
    }
}

#Preview {
    ContentView()
}
