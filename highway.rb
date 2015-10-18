class Highway < Formula
  desc "High performance source code search tool."
  homepage "https://github.com/tkengo/highway/"
  url "https://github.com/tkengo/highway/archive/v1.0.0.tar.gz"
  sha256 "b554c21d9671289bc9c55a45a23c8b219847d232fa30da1a5e5c806b2158b94f"

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
