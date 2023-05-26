//
//  File.swift
//  
//
//  Created by Ktchoumh on 5/26/23.
//

import Foundation
func isDir(
	with fmanager: FileManager = .default,
	fpath: String
) -> Bool {

	var isDir: ObjCBool = false;
	if !fmanager.fileExists(atPath: fpath, isDirectory: &isDir) && isDir.boolValue {
		print("no dir here");
		return false
	}
	return true;
}
