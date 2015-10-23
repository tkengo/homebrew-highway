class Highway < Formula
  desc "High performance source code search tool."
  homepage "https://github.com/tkengo/highway/"
  url "https://github.com/tkengo/highway/archive/v1.0.2.tar.gz"
  sha256 "142217828de393a6fdb87eabb677d2c7af4298872e3071523dff08e7242f93c5"

  version "1.0.2"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gperftools" => :build

  def install
    system "mkdir", "-p config"
    system "aclocal", "-I #{HOMEBREW_PREFIX}/share/aclocal"
    system "autoconf"
    system "autoheader"
    system "automake", "--add-missing"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    path = testpath/"hello_world.txt"
    path.write "Hello World!"

    lines = `#{bin}/hw 'Hello World!' #{path}`.strip.split(":")
    assert_equal "Hello World!", lines[2]
  end
end
