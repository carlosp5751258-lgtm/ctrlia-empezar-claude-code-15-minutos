# Plantilla de primer encargo

Copia, rellena y pégalo en Claude Code.

```text
Tarea: <qué y dónde: archivo o carpeta>
Síntoma / objetivo: <qué pasa hoy y qué debería pasar>
Terminado significa: <test que debe pasar, comando que debe dar 0, captura que debe verse>
Restricciones: <sin dependencias nuevas, no tocar X, seguir el patrón de Y>
Al final: pega el comando que ejecutaste y su salida.
```

Ejemplo de la guía oficial de buenas prácticas: en lugar de «arregla el bug del login», escribe
«los usuarios dicen que el login falla tras caducar la sesión; mira el refresco del token en src/auth/,
escribe un test que lo reproduzca y luego arréglalo».
