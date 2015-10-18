class Highway < Formula
  desc "High performance source code search tool."
  homepage "https://github.com/tkengo/highway/"
  url "https://github.com/tkengo/highway/archive/v1.0.0.tar.gz"
  sha256 "bd7a51b7854c95c2b56499bc7dc5e2dd720e15f9775068263076b49e89d51dd8"

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
