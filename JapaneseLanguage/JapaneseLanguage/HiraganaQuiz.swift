import SwiftUI

struct HiraganaQuiz: View { let hiraganas: [Japanese] = Bundle.main.decode("Hiragana.json")
    @State private var randomHiraganas: [Japanese]

init() {
    randomHiraganas = hiraganas.shuffled()
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
                .font(.system(size: 20))
                .font(.title)
                .padding(.bottom,80)
                .padding(.top,40)

            Button {
                soundplayer.playSounds(file: randomHiraganas[correctAnswer].voice1)
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
                        Text(randomHiraganas[index].letter)
                    }
                }
                .disabled(disabe())
                .foregroundColor(.white)
                .font(.system(size: 35).bold())
                .frame(width: 70, height: 70)
                .background(.cyan)
                .cornerRadius(10)
                .padding([.leading,.trailing])
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

        }
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
        answer = "Incorrect...the answer is '\(randomHiraganas[correctAnswer].letter)'"
    }
    counter += 1

    if counter == 10 {
        showingAlert = true
        alertMessage = "You got \(correctAnswerCounter) out of 10!"
    }
}

     func resetTheGame() {
        randomHiraganas.shuffle()
        correctAnswer = Int.random(in: 0...2)
        answer = ""
    }
    
    func reset() {
        counter = 0
        correctAnswerCounter = 0
        randomHiraganas.shuffle()
        correctAnswer = Int.random(in: 0...2)
        answer = ""
    }
    
    func disabe() -> Bool {
        if answer == "✨Correct✨" || answer == "Incorrect...the answer is '\(randomHiraganas[correctAnswer].letter)'" {
            return true
        }
        return false
    }
}

struct HiraganaQuiz_Previews: PreviewProvider {
    static var previews: some View {
        HiraganaQuiz()
    }
}
