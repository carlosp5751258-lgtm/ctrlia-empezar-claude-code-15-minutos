# Cómo empezar con Claude Code en un proyecto: checklist de 15 minutos (Ctrl+IA)

Los primeros 15 minutos con Claude Code en un proyecto nuevo o recién clonado: revisar la carpeta antes de confiar en ella, modo, modelo y esfuerzo, `/init` y un CLAUDE.md corto, los permisos que vas a necesitar, `/context` y un primer encargo con evidencia.

Página completa: https://ctrlia.dev/recetas/empezar-claude-code-15-minutos.html (English: https://ctrlia.dev/en/recetas/empezar-claude-code-15-minutos.html)

## Qué trae
| Archivo | Para qué |
| --- | --- |
| `checklist.md` / `checklist.en.md` | La lista minuto a minuto, para imprimir o marcar |
| `minuto-0.sh` | Antes de abrir Claude: muestra la configuración que trae la carpeta y el estado de git y, si le das un nombre, crea la rama de trabajo |
| `settings.ejemplo.json` | `.claude/settings.json` mínimo para empezar (Node; cambia los comandos por los tuyos) |
| `primer-encargo.md` / `primer-encargo.en.md` | Plantilla para el primer encargo: tarea, objetivo, qué significa terminado, restricciones y evidencia |

## Cómo usarlo
```bash
cd ~/proyectos/mi-repo
/ruta/a/minuto-0.sh claude/primera-tarea   # sin argumento no crea rama
claude                                     # y lee el diálogo de confianza antes de aceptarlo
```

## Probado
Con Claude Code 2.1.316 en Linux: `claude doctor` y el aviso de reglas allow sin confianza, y `minuto-0.sh` dentro de un repo (desde una subcarpeta, creando la rama) y fuera de un repo (sale con código 1). Los pasos dentro de la sesión (`/init`, `/model`, `/context`…) salen de la documentación oficial (ver la página).

## Licencia
MIT. Copyright (c) 2026 Ctrl+IA (Carlos P.).
