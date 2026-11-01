# Cómo empezar con Claude Code en un proyecto: checklist de 15 min


### Minuto 0-2: antes de abrir Claude, mira la carpeta
Al abrir `claude` en una carpeta nueva aparece el diálogo de confianza, y lo que aceptas ahí activa las reglas allow y las carpetas adicionales del `.claude/settings.json` del proyecto. Antes de eso, los hooks del proyecto ya pueden ejecutarse (con `claude -p` lo hacen siempre, aunque nunca hayas confiado: lo comprobamos en este PC).

- [ ] **Si el repo no es tuyo, mira su configuración antes de abrir Claude.**
  - Por qué: hooks, `env`, reglas allow y servidores MCP del repo pueden actuar en tu máquina.
  - Cómo comprobarlo: `ls -la .claude/ .mcp.json CLAUDE.md AGENTS.md` y lee `.claude/settings.json` (hooks, env, allow), las skills de `.claude/skills/` y los servidores de `.mcp.json`. La [checklist de permisos](https://ctrlia.dev/recetas/checklist-permisos-claude-code.html) explica qué buscar.
- [ ] **Haz un commit o abre una rama nueva.**
  - Por qué: `/rewind` deshace las ediciones que Claude hace con sus herramientas de archivos, pero no los cambios hechos solo con comandos de Bash ni los de subagentes: git es tu red de seguridad.
  - Cómo comprobarlo: `git status` limpio y `git switch -c claude/primera-tarea`.
- [ ] **Abre `claude` en la raíz del proyecto, no en tu carpeta personal.**
  - Por qué: si arrancas en el home, la confianza dura solo esa sesión y no se guarda.
  - Cómo comprobarlo: `git rev-parse --show-toplevel` debe coincidir con la carpeta donde lanzas `claude`.
- [ ] **Lee el diálogo de confianza antes de aceptarlo.**
  - Por qué: lista las reglas y carpetas que el repo te concedería.
  - Cómo comprobarlo: acepta solo si te cuadran. Si no lo has visto nunca en esa carpeta, `claude doctor` te avisa de las reglas allow que están en pausa.

El script `minuto-0.sh` del repositorio hace este minuto por ti (muestra la configuración, el estado de git y, si le das un nombre, crea la rama):

```bash
cd ~/proyectos/mi-repo
ls -la .claude/ .mcp.json CLAUDE.md AGENTS.md 2>/dev/null   # ¿qué configuración trae?
git status && git switch -c claude/primera-tarea           # red de seguridad
claude doctor                                               # ¿ajustes válidos? ¿reglas en pausa?
claude                                                      # abre en la raíz y lee el diálogo de confianza
```

### Minuto 2-4: comprueba modo, modelo y esfuerzo
Sin configurar nada, hoy no arrancas como hace unos meses.

- [ ] **Mira el modo.**
  - Por qué: desde la 2.1.283, si tu cuenta y tu modelo lo admiten, las sesiones interactivas en la terminal y en VS Code arrancan en **auto**: un clasificador revisa los comandos y las peticiones de red y Claude no te pregunta por lo rutinario.
  - Cómo comprobarlo: lo ves en el indicador de la parte inferior y lo cambias con `Shift+Tab`. En un código que no conoces, empieza en **plan** (`/plan` o `Shift+Tab`): Claude explora y propone sin editar hasta que apruebes el plan.
- [ ] **Mira el modelo.**
  - Por qué: el modelo «Default» es **Opus 5.5** en Pro, Max, Ultra, Team, Enterprise y la API (desde la 2.1.280).
  - Cómo comprobarlo: `/model` lo cambia y lo guarda para las sesiones nuevas; en el selector, la tecla `s` lo cambia solo en esta sesión.
- [ ] **Mira el esfuerzo.**
  - Por qué: Opus 5.5, Sonnet 5.5 y Haiku 5.5 vienen con esfuerzo **medium**. Frases como «piensa mucho» o «sé exhaustivo» son texto normal: no suben el esfuerzo; `ultrathink` sí pide razonamiento más profundo en ese turno.
  - Cómo comprobarlo: `/effort status` para verlo, `/effort high` para tareas difíciles.
- [ ] **Confirma versión, cuenta y conexión.**
  - Por qué: es lo primero que conviene saber si algo no se comporta como esperas.
  - Cómo comprobarlo: `/status` muestra versión, modelo, cuenta y conexión. Si algo no carga como esperas, `/doctor` revisa instalación, ajustes y CLAUDE.md, y propone arreglos que aplica si confirmas.

### Minuto 4-8: /init y un CLAUDE.md que no estorbe
CLAUDE.md se carga en cada sesión y cada línea le quita un poco de atención a Claude en cada tarea. La [guía oficial](https://code.claude.com/docs/es/best-practices) lo resume así: escribe solo lo que Claude no puede encontrar leyendo el repo, o lo que tendría que volver a buscar en cada sesión.

- [ ] **Ejecuta `/init`.**
  - Por qué: Claude analiza el código y crea un CLAUDE.md con los comandos de build y de tests y las convenciones que encuentra. Si ya hay uno, propone mejoras en lugar de sobrescribirlo. Si encuentra configuración de Codex o de Gemini CLI, ofrece traerla con `/import`.
  - Modo guiado: si quieres un recorrido que también proponga skills, hooks y un `CLAUDE.local.md` personal, exporta `CLAUDE_CODE_NEW_INIT=1` antes de lanzar `/init`: pregunta qué quieres crear y te enseña una propuesta antes de escribir nada.
- [ ] **Recorta lo que sobre.**
  - Por qué: deja el comando de tests (la línea más útil, según la guía oficial), las decisiones del equipo, el proceso de despliegue, las variables de entorno necesarias y lo que no se debe tocar. Quita la descripción de carpetas y arquitectura (Claude la lee sola) y las mayúsculas o «IMPORTANTE».
  - Cómo comprobarlo: cada línea pasa la prueba «¿Claude lo encontraría leyendo el código?». Más en [un CLAUDE.md que funciona](https://ctrlia.dev/recetas/claude-md-que-funciona.html).
- [ ] **Si ya hay AGENTS.md, decide cómo convive con CLAUDE.md.**
  - Por qué: desde la 2.1.277 Claude Code lee AGENTS.md (de Codex o Cursor) cuando no hay CLAUDE.md. Si creas un CLAUDE.md, el AGENTS.md deja de cargarse.
  - Cómo comprobarlo: si quieres los dos, pon una línea `@AGENTS.md` dentro del CLAUDE.md.
- [ ] **Revisa lo que se carga.**
  - Por qué: lo personal no debe acabar en git.
  - Cómo comprobarlo: `/memory` abre los archivos cargados para editarlos. Lo personal va en `CLAUDE.local.md`, fuera de git.

### Minuto 8-10: los permisos que vas a necesitar
Si estás en Manual, aprobar diez veces `npm test` te lleva a aprobar sin leer; si estás en auto, conviene que lo delicado pregunte siempre.

- [ ] **Mira las reglas activas.**
  - Por qué: saber de dónde viene cada regla evita sorpresas.
  - Cómo comprobarlo: `/permissions` muestra las reglas activas y de qué archivo viene cada una.
- [ ] **Añade en `.claude/settings.json` lo que el equipo usa siempre.**
  - Por qué: los tests y el lint en **allow**, `git push` e instalar paquetes en **ask**, y en **deny** los secretos (`Read(./.env)`, `Read(./.env.*)`). Recuerda el orden: deny → ask → allow, y un ask pregunta incluso en auto. La receta de [permisos](https://ctrlia.dev/recetas/permisos-claude-code.html) tiene la plantilla completa.
  - Cómo comprobarlo: si una regla allow del proyecto no funciona, `claude doctor` en la carpeta te lo dice con «Ignoring N permissions.allow entries … this workspace has not been trusted»: falta aceptar la confianza. Y si el JSON está mal, verás «Invalid settings».

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "allow": ["Bash(npm test *)", "Bash(npm run lint *)"],
    "ask": ["Bash(git push *)", "Bash(npm install *)"],
    "deny": ["Read(./.env)", "Read(./.env.*)"]
  }
}
```

Es el mínimo para empezar en Node (`settings.ejemplo.json` en el repositorio); cambia los comandos por los tuyos.

- [ ] **Pon tus candados personales en `~/.claude/settings.json`.**
  - Por qué: valen en todos los proyectos: `deny` a `~/.ssh` y `~/.aws`, y `"disableBypassPermissionsMode": "disable"` si no quieres entrar en bypass por descuido.
  - Cómo comprobarlo: `python3 -m json.tool ~/.claude/settings.json` y, en la sesión, `/permissions`.
- [ ] **¿Llevas días aprobando lo mismo? Usa `/fewer-permission-prompts`.**
  - Por qué: revisa tus sesiones y propone una lista de comandos de solo lectura para permitir en el proyecto.
  - Cómo comprobarlo: revisa la lista antes de aceptarla.

### Minuto 10-11: mira /context antes de empezar
Antes de tu primer mensaje, la sesión ya lleva dentro el prompt del sistema, las herramientas, los servidores MCP, las skills, los plugins y tus CLAUDE.md. Saber cuánto ocupa te ahorra consumo en cada mensaje.

- [ ] **Ejecuta `/context`.**
  - Por qué: verás una cuadrícula de colores con el uso por categoría, qué CLAUDE.md y qué archivos de memoria se cargaron, y sugerencias cuando una herramienta o la memoria ocupan demasiado.
  - Si algo pesa sin motivo: servidores MCP que no usas en este proyecto, desactívalos en `/mcp`; skills que no usas, `/skills` y la tecla `t` las ordena por tokens, y `/skill-doctor` muestra su coste y cuánto se usan; plugins, en `/plugin` la cabecera «Not used recently» agrupa los que no usas; un CLAUDE.md largo, recórtalo o divide las reglas por carpeta en `.claude/rules/`.
- [ ] **Usa `/clear` entre tareas.**
  - Por qué: los modelos actuales trabajan con una ventana de 1M de tokens y compactan solos hacia los 967K, así que quedarse sin contexto es raro; aun así, la guía oficial recomienda `/clear` entre tareas, porque un contexto centrado da mejores respuestas y cuesta menos. Lo explicamos en [/clear o /compact](https://ctrlia.dev/recetas/clear-vs-compact.html).
  - Cómo comprobarlo: para el consumo de tu plan, `/usage`.

### Minuto 11-15: el primer encargo, bien hecho
Claude para cuando el trabajo **parece** terminado. Si no tiene nada que ejecutar que diga si está terminado de verdad, tú haces de suite de tests. La guía oficial lo dice así: dale algo que pueda ejecutar y que devuelva pasa o falla.

- [ ] **Elige una tarea pequeña y real.**
  - Por qué: un bug acotado o un test que falta se puede comprobar; «mejora el proyecto» no.
  - Cómo comprobarlo: puedes decir en una frase qué significa «terminado».
- [ ] **Escribe un prompt específico.**
  - Por qué: qué archivo, qué síntoma, qué significa «arreglado» y cómo comprobarlo. El ejemplo oficial cambia «arregla el bug del login» por: «los usuarios dicen que el login falla tras caducar la sesión; mira el refresco del token en src/auth/, escribe un test que lo reproduzca y luego arréglalo».
  - Cómo comprobarlo: usa la plantilla de primer encargo de abajo (`primer-encargo.md` en el repositorio).
- [ ] **Pide la evidencia.**
  - Por qué: «Todos los tests pasan» sin salida no te dice casi nada.
  - Cómo comprobarlo: la respuesta trae el comando que ejecutó y su salida.
- [ ] **Si no sabes bien lo que quieres, pide que te entreviste.**
  - Por qué: «entrevístame hasta que puedas escribir la especificación en SPEC.md», y empieza una sesión limpia con ese archivo.
  - Cómo comprobarlo: existe un SPEC.md que tú has leído y aprobado.
- [ ] **Revisa antes de dar nada por bueno.**
  - Por qué: `/diff` muestra los cambios del árbol de trabajo y `/code-review` revisa el diff en un subagente que no vio la conversación.
  - Cómo comprobarlo: antes de fusionar, sigue la [checklist antes de fusionar](https://ctrlia.dev/recetas/checklist-revisar-codigo-ia.html). ¿Cambias de tarea? `/clear`.

```text
Tarea: <qué y dónde: archivo o carpeta>
Síntoma / objetivo: <qué pasa hoy y qué debería pasar>
Terminado significa: <test que debe pasar, comando que debe dar 0, captura que debe verse>
Restricciones: <sin dependencias nuevas, no tocar X, seguir el patrón de Y>
Al final: pega el comando que ejecutaste y su salida.
```

Dentro de la sesión, en orden:

```text
/status                 versión, modelo, cuenta
/model                  Default = Opus 5.5 (s = solo esta sesión)
/effort status          medium por defecto en Opus/Sonnet/Haiku 5.5
/init                   genera o mejora CLAUDE.md (CLAUDE_CODE_NEW_INIT=1 para el modo guiado)
/memory                 revisa y recorta lo que se carga
/permissions            reglas activas y de qué archivo vienen
/context                cuánto ocupa todo antes de empezar
/plan <tarea>           explora sin editar hasta que apruebes
/diff                   revisa lo que cambió
/code-review            revisión en un subagente que no vio la conversación
/clear                  al cambiar de tarea
```

Si vas a dejar el proyecto configurado para todo el equipo, la [plantilla de proyecto](https://ctrlia.dev/recetas/plantilla-claude-code.html) trae todo esto ya puesto.

---
Versión completa, con errores típicos y preguntas frecuentes: https://ctrlia.dev/recetas/empezar-claude-code-15-minutos.html · Probado con Claude Code 2.1.316 · MIT
