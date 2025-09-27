# MQL5 Compiler

Compilar imagen.

```powershell
# Build image
docker build -t mql5-compiler:latest .
```

## Uso

```powershell
# Check versions
docker run -it --rm --name mt5-compiler -v ${PWD}:/work mql5-compiler:latest /opt/mql/scripts/check-version.sh

# Compile
docker run -it --rm --name mt5-compiler -v ${PWD}:/work mql5-compiler:latest /opt/mql/scripts/mql5-compile.sh Experts/Testing/ConfigurationTest.mq5
```

## Comprobaciones

Lanzar contenedor en la misma carpeta del repositorio.

```powershell
# Run container shell
docker run -it --rm --name mt5-compiler -v ${PWD}:/work mql5-compiler:latest
```

### Comprobaciones de Wine

```bash
# Check version
wine --version

# Check command
wine cmd /c "echo Hello World"

# Check script
wine cmd /c "test\\wine-test.bat"
```

### Comprobaciones de MetaEditor4

```bash
# Check version
exiftool /opt/mql/metaeditor64.exe | grep -E '^Product Version[[:space:]]*:' | awk -F': ' '{print $2}'

# Check compilation
wine /opt/mql/metaeditor64.exe /portable /compile:"Z:/work/Experts/Testing/ConfigurationTest.mq5" /inc:Z:/work  /log:"Z:/work/compile.log"
```
