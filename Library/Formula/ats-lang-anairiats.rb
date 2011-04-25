require 'formula'

class AtsLangAnairiats <Formula
  url 'http://downloads.sourceforge.net/sourceforge/ats-lang/ats-lang-anairiats-0.2.4.tar.gz'
  homepage 'http://www.ats-lang.org'
  md5 'ae9813eacddeb03dbe5db10856a5648a'

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'gtk+'
  depends_on 'gmp'

  def install
    ENV.j1
    ENV['ATSHOME']=pwd
    ENV['ATSHOMERELOC']="ATS-#{version}"
    system "./configure", "--prefix=#{prefix}"
    system "make all"
    system "make install"
  end

  def caveats; <<-EOS.undent
    In order to use ATS/GTK, you must have gtk+ installed. To do so, run:
      $ brew install gtk
    In order to use ATK/Cairo, you must have cairo installed. To do so, run:
      $ brew install cairo
    EOS
  end

  def test
    system "atscc --version"
  end
end
