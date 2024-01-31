from conan import ConanFile

class LibQux(ConanFile):
    name = "qux"
    settings = "os", "arch", "compiler", "build_type"
    package_type = "static-library"

    def requirements(self):
        self.requires("bar/1.0.0")
    
    def source(self):
        pass

    def build(self):
        pass

    def package_info(self):
        self.cpp_info.libs = ['qux']