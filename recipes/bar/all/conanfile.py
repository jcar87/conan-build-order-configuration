from conan import ConanFile

class LibBar(ConanFile):
    name = "bar"
    settings = "os", "arch", "compiler", "build_type"
    package_type = "static-library"

    def source(self):
        pass

    def build(self):
        pass

    def package_info(self):
        self.cpp_info.libs = ['bar']