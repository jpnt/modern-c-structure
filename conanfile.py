from conan import ConanFile
from conan.tools.meson import MesonToolchain, Meson
from conan.tools.gnu import PkgConfigDeps

class MyProjectRecipe(ConanFile):
    settings = "os", "compiler", "build_type", "arch"

    def generate(self):
        pkg_config = PkgConfigDeps(self)
        pkg_config.generate()

        meson_toolchain = MesonToolchain(self)
        meson_toolchain.generate()

    def requirements(self):
        self.requires("zlib/1.2.13")
