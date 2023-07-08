//
//  Home.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 6/29/23.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState: CGSize = .zero
    @State var showContent = false
    @EnvironmentObject var user: UserStore
    var body: some View {
        ZStack {
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top, 44)
                .background(VStack(content: {
                    LinearGradient(gradient: .init(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 200)
                    Spacer()
                }).background(Color("background1")))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .offset(y: showProfile ? -450 : 0)
                .rotation3DEffect(.degrees(showProfile ? Double(viewState.height / 10) - 10 : 0), axis: (x: 1, y: 0, z: 0))
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
                .ignoresSafeArea()
            
            MenuView(showProfile: $showProfile)
                .background(Color.black.opacity(0.00001))
                .offset(y: showProfile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: showProfile)
                .onTapGesture {
                    showProfile.toggle()
                }
                .gesture(DragGesture().onChanged { value in
                    withAnimation {
                        viewState = value.translation
                        if viewState.height < -300 {
                            viewState.height = -300
                        }
                    }
                }.onEnded { _ in
                    if viewState.height > 50 {
                        showProfile = false
                    }
                    withAnimation {
                        viewState = .zero
                    }
                })
            if user.showLogin {
                ZStack {
                    LoginView()
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "xmark")
                                .frame(width: 36, height: 36)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .clipShape(Circle())
                        }
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        user.showLogin = false
                    }
                }
            }
            if showContent {
                BlurView(style: .systemMaterial).ignoresSafeArea()
                ContentView()
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .zIndex(1)
                .onTapGesture {
                    showContent = false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(UserStore())
    }
}

struct AvatarView: View {
    @Binding var showProfile: Bool
    @EnvironmentObject var user: UserStore
    var body: some View {
        VStack {
            if user.isLogged {
                Button {
                    showProfile.toggle()
                } label: {
                    Image("Avatar")
                        .resizable()
                        .frame(width: 36, height: 36)
                        .clipShape(Circle())
                }
            } else {
                Button {
                    user.showLogin.toggle()
                } label: {
                    Image(systemName: "person")
                        .foregroundColor(.primary)
                        .font(.system(size: 16, weight: .medium))
                        .frame(width: 36, height: 36)
                        .background(Color("background3"))
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                }

            }
        }
    }
}

let screen = UIScreen.main.bounds
