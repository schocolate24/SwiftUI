import SwiftUI

struct KatakanaQuiz: View {
@State private var katakanas: [Japanese] = Bundle.main.decode("Katakana.json")
    init() {
        katakanas.shuffle()
    }
@State private var correctAnswer = Int.random(in: 0...2)
@StateObject var soundplayer = Audio()
@State private var answer = ""
@State private var counter = 0
@State private var correctAnswerCounter = 0
@State private var showingAlert = false
@State private var alertMessage = ""
@State private var disabled = false

var body: some View {
    ZStack {
        Color.darkBackground
            .ignoresSafeArea()
        VStack {
            Text("\(counter) / 10")
                .padding(.top,40)
                .foregroundColor(.white)
                .font(.system(size:30).bold())

            Text("Tap the speaker and chose the right letter")
                .foregroundColor(.white)
                .font(.system(size: 18))
                .font(.title)
                .padding(.bottom,80)
                .padding(.top,40)

            Button {
                soundplayer.playSounds(file: katakanas[correctAnswer].voice1)
            } label: {
                Image(systemName: "speaker.wave.3.fill")
            }
            .font(.system(size:70))
            .foregroundColor(.blue)
            .frame(width: 110, height: 110)
            .background(.white)
            .cornerRadius(10)
            .padding(.bottom,100)

            HStack {
                ForEach (0...2, id: \.self) { index in
                    Button { letterTapped(index)
                    } label: {
                        Text(katakanas[index].letter)
                    }
                }
                .disabled(disabe())
                .foregroundColor(.white)
                .font(.system(size: 35).bold())
                .frame(width: 70, height: 70)
                .background(.cyan)
                .cornerRadius(10)
                .padding([.leading,.trailing])
                .padding(.top, -15)
            }
            Spacer()
            Spacer()

            Text("\(answer)")
                .foregroundColor(.white)
                .padding(.bottom,20)
                .font(.system(size: 30))

            Button {
                resetTheGame()
            } label: {
                Text("Next")
            }.buttonStyle(.plain)
             .font(.system(size: 30).bold())
             .frame(width: 200, height: 50)
             .foregroundColor(.white)
             .background(.orange)
             .cornerRadius(20)
             .padding([.bottom,.top])
             .disabled(disableNext())

        }
    } .onAppear {
        katakanas = Bundle.main.decode("Katakana.json", [Japanese].self).shuffled()
        correctAnswer = Int.random(in: 0...2)
      }
    .alert("⭐️ Well done ⭐️", isPresented: $showingAlert) {
        Button("Retry", action: reset)

    } message: {
        Text(alertMessage)
    }
}

func letterTapped(_ aiueo: Int) {
    if aiueo == correctAnswer {
        answer = "✨Correct✨"
        correctAnswerCounter += 1
    } else {
        answer = "Incorrect...the answer is '\(katakanas[correctAnswer].letter)'"
    }
    counter += 1

    if counter == 10 {
        showingAlert = true
        if counter == 10 {
            showingAlert = true
            if correctAnswerCounter < 5 {
                alertMessage = "You got \(correctAnswerCounter) out of 10\nNeed more review on Katakana letters!"
            } else if correctAnswerCounter < 8 {
                alertMessage = "You got \(correctAnswerCounter) out of 10\nWay to go!"
            } else {
                alertMessage = "You got \(correctAnswerCounter) out of 10!\nExcellent!!"
            }
        }
    }
}

     func resetTheGame() {
        katakanas.shuffle()
        correctAnswer = Int.random(in: 0...2)
        answer = ""
    }
    
    func reset() {
        counter = 0
        correctAnswerCounter = 0
        katakanas.shuffle()
        correctAnswer = Int.random(in: 0...2)
        answer = ""
    }
    
    func disabe() -> Bool {
        if answer == "✨Correct✨" || answer == "Incorrect...the answer is '\(katakanas[correctAnswer].letter)'" {
            return true
        }
        return false
    }
    
    func disableNext() -> Bool {
        if answer == "" {
            return true
        }
        return false
    }
}

struct KatakanaQuiz_Previews: PreviewProvider {
    static var previews: some View {
        KatakanaQuiz()
    }
}
