# amr-motifs
Pipeline en R utilizando el paquete Biostrings para la identificación y cuantificación de motivos asociados a resistencia antimicrobiana (genes bla / betalactamasas) en secuencias cortas de bacterias.

-----------------------------------------------------------------------------------------------------------------------------------------

## Estructura de un Pipeline con Biostrings

Para detectar y cuantificar un motivo específico en un conjunto de lecturas cortas, el flujo bioinformático sigue 4 etapas clave:

[ Archivo FASTQ ] ➔ [ Lectura y Limpieza ] ➔ [ Búsqueda de Motivo ] ➔ [ Cuantificación / Conteo ]
---

## Paso a Paso con Código en R

### 1. Carga de Librerías y Datos
Leemos el archivo de lecturas cortas en formato FASTQ usando la función `readDNAStringSet()` de **Biostrings**.

```r
# Cargar el paquete Biostrings
library(Biostrings)

# Cargar las lecturas cortas (reads)
reads <- readDNAStringSet("secuencias_bacterianas.fastq", format = "fastq")
2. Definición del Motivo ($bla$)Un motivo puede ser una secuencia exacta de ADN o una secuencia de consenso usando códigos IUPAC (por ejemplo, R para A/G, Y para C/T). Supongamos que buscamos la secuencia conservada del sitio activo de un gen $bla_{\text{TEM}}$:R# Motivo conservado de interés (ejemplo: sitio activo de betalactamasa)
motivo_bla <- DNAString("ATGAGTATTCAACATTTCCGT")
3. Búsqueda y Matching de MotivosPara identificar cuántas lecturas contienen este motivo (incluso permitiendo algunas mutaciones o mismatches), utilizamos la función vcountPattern() o vmatchPattern().vcountPattern(): Cuenta cuántas veces aparece el motivo en cada una de las lecturas.max.mismatch = 1: Permite hasta 1 error de lectura o mutación puntual.R# Buscar el motivo en la hebra directa
coincidencias_directas <- vcountPattern(
  pattern = motivo_bla, 
  subject = reads, 
  max.mismatch = 1, 
  fixed = FALSE
)

# Buscar en la hebra reverso-complementaria (muy importante en ADN)
motivo_revcomp <- reverseComplement(motivo_bla)
coincidencias_reverso <- vcountPattern(
  pattern = motivo_revcomp, 
  subject = reads, 
  max.mismatch = 1, 
  fixed = FALSE
)
4. Cuantificación y MétricasFinalmente, sumamos las detecciones para calcular la abundancia del motivo en la muestra:R# Identificar qué lecturas tienen al menos 1 coincidencia
lecturas_con_bla <- (coincidencias_directas > 0) | (coincidencias_reverso > 0)

# Métricas de cuantificación
total_reads <- length(reads)
total_bla_reads <- sum(lecturas_con_bla)
porcentaje_posiciones <- (total_bla_reads / total_reads) * 100

cat("Total de lecturas analizadas:", total_reads, "\n")
cat("Lecturas positivas para gen bla:", total_bla_reads, "\n")
cat("Abundancia relativa del motivo:", round(porcentaje_posiciones, 4), "%\n")
