# TODO
from conan import ConanFile
from conan.tools.meson import MesonToolchain, Meson
from conan.tools.build import check_min_cppstd

class MyProject(ConanFile):
    name = "my_project"
    version = "0.1.0"
    license = "MIT"
    author = "Your Name <you@example.com>"
    url = "https://github.com/name/my_project"
    description = "A C/C++ project."

    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = {"shared": False}

    exports_sources = "src/*", "include/*", "tests/*", "meson.build"

    requires = [
        "zlib/1.2.11", # Example: Add any other dependency here
    ]

    generators = "MesonToolchain"

    def layout(self):
        self.folders.source = "."
        self.folders.build = "build"

    # def validate(self):
        # if self.settings.compiler.get_safe("cppstd"):
        #     check_min_cppstd(self, "17")

    def build(self):
        meson = Meson(self)
        meson.configure()
        meson.build()

    def package(self):
        meson = Meson(self)
        meson.install()
