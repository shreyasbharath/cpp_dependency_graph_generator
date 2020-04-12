module DirectoryParser
  def fetch_all_dirs(root_dir)
    Find.find(root_dir).select { |e| File.directory?(e) }
  end

  def glob_files(path, extensions)
    path = File.join(path, File::SEPARATOR) + '*' + extensions
    Dir.glob(path).select { |entry| File.file?(entry) }.compact
  end
end
