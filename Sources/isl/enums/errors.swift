//
//  File.swift
//  
//
//  Created by Ktchoumh on 5/26/23.
//

import Foundation

public enum configError: Error {
	case fileNotFound(fname: String);
	case folderNotFound(dpath: String);
	case unexpected;
}
