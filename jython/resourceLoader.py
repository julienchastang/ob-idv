
class classPathLoader :
    import java.net.URLClassLoader

    def loadResource (self, u) :
        sysloader = self.java.lang.ClassLoader.getSystemClassLoader()
        return sysloader.getResourceAsStream(u)
