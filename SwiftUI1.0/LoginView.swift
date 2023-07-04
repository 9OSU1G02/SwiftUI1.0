//
//  LoginView.swift
//  SwiftUI1.0
//
//  Created by Quốc Huy Nguyễn on 7/4/23.
//

import SwiftUI

struct LoginView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var isDragging = false
    @State var email: String = ""
    @State var password: String = ""
    @State var isFocused: Bool = false
    @State var showAlert: Bool = false
    var alertMessage = ""
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ZStack(alignment: .top) {
                Color("background2")
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)

                CoverView(show: $show, viewState: $viewState, isDragging: $isDragging)
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)
                        TextField("your email".uppercased(), text: $email)
                            .keyboardType(.emailAddress)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                isFocused = true
                            }
                    }
                    Divider().padding(.leading, 80)
                    HStack {
                        Image(systemName: "lock.fill")
                            .foregroundColor(Color(#colorLiteral(red: 0.6549019608, green: 0.7137254902, blue: 0.862745098, alpha: 1)))
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
                            .padding(.leading)

                        TextField("passowrd".uppercased(), text: $email)
                            .keyboardType(.default)
                            .font(.subheadline)
                            .padding(.leading)
                            .frame(height: 44)
                            .onTapGesture {
                                isFocused = true
                            }
                    }
                }
                .frame(height: 136)
                .frame(maxWidth: .infinity)
                .background(BlurView(style: .systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 20)
                .padding(.horizontal)
                .offset(y: 460)
                HStack {
                    Text("Forgot password?")
                        .font(.subheadline)
                    Spacer()
                    Button {
                        showAlert = true
                        hideKeyboard()
                        isFocused = false
                    } label: {
                        Text("Login").foregroundColor(.black)
                    }
                    .padding(12)
                    .padding(.horizontal, 30)
                    .background(Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)), radius: 20, x: 0, y: 20)
                    .alert(isPresented: $showAlert) {
                        Alert(title: .init("Error"), message: .init(alertMessage), dismissButton: .default(.init("OK"), action: {
                            
                        }))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding()
            }
            .offset(y: isFocused ? -300 : 0)
            .animation(isFocused ? .easeInOut : nil, value: isFocused)
            .onTapGesture {
                isFocused = false
                hideKeyboard()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct CoverView: View {
    @Binding var show: Bool
    @Binding var viewState: CGSize
    @Binding var isDragging: Bool
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Learn design & code.\nFrom scratch.")
                    .font(.system(size: geometry.size.width/10, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: 375, maxHeight: 100)
            .padding(.horizontal, 16)
            .offset(x: viewState.width/15, y: viewState.height/15)

            Text("80 hours of courses for SwiftUI, React and design tools.")
                .font(.subheadline)
                .frame(width: 250)
                .offset(x: viewState.width/20, y: viewState.height/20)

            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding(.top, 100)
        .frame(height: 477)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -150, y: -200)
                    .rotationEffect(Angle(degrees: show ? 360 + 90 : 90))
                    .blendMode(.plusDarker)
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
                    .onAppear { self.show = true }

                Image(uiImage: #imageLiteral(resourceName: "Blob"))
                    .offset(x: -200, y: -250)
                    .rotationEffect(Angle(degrees: show ? 360 : 0), anchor: .leading)
                    .blendMode(.overlay)
                    .animation(Animation.linear(duration: 120).repeatForever(autoreverses: false))
            }
        )
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Card3"))
                .offset(x: viewState.width/25, y: viewState.height/25),
            alignment: .bottom
        )
        .background(Color(#colorLiteral(red: 0.4117647059, green: 0.4705882353, blue: 0.9725490196, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .scaleEffect(isDragging ? 0.9 : 1)
        .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
        .rotation3DEffect(Angle(degrees: 5), axis: (x: viewState.width, y: viewState.height, z: 0))
        .gesture(
            DragGesture().onChanged { value in
                self.viewState = value.translation
                self.isDragging = true
            }
            .onEnded { _ in
                self.viewState = .zero
                self.isDragging = false
            }
        )
    }
}
