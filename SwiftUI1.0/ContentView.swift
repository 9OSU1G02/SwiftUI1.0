//
//  ContentView.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var showFull = false
    @State var bottomState: CGSize = .zero
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(.default.delay(0.1))
            BackCardView()
                .frame(maxWidth: showCard ? 300 : 340)
                .frame(height: 220)
                .background(Color(show ? "card3" : "card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(.degrees(showCard ? -10 : 0))
                .rotation3DEffect(.degrees(10), axis: (x: 1.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            BackCardView()
                .frame(maxWidth: 340)
                .frame(height: 220)
                .background(Color(show ? "card4" : "card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .scaleEffect(0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(.degrees(showCard ? -5 : 0))
                .rotation3DEffect(.degrees(5), axis: (x: 1.0, y: 0, z: 0.0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            CardView()
                .frame(maxWidth: showCard ? 375 : 340)
                .frame(height: 220)
                .background(Color.black)
                // .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    showCard.toggle()
                }
                .gesture(DragGesture().onChanged { value in
                    viewState = value.translation
                    show = true
                }.onEnded { _ in
                    viewState = .zero
                    show = false
                })
            GeometryReader { proxy in
                BottomCardView(show: $showCard)
                    .offset(x: 0, y: showCard ? proxy.size.height / 2 : proxy.size.height + proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom)
                    .offset(y: bottomState.height)
                    .blur(radius: show ? 20 : 0)
                    .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                    .gesture(DragGesture().onChanged { value in
                        bottomState = value.translation
                        if showFull {
                            bottomState.height -= 300
                        }
                        if bottomState.height < -300 {
                            bottomState.height = -300
                        }
                    }.onEnded { _ in
                        if bottomState.height > 50 {
                            showCard = false
                        }
                        if (bottomState.height < -100 && !showFull) || (bottomState.height < -250 && showFull) {
                            bottomState.height = -300
                            showFull = true
                        } else {
                            bottomState = .zero
                            showFull = false
                        }
                    })
            }
            //.ignoresSafeArea()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color.accentColor)
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 375)
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var show: Bool
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5)
                .cornerRadius(5)
                .opacity(0.1)
            Text("Ullamco excepteur velit nulla adipisicing elit fugiat quis id amet ut. Voluptate do et in et nostrud proident nostrud dolore eiusmod. Ea eu pariatur adipisicing tempor tempor irure anim sint. Esse labore aliquip occaecat sit do deserunt eu proident ullamco velit. Elit aliquip eiusmod anim duis enim irure. Fugiat enim labore enim voluptate elit occaecat.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            HStack(spacing: 20) {
                RingView(show: $show, color1: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1), width: 88, height: 88, percent: 78)
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUI").fontWeight(.bold)
                    Text("12 of 12 sections completed\n10 hours spent so far")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineSpacing(4)
                }
                .padding(20)
                .background(Color("background3"))
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: 720)
        .background(BlurView(style: .systemUltraThinMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
        .frame(maxWidth: .infinity)
    }
}
