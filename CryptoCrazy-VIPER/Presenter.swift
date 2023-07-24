//
//  Presenter.swift
//  CryptoCrazy-VIPER
//
//  Created by Salih Yusuf Göktaş on 24.07.2023.
//

import Foundation

// Talks to -> interactor, router, view
// Class, protocol

enum NetworkError : Error {
	case NetworkFailed
	case ParseFailed
}

protocol AnyPresenter {
	var router : AnyRouter? {get set}
	var interactor : AnyInteractor? {get set}
	var view : AnyView? {get set}
	
	func interactorDidDownloadCrypto(result:Result<[Crypto],Error>)
}

class CryptoPresenter : AnyPresenter {
	var router: AnyRouter?
	
	var interactor: AnyInteractor? {
		didSet {
			interactor?.downloadCryptos()
		}
	}
	
	var view: AnyView?
	
	func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
		switch result {
		case.success(let cryptos):
			view?.update(with: cryptos)
		case.failure(_):
			view?.update(with: "Try again later...")
		}
	}
	
	 
}
