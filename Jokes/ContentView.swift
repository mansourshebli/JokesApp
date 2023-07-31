//
//  ContentView.swift
//  Jokes
//
//  Created by Mansour Mohammed Alshebli on 19/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    // Creating an array called jokes that will use the Joke() struct arguments
    var jokes = [ Joke(setup: "Why couldn't the bicycle stand up?",
                       punchline: "It was two tired!"),
                  
                  Joke(setup: "Why did the chicken cross the road?",
                       punchline: "To get to the other side!"),
                  
                  Joke(setup: "Is this pool safe for diving?",
                       punchline: "It deep ends"),
                  
                  Joke(setup: "Did you hear about the cheese factory that exploded in France?",
                       punchline: "There was nothing left but de Brie"),
                  
                  Joke(setup: "Dad, can you put my shoes on?",
                       punchline: "I don’t think they'll fit me"),
    ]
    
    // These state variables will be used in the sheets and alerts and in tracking
    @State private var showPunchline = false
    @State private var currentJokeIndex = 0
    @State private var isFeedbackPresented = false
    @State private var displaySheet = false
    @State private var isPositive = false
    @State private var showHomePage = false
    @State private var currentJokeNumber = 0
    @State private var jokesAreFinished = false
    
    
    // Animation variabled
    @State private var punchlineSize = 0.1
    @State private var punchlineRotation: Angle = .zero
    @State private var hueRotationPunchline: Angle = .zero
    @State private var opacity = 0.0
    @State private var tapToContinueOffset = 50.0
    
    
    var body: some View {
        ZStack {
            // Using the .systemBackground for dark and light mode
            Color(.systemBackground)
                .onTapGesture {
                    if showPunchline {
                        currentJokeIndex += 1
                        showPunchline = false
                        isFeedbackPresented = true
                    }
                    
                    if currentJokeNumber >= jokes.count {
                        currentJokeIndex = 0
                        currentJokeNumber = 0
                        jokesAreFinished = true
                    }
                }
            
            // Creating a text that will be displayed and will keep track of currentJokeNumber with string interpolation
            Text("Current Joke Number 🤡 \n \(currentJokeNumber)")
                .multilineTextAlignment(.center)
                .font(.title)
                .padding()
                .background(Color.yellow)
                .cornerRadius(30)
                .shadow(color: .yellow.opacity(0.8),
                        radius: 10, x: 0.0, y: 0.0)
                .offset(y: -300)
            
            
            VStack {
                // This is the setup of the joke that will be diplayed in the screen
                Text(jokes[currentJokeIndex % jokes.count].setup)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Button for showing the joke
                Button {
                    print("Show the Joke!")
                    showPunchline = true
                    currentJokeNumber = currentJokeIndex + 1
                }label: {
                    Text("**What??**")
                        .font(.title2)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(40)
                }
                .padding()
                
                // If punchline is true then the joke punchline will be shown and tap to continue will also be displayed
                if showPunchline {
                    
                    Text(jokes[currentJokeIndex % jokes.count].punchline)
                        .font(.title)
                        .padding()
                        .scaleEffect(punchlineSize)
                        .rotationEffect(punchlineRotation)
                        .hueRotation(hueRotationPunchline)
                        .opacity(opacity)
                    // Animating the punchline and tap to continue button when it appears using state variabls
                        .onAppear {
                            withAnimation (.easeInOut(duration: 0.7)) {
                                punchlineSize = 1
                                punchlineRotation = Angle(degrees: -360)
                                hueRotationPunchline = Angle(degrees: 180)
                                opacity = 1
                                tapToContinueOffset = 0
                                
                            }
                        }
                    // The animation will stop when the animation is already displayed
                        .onDisappear {
                            punchlineSize = 0.1
                            punchlineRotation = .zero
                            hueRotationPunchline = .zero
                            opacity = 0.0
                            tapToContinueOffset = 50
                        }
                    
                    Text("Tap to continue")
                        .italic()
                        .padding()
                        .opacity(opacity)
                        .offset(y: tapToContinueOffset)
                    
                        
                }
            }
            
            /* Alert asking for the user feedback and based on the feedback sad or happy image will be displayed with a meme punchline */
            .alert("Did you like the last joke?", isPresented: $isFeedbackPresented) {
                Button("Love it 😍 !", role: .destructive){
                    print("Great!")
                    // If the user liked the joke; the happy image will be shown which mean isPositive variable will be true
                    isPositive = true
                    displaySheet = true
                }
                Button("MEH 😒 !", role: .cancel){
                    print("Why??")
                    // If the user didn't liked the joke; the sad image will be shown which mean isPositive variable will be false
                    isPositive = false
                    displaySheet = true
                }
                // The message will be small under the title of the button
            } message: {
                Text("This feedback is useless anyway")
            }
            
            // Displaying the sheet using binding
        
            .sheet(isPresented: $displaySheet) {
                FeedbackResponseView(isPositive: isPositive)
                // This sheet modifer will determine the size of the sheet
                    .presentationDetents([.large, .medium])
                // This sheet modifier will make the indicator for the sheet visisble
                    .presentationDragIndicator(.visible)
                    
            // This alert will be true when the jokes are finished
            .alert("Thats all! the jokes are finished 😄", isPresented: $jokesAreFinished) {
                Button("Repeat"){
                    reset()
                    
                }
                    }
            }
        }
        
        
    }
    
    
    // The reset function will be used in the last alert which will say all jokes are finished and when the user clicks ok the game will be restated; each variable will be setteled to it's origional value
    func reset() {
        showPunchline = false
        currentJokeIndex = 0
        isFeedbackPresented = false
        displaySheet = false
        isPositive = false
        currentJokeNumber = 0
        jokesAreFinished = false
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            
        }
    }
    
}
