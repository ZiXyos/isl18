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
		print("[LOG::LOCAL-FOLDER]: \(self.doesLocalFolderExist())");
		print("[LOG::BUNDLE]: \(self.doesBundleFolderExist())");
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
		
		return .success(());
	}
	
	public func doesLocalFolderExist(
		with fmanager: FileManager = .default
	) -> Result<Void, configError> {
		
		guard self.doesLangExist() else {
			return .failure(configError.folderNotFound(dpath: "/lang"));
		}

		let langPath = fmanager.currentDirectoryPath.appending("/lang/");
		for lang in self.lang {
			guard isDir(fpath: langPath.appending(lang)) else {
				return .failure(configError.folderNotFound(dpath: langPath.appending(lang)));
			}
		}
		return .success(());
	}
	
	private func generateBundleFolder(
		_ lang: String,
		withBundle bundle: Bundle = .main,
		withFManager fManager: FileManager = .default
	) -> Result<Void, configError> {
		
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
			return .success(())
		}
		
		return .failure(configError.unexpected);
	}
	
	public func generateLocalFolder(
		_ lang: String,
		with fmanager: FileManager = .default
	) -> Result<Void, configError> {
		return .success(());
	}
	
	public func doesLangExist(
		with fmanager: FileManager = .default
	) -> Bool {

		let currentPath = fmanager.currentDirectoryPath;
		do {
			let items = try fmanager.contentsOfDirectory(atPath: currentPath);
			for _ in items {
				if isDir(fpath: currentPath.appending("/lang/")) {
					return true;
				};
			}
		} catch {
			return false;
		}
		return false;
	}
}
