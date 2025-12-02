# Proyecto II: Mundo Chiquito

**Laboratorio de Lenguajes de Programación (CI-3661)**  
**Universidad Simón Bolívar**  
**Septiembre - Diciembre 2025**

## Integrante
- **Nombre:** Gerel Negreira Peruzzi  
- **Carnet:** 09-11163

---

## Descripción del Juego

Este proyecto está basado en el juego de cartas coleccionables "Duelo de cartas de mostro", donde los jugadores (duelistas) arman mazos de cartas para competir. Existen dos tipos principales de cartas:

- **Cartas Mostro:** Representan criaturas con características específicas:
  - Nombre único
  - Nivel (1-12)
  - Atributo (agua, fuego, viento, tierra, luz, oscuridad, divino)
  - Poder (múltiplo de 50)

- **Cartas Conjuro:** Contienen efectos especiales que los jugadores pueden activar.

### La Carta "Mundo Chiquito"

La carta "Mundo Chiquito" es un conjuro especial que permite buscar cartas específicas del mazo siguiendo esta mecánica:

1. Revelas un mostro de tu mano
2. Buscas en el mazo un mostro que comparta **exactamente una característica** (nivel, poder o atributo) con el revelado
3. Luego agregas a tu mano otro mostro del mazo que comparta **exactamente una característica** con el segundo mostro

El problema es que las condiciones son bastante complicadas de calcular mentalmente durante una partida, por eso este programa ayuda a encontrar todas las combinaciones válidas.

---

## Implementación

### Estructura del Código

El archivo `mundo_chiquito.pl` contiene la solución completa con los siguientes componentes:

#### 1. Base de Conocimiento
Usa el predicado dinámico `mostro/4` que almacena:
```prolog
mostro(Nombre, Nivel, Atributo, Poder)
```

#### 2. Predicado Auxiliar: `compartenUnaCaracteristica/2`
Este predicado es el corazón de la lógica. Verifica que dos mostros compartan exactamente una característica entre nivel, atributo y poder.

La implementación cuenta cuántas características coinciden sumando 1 por cada coincidencia, y luego verifica que el total sea exactamente 1. Esto asegura que no haya más ni menos coincidencias.

#### 3. `ternaMundoChiquito/3`
Este predicado encuentra todas las ternas válidas (Mano, Mazo1, Mazo2) siguiendo la lógica de la carta:

- Selecciona un mostro de la base de datos (representa la mano)
- Busca un mostro que comparta exactamente una característica con el primero
- Busca un tercer mostro que comparta exactamente una característica con el segundo

Prolog automáticamente genera todas las combinaciones posibles mediante backtracking.

#### 4. `mundoChiquito/0`
Utiliza `forall` para imprimir todas las ternas válidas encontradas por `ternaMundoChiquito/3`, una por línea con el formato solicitado.

#### 5. `agregarMostro/0`
Permite agregar nuevos mostros interactivamente. Lee los datos del usuario y valida que cumplan las restricciones:
- Nivel entre 1 y 12
- Atributo válido
- Poder múltiplo de 50

Usa `assertz` para agregar dinámicamente el nuevo mostro a la base de conocimiento.

---

## Uso del Programa

### Consultar todas las ternas válidas:
```prolog
?- mundoChiquito.
```

### Consultar ternas de forma interactiva:
```prolog
?- ternaMundoChiquito(X, Y, Z).
```
Presiona `;` para ver más soluciones.

### Agregar un nuevo mostro:
```prolog
?- agregarMostro.
```
Sigue las instrucciones en pantalla.

---

## Ejemplo de Ejecución

Con la base de datos inicial:
```prolog
mostro(mostroUno, 5, luz, 2100).
mostro(mostroDos, 7, luz, 2400).
mostro(mostroTres, 7, viento, 2500).
```

El comando `mundoChiquito.` produce:
```
mostroUno mostroDos mostroTres
mostroTres mostroDos mostroUno
mostroUno mostroDos mostroUno
mostroDos mostroUno mostroDos
mostroDos mostroTres mostroDos
mostroTres mostroDos mostroTres
```

### Explicación de una terna:
`mostroUno mostroDos mostroTres`
- mostroUno (nivel 5, luz, 2100) → mostroDos (nivel 7, luz, 2400): comparten **luz**
- mostroDos (nivel 7, luz, 2400) → mostroTres (nivel 7, viento, 2500): comparten **nivel 7**

---

## Notas de Implementación

- El programa considera que pueden existir múltiples copias de la misma carta en el mazo, por eso algunas ternas comienzan y terminan con el mismo mostro.
- La validación de datos en `agregarMostro` asegura la integridad de la base de conocimiento.
- El uso de predicados auxiliares hace el código más legible y fácil de mantener.

---

## Archivo de Entrega
- `mundo_chiquito.pl` - Código fuente completo
- `README.md` - Este archivo
