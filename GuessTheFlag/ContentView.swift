//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kha Tran on 6/4/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitile = ""
    @State private var score = 0
    
    @State private var contries = ["australia", "brazil", "france", "germany", "japan", "south-korea", "united-kingdom", "united-states", "vietnam"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.4, green: 0.5, blue: 0.7), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.3, blue: 0.83), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack {
                    Text("Guess the Flag")
                        .foregroundColor(.white)
                        .font(.largeTitle.bold())
                }
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text(contries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(contries[number])
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
            }
            .padding()
        }
        .alert(scoreTitile, isPresented: $showingScore) {
            Button("Continue", action: {
                askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitile = "Correct!!!"
            score += 1
        } else {
            scoreTitile = "Wrong!"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        contries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
