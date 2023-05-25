public struct Isl18 {

	private let config: IslConfig;
	public private(set) var text = "Hello, World!"

	public init(lang: Array<String>) {
		self.config = IslConfig(lang: lang)
	}
}
