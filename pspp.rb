require 'formula'

class Pspp < Formula
  homepage 'http://www.gnu.org/software/pspp/'
  url 'http://ftpmirror.gnu.org/pspp/pspp-0.8.3.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/pspp/pspp-0.8.3.tar.gz'
  sha1 '48e9f9e264f76d7d8518b785b2e228b7539ffa99'

  option 'without-check', 'Skip running the PSPP test suite'
  option 'without-gui', 'Build without gui support'

  depends_on 'pkg-config' => :build

  depends_on :x11
  depends_on 'gsl'
  depends_on 'glib'
  depends_on 'gettext'
  depends_on 'readline'
  depends_on 'libxml2'
  depends_on 'cairo'
  depends_on 'pango'

  if build.with? 'gui'
    depends_on 'gtk+'
    depends_on 'gtksourceview'
    depends_on 'freetype'
    depends_on 'fontconfig'
  end

  def install
    args = ['--disable-rpath', '--without-libpq']
    args << '--without-gui' if build.without? 'gui'

    system './configure', "--prefix=#{prefix}", *args
    system 'make'
    system 'make', 'check' if build.with? 'check'
    system 'make', 'install'
  end

  test do
    system "#{bin}/pspp", '--version'
  end
end

