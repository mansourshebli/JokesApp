//
//  FeedbackResponseView.swift
//  Jokes
//
//  Created by Mansour Mohammed Alshebli on 24/07/2023.
//

import SwiftUI

struct FeedbackResponseView: View {
    
    // isPositive var will act as a argument for the FeedbackResponseView()
    var isPositive: Bool
    
    // Variable for applying scale effect for the images
    @State private var scalingEffect = 0.0
    // Varibale for applying the rotation effect to the images
    @State private var rotationEffect: Angle = .zero
    
    var body: some View {
        VStack{
            // Using ternary operator to determine which image to display
            Image(isPositive ? "happy" : "sad")
                .resizable()
                .scaledToFit()
                .scaleEffect(scalingEffect)
                .rotationEffect(rotationEffect)
            // Animation both images on Appear
                .onAppear {
                    withAnimation (.easeIn(duration: 0.9)) {
                        // Using ternary operator for zooming in more closely when the image is sad
                        scalingEffect = isPositive ? 1 : 2.4
                        // Using ternary operator for rotating in more closely when the image is sad
                        rotationEffect = isPositive ? Angle(degrees: 360) : Angle(degrees: 720)
                    }
                }


            // Using ternary operator to determine which sentence to display
            Text(isPositive ? "Thanks, here's a cookie 🍪!" : "You lack the sense of humor!")
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

struct FeedbackResponseView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackResponseView(isPositive: true)
        FeedbackResponseView(isPositive: false)
    }
}
