require 'formula'

class Mapnik <Formula
  url 'http://download.berlios.de/mapnik/mapnik-0.7.1.tar.gz'
  homepage 'http://www.mapnik.org/'
  md5 '3a070fdd7c6a3367ad78d95c2387b03b'

  depends_on 'scons' => :build
  depends_on 'libtiff'
  depends_on 'jpeg'
  depends_on 'proj'
  depends_on 'icu4c'
  depends_on 'boost'

  def install
    tiff_prefix = Formula.factory("libtiff").prefix
    jpeg_prefix = Formula.factory("jpeg").prefix
    proj_prefix = Formula.factory("proj").prefix
    icu_prefix = Formula.factory("icu4c").prefix
    boost_prefix = Formula.factory("boost").prefix
    system 'scons', "PREFIX=#{prefix}",
        "TIFF_INCLUDES=#{tiff_prefix}/include",   "TIFF_LIBS=#{tiff_prefix}/lib",
        "JPEG_INCLUDES=#{jpeg_prefix}/include",   "JPEG_LIBS=#{jpeg_prefix}/lib",
        "PROJ_INCLUDES=#{proj_prefix}/include",   "PROJ_LIBS=#{proj_prefix}/lib",
        "ICU_INCLUDES=#{icu_prefix}/include",     "ICU_LIBS=#{icu_prefix}/lib",
        "BOOST_INCLUDES=#{boost_prefix}/include", "BOOST_LIBS=#{boost_prefix}/lib",
        "install"
  end
end
