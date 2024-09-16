//
//  HomeView.swift
//  PasswordManager
//
//  Created by Najir on 13/09/24.
//

import SwiftUI

struct HomeView: View {
    @State var showAddPasswordSheet: Bool = false
    @State var showAccountDetailsSheet: Bool = false
    @StateObject var homeVM: HomeViewModal = HomeViewModal()
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            mainBody
            addButton
        }
        .showCustomSheet(isPresented: $showAddPasswordSheet) {
            AddPasswordView(
                passwordsDetails: $homeVM.passwordsDatails,
                isOpenSheet: $showAddPasswordSheet
            )
        }
        .showCustomSheet(isPresented: $showAccountDetailsSheet) {
            AccountDetailsView(
                passwordsDetails: $homeVM.passwordsDatails,
                index: $homeVM.currentPasswordIndex,
                isSheetOpen: $showAccountDetailsSheet
            )
        }
    }
    
}

#Preview {
    HomeView()
}

extension HomeView {
    
    private var mainBody: some View {
        VStack(spacing: .zero) {
            header
            if homeVM.passwordsDatails.isEmpty {
                noDataText
            } else {
                passwordDetailsScrollView
            }
            Spacer()
            
        }
        .background(Color.backgroundColor)
    }
    
    private var passwordDetailsScrollView: some View {
        ScrollView {
            ForEach(Array(homeVM.passwordsDatails.enumerated()), id: \.offset) { index, _ in
                passwordRowButton(index: index)
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: .zero) {
            HStack {
                Text("Password Manager")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            Divider()
        }
    }
    
    private var addButtonView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 70, height: 70)
            Image(systemName: "plus")
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
        }
    }
    
    private var addButton: some View {
        Button {
            showAddPasswordSheet = true
        } label: {
            addButtonView
        }
        .padding()
        .padding()
    }
    
    private func passwordRowButton(index: Int) -> some View {
        Button {
            homeVM.currentPasswordIndex = index
            showAccountDetailsSheet = true
        } label: {
            passwordRowView(index: index)
        }

    }
    
    private func passwordRowView(index: Int) -> some View {
        HStack {
            Text(homeVM.passwordsDatails[index].accountName)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundStyle(.black)
            passwordHideView
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.black)
        }
        .padding()
        .padding(.horizontal)
        .background(.white)
        .cornerRadius(50)
        .padding([.horizontal, .top])
        
    }
    
    private var passwordHideView: some View {
        HStack(spacing: 2) {
            ForEach(0..<7, id: \.self) { _ in
                Image(systemName: "staroflife.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.primaryGray)
            }
        }
    }
    
    private var noDataText: some View {
        VStack {
            Spacer()
            Text("Add(+) Password Details")
                .font(.system(size: 24))
                .fontWeight(.bold)
            Spacer()
        }
    }
}

