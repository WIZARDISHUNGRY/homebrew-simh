class Simh < Formula
  desc "Portable, multi-system simulator"
  homepage "http://simh.trailing-edge.com/"
  sha256 ""
  #version "v4.0-Beta-1"

  head "https://github.com/simh/simh.git"

  depends_on "sdl2"

  def install
    ENV.deparallelize unless build.head?
    inreplace "makefile", "GCC = gcc", "GCC = #{ENV.cc}"
    inreplace "makefile", "CFLAGS_O = -O2", "CFLAGS_O = #{ENV.cflags}"
    inreplace "makefile", "/opt/local", "/usr/local"
    system "make", "all"
    bin.install Dir["BIN/*"]
    Dir["**/*.txt"].each do |f|
      (doc/File.dirname(f)).install f
    end
    (share/"simh/vax").install Dir["VAX/*.{bin,exe}"]
  end

  test do
    assert_match(/Goodbye/, pipe_output("#{bin}/altair", "exit\n", 0))
  end
end
