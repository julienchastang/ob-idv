class resourceLoader :
    import java.net.URLClassLoader

    def loadResource (self, u) :
        sysloader = self.java.lang.ClassLoader.getSystemClassLoader()
        return sysloader.getResourceAsStream(u)

import java.nio.file.Files as Files
import java.nio.file.Paths as Paths
import java.lang.System as System
import java.util.List
from java.awt import *
import ucar.unidata.idv.DefaultIdv as DefaultIdv
import ucar.unidata.idv.ui.ImageGenerator as ImageGenerator

idv = DefaultIdv([])
islInterpreter = ImageGenerator(idv)

# need to load a few resources from the classpath

my_files = ["ucar/unidata/idv/resources/python/shell.py",
           "ucar/unidata/idv/resources/python/isl.py"]

cpl = resourceLoader()
tmpfile = System.getProperty("java.io.tmpdir") + "/idv.py"

for f in my_files:
    inpstr = cpl.loadResource(f)
    path = Paths.get(tmpfile)
    Files.copy(inpstr, path)
    execfile(tmpfile)
    Files.delete(path)

