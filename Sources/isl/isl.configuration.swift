//
//  File.swift
//  
//
//  Created by Ktchoumh on 5/26/23.
//

import Foundation
public struct IslConfig {
	
	let lang: Array<String>;
	public init(lang: Array<String>) {
		self.lang = lang;
	}
	
	public func doesBundleFolderExist(
		with bundle: Bundle = .main
	) -> Result<Void, configError> {
		
		for folderName in self.lang {
			
			if bundle.path(forResource: folderName, ofType: nil) == nil {

				let res = self.generateBundleFolder(folderName)
				switch res {
				case .success(_):
					continue;
				case .failure(_):
					return .failure(configError.folderNotFound(dpath: folderName)) // already Exist
				}
			}
		}
		
		return .success(<#Void#>);
	}
	
	public func doesLocalFolderExist(
		with fmanager: FileManager = .default
	) -> Result<Void, configError> {}
	
	private func generateBundleFolder(
		_ lang: String,
		withBundle bundle: Bundle = .main,
		withFManager fManager: FileManager = .default
	) -> Result<String, configError> {
		
		if let bundlePath = bundle.resourcePath {

			let folderPath = (bundlePath as NSString)
				.appendingPathComponent(lang);
			do {
				try fManager.createDirectory(
					atPath: folderPath,
					withIntermediateDirectories: true,
					attributes: nil
				);
			} catch {
				return .failure(configError.folderNotFound(dpath: folderPath));
			}
			return .success(folderPath)
		}
	}
}
