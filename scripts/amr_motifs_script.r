# -- 1. Instalar dependencias de Bioconductor (solo la primera vez) ----

if (!requireNamespace("BiocManager", quietly = TRUE)){
    install.packages("BiocManager")
}
BiocManager::install(c("Biostrings"))

# -- 2. Cargar librería Biostrings ----
library(Biostrings)

# -- 3. Leer las secuencias FASTA ---- 
archivo_fasta <- "data/secuencias_ampC.fa"
dna_seq <- readDNAStringSet(archivo_fasta)

# -- 4. Definir motivo y su reverso complementario ----
motivo_fwd <- DNAString("AAAACGGG")
motivo_rev <- reverseComplement(motivo_fwd)

# -- 5. Buscar coincidencias en ambas hebras ----
# Usamos max.mismatch = 1 por si hay pequeñas variaciones entre especies (opcional)
coincidencias_fwd <- vmatchPattern(motivo_fwd, dna_seq, max.mismatch = 0)
coincidencias_rev <- vmatchPattern(motivo_rev, dna_seq, max.mismatch = 0)

# -- 6. Generar tabla de resultados ----
resultados <- data.frame(
    Secuencia = names(dna_seq),
    Longitud_bp = width(dna_seq), # Corregido: width() da la longitud de cada secuencia
    Coincidencias_Hebra_Directa = sapply(coincidencias_fwd, length),
    Coincidencias_Hebra_Reversa = sapply(coincidencias_rev, length),
    Total_Motivos = sapply(coincidencias_fwd, length) + sapply(coincidencias_rev, length)
)

print(resultados)

# Exportar CSV
write.csv(resultados, "results/reporte_de_resistencia.csv", row.names = FALSE)
