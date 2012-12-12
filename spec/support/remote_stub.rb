module RemoteStub
  def load_fixture(name)
    path = File.join SPEC_ROOT, "fixtures", name
    File.exists?(path) ? File.read(path) : nil
  end
end
