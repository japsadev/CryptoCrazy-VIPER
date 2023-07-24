//
//  Interactor.swift
//  CryptoCrazy-VIPER
//
//  Created by Salih Yusuf Göktaş on 24.07.2023.
//

import Foundation

// Talks to -> presenter
// Class, protocol
// https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json

protocol AnyInteractor {
	var presenter : AnyPresenter? {get set}
	
	func downloadCryptos()
}

class CryptoInteractor : AnyInteractor {
	var presenter: AnyPresenter?
	
	func downloadCryptos() {
		
		guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else {
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
			
			guard let data = data, error == nil else {
				self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed))
				return
			}
			do {
				let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
				self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
			} catch {
				self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.ParseFailed))
			}
		}
		
		task.resume()
		
	}
	

}
