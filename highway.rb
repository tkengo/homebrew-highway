class Highway < Formula
  desc "High performance source code search tool."
  homepage "https://github.com/tkengo/highway/"
  url "https://github.com/tkengo/highway/archive/v1.0.1.tar.gz"
  sha256 "e1ad3732cbbd55f46c0cee334150af6a2222bfb27b77a1753fc0f0d0579cd865"

  version "1.0.0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gperftools" => :build

  def install
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
