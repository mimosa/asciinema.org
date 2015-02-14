class CompressedFileUploader < BaseUploader

  def cached?
    File.exist?(current_path)
  end

  def cache_stored_file!
    FileUtils.mkdir_p File.dirname(current_path)
    File.open(current_path, 'w') { |f| f.write file.read }
  end

  def decompressed_path
    return unless file
    cache_stored_file! unless cached?

    out_path = "#{current_path}.decompressed"

    unless File.exist?(out_path)
      decompress(out_path)
    end

    out_path
  end

  private

    def decompress(out_path)
      header = File.read(current_path, 2).bytes

      case header
      when [31, 139]
        system("gzip -d -c #{current_path} >#{out_path}")
      when [66, 90]
        system("bzip2 -d -c #{current_path} >#{out_path}")
      else
        raise "unknown compressed file format"
      end
    end

end
