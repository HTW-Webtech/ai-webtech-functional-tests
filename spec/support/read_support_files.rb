module SupportFiles
  def read_support_file(file_name)
    IO.binread(File.expand_path(__dir__) + "/files/#{file_name}")
  end
end

