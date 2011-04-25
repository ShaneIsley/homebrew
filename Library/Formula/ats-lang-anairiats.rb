require 'formula'

class AtsLangAnairiats <Formula
  url 'http://downloads.sourceforge.net/sourceforge/ats-lang/ats-lang-anairiats-0.2.4.tar.gz'
  homepage 'http://www.ats-lang.org'
  md5 'ae9813eacddeb03dbe5db10856a5648a'

  depends_on 'pkg-config' => :build
  depends_on 'gmp'
  depends_on 'glib' => :optional
  depends_on 'gtk+' => :optional

  def install
    ENV.j1
    ENV['ATSHOME'] = pwd
    ENV['ATSHOMERELOC'] = "ATS-#{version}"

    # glib contrib hardcodes the include search path
    glib = Formula.factory 'glib'
    inreplace "contrib/glib/Makefile" do |s|
      s.gsub! 'INCLUDES= $(GLIBINC) -I"/usr/include/glib-2.0"', "INCLUDES= -I#{glib.include} -I#{glib.lib}/glib-2.0/include"
    end
    raise
    system "./configure", "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--disable-gtktest"
    system "make all"
    system "make install"
  end

  def test
    system "atscc --version"
  end
end
