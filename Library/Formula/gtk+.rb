require 'formula'

class Gtkx < Formula
  homepage 'http://www.gtk.org/'
  url 'http://ftp.gnome.org/pub/gnome/sources/gtk+/2.24/gtk+-2.24.4.tar.bz2'
  sha256 '7d3033ad83647079977466d3e8f1a7533f47abd5cc693f01b8797ff43dd407a5'

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'gdk-pixbuf'

  # Used by pango, but keg-only, so needs to be added to
  # the flags for gtk+ explicitly.
  # Also need a newer Cairo to use the quartz back-end.
  depends_on 'cairo' if MacOS.leopard? or ARGV.include? "--quartz"

  depends_on 'pango'
  depends_on 'jasper' => :optional
  depends_on 'atk' => :optional

  fails_with_llvm "Undefined symbols when linking", :build => "2326"

  def options
    [['--quartz', 'Use the Quartz backend instead of X11']]
  end

  def install
    args = ["--disable-debug",
            "--disable-dependency-tracking",
            "--prefix=#{prefix}",
            "--disable-glibtest"]
    args << "--with-gdktarget=quartz" if ARGV.include? "--quartz"
    system "./configure", *args

    system "make install"
  end

  def test
    system "gtk-demo"
  end
end
