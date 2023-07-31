//
//  HomePageView.swift
//  Jokes
//
//  Created by Mansour Mohammed Alshebli on 25/07/2023.
//

import SwiftUI

struct HomePageView: View {
    

    var body: some View {
        NavigationView {
            VStack {
                // Title for the app
                Text("Jokes App")
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.yellow)
                    .font(.largeTitle)
                    .cornerRadius(15)
                    .shadow(color: .yellow.opacity(1),
                            radius: 10, x: 0.0, y: 0.0)
                    .offset(y: -50)
                    .padding()
                
                // Happy image from assets
                Image("happy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .offset(x: -100, y: 60)
                    .padding()
                
                // Sad image from assets
                Image("sad")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .offset(x: 100, y: -180)
                    .padding()
                
                HStack(alignment: .top) {
                    // Using NavigationLik for navigating to the ContentView() view
                    NavigationLink(
                        destination: ContentView()) {
                        Text("Start →")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.green)
                            .font(.title)
                            .cornerRadius(15)
                            .shadow(color: .green.opacity(0.6),
                                    radius: 10, x: 0.0, y: 0.0)
                            .offset(y: -50)
                    }
                }
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

