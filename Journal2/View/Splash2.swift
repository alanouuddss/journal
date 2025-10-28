//
//  Splash2.swift
//  Journal2
//
//  Created by AlAnoud Alsaaid on 01/05/1447 AH.
//

import SwiftUI

struct Splash2: View {
    @State private var showIntro = false
    @State private var animate = false

    var body: some View {
        ZStack {
            if showIntro {
                Intro2()
                
            // بعد 3 ثواني يفتح شاشة اليومية
            } else {
                // الخلفية الغامقة المتدرجة
                LinearGradient(
                    colors: [
                        Color(red: 0.03, green: 0.03, blue: 0.05),
                        Color(red: 0.09, green: 0.09, blue: 0.11)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 14) {
                    Spacer()

                    // شعار التطبيق (دفتر بنفسجي)
                    Image("SplashIcon") // تأكد من إضافتها في Assets
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .scaleEffect(animate ? 1.0 : 0.85)
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 5)

                    // اسم التطبيق
                    Text("Journali")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.top, 8)

                    // الوصف
                    Text("Your thoughts, your story")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(.white.opacity(0.75))
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)

                    Spacer()
                }
                .onAppear {
                    // حركة دخول ناعمة
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.65)) {
                        animate = true
                    }
                    // انتقال تلقائي بعد 3 ثواني
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            showIntro = true
                        }
                    }
                }
                .transition(.opacity)
            }
        }
        .toolbar(.hidden) // إخفاء شريط التنقل
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Splash2()
}
