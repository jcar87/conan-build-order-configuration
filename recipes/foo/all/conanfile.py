from conan import ConanFile

class LibFoo(ConanFile):
    name = "foo"
    settings = "os", "arch", "compiler", "build_type"
    package_type = "static-library"

    def requirements(self):
        self.requires("bar/1.0.0")

        if self.settings.os == "Macos":
            # Force conditional dependency only on one platform
            self.requires("qux/1.0.0")

    def source(self):
        pass

    def build(self):
        pass

    def package_info(self):
        self.cpp_info.libs = ['foo']